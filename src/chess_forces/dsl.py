"""The force language (DSL v0): types, primitives with operation costs, parser and size code.

Programs are a small subset of Python, read with ast and never executed as Python; see
docs/01-dsl-concept.md. Types: Int (saturates at +-99, 99 means inf), Bool, Sq (0..63 or none), Field
(a set of squares, 64 bits), and the constants Side, Kind, Piece and Dir. Operations on none give
none, False or inf, never an error. Sq = rank * 8 + file, rank 0 is the strong side's back rank.

Operations are 64-bit word operations of the reference implementation below (no lookup tables);
each primitive adds its cost to ctx.ops, loops add per wave or per square.
"""

import ast
import hashlib
import json
import math
from collections import Counter
from collections.abc import Callable
from dataclasses import dataclass

DSL_VERSION = "0.3"
INF = 99
CAP = 4096
TIERS = (64, 256, 1024, 4096)
MASK = (1 << 64) - 1
FILE_A = 0x0101010101010101
FILE_H = FILE_A << 7
NOT_A = MASK ^ FILE_A
NOT_H = MASK ^ FILE_H
RANK_1 = 0xFF

VALUE_TYPES = ("Int", "Bool", "Sq", "Field")
SIDES = ("strong", "weak")
PIECES = ("pawn", "knight", "bishop", "rook", "queen", "king")
KINDS = ("any", *PIECES)
DIRS = ("N", "NE", "E", "SE", "S", "SW", "W", "NW")
ENUMS: dict[str, tuple[str, ...]] = {"Side": SIDES, "Kind": KINDS, "Piece": PIECES, "Dir": DIRS}
INT_MIN, INT_MAX = -8, 63
# Size is limited by information (grammar code), not by text: layout and names cost nothing (0.3).
MAX_BITS = 1 << 20  # 128 KiB of grammar code
# Guards on parsing work only, far above any program within MAX_BITS.
MAX_SOURCE = 4_000_000
MAX_NODES = 400_000
MAX_DEPTH = 100  # nesting of expressions and of if statements
MAX_BLOCK = 100


class DslError(Exception):
    """The text is not a valid program (syntax, names, types or limits)."""


class OpLimit(Exception):
    """The program ran past its operation cap on some position."""


# --- position ------------------------------------------------------------------------------------

KING_DIRS = {
    "N": (0, 1),
    "NE": (1, 1),
    "E": (1, 0),
    "SE": (1, -1),
    "S": (0, -1),
    "SW": (-1, -1),
    "W": (-1, 0),
    "NW": (-1, 1),
}
ROOK_DIRS = ("N", "E", "S", "W")
BISHOP_DIRS = ("NE", "SE", "SW", "NW")


class Position:
    """A position from the strong side's view. men: (side, kind, square) with sides 'strong'/'weak'."""

    __slots__ = ("K", "P", "k", "masks", "men", "occ", "tempo")

    def __init__(self, men, tempo: int):
        self.men = tuple(men)
        self.tempo = tempo
        self.masks: dict[tuple[str, str], int] = {}
        for side in SIDES:
            for kind in KINDS:
                self.masks[side, kind] = 0
        for side, kind, s in self.men:
            self.masks[side, kind] |= 1 << s
            self.masks[side, "any"] |= 1 << s
        self.occ = self.masks["strong", "any"] | self.masks["weak", "any"]
        self.K = self._only("strong", "king")
        self.k = self._only("weak", "king")
        self.P = self._only("strong", "pawn")

    def _only(self, side: str, kind: str) -> int | None:
        m = self.masks[side, kind]
        return m.bit_length() - 1 if m and m & (m - 1) == 0 else None


# --- primitives ----------------------------------------------------------------------------------


class Ctx:
    """Evaluation state: position, operations used, cap."""

    __slots__ = ("cap", "ops", "pos")

    def __init__(self, pos: Position, cap: int = CAP):
        self.pos, self.cap, self.ops = pos, cap, 0

    def spend(self, n: int) -> None:
        self.ops += n
        if self.ops > self.cap:
            raise OpLimit


def clamp(x: int) -> int:
    return -INF if x < -INF else min(x, INF)


def _king_step(x: int) -> int:
    """Squares a king can step to from the set x (x included). 10 word operations."""
    h = x | ((x >> 1) & NOT_H) | ((x << 1) & NOT_A)
    return (h | (h << 8) | (h >> 8)) & MASK


def _ray(c: Ctx, s: int, d: str, occ: int) -> int:
    df, dr = KING_DIRS[d]
    f, r, out = (s & 7) + df, (s >> 3) + dr, 0
    while 0 <= f < 8 and 0 <= r < 8:
        c.spend(4)
        q = r * 8 + f
        out |= 1 << q
        if occ >> q & 1:
            break
        f, r = f + df, r + dr
    return out


