"""Concepts by enumeration, no model: small comparisons of force quantities, combined by trees.

Atoms are Int expressions of the language: files and ranks, the side to move, Chebyshev distances
between the kings, the pawn and the squares in front of it, and king walks that avoid the other
side's guarded squares (steps). Concepts are every comparison of two atoms,
`a < b`, `a + c < b` and `a + tempo + c < b` for small c, and `a == b`. Concepts that give the same
answer on every position are merged; the most informative are kept and handed, with the atoms, to
greedy trees, which are written out as DSL programs and scored like any other. The same trees over
the concepts of a model-found program (scripts/force_trees.py) are the comparison. Nothing here
calls a model; whether a found concept is new to chess theory needs a person to judge.

    uv run python scripts/enumerate_concepts.py [--keep 500] [--out state/enumerated]
"""

import argparse
import itertools
import sys
from pathlib import Path

import numpy as np
from sklearn.tree import DecisionTreeClassifier

from chess_forces import baselines, dsl, endgames, score

SQUARES = {
    "K": "K",
    "k": "k",
    "P": "P",
    "Q": "sq(file(P), 7)",
    "F1": "sq(file(P), rank(P) + 1)",
    "F2": "sq(file(P), rank(P) + 2)",
}
LEAVES = (64, 256, 1024, None)
SHIFTS = (-1, 1, 2)


def atoms() -> dict[str, str]:
    out = {"tempo": "tempo"}
    for s in ("P", "K", "k"):
        out[f"file({s})"] = f"file({s})"
        out[f"rank({s})"] = f"rank({s})"
    for a, b in itertools.combinations(SQUARES, 2):
        out[f"dist({a},{b})"] = f"dist({SQUARES[a]}, {SQUARES[b]})"
    for t in ("P", "Q", "F1", "F2"):
        out[f"walkK({t})"] = f"steps(K, {SQUARES[t]}, compl(guard(weak)))"
        out[f"walkk({t})"] = f"steps(k, {SQUARES[t]}, compl(king_f(K)))"
    return out


def evaluate(expr: str, task: score.Task) -> np.ndarray:
    prog = dsl.parse(f"def wins() -> Bool:\n    v = {expr}\n    return True\n")
    let = prog.defs[-1].body
    fn = dsl._compile(let.rhs, [])
    ctx = dsl.Ctx(task.positions[0], dsl.CAP)
    env = [None] * prog.defs[-1].nslots
    out = np.empty(task.n, dtype=np.int16)
    for i, pos in enumerate(task.positions):
        ctx.pos, ctx.ops = pos, 0
        out[i] = fn(env, ctx)
    return out


def clamp(x: np.ndarray) -> np.ndarray:
    return np.clip(x, -dsl.INF, dsl.INF)


def candidates(names: list[str], A: np.ndarray, tempo: np.ndarray):
    """(text with {i}/{j} placeholders, i, j, values), in the language's own arithmetic."""
    for i, j in itertools.permutations(range(len(names)), 2):
        a, b = A[:, i].astype(np.int32), A[:, j].astype(np.int32)
        yield "a{i} < a{j}", i, j, a < b
        for c in SHIFTS:
            op = f"+ {c}" if c > 0 else f"- {-c}"
            yield f"a{{i}} {op} < a{{j}}", i, j, clamp(a + c) < b
            yield f"a{{i}} + tempo {op} < a{{j}}", i, j, clamp(clamp(a + tempo) + c) < b
        yield "a{i} + tempo < a{j}", i, j, clamp(a + tempo) < b
        if i < j:
            yield "a{i} == a{j}", i, j, a == b


def gain(x: np.ndarray, y: np.ndarray) -> float:
    def h(p):
        return 0.0 if p <= 0 or p >= 1 else -(p * np.log2(p) + (1 - p) * np.log2(1 - p))

    n, n1 = len(y), int(x.sum())
    if n1 in (0, n):
        return 0.0
    p1 = float(y[x].mean())
    p0 = float(y[~x].mean())
    return h(float(y.mean())) - (n1 / n) * h(p1) - ((n - n1) / n) * h(p0)


