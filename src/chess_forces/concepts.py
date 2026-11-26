"""Concept loop (docs/03-concept-loop.md): concepts as Bool expressions of the language, combined by
greedy trees into programs. A model proposes concepts; the trees decide what they are worth.

Atoms are Int expressions (force quantities) evaluated on every position. A concept is a Bool, either a
comparison of atoms (enumerated; written inline where a tree tests it) or a named statement of a
program together with the statements it needs (from a model or from a found program). Trees over atoms
and concepts are written as DSL programs. A concept's worth is the bytes it saves when the trees are
grown again with it; the size is taken without running the interpreter (grammar code of the written
program plus log2 C(N, k) for the tree's errors), and every program that is kept is scored in full.
"""

import ast
import hashlib
import itertools
import json
from collections.abc import Callable
from dataclasses import dataclass, field
from pathlib import Path

import numpy as np
from sklearn.tree import DecisionTreeClassifier

from . import budget, codec, dsl, score

SQUARES = {
    "K": "K",
    "k": "k",
    "P": "P",
    "Q": "sq(file(P), 7)",
    "F1": "sq(file(P), rank(P) + 1)",
    "F2": "sq(file(P), rank(P) + 2)",
}


def base_atoms() -> dict[str, str]:
    """The 30 atoms of scripts/enumerate_concepts.py."""
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


def atoms() -> dict[str, str]:
    """The stronger baseline: more walks, king and pawn differences (opposition), counts of squares."""
    out = base_atoms()
    for t in ("Q", "F1", "F2"):
        out[f"walkk_guarded({t})"] = (
            f"steps(k, {SQUARES[t]}, compl(union(king_f(K), guard(strong))))"
        )
    for a, b in (("K", "k"), ("K", "P"), ("k", "P")):
        out[f"df({a},{b})"] = f"file({a}) - file({b})"
        out[f"dr({a},{b})"] = f"rank({a}) - rank({b})"
    out["adf(K,k)"] = "abs(file(K) - file(k))"
    out["adr(K,k)"] = "abs(rank(K) - rank(k))"
    out["k_free"] = "count(minus(king_f(k), guard(strong)))"
    out["k_guarded"] = "count(inter(king_f(k), guard(strong)))"
    out["kings_shared"] = "count(inter(king_f(K), king_f(k)))"
    out["pawn_path"] = "count(path(strong, P))"
    return out


def _cache_path(task: score.Task, texts: list[str]) -> Path:
    h = hashlib.sha256(json.dumps([dsl.fingerprint(), task.sha256, texts]).encode()).hexdigest()[
        :16
    ]
    return budget.default_path().parent / "cache" / f"atoms-{h}.npy"


def evaluate_atoms(task: score.Task, texts: list[str]) -> np.ndarray:
    """n x m Int values, cached on disk by language, table and atom texts."""
    path = _cache_path(task, texts)
    if path.exists():
        return np.load(path)
    cols = []
    for expr in texts:
        prog = dsl.parse(f"def wins() -> Bool:\n    v = {expr}\n    return True\n")
        fn = dsl._compile(prog.defs[-1].body.rhs, [])
        ctx = dsl.Ctx(task.positions[0], dsl.CAP)
        env = [None] * prog.defs[-1].nslots
        col = np.empty(task.n, dtype=np.int16)
        for i, pos in enumerate(task.positions):
            ctx.pos, ctx.ops = pos, 0
            col[i] = fn(env, ctx)
        cols.append(col)
    out = np.stack(cols, axis=1)
    path.parent.mkdir(parents=True, exist_ok=True)
    np.save(path, out)
    return out


# --- concepts ------------------------------------------------------------------------------------


@dataclass(eq=False)  # concepts are compared by identity, not by their value arrays
class Concept:
    kind: str  # "enum": a comparison of atoms; "named": statements ending in a Bool name
    values: np.ndarray  # bool, one per position
    template: str = ""  # enum: Python format string over atom references {0}, {1}, ...
    refs: tuple[int, ...] = ()
    name: str = ""  # named: the Bool name and the statements it needs, already renamed
    lines: tuple[str, ...] = ()
    origin: str = ""  # enumeration, a program, or a paid call key
    gain: float = 0.0  # information about the result, bits per position

    def text(self, atom_texts: list[str]) -> str:
        if self.kind == "enum":
            return self.template.format(*(f"({atom_texts[r]})" for r in self.refs))
        return f"{self.name}: " + "; ".join(ln.strip() for ln in self.lines)