def _hits(c: Ctx, side: str, piece: str, s: int | None, occ: int) -> int:
    if s is None:
        return 0
    b = 1 << s
    if piece == "king":
        c.spend(11)
        return _king_step(b) & ~b
    if piece == "knight":
        c.spend(18)
        l1, l2 = (b >> 1) & NOT_H, (b >> 2) & NOT_H & (NOT_H >> 1)
        r1, r2 = (b << 1) & NOT_A, (b << 2) & NOT_A & (NOT_A << 1)
        h1, h2 = l1 | r1, l2 | r2
        return (h1 << 16 | h1 >> 16 | h2 << 8 | h2 >> 8) & MASK
    if piece == "pawn":
        c.spend(6)
        if side == "strong":
            return ((b << 7) & NOT_H | (b << 9) & NOT_A) & MASK
        return (b >> 9) & NOT_H | (b >> 7) & NOT_A
    dirs = {"rook": ROOK_DIRS, "bishop": BISHOP_DIRS, "queen": ROOK_DIRS + BISHOP_DIRS}[piece]
    out = 0
    for d in dirs:
        c.spend(1)
        out |= _ray(c, s, d, occ)
    return out


def _guard(c: Ctx, side: str, skip: int | None, occ: int) -> int:
    out = 0
    for m_side, kind, s in c.pos.men:
        if m_side == side and s != skip:
            c.spend(1)
            out |= _hits(c, side, kind, s, occ)
    return out


def _wave(c: Ctx, s: int, field: int, limit: int | None, goal: int | None):
    """Flood from s through field. Returns (set, waves, reached goal)."""
    x = 1 << s
    waves = 0
    goal_bit = 0 if goal is None else 1 << goal
    while limit is None or waves < limit:
        c.spend(12 if goal is None else 14)
        n = x | _king_step(x) & field
        waves += 1
        if goal_bit & n:
            return n, waves, True
        if n == x:
            return x, waves, False
        x = n
    return x, waves, False


def p_steps(c, s, t, field):
    if s is None or t is None:
        return INF
    if s == t:
        return 0
    if not field >> t & 1:
        return INF
    _, waves, hit = _wave(c, s, field, None, t)
    return waves if hit else INF


def p_path(c, side, s):
    if s is None:
        return 0
    b = 1 << s
    if side == "strong":
        f = b | b << 8
        f |= f << 16
        f |= f << 32
    else:
        f = b | b >> 8
        f |= f >> 16
        f |= f >> 32
    return f & MASK & ~b


def _board(f: int, r: int) -> int | None:
    return r * 8 + f if 0 <= f < 8 and 0 <= r < 8 else None


def _cheb(s, t):
    return max(abs((s & 7) - (t & 7)), abs((s >> 3) - (t >> 3)))


def _manh(s, t):
    return abs((s & 7) - (t & 7)) + abs((s >> 3) - (t >> 3))


@dataclass(frozen=True)
class Prim:
    name: str
    args: tuple[str, ...]
    ret: str
    cost: int  # fixed part; loops add more inside fn
    fn: Callable
    note: str = ""


