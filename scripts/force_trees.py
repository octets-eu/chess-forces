"""How compactly can the force language describe KPK? Decision trees over force concepts, written as DSL.

Takes the concepts (the named statements) of a force program, evaluates them on every position next
to the simple features of the tree baselines, grows greedy entropy trees of several sizes and writes
each tree out as a DSL program: the concepts as statements on top, the tree as nested ifs. Every
program is scored like any other, with its real size. The language's text limits (40,000 characters,
3,000 nodes) would reject the larger ones, so they are lifted for the measurement and each row says
whether the program fits them. Greedy trees give upper bounds, not the shortest programs.

    uv run python scripts/force_trees.py [--from r1-unit-831] [--out state/force-trees]
"""

import argparse
import sys
from pathlib import Path

import numpy as np
from sklearn.tree import DecisionTreeClassifier

from chess_forces import baselines, dsl, endgames, score

LEAVES = (64, 256, 1024, None)  # None: grow until every position is right


def concepts(source: str) -> tuple[str, dict[str, str]]:
    """The statements of wins() and the Bool names it defines (the concepts)."""
    body = [
        ln
        for ln in source.splitlines()
        if ln.startswith("    ") and not ln.strip().startswith(("return", '"""', "#"))
    ]
    names = {}
    prog = dsl.parse("def wins() -> Bool:\n" + "\n".join(body) + "\n    return True\n")
    del prog  # parses: the statements are valid on their own
    for ln in body:
        name, _, _ = ln.strip().partition(" = ")
        names[name] = name
    return "\n".join(body), names


def values(lets: str, name: str, task: score.Task) -> list[int] | None:
    try:
        run = dsl.compile_program(dsl.parse(f"def wins() -> Bool:\n{lets}\n    return {name}\n"))
    except dsl.DslError:
        return None  # not a Bool
    ctx = dsl.Ctx(task.positions[0], dsl.CAP)
    out = []
    for pos in task.positions:
        ctx.pos, ctx.ops = pos, 0
        out.append(int(run(ctx)))
    return out


def tree_program(tree, names: list[str], simple: int, lets: str) -> str:
    t = tree.tree_
    used = sorted({int(i) for i in t.feature if i >= 0})
    lines = [lets] if any(i >= simple for i in used) else []
    lines += [f"    x{i} = {baselines.FEATURES[names[i]]}" for i in used if i < simple]

    def emit(node: int, depth: int) -> None:
        pad = "    " * depth
        if t.children_left[node] == -1:
            lines.append(f"{pad}return {bool(np.argmax(t.value[node]))}")
            return
        i = int(t.feature[node])
        cond = f"not {names[i]}" if i >= simple else f"x{i} <= {int(np.floor(t.threshold[node]))}"
        lines.append(f"{pad}if {cond}:")
        emit(t.children_left[node], depth + 1)
        lines.append(f"{pad}else:")
        emit(t.children_right[node], depth + 1)

    emit(0, 1)
    return "def wins() -> Bool:\n" + "\n".join(lines) + "\n"


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--from", dest="source", default="r1-unit-831")
    ap.add_argument("--out", default=str(endgames.ROOT / "state" / "force-trees"))
    args = ap.parse_args()
    kpk = endgames.KPK
    task = kpk.task()
    lets, defined = concepts((kpk.programs / f"{args.source}.dsl").read_text())
    cols, force = [], []
    for name in defined:
        v = values(lets, name, task)
        if v is not None:
            cols.append(v)
            force.append(name)
    simple = len(baselines.FEATURES)
    x_simple = baselines.feature_matrix(task)
    x_all = np.hstack([x_simple, np.array(cols).T])
    y = np.array(task.truth)
    limits = (dsl.MAX_NODES, dsl.MAX_SOURCE, dsl.MAX_DEPTH, dsl.MAX_BLOCK)
    sys.setrecursionlimit(100_000)
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    print(f"concepts of {args.source}: {', '.join(force)}\n")
    print(
        "| Features | Leaves | Errors | Program (bound) | Total (bound) | Real bytes | Max ops | Fits the limits |"
    )
    print("| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |")
    for label, x in (("simple", x_simple), ("simple + concepts", x_all)):
        names = list(baselines.FEATURES) + force
        for leaves in LEAVES:
            tree = DecisionTreeClassifier(
                criterion="entropy", random_state=0, max_leaf_nodes=leaves
            )
            tree.fit(x, y)
            text = tree_program(tree, names, simple, lets)
            dsl.MAX_NODES, dsl.MAX_SOURCE, dsl.MAX_DEPTH, dsl.MAX_BLOCK = limits
            try:
                dsl.parse(text)
                fits = "yes"
            except dsl.DslError as e:
                fits = f"no: {str(e).split(':')[-1].strip()[:40]}"
            dsl.MAX_NODES, dsl.MAX_SOURCE, dsl.MAX_DEPTH, dsl.MAX_BLOCK = 10**7, 10**8, 10**4, 10**4
            r = score.score(text, task)
            real = baselines.real_program_bytes(text, r)
            n = tree.get_n_leaves()
            (out / f"{'concepts' if x is x_all else 'simple'}-{n:04d}.dsl").write_text(text)
            print(
                f"| {label} | {n:,} | {r.errors:,} | {r.bits_program / 8:,.0f} | {r.bytes_total:,.0f} "
                f"| {real:,} | {r.ops_max:,} | {fits} |"
            )
    dsl.MAX_NODES, dsl.MAX_SOURCE, dsl.MAX_DEPTH, dsl.MAX_BLOCK = limits
    print(f"\nprograms written to {out}")


if __name__ == "__main__":
    main()