def _h(p: np.ndarray | float) -> np.ndarray | float:
    p = np.clip(p, 1e-12, 1 - 1e-12)
    return -(p * np.log2(p) + (1 - p) * np.log2(1 - p))


def info_gain(x: np.ndarray, y: np.ndarray) -> float:
    n1 = int(x.sum())
    if n1 in (0, len(y)):
        return 0.0
    w = n1 / len(y)
    return float(_h(y.mean()) - w * _h(y[x].mean()) - (1 - w) * _h(y[~x].mean()))


def gain_in_leaves(x: np.ndarray, y: np.ndarray, leaf: np.ndarray) -> float:
    """Bits the candidate would save, summed over the leaves of a tree, if each leaf were split by it."""
    leaves, inv = np.unique(leaf, return_inverse=True)
    m = len(leaves)
    n = np.bincount(inv, minlength=m).astype(float)
    pos = np.bincount(inv, weights=y.astype(float), minlength=m)
    n1 = np.bincount(inv, weights=x.astype(float), minlength=m)
    pos1 = np.bincount(inv, weights=(x & y).astype(float), minlength=m)
    n0, pos0 = n - n1, pos - pos1
    with np.errstate(divide="ignore", invalid="ignore"):
        before = n * _h(np.where(n > 0, pos / np.maximum(n, 1), 0.5))
        after = n1 * _h(np.where(n1 > 0, pos1 / np.maximum(n1, 1), 0.5)) + n0 * _h(
            np.where(n0 > 0, pos0 / np.maximum(n0, 1), 0.5)
        )
    return float(np.sum(np.where((n1 > 0) & (n0 > 0), before - after, 0.0)))


SHIFTS = (-1, 1, 2)


def _clamp(x: np.ndarray) -> np.ndarray:
    return np.clip(x, -dsl.INF, dsl.INF)


def enumerate_comparisons(A: np.ndarray, names: list[str], sums_from: int = 12) -> list[Concept]:
    """Every a < b, a + c < b, a + tempo + c < b, a == b, and a + b < c over the most informative atoms."""
    tempo = A[:, names.index("tempo")].astype(np.int32)
    out = []
    for i, j in itertools.permutations(range(len(names)), 2):
        a, b = A[:, i].astype(np.int32), A[:, j].astype(np.int32)
        out.append(Concept("enum", a < b, "{0} < {1}", (i, j), origin="enumeration"))
        for c in SHIFTS:
            op = f"+ {c}" if c > 0 else f"- {-c}"
            out.append(
                Concept(
                    "enum", _clamp(a + c) < b, "{0} " + op + " < {1}", (i, j), origin="enumeration"
                )
            )
            out.append(
                Concept(
                    "enum",
                    _clamp(_clamp(a + tempo) + c) < b,
                    "{0} + tempo " + op + " < {1}",
                    (i, j),
                    origin="enumeration",
                )
            )
        out.append(
            Concept(
                "enum", _clamp(a + tempo) < b, "{0} + tempo < {1}", (i, j), origin="enumeration"
            )
        )
        if i < j:
            out.append(Concept("enum", a == b, "{0} == {1}", (i, j), origin="enumeration"))
    return out


def add_sums(A: np.ndarray, y: np.ndarray, top: int = 12) -> list[Concept]:
    """a + b < c over the atoms that split the result best on their own (at their best threshold)."""

    def best_split(col: np.ndarray) -> float:
        return max((info_gain(col <= t, y) for t in np.unique(col)[:-1]), default=0.0)

    order = sorted(range(A.shape[1]), key=lambda i: -best_split(A[:, i]))[:top]
    out = []
    for i, j in itertools.combinations(order, 2):
        s = _clamp(A[:, i].astype(np.int32) + A[:, j])
        for k in order:
            if k not in (i, j):
                out.append(
                    Concept("enum", s < A[:, k], "{0} + {1} < {2}", (i, j, k), origin="enumeration")
                )
    return out