_TABLE = (
    # position (a load each)
    Prim("K", (), "Sq", 1, lambda c: c.pos.K, "strong king"),
    Prim("k", (), "Sq", 1, lambda c: c.pos.k, "weak king"),
    Prim("P", (), "Sq", 1, lambda c: c.pos.P, "the strong side's only pawn, else none"),
    Prim("occ", (), "Field", 1, lambda c: c.pos.occ, "occupied squares"),
    Prim("tempo", (), "Int", 1, lambda c: c.pos.tempo, "1 if the strong side is to move, else 0"),
    Prim("inf", (), "Int", 0, lambda c: INF, "99"),
    Prim("men", ("Side", "Kind"), "Field", 1, lambda c, a, b: c.pos.masks[a, b], "squares of men"),
    # scalars
    Prim("add", ("Int", "Int"), "Int", 1, lambda c, a, b: clamp(a + b), "+"),
    Prim("sub", ("Int", "Int"), "Int", 1, lambda c, a, b: clamp(a - b), "-"),
    Prim("min", ("Int", "Int"), "Int", 1, lambda c, a, b: min(b, a)),
    Prim("max", ("Int", "Int"), "Int", 1, lambda c, a, b: max(b, a)),
    Prim("abs", ("Int",), "Int", 1, lambda c, a: a if a >= 0 else -a),
    Prim("odd", ("Int",), "Bool", 1, lambda c, a: a & 1 == 1),
    Prim("lt", ("Int", "Int"), "Bool", 1, lambda c, a, b: a < b, "<"),
    Prim("le", ("Int", "Int"), "Bool", 1, lambda c, a, b: a <= b, "<="),
    Prim("eq:Int", ("Int", "Int"), "Bool", 1, lambda c, a, b: a == b, "=="),
    Prim("eq:Sq", ("Sq", "Sq"), "Bool", 1, lambda c, a, b: a is not None and a == b, "=="),
    Prim("eq:Field", ("Field", "Field"), "Bool", 1, lambda c, a, b: a == b, "=="),
    Prim("eq:Bool", ("Bool", "Bool"), "Bool", 1, lambda c, a, b: a == b, "=="),
    # squares
    Prim("file", ("Sq",), "Int", 1, lambda c, s: INF if s is None else s & 7, "0..7"),
    Prim(
        "rank",
        ("Sq",),
        "Int",
        1,
        lambda c, s: INF if s is None else s >> 3,
        "0..7, 0 = strong home",
    ),
    Prim("sq", ("Int", "Int"), "Sq", 4, lambda c, f, r: _board(f, r), "file, rank; none off board"),
    Prim(
        "shift",
        ("Sq", "Int", "Int"),
        "Sq",
        8,
        lambda c, s, f, r: None if s is None else _board((s & 7) + f, (s >> 3) + r),
        "files, ranks",
    ),
    Prim(
        "dist",
        ("Sq", "Sq"),
        "Int",
        9,
        lambda c, s, t: INF if s is None or t is None else _cheb(s, t),
        "king moves",
    ),
    Prim(
        "mdist",
        ("Sq", "Sq"),
        "Int",
        9,
        lambda c, s, t: INF if s is None or t is None else _manh(s, t),
        "Manhattan",
    ),
    Prim(
        "shade",
        ("Sq",),
        "Int",
        3,
        lambda c, s: INF if s is None else (s ^ s >> 3) & 1,
        "0 dark, 1 light",
    ),
    # fields
    Prim("union", ("Field", "Field"), "Field", 1, lambda c, a, b: a | b),
    Prim("inter", ("Field", "Field"), "Field", 1, lambda c, a, b: a & b),
    Prim("minus", ("Field", "Field"), "Field", 1, lambda c, a, b: a & ~b),
    Prim("compl", ("Field",), "Field", 1, lambda c, a: ~a & MASK),
    Prim("one", ("Sq",), "Field", 1, lambda c, s: 0 if s is None else 1 << s),
    Prim("count", ("Field",), "Int", 1, lambda c, a: a.bit_count(), "number of squares"),
    Prim("in", ("Sq", "Field"), "Bool", 2, lambda c, s, a: s is not None and bool(a >> s & 1)),
    Prim("empty", ("Field",), "Bool", 1, lambda c, a: a == 0),
    Prim("rank_f", ("Int",), "Field", 3, lambda c, r: RANK_1 << 8 * r if 0 <= r < 8 else 0),
    Prim("file_f", ("Int",), "Field", 3, lambda c, f: FILE_A << f if 0 <= f < 8 else 0),
    # forces
    Prim(
        "king_f",
        ("Sq",),
        "Field",
        11,
        lambda c, s: 0 if s is None else _king_step(1 << s) & ~(1 << s),
        "king's attack",
    ),
    Prim(
        "ray",
        ("Sq", "Dir", "Field"),
        "Field",
        1,
        lambda c, s, d, o: 0 if s is None else _ray(c, s, d, o),
        "until and including a blocker; 4 per square",
    ),
    Prim(
        "hits",
        ("Side", "Piece", "Sq", "Field"),
        "Field",
        0,
        _hits,
        "attacks of a piece; 6 to about 100",
    ),
    Prim(
        "guard",
        ("Side",),
        "Field",
        0,
        lambda c, a: _guard(c, a, None, c.pos.occ),
        "all squares a side attacks",
    ),
    Prim(
        "guard_x",
        ("Side", "Sq"),
        "Field",
        1,
        lambda c, a, s: _guard(c, a, s, c.pos.occ & ~(0 if s is None else 1 << s)),
        "same, with the man on s removed",
    ),
    Prim("path", ("Side", "Sq"), "Field", 8, p_path, "squares ahead of a pawn"),
    # motion with everything else frozen
    Prim(
        "within",
        ("Sq", "Int", "Field"),
        "Field",
        1,
        lambda c, s, k, f: 0 if s is None or k < 0 else _wave(c, s, f, k, None)[0],
        "at most k king moves through a field; 12 per wave",
    ),
    Prim(
        "flood",
        ("Sq", "Field"),
        "Field",
        1,
        lambda c, s, f: 0 if s is None else _wave(c, s, f, None, None)[0],
        "all reachable; 12 per wave",
    ),
    Prim(
        "steps",
        ("Sq", "Sq", "Field"),
        "Int",
        1,
        p_steps,
        "king moves to t through a field, or inf; 14 per wave",
    ),
)
PRIMS: dict[str, Prim] = {p.name: p for p in _TABLE}
SUGAR_FUNCTIONS = frozenset(
    n for n in PRIMS if ":" not in n and n not in {"add", "sub", "lt", "le", "in"} and PRIMS[n].args
)
ZERO_ARY = frozenset(n for n, p in PRIMS.items() if not p.args)
# Special forms: cost in operations (branch or bookkeeping) when they run
IF_COST = 1
LOGIC_COST = 1
LOOP_COST = 2  # per visited square, plus the body
COUNT_ADD_COST = 1
EXCEPTION_LOOKUP_OPS = 32  # assumption: one succinct lookup of a listed exception


def _productions() -> dict[str, list[str]]:
    """What can produce each type (before variables and defs). Used by the size code."""
    prods: dict[str, list[str]] = {t: [p.name for p in _TABLE if p.ret == t] for t in VALUE_TYPES}
    for t in VALUE_TYPES:
        prods[t] += ["if", "let"]
    prods["Int"] += ["lit", "count_if"]
    prods["Bool"] += ["lit", "and", "or", "not", "any"]
    return prods