def program(tree, kinds: list[tuple], atom_text: list[str]) -> str:
    """kinds[f] = ("atom", i) or ("concept", text, i, j) or ("let", lets, name)."""
    t = tree.tree_
    used = sorted({int(f) for f in t.feature if f >= 0})
    need_atoms = set()
    lines, lets = [], None
    for f in used:
        k = kinds[f]
        if k[0] == "atom":
            need_atoms.add(k[1])
        elif k[0] == "concept":
            need_atoms.update((k[2], k[3]))
        else:
            lets = k[1]
    if lets:
        lines.append(lets)
    lines += [f"    a{i} = {atom_text[i]}" for i in sorted(need_atoms)]
    # concepts are written where they are tested: a block holds at most 100 statements

    def emit(node: int, depth: int) -> None:
        pad = "    " * depth
        if t.children_left[node] == -1:
            lines.append(f"{pad}return {bool(np.argmax(t.value[node]))}")
            return
        f = int(t.feature[node])
        k = kinds[f]
        if k[0] == "atom":
            cond = f"a{k[1]} <= {int(np.floor(t.threshold[node]))}"
        elif k[0] == "concept":
            cond = f"not ({k[1].format(i=k[2], j=k[3])})"
        else:
            cond = f"not {k[2]}"
        lines.append(f"{pad}if {cond}:")
        emit(t.children_left[node], depth + 1)
        lines.append(f"{pad}else:")
        emit(t.children_right[node], depth + 1)

    emit(0, 1)
    return "def wins() -> Bool:\n" + "\n".join(lines) + "\n"


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--keep", type=int, default=500, help="concepts handed to the trees")
    ap.add_argument("--out", default=str(endgames.ROOT / "state" / "enumerated"))
    ap.add_argument(
        "--from", dest="source", default="r1-unit-831", help="model-found program to compare with"
    )
    args = ap.parse_args()
    sys.setrecursionlimit(10_000)
    kpk = endgames.KPK
    task = kpk.task()
    y = np.array(task.truth)
    at = atoms()
    names, atom_text = list(at), list(at.values())
    A = np.stack([evaluate(e, task) for e in atom_text], axis=1)
    tempo = A[:, names.index("tempo")].astype(np.int32)
    seen, pool = set(), []
    total = 0
    for text, i, j, v in candidates(names, A, tempo):
        total += 1
        v = np.asarray(v, dtype=bool)
        key = np.packbits(v).tobytes()
        if key in seen or v.all() or not v.any():
            continue
        seen.add(key)
        pool.append((gain(v, y), text, i, j, v))
    pool.sort(key=lambda r: -r[0])
    kept = pool[: args.keep]
    print(
        f"{len(names)} atoms, {total:,} comparisons, {len(pool):,} distinct concepts, {len(kept)} kept\n"
    )

    # the model-found concepts, as in scripts/force_trees.py
    import importlib.util

    spec = importlib.util.spec_from_file_location(
        "force_trees", Path(__file__).with_name("force_trees.py")
    )
    ft = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(ft)
    lets, defined = ft.concepts((kpk.programs / f"{args.source}.dsl").read_text())
    model_cols, model_names = [], []
    for name in defined:
        v = ft.values(lets, name, task)
        if v is not None:
            model_cols.append(v)
            model_names.append(name)

    sets = {
        "atoms only": ([("atom", i) for i in range(len(names))], A),
        "atoms + enumerated concepts": (
            [("atom", i) for i in range(len(names))]
            + [("concept", t, i, j) for _, t, i, j, _ in kept],
            np.hstack([A, np.stack([v for *_, v in kept], axis=1)]),
        ),
        f"atoms + concepts of {args.source}": (
            [("atom", i) for i in range(len(names))] + [("let", lets, n) for n in model_names],
            np.hstack([A, np.array(model_cols).T]),
        ),
        "atoms + both": (
            [("atom", i) for i in range(len(names))]
            + [("concept", t, i, j) for _, t, i, j, _ in kept]
            + [("let", lets, n) for n in model_names],
            np.hstack([A, np.stack([v for *_, v in kept], axis=1), np.array(model_cols).T]),
        ),
    }
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    print("| Features | Leaves | Errors | Program (bound) | Real bytes | Max ops |")
    print("| --- | ---: | ---: | ---: | ---: | ---: |")
    best = {}
    for label, (kinds, X) in sets.items():
        for leaves in LEAVES:
            tree = DecisionTreeClassifier(
                criterion="entropy", random_state=0, max_leaf_nodes=leaves
            )
            tree.fit(X, y)
            text = program(tree, kinds, atom_text)
            r = score.score(text, task)
            if r.errors != int((tree.predict(X) != y).sum()):
                raise AssertionError(f"{label}: the program and its tree disagree")
            real = baselines.real_program_bytes(text, r)
            n = tree.get_n_leaves()
            slug = {
                "atoms only": "atoms",
                "atoms + enumerated concepts": "enumerated",
                "atoms + both": "both",
            }.get(label, "model")
            (out / f"{slug}-{n:04d}.dsl").write_text(text)
            print(
                f"| {label} | {n:,} | {r.errors:,} | {r.bits_program / 8:,.0f} | {real:,} | {r.ops_max:,} |"
            )
            if leaves == 256:
                best[label] = (tree, kinds)
    tree, kinds = best["atoms + enumerated concepts"]
    order = np.argsort(-tree.feature_importances_)[:12]
    print("\nMost used in the 256-leaf tree over enumerated concepts:")
    for f in order:
        k = kinds[f]
        if tree.feature_importances_[f] == 0:
            break
        what = atom_text[k[1]] if k[0] == "atom" else k[1].format(i=k[2], j=k[3])
        where = (
            ""
            if k[0] == "atom"
            else f"   (a{k[2]} = {atom_text[k[2]]}, a{k[3]} = {atom_text[k[3]]})"
        )
        print(f"  {tree.feature_importances_[f]:.3f}  {what}{where}")
    print(f"\nprograms written to {out}")


if __name__ == "__main__":
    main()