def distinct(
    concepts: list[Concept], y: np.ndarray, seen: set[bytes] | None = None
) -> list[Concept]:
    """Drops constants and concepts with the same values as an earlier one; fills in the gain."""
    seen = set() if seen is None else seen
    out = []
    for c in concepts:
        v = np.asarray(c.values, dtype=bool)
        key = np.packbits(v).tobytes()
        if key in seen or v.all() or not v.any():
            continue
        seen.add(key)
        c.values = v
        c.gain = info_gain(v, y)
        out.append(c)
    return out


# --- concepts from a program ---------------------------------------------------------------------


class Rejected(Exception):
    """A proposal that gives no concept: invalid, too costly, or in a form the loop does not take."""


def named_concepts(source: str, prefix: str, task: score.Task, origin: str) -> list[Concept]:
    """Every Bool statement before the first if/return of wins(), with the statements it needs, renamed
    with prefix so concepts from different programs never clash. The returned expression counts too."""
    prog = dsl.parse(source)  # raises DslError
    tree = ast.parse(source)
    fns = [n for n in tree.body if isinstance(n, ast.FunctionDef)]
    if len(fns) != 1:
        raise Rejected("concepts must be statements of wins(), without helper functions")
    body = [
        s
        for s in fns[0].body
        if not (isinstance(s, ast.Expr) and isinstance(getattr(s, "value", None), ast.Constant))
    ]
    assigns, ret = [], None
    for s in body:
        if isinstance(s, ast.Assign) and len(s.targets) == 1 and isinstance(s.targets[0], ast.Name):
            assigns.append(s)
        elif isinstance(s, ast.Return):
            ret = s.value
            break
        else:
            break
    defined = [a.targets[0].id for a in assigns]
    rename = {n: f"{prefix}{n}" for n in defined}

    class R(ast.NodeTransformer):
        def visit_Name(self, node):
            return ast.copy_location(ast.Name(rename.get(node.id, node.id), node.ctx), node)

    def uses(expr) -> set[str]:
        return {n.id for n in ast.walk(expr) if isinstance(n, ast.Name) and n.id in rename}

    stmts = [(a.targets[0].id, a.value) for a in assigns]
    if ret is not None and not (isinstance(ret, ast.Name) and ret.id in rename):
        stmts.append(("wins", ret))
        rename["wins"] = f"{prefix}wins"
    lines = {
        n: f"    {rename[n]} = {ast.unparse(R().visit(ast.parse(ast.unparse(e), mode='eval')).body)}"
        for n, e in stmts
    }
    deps = {n: uses(e) for n, e in stmts}
    order = [n for n, _ in stmts]

    def closure(n: str) -> list[str]:
        need, todo = set(), [n]
        while todo:
            m = todo.pop()
            if m not in need:
                need.add(m)
                todo += list(deps[m])
        return [m for m in order if m in need]

    # one pass over the positions evaluates every statement; the language decides the types
    text = "def wins() -> Bool:\n" + "\n".join(lines[n] for n in order) + "\n    return True\n"
    p = dsl.parse(text)
    chain, e = [], p.defs[-1].body
    while isinstance(e, dsl.Let):
        chain.append(e)
        e = e.body
    fns_c = [(dsl._compile(let.rhs, []), let.slot, let.rhs.t) for let in chain]
    ctx = dsl.Ctx(task.positions[0], dsl.CAP)
    env = [None] * p.defs[-1].nslots
    bools = [i for i, (_, _, t) in enumerate(fns_c) if t == "Bool"]
    vals = np.zeros((task.n, len(bools)), dtype=bool)
    for r, pos in enumerate(task.positions):
        ctx.pos, ctx.ops = pos, 0
        for fn, slot, _ in fns_c:
            env[slot] = fn(env, ctx)
        if ctx.ops > dsl.CAP:
            raise Rejected(f"over {dsl.CAP} operations on a position")
        for c, i in enumerate(bools):
            vals[r, c] = env[fns_c[i][1]]
    del prog
    out = []
    for c, i in enumerate(bools):
        n = order[i]
        out.append(
            Concept(
                "named",
                vals[:, c],
                name=rename[n],
                lines=tuple(lines[m] for m in closure(n)),
                origin=origin,
            )
        )
    return out