PRODUCTIONS = _productions()


def fingerprint() -> str:
    """Pins the language: any change to names, types, costs or rules changes this hash."""
    spec = {
        "version": DSL_VERSION,
        "cap": CAP,
        "tiers": TIERS,
        "inf": INF,
        "lit": [INT_MIN, INT_MAX],
        "prims": [(p.name, p.args, p.ret, p.cost) for p in _TABLE],
        "special": [IF_COST, LOGIC_COST, LOOP_COST, COUNT_ADD_COST, EXCEPTION_LOOKUP_OPS],
        "enums": ENUMS,
        "limits": [MAX_BITS, MAX_SOURCE, MAX_NODES, MAX_DEPTH, MAX_BLOCK],
    }
    return hashlib.sha256(json.dumps(spec, sort_keys=True).encode()).hexdigest()[:16]


# --- program trees -------------------------------------------------------------------------------


@dataclass(frozen=True, slots=True)
class Lit:
    t: str
    v: object


@dataclass(frozen=True, slots=True)
class Var:
    t: str
    slot: int


@dataclass(frozen=True, slots=True)
class App:
    t: str
    prim: str
    args: tuple


@dataclass(frozen=True, slots=True)
class Call:
    t: str
    fn: int  # index into Program.defs
    args: tuple


@dataclass(frozen=True, slots=True)
class Logic:
    t: str
    op: str  # and, or, not
    args: tuple


@dataclass(frozen=True, slots=True)
class If:
    t: str
    c: object
    a: object
    b: object


@dataclass(frozen=True, slots=True)
class Let:
    t: str
    slot: int
    rhs: object
    body: object


@dataclass(frozen=True, slots=True)
class Loop:
    """any (Bool body) or count_if (Bool filter) over the squares of a field."""

    t: str
    op: str
    slot: int
    over: object
    body: object


@dataclass(frozen=True, slots=True)
class Def:
    params: tuple[str, ...]
    ret: str
    body: object
    nslots: int


@dataclass(frozen=True, slots=True)
class Program:
    defs: tuple[Def, ...]  # the last one is wins() -> Bool


# --- parser --------------------------------------------------------------------------------------

# Enum names (strong, rook, N, ...) are not reserved: they mean something only as arguments of men,
# hits, guard and ray, where the constant always wins over a variable of the same name.
_RESERVED = {*PRIMS, *VALUE_TYPES, "wins", "any", "True", "False", "not", "none"}


class _Scope:
    def __init__(self, names: dict[str, tuple[str, int]], counter: list[int]):
        self.names, self.counter = names, counter

    def child(self, name: str, t: str) -> "tuple[_Scope, int]":
        slot = self.counter[0]
        self.counter[0] += 1
        return _Scope({**self.names, name: (t, slot)}, self.counter), slot


class _Parser:
    def __init__(self, defs: dict[str, tuple[tuple[str, ...], str, int]]):
        self.defs = defs
        self.nodes = 0
        self.depth = 0

    def fail(self, node, msg: str):
        raise DslError(f"line {getattr(node, 'lineno', '?')}: {msg}")

    def count(self, node):
        self.nodes += 1
        if self.nodes > MAX_NODES:
            self.fail(node, f"program too large (more than {MAX_NODES} nodes)")

    # statements -> expression tree
    def block(self, stmts: list, scope: _Scope, ret: str):
        if not stmts:
            raise DslError("missing return")
        if len(stmts) > MAX_BLOCK:
            raise DslError(f"more than {MAX_BLOCK} statements")
        st, rest = stmts[0], stmts[1:]
        if (
            isinstance(st, ast.Expr)
            and isinstance(st.value, ast.Constant)
            and isinstance(st.value.value, str)
        ):
            return self.block(rest, scope, ret)  # docstring: free, ignored
        if isinstance(st, ast.Assign):
            if len(st.targets) != 1 or not isinstance(st.targets[0], ast.Name):
                self.fail(st, "assignments are name = expression")
            name = st.targets[0].id
            if name in _RESERVED or name in self.defs:
                self.fail(st, f"{name!r} is reserved")
            if name in scope.names:
                self.fail(st, f"{name!r} is assigned twice")
            rhs = self.expr(st.value, scope)
            if rhs.t not in VALUE_TYPES:
                self.fail(st, "only Int, Bool, Sq and Field can be named")
            self.count(st)
            inner, slot = scope.child(name, rhs.t)
            return Let(ret, slot, rhs, self.block(rest, inner, ret))
        if isinstance(st, ast.Return):
            if rest:
                self.fail(rest[0], "code after return")
            if st.value is None:
                self.fail(st, "return needs a value")
            e = self.expr(st.value, scope)
            if e.t != ret:
                self.fail(st, f"returns {e.t}, expected {ret}")
            return e
        if isinstance(st, ast.If):
            self.depth += 1
            if self.depth > MAX_DEPTH:
                self.fail(st, "too deeply nested")
            cond = self.typed(st.test, scope, "Bool")
            then = self.block(st.body, scope, ret)
            self.depth -= 1
            if st.orelse and rest:
                self.fail(rest[0], "code after a complete if/else")
            if not st.orelse and not rest:
                self.fail(st, "if needs a return after it or an else")
            other = self.block(st.orelse or rest, scope, ret)
            self.count(st)
            return If(ret, cond, then, other)
        self.fail(st, f"{type(st).__name__} is not part of the language")

    def typed(self, node, scope: _Scope, t: str):
        e = self.expr(node, scope)
        if e.t != t:
            self.fail(node, f"expected {t}, got {e.t}")
        return e

    def arg(self, node, scope: _Scope, t: str):
        if t in ENUMS:
            if not isinstance(node, ast.Name) or node.id not in ENUMS[t]:
                self.fail(node, f"expected a {t} constant: {', '.join(ENUMS[t])}")
            self.count(node)
            return Lit(t, node.id)
        return self.typed(node, scope, t)

    def expr(self, node, scope: _Scope):
        self.depth += 1
        if self.depth > MAX_DEPTH:
            self.fail(node, "too deeply nested")
        try:
            self.count(node)
            return self._expr(node, scope)
        finally:
            self.depth -= 1

    def _expr(self, node, scope: _Scope):
        if isinstance(node, ast.Constant):
            v = node.value
            if isinstance(v, bool):
                return Lit("Bool", v)
            if isinstance(v, int):
                if not INT_MIN <= v <= INT_MAX:
                    self.fail(node, f"integer literals are {INT_MIN}..{INT_MAX}")
                return Lit("Int", v)
            self.fail(node, f"literal {v!r} is not allowed")
        if isinstance(node, ast.Name):
            if node.id in scope.names:
                t, slot = scope.names[node.id]
                return Var(t, slot)
            if node.id in ZERO_ARY:
                return App(PRIMS[node.id].ret, node.id, ())
            self.fail(node, f"unknown name {node.id!r}")
        if isinstance(node, ast.UnaryOp):
            if isinstance(node.op, ast.Not):
                return Logic("Bool", "not", (self.typed(node.operand, scope, "Bool"),))
            if isinstance(node.op, ast.USub):
                if isinstance(node.operand, ast.Constant) and type(node.operand.value) is int:
                    v = -node.operand.value
                    if v < INT_MIN:
                        self.fail(node, f"integer literals are {INT_MIN}..{INT_MAX}")
                    return Lit("Int", v)
                return App("Int", "sub", (Lit("Int", 0), self.typed(node.operand, scope, "Int")))
        if isinstance(node, ast.BinOp) and isinstance(node.op, (ast.Add, ast.Sub)):
            op = "add" if isinstance(node.op, ast.Add) else "sub"
            return App(
                "Int",
                op,
                (self.typed(node.left, scope, "Int"), self.typed(node.right, scope, "Int")),
            )
        if isinstance(node, ast.BoolOp):
            op = "and" if isinstance(node.op, ast.And) else "or"
            if len(node.values) > MAX_BLOCK:
                self.fail(node, f"more than {MAX_BLOCK} operands in one {op}")
            parts = [self.typed(v, scope, "Bool") for v in node.values]
            out = parts[-1]
            for p in reversed(parts[:-1]):
                self.count(node)
                out = Logic("Bool", op, (p, out))
            return out
        if isinstance(node, ast.Compare):
            return self.compare(node, scope)
        if isinstance(node, ast.IfExp):
            c = self.typed(node.test, scope, "Bool")
            a, b = self.expr(node.body, scope), self.expr(node.orelse, scope)
            if a.t != b.t or a.t not in VALUE_TYPES:
                self.fail(node, f"if branches differ: {a.t} and {b.t}")
            return If(a.t, c, a, b)
        if isinstance(node, ast.Call):
            return self.call(node, scope)
        self.fail(node, f"{type(node).__name__} is not part of the language")

    def compare(self, node, scope):
        if len(node.ops) != 1:
            self.fail(node, "chained comparisons are not allowed")
        op, a, b = node.ops[0], self.expr(node.left, scope), self.expr(node.comparators[0], scope)
        if isinstance(op, (ast.In, ast.NotIn)):
            if a.t != "Sq" or b.t != "Field":
                self.fail(node, "in needs a Sq and a Field")
            e = App("Bool", "in", (a, b))
            return Logic("Bool", "not", (e,)) if isinstance(op, ast.NotIn) else e
        if isinstance(op, (ast.Eq, ast.NotEq)):
            if a.t != b.t or a.t not in VALUE_TYPES:
                self.fail(node, f"cannot compare {a.t} with {b.t}")
            e = App("Bool", f"eq:{a.t}", (a, b))
            return Logic("Bool", "not", (e,)) if isinstance(op, ast.NotEq) else e
        table = {ast.Lt: ("lt", 0), ast.LtE: ("le", 0), ast.Gt: ("lt", 1), ast.GtE: ("le", 1)}
        if type(op) not in table:
            self.fail(node, f"{type(op).__name__} is not part of the language")
        name, swap = table[type(op)]
        if a.t != "Int" or b.t != "Int":
            self.fail(node, "comparisons need Int")
        return App("Bool", name, (b, a) if swap else (a, b))

    def call(self, node, scope):
        if not isinstance(node.func, ast.Name) or node.keywords:
            self.fail(node, "calls are name(arguments) with a primitive or an earlier def")
        name = node.func.id
        if name == "any" or (
            name == "count" and len(node.args) == 1 and isinstance(node.args[0], ast.GeneratorExp)
        ):
            return self.loop(node, name, scope)
        if name in self.defs:
            params, ret, index = self.defs[name]
            if len(params) != len(node.args):
                self.fail(node, f"{name} takes {len(params)} arguments")
            args = tuple(self.arg(a, scope, t) for a, t in zip(node.args, params, strict=True))
            return Call(ret, index, args)
        if name in SUGAR_FUNCTIONS:
            p = PRIMS[name]
            if name in ("min", "max") and len(node.args) > 2:
                if len(node.args) > MAX_BLOCK:
                    self.fail(node, f"more than {MAX_BLOCK} operands in one {name}")
                out = self.typed(node.args[0], scope, "Int")
                for a in node.args[1:]:
                    self.count(node)
                    out = App("Int", name, (out, self.typed(a, scope, "Int")))
                return out
            if len(p.args) != len(node.args):
                self.fail(node, f"{name} takes {len(p.args)} arguments")
            return App(
                p.ret,
                name,
                tuple(self.arg(a, scope, t) for a, t in zip(node.args, p.args, strict=True)),
            )
        self.fail(node, f"unknown function {name!r}")

    def loop(self, node, name, scope):
        if len(node.args) != 1 or not isinstance(node.args[0], ast.GeneratorExp):
            self.fail(node, f"{name} takes a generator: {name}(... for s in Field)")
        gen = node.args[0]
        if (
            len(gen.generators) != 1
            or gen.generators[0].is_async
            or not isinstance(gen.generators[0].target, ast.Name)
        ):
            self.fail(node, "loops are over one variable")
        g = gen.generators[0]
        var = g.target.id
        if var in _RESERVED or var in self.defs or var in scope.names:
            self.fail(node, f"{var!r} is not a free name")
        over = self.typed(g.iter, scope, "Field")
        inner, slot = scope.child(var, "Sq")
        conds = [self.typed(c, inner, "Bool") for c in g.ifs]
        if name == "any":
            body = [*conds, self.typed(gen.elt, inner, "Bool")]
            op, t = "any", "Bool"
        else:
            if not isinstance(gen.elt, ast.Name) or gen.elt.id != var:
                self.fail(node, "count(s for s in Field if condition) must count the loop variable")
            if not conds:
                self.fail(node, "count without a condition is count(Field)")
            body, op, t = conds, "count_if", "Int"
        out = body[-1]
        for p in reversed(body[:-1]):
            out = Logic("Bool", "and", (p, out))
        return Loop(t, op, slot, over, out)