# --- trees written as programs -------------------------------------------------------------------


@dataclass
class Grown:
    tree: DecisionTreeClassifier
    text: str
    errors: int
    bits_program: float
    bits_exceptions: float
    real_bytes: int
    used: list[int]  # feature indices the tree uses

    @property
    def bytes_total(self) -> float:
        return (self.bits_program + self.bits_exceptions) / 8


class Pool:
    """Atoms and concepts over one task, as one feature matrix for the trees."""

    def __init__(
        self, task: score.Task, atom_names: list[str], atom_texts: list[str], A: np.ndarray
    ):
        self.task, self.names, self.texts, self.A = task, atom_names, atom_texts, A
        self.y = np.array(task.truth)
        self.concepts: list[Concept] = []
        self.seen: set[bytes] = set()

    def add(self, concepts: list[Concept]) -> list[Concept]:
        new = distinct(concepts, self.y, self.seen)
        self.concepts += new
        return new

    def is_new(self, c: Concept) -> bool:
        return np.packbits(np.asarray(c.values, dtype=bool)).tobytes() not in self.seen

    @property
    def width(self) -> int:
        return self.A.shape[1] + len(self.concepts)

    def matrix(self, features: list[int] | None = None, extra: list[Concept] = ()) -> np.ndarray:
        m = self.A.shape[1]
        feats = list(range(self.width)) if features is None else features
        cols = [self.A[:, f] if f < m else self.concepts[f - m].values for f in feats]
        cols += [c.values for c in extra]
        return np.stack([np.asarray(c, dtype=np.int16) for c in cols], axis=1)

    def grow(
        self, leaves: int | None, features: list[int] | None = None, extra: list[Concept] = ()
    ) -> Grown:
        feats = list(range(self.width)) if features is None else list(features)
        X = self.matrix(feats, extra)
        tree = DecisionTreeClassifier(
            criterion="entropy", random_state=0, max_leaf_nodes=leaves
        ).fit(X, self.y)
        kinds = [self._feature(f) for f in feats] + [("concept", c) for c in extra]
        text = self.program(tree, kinds)
        wrong = np.nonzero(tree.predict(X) != self.y)[0]
        prog = dsl.parse(text)
        k = len(wrong)
        exc_bits = score.exception_bits(self.task.n, k) if k else 0.0
        real = (
            len(codec.encode_program(prog)) + 2 + len(codec.encode_exceptions(self.task.n, wrong))
        )
        used_local = sorted({int(f) for f in tree.tree_.feature if f >= 0})
        used = [feats[u] if u < len(feats) else -1 - (u - len(feats)) for u in used_local]
        return Grown(tree, text, k, dsl.size_bits(prog), exc_bits, real, used)

    def _feature(self, f: int):
        m = self.A.shape[1]
        return ("atom", f) if f < m else ("concept", self.concepts[f - m])

    def program(self, tree, kinds: list) -> str:
        t = tree.tree_
        used = sorted({int(f) for f in t.feature if f >= 0})
        atom_uses: dict[int, int] = {}
        named: list[Concept] = []
        for f in used:
            kind, x = kinds[f]
            nodes = int(np.sum(t.feature == f))
            if kind == "atom":
                atom_uses[x] = atom_uses.get(x, 0) + nodes
            elif x.kind == "enum":
                for r in x.refs:
                    atom_uses[r] = atom_uses.get(r, 0) + nodes
            elif x not in named:
                named.append(x)
        lines: list[str] = []
        for c in named:
            lines += [ln for ln in c.lines if ln not in lines]
        # atoms used more than once are named; the others are written where they are used
        named_atoms = sorted(a for a, n in atom_uses.items() if n > 1)
        while len(lines) + len(named_atoms) > dsl.MAX_BLOCK - 5 and named_atoms:
            named_atoms.remove(min(named_atoms, key=lambda a: atom_uses[a]))
        ref = {a: f"a{a}" for a in named_atoms}

        def atom(a: int) -> str:
            return ref.get(a, f"({self.texts[a]})")

        head = [f"    a{a} = {self.texts[a]}" for a in named_atoms] + lines

        def cond(f: int, node: int) -> str:
            kind, x = kinds[f]
            if kind == "atom":
                return f"{atom(x)} <= {int(np.floor(t.threshold[node]))}"
            if x.kind == "enum":
                return f"not ({x.template.format(*(atom(r) for r in x.refs))})"
            return f"not {x.name}"

        body: list[str] = []

        def emit(node: int, depth: int) -> None:
            pad = "    " * depth
            if t.children_left[node] == -1:
                body.append(f"{pad}return {bool(np.argmax(t.value[node]))}")
                return
            body.append(f"{pad}if {cond(int(t.feature[node]), node)}:")
            emit(t.children_left[node], depth + 1)
            body.append(f"{pad}else:")
            emit(t.children_right[node], depth + 1)

        emit(0, 1)
        return "def wins() -> Bool:\n" + "\n".join(head + body) + "\n"


def build_pool(
    task: score.Task,
    keep: int = 500,
    model_programs: dict[str, str] | None = None,
    stronger: bool = True,
):
    """Atoms, the most informative enumerated comparisons and the concepts of given programs."""
    at = atoms() if stronger else base_atoms()
    names, texts = list(at), list(at.values())
    A = evaluate_atoms(task, texts)
    pool = Pool(task, names, texts, A)
    y = pool.y
    ranked = distinct(enumerate_comparisons(A, names) + (add_sums(A, y) if stronger else []), y)
    ranked.sort(key=lambda c: -c.gain)
    pool.add(ranked[:keep])
    for name, source in (model_programs or {}).items():
        pool.add(named_concepts(source, f"{name}_", task, f"program {name}"))
    rest = ranked[keep:]
    return pool, rest


def candidate_gain(
    pool: Pool, base: dict[str, Grown], features: list[int], c: Concept
) -> dict[str, float]:
    """Bytes (score) saved by adding c, at 256 leaves and grown until exact, on the given features."""
    out = {}
    for size, leaves in (("256", 256), ("exact", None)):
        g = pool.grow(leaves, features, extra=[c])
        out[size] = base[size].bytes_total - g.bytes_total
    return out


# --- the paid loop -------------------------------------------------------------------------------

TASK_TEXT = """THE TASK
A concept is a named Bool statement in the language, for example
    runs = min(5, 7 - rank(P)) + 1 - tempo < dist(k, sq(file(P), 7))
Concepts are not judged as programs. A decision tree combines them with the quantities and concepts it
already has, and a concept is worth the bytes it saves: the tree with it is written as a program and
scored like any program (program bits plus log2(choose(165676, k)) bits for its k errors). A concept
saves most when it separates positions the tree gets wrong and the tree cannot already express it by
comparing its quantities. A concept that equals an existing one on every position is worth nothing.

OUTPUT
Write at most three sentences on the idea. Then one python code block with a program
def wins() -> Bool: whose statements define up to five Bool concepts (Int statements they need are
fine) and that returns one of them. No helper functions, no if statements, no comments in the block."""


def system_text() -> str:
    from . import search

    head = search.SYSTEM.split("THE SCORE")[0]
    head = head.replace(
        "You improve small programs that decide whether the strong side wins a chess endgame.",
        "You propose concepts for decision trees that decide whether the strong side wins a chess endgame.",
    )
    return head.replace("{SPEC}", dsl.spec()) + TASK_TEXT


@dataclass
class LoopSettings:
    run: str
    model: str = "claude-haiku-5-5"
    effort: str = "medium"
    max_tokens: int = 9000
    workers: int = 8
    plateau: int = 200  # stop after this many calls without an accepted concept
    window: int = 100  # calls over which bytes saved per dollar is measured
    min_bytes_per_usd: float = 100.0  # stop when the last window saved less per dollar
    filter_bits: float = (
        64.0  # candidates below this information inside the tree's leaves are not refitted
    )
    exact_bits: float = (
        256.0  # ... and below this the exact tree is not refitted unless 256 leaves improved
    )