def parse(source: str) -> Program:
    """Text to a typed, checked program. Raises DslError."""
    if len(source) > MAX_SOURCE:
        raise DslError(f"source longer than {MAX_SOURCE} characters")
    try:
        tree = ast.parse(source)
    except (SyntaxError, ValueError, RecursionError, MemoryError) as e:
        raise DslError(f"syntax: {e}") from None
    try:
        return _program(tree)
    except RecursionError:
        raise DslError("too deeply nested") from None


def _program(tree: ast.Module) -> Program:
    body = [
        n
        for n in tree.body
        if not (
            isinstance(n, ast.Expr)
            and isinstance(n.value, ast.Constant)
            and isinstance(n.value.value, str)
        )
    ]
    if not body or not all(isinstance(n, ast.FunctionDef) for n in body):
        raise DslError("a program is a list of def statements, the last one wins() -> Bool")
    defs: dict[str, tuple[tuple[str, ...], str, int]] = {}
    out: list[Def] = []
    for i, fn in enumerate(body):
        last = i == len(body) - 1
        if (fn.name == "wins") != last:
            raise DslError(
                f"line {fn.lineno}: {'the last def must be wins()' if last else 'wins() must be last'}"
            )
        if fn.name in _RESERVED - {"wins"} or fn.name in defs:
            raise DslError(f"line {fn.lineno}: {fn.name!r} is reserved or defined twice")
        a = fn.args
        if fn.decorator_list or a.posonlyargs or a.kwonlyargs or a.vararg or a.kwarg or a.defaults:
            raise DslError(f"line {fn.lineno}: only plain annotated parameters are allowed")
        params = tuple(_annotation(x.annotation, fn) for x in a.args)
        ret = _annotation(fn.returns, fn)
        if last and (params or ret != "Bool"):
            raise DslError(f"line {fn.lineno}: wins() takes nothing and returns Bool")
        names: dict[str, tuple[str, int]] = {}
        for j, (x, t) in enumerate(zip(a.args, params, strict=True)):
            if x.arg in _RESERVED or x.arg in names or x.arg in defs:
                raise DslError(f"line {fn.lineno}: parameter {x.arg!r} is reserved or repeated")
            names[x.arg] = (t, j)
        counter = [len(params)]
        p = _Parser(defs)
        tree_body = p.block(fn.body, _Scope(names, counter), ret)
        out.append(Def(params, ret, tree_body, counter[0]))
        defs[fn.name] = (params, ret, i)
    program = Program(tuple(out))
    if size_bits(program) > MAX_BITS:
        raise DslError(f"program larger than {MAX_BITS // 8:,} bytes of grammar code")
    return program