@dataclass
class Outcome:
    unit: int
    name: str
    text: str
    status: str  # accepted, small, duplicate, rejected
    reason: str = ""
    filter_bits: float = 0.0
    saved_256: float = 0.0
    saved_exact: float = 0.0


@dataclass
class State:
    best: dict  # "256" and "exact": Grown over the whole pool
    features: list[int]  # used by either tree; candidates are refitted on these
    base: dict  # Grown on features only
    leaf: np.ndarray  # leaf of every position in the 256-leaf tree
    clusters: list = field(default_factory=list)
    samples: list = field(default_factory=list)


class ConceptLoop:
    """Proposals from a model, judged by trees. client has .messages.create; a test client can stand in."""

    def __init__(
        self,
        settings: LoopSettings,
        guard,
        client,
        pool: Pool,
        out_dir: Path,
        log: Callable[[str], None] = print,
    ):
        self.s, self.guard, self.client, self.pool = settings, guard, client, pool
        self.out = out_dir
        self.out.mkdir(parents=True, exist_ok=True)
        self.system = system_text()
        self.log = log
        self.outcomes: list[Outcome] = []
        self.accepted: list[Concept] = []
        self.calls: list[
            tuple[int, float, float]
        ] = []  # unit, saved bytes, run spend after the call
        self.state = self.rebuild()

    def rebuild(self) -> State:
        best = {"256": self.pool.grow(256), "exact": self.pool.grow(None)}
        feats = sorted({f for g in best.values() for f in g.used if f >= 0})
        base = {"256": self.pool.grow(256, feats), "exact": self.pool.grow(None, feats)}
        leaf = best["256"].tree.apply(self.pool.matrix())
        r = score.score(best["256"].text, self.pool.task)
        for size, g in best.items():
            (self.out / f"best-{size}.dsl").write_text(g.text)
        return State(
            best, feats, base, leaf, r.clusters, list(zip(r.samples, r.samples_truth, strict=False))
        )

    def prompt(self, unit: int) -> str:
        from . import search

        st, at = self.state, self.pool.texts
        b256, bx = st.best["256"], st.best["exact"]
        lines = [
            (
                f"Target: Syzygy's file for KPK has 7,824 bytes. The trees over the current concepts: "
                f"256 leaves {b256.real_bytes:,} bytes ({b256.errors:,} errors), grown until exact "
                f"{bx.real_bytes:,} bytes (no errors)."
            ),
            f"Theme for this answer: {search.HINTS[unit % len(search.HINTS)]}.",
            "",
            "Largest error groups of the 256-leaf tree (who moves, kind of mistake, pawn rank: count, example FEN):",
            *[f"- {label}: {n:,}, e.g. {fen}" for label, n, fen in st.clusters[:8]],
            "",
            "Some positions it gets wrong (FEN, true result):",
            *[f"- {fen}: {'White wins' if truth else 'draw'}" for fen, truth in st.samples[:10]],
            "",
            "Concepts and quantities the trees use most (do not repeat them):",
        ]
        imp = b256.tree.feature_importances_
        local = np.argsort(-imp)[:15]
        feats = list(range(self.pool.width))
        for f in local:
            if imp[f] <= 0:
                break
            kind, x = self.pool._feature(feats[f])
            lines.append(f"- {at[x]}" if kind == "atom" else f"- {x.text(at)}")
        lines += ["", "Propose up to five new concepts."]
        return "\n".join(lines)

    def request(self, prompt: str) -> dict:
        return {
            "model": self.s.model,
            "max_tokens": self.s.max_tokens,
            "system": [
                {"type": "text", "text": self.system, "cache_control": {"type": "ephemeral"}}
            ],
            "messages": [{"role": "user", "content": prompt}],
            "output_config": {"effort": self.s.effort},
        }

    def paid(self, unit: int, prompt: str) -> dict | Exception:
        """One paid answer through the guard (cached by key, so a rerun replays it for free)."""
        import anthropic

        from .budget import NotBilled
        from .search import RateLimited, SearchStopped, _retry_after

        def do(_handle):
            try:
                r = self.client.messages.create(**self.request(prompt))
            except anthropic.APIConnectionError:
                raise
            except anthropic.APIStatusError as e:
                text = f"{type(e).__name__}: {e.message}"
                if type(e) is anthropic.RateLimitError:
                    raise RateLimited(text, _retry_after(e)) from e
                if 400 <= e.status_code < 500 and e.status_code not in (408, 409):
                    raise NotBilled(text) from e
                raise
            text = "".join(b.text for b in r.content if b.type == "text")
            return {"text": text, "stop": r.stop_reason, "model": r.model}, r.usage.model_dump()

        import time

        last: Exception = RuntimeError("no attempt")
        tokens = int((len(self.system) + len(prompt)) / 1.6) + 200
        for attempt in range(8):
            wait_s = min(60.0, 4.0 * 2**attempt)
            try:
                return self.guard.run(
                    f"{self.s.run}/{unit}", self.s.model, tokens, self.s.max_tokens, do, cached=True
                )
            except RateLimited as e:
                last, wait_s = e, max(e.after, wait_s)
            except NotBilled as e:
                raise SearchStopped(str(e)) from e
            except (anthropic.APIError, OSError) as e:
                last = e
                if attempt >= 4:
                    break
            time.sleep(wait_s)
        return last

    def judge(self, unit: int, answer: dict) -> list[Outcome]:
        from . import search

        try:
            source = search.extract(answer.get("text", ""))
            cands = named_concepts(source, f"u{unit}_", self.pool.task, f"{self.s.run}/{unit}")
        except (dsl.DslError, Rejected) as e:
            return [Outcome(unit, "", "", "rejected", str(e)[:200])]
        return [self.consider(unit, c) for c in cands]

    def consider(self, unit: int, c: Concept) -> Outcome:
        """Duplicate, too little information, or refitted: accepted when it saves at least 1 B."""
        st = self.state
        text = c.text(self.pool.texts)
        if not self.pool.is_new(c) or c.values.all() or not c.values.any():
            return Outcome(unit, c.name, text, "duplicate")
        bits = gain_in_leaves(c.values, self.pool.y, st.leaf)
        o = Outcome(unit, c.name, text, "small", filter_bits=bits)
        if bits >= self.s.filter_bits:
            g256 = self.pool.grow(256, st.features, extra=[c])
            o.saved_256 = st.base["256"].bytes_total - g256.bytes_total
            if o.saved_256 > 0 or bits >= self.s.exact_bits:
                gx = self.pool.grow(None, st.features, extra=[c])
                o.saved_exact = st.base["exact"].bytes_total - gx.bytes_total
            if o.saved_256 >= 1 or o.saved_exact >= 1:
                o.status = "accepted"
                self.pool.add([c])
                self.accepted.append(c)
        return o

    def run(self, max_units: int | None = None) -> str:
        from concurrent.futures import ThreadPoolExecutor

        from .search import SearchStopped

        unit, since_accept, why = 0, 0, "max units"
        with ThreadPoolExecutor(self.s.workers) as threads:
            while max_units is None or unit < max_units:
                n = self.s.workers if max_units is None else min(self.s.workers, max_units - unit)
                prompts = {u: self.prompt(u) for u in range(unit, unit + n)}
                answers = dict(
                    zip(
                        prompts,
                        threads.map(lambda u, p=prompts: self.paid(u, p[u]), prompts),
                        strict=True,
                    )
                )
                changed = False
                for u in sorted(answers):
                    a = answers[u]
                    if isinstance(a, SearchStopped):
                        raise a
                    res = (
                        [Outcome(u, "", "", "rejected", f"call failed: {a}")]
                        if isinstance(a, Exception)
                        else self.judge(u, a)
                    )
                    self.outcomes += res
                    saved = sum(
                        max(0.0, o.saved_256) + max(0.0, o.saved_exact)
                        for o in res
                        if o.status == "accepted"
                    )
                    self.calls.append((u, saved, self.guard.run_spent() / 1e9))
                    if any(o.status == "accepted" for o in res):
                        changed, since_accept = True, 0
                    else:
                        since_accept += 1
                    self.log(self.line(u, res))
                unit += n
                if changed:
                    self.state = self.rebuild()
                if since_accept >= self.s.plateau:
                    why = f"{self.s.plateau} calls without an accepted concept"
                    break
                if len(self.calls) >= self.s.window:
                    w = self.calls[-self.s.window :]
                    spent = w[-1][2] - (
                        self.calls[-self.s.window - 1][2]
                        if len(self.calls) > self.s.window
                        else 0.0
                    )
                    if spent > 0 and sum(s for _, s, _ in w) / spent < self.s.min_bytes_per_usd:
                        why = f"the last {self.s.window} calls saved less than {self.s.min_bytes_per_usd:,.0f} B per USD"
                        break
        return why

    def line(self, unit: int, res: list[Outcome]) -> str:
        acc = [o for o in res if o.status == "accepted"]
        b = self.state.best
        return (
            f"unit {unit}: {len(res)} candidates, {len(acc)} accepted"
            + (
                f" (saved {sum(o.saved_256 for o in acc):.0f} B at 256, {sum(o.saved_exact for o in acc):.0f} B exact)"
                if acc
                else ""
            )
            + f" | best 256 {b['256'].real_bytes:,} B, exact {b['exact'].real_bytes:,} B | spend {self.guard.run_spent() / 1e9:.3f} USD"
        )

    def save(self, path: Path) -> None:
        rows = [o.__dict__ for o in self.outcomes]
        acc = [concept_record(c, self.pool.texts) for c in self.accepted]
        path.write_text(
            json.dumps({"settings": self.s.__dict__, "accepted": acc, "outcomes": rows}, indent=1)
        )


def concept_from_record(rec: dict, task: score.Task) -> Concept:
    """A named concept back from its statements (values are computed again)."""
    source = "def wins() -> Bool:\n" + "\n".join(rec["lines"]) + f"\n    return {rec['name']}\n"
    for c in named_concepts(source, "", task, rec["origin"]):
        if c.name == rec["name"]:
            return c
    raise ValueError(f"concept {rec['name']} not found in its statements")


def compare(
    pool: Pool,
    rest: list[Concept],
    model: list[Concept],
    out_dir: Path,
    log: Callable[[str], None] = print,
    tries: int = 400,
) -> dict:
    """C5: bytes saved by the model's accepted concepts against as many enumerated ones, taken from
    further down the enumeration's ranking and accepted by the same rule."""
    import copy

    def bytes_with(extra: list[Concept]) -> dict[str, float]:
        p = copy.copy(pool)
        p.concepts = pool.concepts + extra
        return {"256": p.grow(256).bytes_total, "exact": p.grow(None).bytes_total}

    base = bytes_with([])
    with_model = bytes_with(model)
    judge = ConceptLoop(LoopSettings(run="compare"), None, None, copy.deepcopy(pool), out_dir, log)
    picked: list[Concept] = []
    for i, c in enumerate(rest[:tries]):
        if len(picked) >= len(model):
            break
        o = judge.consider(-1 - i, c)
        if o.status == "accepted":
            picked.append(c)
            judge.state = judge.rebuild()
    with_enum = bytes_with(picked)
    out = {
        "model concepts": len(model),
        "enumerated concepts": len(picked),
        "base": base,
        "saved by the model": {k: base[k] - with_model[k] for k in base},
        "saved by enumeration": {k: base[k] - with_enum[k] for k in base},
    }
    log(json.dumps(out, indent=1))
    return out


def concept_record(c: Concept, atom_texts: list[str]) -> dict:
    return {
        "kind": c.kind,
        "name": c.name,
        "lines": list(c.lines),
        "template": c.template,
        "refs": list(c.refs),
        "origin": c.origin,
        "text": c.text(atom_texts),
    }


__all__ = [
    "Concept",
    "ConceptLoop",
    "Grown",
    "LoopSettings",
    "Pool",
    "Rejected",
    "atoms",
    "base_atoms",
    "build_pool",
    "candidate_gain",
    "enumerate_comparisons",
    "gain_in_leaves",
    "named_concepts",
]