def _annotation(node, fn) -> str:
    if isinstance(node, ast.Name) and node.id in VALUE_TYPES:
        return node.id
    raise DslError(
        f"line {fn.lineno}: annotate every parameter and the return with {', '.join(VALUE_TYPES)}"
    )


# --- size of a program (D3): uniform code over the typed grammar ---------------------------------


def size_bits(program: Program) -> float:
    """Length in bits. At each node the code chooses among everything that can produce the required
    type there (primitives, special forms, variables in scope, earlier defs)."""
    total = 1.0  # end of the list of defs
    for i, d in enumerate(program.defs):
        if i < len(program.defs) - 1:
            total += 1  # "another def"
            total += (
                sum(1 + math.log2(len(VALUE_TYPES)) for _ in d.params)
                + 1
                + math.log2(len(VALUE_TYPES))
            )
        earlier = Counter(p.ret for p in program.defs[:i])
        total += _bits(d.body, Counter(d.params), earlier, program)
    return total


def _bits(e, vars_: Counter, defs: Counter, program: Program) -> float:
    t = e.t
    if t in ENUMS:
        return math.log2(len(ENUMS[t]))
    n = len(PRODUCTIONS[t]) + vars_[t] + defs[t]
    bits = math.log2(n)
    match e:
        case Lit():
            return bits + (1.0 if t == "Bool" else math.log2(INT_MAX - INT_MIN + 1))
        case Var():
            return bits
        case App():
            return bits + sum(_bits(a, vars_, defs, program) for a in e.args)
        case Call():
            return bits + sum(_bits(a, vars_, defs, program) for a in e.args)
        case Logic():
            return bits + sum(_bits(a, vars_, defs, program) for a in e.args)
        case If():
            return bits + sum(_bits(x, vars_, defs, program) for x in (e.c, e.a, e.b))
        case Let():
            inner = Counter(vars_)
            inner[e.rhs.t] += 1
            return (
                bits
                + math.log2(len(VALUE_TYPES))
                + _bits(e.rhs, vars_, defs, program)
                + _bits(e.body, inner, defs, program)
            )
        case Loop():
            inner = Counter(vars_)
            inner["Sq"] += 1
            return bits + _bits(e.over, vars_, defs, program) + _bits(e.body, inner, defs, program)
    raise AssertionError(e)


# --- canonical text ------------------------------------------------------------------------------


def canonical(program: Program) -> str:
    """Same program, fixed names and layout. Parses back to the same tree."""
    lines: list[str] = []
    for i, d in enumerate(program.defs):
        names = {j: f"p{j}" for j in range(len(d.params))}
        head = f"def {'wins' if i == len(program.defs) - 1 else f'f{i}'}({', '.join(f'p{j}: {t}' for j, t in enumerate(d.params))}) -> {d.ret}:"
        lines.append(head)
        _block_text(d.body, names, lines, 1)
    return "\n".join(lines) + "\n"


def _name(slot: int, names: dict[int, str]) -> str:
    return names.setdefault(slot, f"x{slot}")


def _has_let(e) -> bool:
    return isinstance(e, Let) or (isinstance(e, If) and (_has_let(e.a) or _has_let(e.b)))


def _block_text(e, names, lines, depth):
    pad = "    " * depth
    if isinstance(e, Let):
        # render before naming, so the right side cannot refer to itself
        rhs = _text(e.rhs, names)
        lines.append(f"{pad}{_name(e.slot, names)} = {rhs}")
        _block_text(e.body, names, lines, depth)
    elif isinstance(e, If) and (_has_let(e.a) or _has_let(e.b)):
        lines.append(f"{pad}if {_text(e.c, names)}:")
        _block_text(e.a, dict(names), lines, depth + 1)
        lines.append(f"{pad}else:")
        _block_text(e.b, dict(names), lines, depth + 1)
    else:
        lines.append(f"{pad}return {_text(e, names)}")


_OPS = {"add": "+", "sub": "-", "lt": "<", "le": "<=", "in": "in"}


def _text(e, names) -> str:
    match e:
        case Lit():
            return str(e.v)
        case Var():
            return _name(e.slot, names)
        case App():
            a = [_text(x, names) for x in e.args]
            if e.prim.startswith("eq:"):
                return f"({a[0]} == {a[1]})"
            if e.prim in _OPS:
                return f"({a[0]} {_OPS[e.prim]} {a[1]})"
            return e.prim if not a else f"{e.prim}({', '.join(a)})"
        case Call():
            return f"f{e.fn}({', '.join(_text(x, names) for x in e.args)})"
        case Logic():
            a = [_text(x, names) for x in e.args]
            return f"(not {a[0]})" if e.op == "not" else f"({a[0]} {e.op} {a[1]})"
        case If():
            return f"({_text(e.a, names)} if {_text(e.c, names)} else {_text(e.b, names)})"
        case Loop():
            over = _text(e.over, names)
            v = _name(e.slot, names)
            if e.op == "any":
                return f"any({_text(e.body, names)} for {v} in {over})"
            return f"count({v} for {v} in {over} if {_text(e.body, names)})"
    raise DslError(f"cannot write {type(e).__name__} as an expression")


# --- evaluation ----------------------------------------------------------------------------------


def compile_program(program: Program) -> Callable[[Ctx], bool]:
    """Closure tree: program(ctx) -> Bool, adding to ctx.ops. Raises OpLimit above ctx.cap."""
    fns: list[Callable] = []
    for d in program.defs:
        body = _compile(d.body, fns)
        fns.append((body, d.nslots))
    body, nslots = fns[-1]

    def run(c: Ctx) -> bool:
        out = body([None] * nslots, c)
        if c.ops > c.cap:
            raise OpLimit
        return out

    return run


def _compile(e, fns) -> Callable:
    match e:
        case Lit():
            v = e.v
            return lambda env, c: v
        case Var():
            s = e.slot
            return lambda env, c: env[s]
        case App():
            return _compile_app(e, fns)
        case Call():
            args = [_compile(a, fns) for a in e.args]
            index = e.fn

            def call(env, c):
                body, nslots = fns[index]
                inner = [None] * nslots
                for i, a in enumerate(args):
                    inner[i] = a(env, c)
                return body(inner, c)

            return call
        case Logic():
            args = [_compile(a, fns) for a in e.args]
            if e.op == "not":
                a0 = args[0]

                def not_(env, c):
                    c.ops += LOGIC_COST
                    return not a0(env, c)

                return not_
            x, y = args
            if e.op == "and":

                def and_(env, c):
                    c.ops += LOGIC_COST
                    return x(env, c) and y(env, c)

                return and_

            def or_(env, c):
                c.ops += LOGIC_COST
                return x(env, c) or y(env, c)

            return or_
        case If():
            cond, a, b = _compile(e.c, fns), _compile(e.a, fns), _compile(e.b, fns)

            def if_(env, c):
                c.ops += IF_COST
                return a(env, c) if cond(env, c) else b(env, c)

            return if_
        case Let():
            rhs, body, slot = _compile(e.rhs, fns), _compile(e.body, fns), e.slot

            def let(env, c):
                env[slot] = rhs(env, c)
                return body(env, c)

            return let
        case Loop():
            over, body, slot = _compile(e.over, fns), _compile(e.body, fns), e.slot
            if e.op == "any":

                def any_(env, c):
                    field = over(env, c)
                    while field:
                        c.spend(LOOP_COST)
                        low = field & -field
                        env[slot] = low.bit_length() - 1
                        if body(env, c):
                            return True
                        field ^= low
                    return False

                return any_

            def count_(env, c):
                field, n = over(env, c), 0
                while field:
                    c.spend(LOOP_COST + COUNT_ADD_COST)
                    low = field & -field
                    env[slot] = low.bit_length() - 1
                    n += bool(body(env, c))
                    field ^= low
                return n

            return count_
    raise AssertionError(e)


def _compile_app(e: App, fns) -> Callable:
    p = PRIMS[e.prim]
    cost, fn = p.cost, p.fn
    args = [_compile(a, fns) for a in e.args]
    if not args:

        def app0(env, c):
            c.ops += cost
            return fn(c)

        return app0
    if len(args) == 1:
        (a0,) = args

        def app1(env, c):
            c.ops += cost
            return fn(c, a0(env, c))

        return app1
    if len(args) == 2:
        a0, a1 = args

        def app2(env, c):
            c.ops += cost
            return fn(c, a0(env, c), a1(env, c))

        return app2
    parts = args

    def appn(env, c):
        c.ops += cost
        return fn(c, *[a(env, c) for a in parts])

    return appn


def spec() -> str:
    """The language as text, generated from the tables (also the base of the Phase 2 prompt)."""
    out = [
        f"DSL {DSL_VERSION}, fingerprint {fingerprint()}",
        "",
        "def name(p: Type, ...) -> Type: name = expr ... return expr; if cond: return ... else: ...; the last def is wins() -> Bool",
        f"Types {', '.join(VALUE_TYPES)}; Int literals {INT_MIN}..{INT_MAX}; operators + - < <= > >= == != in, not in, and, or, not, x if c else y",
        "Loops: any(condition for s in Field), count(s for s in Field if condition)",
        "",
        f"{'name':<9}{'arguments':<26}{'returns':<8}{'ops':>4}  note",
    ]
    out += [f"{p.name:<9}{', '.join(p.args):<26}{p.ret:<8}{p.cost:>4}  {p.note}" for p in _TABLE]
    out += [
        "",
        *(f"{t}: {', '.join(v)}" for t, v in ENUMS.items()),
        f"if {IF_COST}, and/or/not {LOGIC_COST}, loop {LOOP_COST} per square (+{COUNT_ADD_COST} when counting), ops cap {CAP}, tiers {TIERS}",
    ]
    return "\n".join(out)
