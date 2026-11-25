"""Language tests: primitives against python-chess and brute force, costs, parser, size, fuzz."""

import math
import random

import pytest

from chess_forces import dsl
from chess_forces.dsl import INF, PRIMS, Ctx, DslError, OpLimit, Position

chess = pytest.importorskip("chess")


def random_position(rng, extra=3):
    squares = rng.sample(range(64), 2 + extra)
    men = [("strong", "king", squares[0]), ("weak", "king", squares[1])]
    men += [
        (rng.choice(dsl.SIDES), rng.choice(("pawn", "knight", "bishop", "rook", "queen")), s)
        for s in squares[2:]
    ]
    return Position(men, rng.randint(0, 1))


def call(name, pos, *args):
    return PRIMS[name].fn(Ctx(pos, 10**9), *args)


def to_board(pos):
    b = chess.Board(None)
    for side, kind, s in pos.men:
        b.set_piece_at(s, chess.Piece(chess.PIECE_NAMES.index(kind), side == "strong"))
    return b


def attacks_of(board, color):
    out = 0
    for q in board.piece_map():
        if board.color_at(q) == color:
            out |= board.attacks_mask(q)
    return out


# --- primitives ----------------------------------------------------------------------------------


def test_distances_match_python_chess():
    for s in range(64):
        assert call("shade", None, s) == (0 if chess.BB_SQUARES[s] & chess.BB_DARK_SQUARES else 1)
        for t in range(64):
            assert call("dist", None, s, t) == chess.square_distance(s, t)
            assert call("mdist", None, s, t) == chess.square_manhattan_distance(s, t)


def test_hits_and_guard_match_python_chess():
    rng = random.Random(1)
    for _ in range(300):
        pos = random_position(rng, extra=6)
        board = to_board(pos)
        for side in dsl.SIDES:
            for piece in dsl.PIECES:
                s = rng.randrange(64)
                b = board.copy()
                b.set_piece_at(s, chess.Piece(chess.PIECE_NAMES.index(piece), side == "strong"))
                occ = sum(1 << q for q in b.piece_map())
                assert call("hits", pos, side, piece, s, occ) == b.attacks_mask(s), (side, piece, s)
            assert call("guard", pos, side) == attacks_of(board, side == "strong")


def test_guard_x_removes_the_man_and_sees_through_it():
    rng = random.Random(7)
    for _ in range(300):
        pos = random_position(rng, extra=5)
        s = rng.choice(pos.men)[2]
        for side in dsl.SIDES:
            b = to_board(pos)
            b.remove_piece_at(s)
            assert call("guard_x", pos, side, s) == attacks_of(b, side == "strong")


def test_ray_and_king_f():
    pos = Position([("strong", "king", 0), ("weak", "king", 63)], 1)
    for s in range(64):
        assert call("king_f", pos, s) == chess.BB_KING_ATTACKS[s]
        for d in dsl.DIRS:
            df, dr = dsl.KING_DIRS[d]
            want, f, r = 0, (s & 7) + df, (s >> 3) + dr
            while 0 <= f < 8 and 0 <= r < 8:
                want |= 1 << (r * 8 + f)
                f, r = f + df, r + dr
            assert call("ray", pos, s, d, 0) == want


def test_path_is_the_squares_ahead():
    for s in range(64):
        assert call("path", None, "strong", s) == sum(1 << q for q in range(s + 8, 64, 8))
        assert call("path", None, "weak", s) == sum(1 << q for q in range(s - 8, -1, -8))


def brute_force(start, field, limit=None):
    """Dict square -> king moves through field, by plain breadth-first search."""
    seen, frontier, n = {start: 0}, [start], 0
    while frontier and (limit is None or n < limit):
        n += 1
        frontier = [
            t
            for s in frontier
            for t in range(64)
            if chess.square_distance(s, t) == 1
            and field >> t & 1
            and t not in seen
            and not seen.update({t: n})
        ]
    return seen


def test_flood_within_steps_match_brute_force():
    rng = random.Random(2)
    pos = Position([("strong", "king", 0), ("weak", "king", 63)], 1)
    for _ in range(300):
        field = rng.getrandbits(64) | (rng.getrandbits(64) & rng.getrandbits(64))
        s, t, k = rng.randrange(64), rng.randrange(64), rng.randrange(6)
        seen = brute_force(s, field)
        assert call("flood", pos, s, field) == sum(1 << q for q in seen)
        assert call("within", pos, s, k, field) == sum(1 << q for q in brute_force(s, field, k))
        assert call("steps", pos, s, t, field) == (
            seen.get(t, INF) if t == s or field >> t & 1 else INF
        )


def test_none_gives_the_documented_answers():
    pos = Position([("strong", "king", 0), ("weak", "king", 63)], 1)  # no pawn, so P is none
    assert pos.P is None
    assert call("dist", pos, None, 5) == INF
    assert call("in", pos, None, dsl.MASK) is False
    assert call("one", pos, None) == 0
    assert call("eq:Sq", pos, None, None) is False
    assert call("flood", pos, None, dsl.MASK) == 0
    assert call("steps", pos, None, 3, dsl.MASK) == INF
    assert call("sq", pos, 8, 0) is None and call("shift", pos, 0, -1, 0) is None


def test_integers_saturate():
    assert call("add", None, 99, 63) == 99
    assert call("sub", None, -99, 63) == -99


# --- costs ---------------------------------------------------------------------------------------


def cost_of(expr, pos=None, cap=10**9):
    prog = dsl.compile_program(dsl.parse(f"def wins() -> Bool:\n    return {expr}\n"))
    c = Ctx(
        pos or Position([("strong", "king", 0), ("weak", "king", 63), ("strong", "pawn", 8)], 1),
        cap,
    )
    return prog(c), c.ops


def test_hand_counted_costs():
    assert cost_of("dist(K, k) < 8") == (True, 12)  # load K, load k, dist 9, less-than 1
    assert cost_of("empty(one(K))") == (False, 3)
    assert cost_of("K in king_f(K)") == (False, 15)  # in 2, two loads, king_f 11
    assert cost_of("not (tempo == 0)") == (True, 3)
    assert cost_of("True if tempo == 1 else False") == (True, 3)


def test_hit_costs_by_hand():
    board = Position([("strong", "king", 0), ("weak", "king", 63)], 1)
    # hits has no fixed cost: the piece decides; + occ load, K load, and empty 1 for the comparison
    assert cost_of("empty(hits(strong, king, K, occ))", board)[1] == 11 + 3
    assert cost_of("empty(hits(strong, knight, K, occ))", board)[1] == 18 + 3
    assert cost_of("empty(hits(strong, pawn, K, occ))", board)[1] == 6 + 3
    # rook on a1 of an empty board: 4 rays, 14 squares at 4 each, plus 1 per ray
    assert cost_of("empty(hits(strong, rook, K, occ))", board)[1] == 4 + 14 * 4 + 3
    assert cost_of("empty(ray(K, N, occ))", board)[1] == 1 + 7 * 4 + 3
    assert cost_of("empty(guard(strong))", board)[1] == 1 + 11 + 1
    # a square that cannot be entered is recognised at once: steps 1, K, k, one(K) 2, == 1
    assert cost_of("steps(K, k, one(K)) == inf", board) == (True, 1 + 1 + 1 + 2 + 1)


def test_and_or_if_are_lazy():
    costly = "empty(flood(K, compl(one(k))))"
    assert cost_of(f"False and {costly}") == (False, 1)
    assert cost_of(f"True or {costly}") == (True, 1)
    assert cost_of(f"True if True else {costly}")[1] == 1


def test_waves_and_loops_are_counted_exactly():
    two_kings = Position([("strong", "king", 0), ("weak", "king", 63)], 1)
    # 7 waves reach every square, the 8th shows that nothing changed: 8 * 12, plus flood 1, K 1,
    # compl 1, occ 1, count 1, == 1
    assert cost_of("count(flood(K, compl(occ))) == 0", two_kings) == (False, 8 * 12 + 6)
    assert cost_of("any(False for s in rank_f(0))", two_kings) == (False, 3 + 8 * 2)
    assert cost_of("any(True for s in rank_f(0))", two_kings) == (True, 3 + 2)  # stops at once
    assert cost_of("count(s for s in rank_f(0) if True) == 8", two_kings) == (True, 3 + 8 * 3 + 1)


def test_operation_cap_is_enforced():
    heavy = (
        "any(any(any(any(dist(a, b) == inf for a in compl(one(d))) for b in compl(one(c)))"
        " for c in compl(one(K))) for d in compl(one(k)))"
    )
    with pytest.raises(OpLimit):
        cost_of(heavy, cap=dsl.CAP)


def test_the_cap_applies_to_straight_line_programs_too():
    assert cost_of("dist(K, k) < 8", cap=12) == (True, 12)
    with pytest.raises(OpLimit):
        cost_of("dist(K, k) < 8", cap=11)


def test_size_of_names_by_hand():
    b, i, sq = (math.log2(len(dsl.PRODUCTIONS[t])) for t in ("Bool", "Int", "Sq"))
    # Bool let: let + type choice + dist(K, k) + lt(Int var, Int literal), with one Int name in scope
    n_int = math.log2(len(dsl.PRODUCTIONS["Int"]) + 1)
    let = b + 2 + (i + 2 * sq) + b + n_int + (n_int + math.log2(72))
    got = dsl.size_bits(dsl.parse("def wins() -> Bool:\n    d = dist(K, k)\n    return d < 3\n"))
    assert got == pytest.approx(1 + let)


def test_size_of_a_loop_variable_by_hand():
    b, f = (math.log2(len(dsl.PRODUCTIONS[t])) for t in ("Bool", "Field"))
    n_sq = math.log2(len(dsl.PRODUCTIONS["Sq"]) + 1)
    # any(s in occ for s in occ): any + occ, then in(s, occ) with one Sq name in scope
    got = dsl.size_bits(dsl.parse("def wins() -> Bool:\n    return any(s in occ for s in occ)\n"))
    assert got == pytest.approx(1 + b + f + (b + n_sq + f))


def test_size_of_defs_by_hand():
    # one parameter: "another def" 1, parameter 1 + 2, end of parameters 1, return type 2; then body
    n_sq, b_with_f = (
        math.log2(len(dsl.PRODUCTIONS["Sq"]) + 1),
        math.log2(len(dsl.PRODUCTIONS["Bool"]) + 1),
    )
    f_bits = (
        math.log2(len(dsl.PRODUCTIONS["Bool"])) + n_sq + math.log2(len(dsl.PRODUCTIONS["Field"]))
    )
    src = "def near(s: Sq) -> Bool:\n    return s in occ\ndef wins() -> Bool:\n    return near(K)\n"
    got = dsl.size_bits(dsl.parse(src))
    want = 1 + (1 + (1 + 2) + 1 + 2) + f_bits + b_with_f + math.log2(len(dsl.PRODUCTIONS["Sq"]))
    assert got == pytest.approx(want)


# --- parser --------------------------------------------------------------------------------------


def test_programs_that_must_parse():
    for text in (
        "def wins() -> Bool:\n    return True\n",
        'def wins() -> Bool:\n    "docstring is free"\n    return K in king_f(k)\n',
        "def far(a: Sq, b: Sq) -> Bool:\n    return dist(a, b) > 3\ndef wins() -> Bool:\n    return far(K, k)\n",
        "def wins() -> Bool:\n    if tempo == 1:\n        n = 3\n        return dist(K, k) < n\n    return False\n",
        "def wins() -> Bool:\n    x = -3\n    return abs(x - 5) >= 8\n",
        "def wins() -> Bool:\n    return min(1, 2, 3) == 1 and K not in path(strong, P)\n",
        "def wins() -> Bool:\n    pawn = 3\n    strong = file(P)\n    return pawn < strong and empty(men(strong, rook))\n",
    ):
        dsl.parse(text)


W = "def wins() -> Bool:\n    return "
REJECTED = [
    (W + "nope(1)\n", "unknown function"),
    (W + "unknown == 1\n", "unknown name"),
    (W + "64 == 64\n", "integer literals"),
    (W + "-9 == 1\n", "integer literals"),
    (W + "'data' == 'data'\n", "literal"),
    (W + "0.5 == 1\n", "literal"),
    (W + "tempo + 1\n", "returns Int"),
    (W + "K + 1 == 2\n", "expected Int"),
    (W + "1 < 2 < 3\n", "chained"),
    (W + "hits(strong, dragon, K, occ) == occ\n", "Piece constant"),
    (W + "(lambda: True)()\n", "calls are name"),
    (W + "K.x\n", "Attribute"),
    (W + "[s for s in occ]\n", "ListComp"),
    (W + "any(True for s in 5)\n", "expected Field"),
    (W + "any(True for s in occ for t in occ)\n", "one variable"),
    (W + "count(1 for s in occ)\n", "count"),
    (W + "count(s for s in occ)\n", "condition"),
    (W + "sq(1)\n", "2 arguments"),
    (W + "all(True for s in occ)\n", "unknown function"),
    (W + "abs(" * 70 + "1" + ")" * 70 + " == 1\n", "deeply nested"),
    (W + " and ".join(["True"] * 700) + "\n", "too large"),
    ("import os\ndef wins() -> Bool:\n    return True\n", "list of def"),
    ("def wins() -> Bool:\n    import os\n    return True\n", "Import"),
    ("def wins() -> Bool:\n    while True:\n        pass\n    return True\n", "While"),
    ("def wins(x: Sq) -> Bool:\n    return True\n", "takes nothing"),
    ("def wins() -> Int:\n    return 1\n", "returns Bool"),
    ("def wins() -> Bool:\n    x = 1\n    x = 2\n    return True\n", "assigned twice"),
    ("def wins() -> Bool:\n    K = 1\n    return True\n", "reserved"),
    ("def wins() -> Bool:\n    n = strong\n    return True\n", "unknown name"),
    ("def f() -> Bool:\n    return f()\ndef wins() -> Bool:\n    return f()\n", "unknown function"),
    (
        "def wins() -> Bool:\n    return True\ndef extra() -> Bool:\n    return True\n",
        "must be last|last def",
    ),
    ("def a(x) -> Bool:\n    return True\ndef wins() -> Bool:\n    return True\n", "annotate"),
    ("def wins() -> Bool:\n    if tempo == 1:\n        return True\n", "needs a return"),
    ("def wins() -> Bool:\n    n = 1\n", "missing return"),
    (
        "def wins() -> Bool:\n"
        + "".join(f"    v{i} = {i % 9}\n" for i in range(150))
        + "    return True\n",
        "statements",
    ),
    ("x" * 9000, "longer than"),
    ("def wins() -> Bool:\n    return (\n", "syntax"),
]


@pytest.mark.parametrize(("text", "match"), REJECTED)
def test_programs_that_must_be_rejected(text, match):
    with pytest.raises(DslError, match=match):
        dsl.parse(text)


def test_if_statement_equals_if_expression():
    a = dsl.parse(
        "def wins() -> Bool:\n    if tempo == 1:\n        return dist(K, k) < 3\n    return False\n"
    )
    b = dsl.parse("def wins() -> Bool:\n    return dist(K, k) < 3 if tempo == 1 else False\n")
    assert dsl.canonical(a) == dsl.canonical(b) and dsl.size_bits(a) == dsl.size_bits(b)


# --- size and canonical text ---------------------------------------------------------------------


def bits(expr):
    return dsl.size_bits(dsl.parse(f"def wins() -> Bool:\n    return {expr}\n"))


def test_size_of_the_smallest_program_by_hand():
    assert bits("True") == pytest.approx(1 + math.log2(len(dsl.PRODUCTIONS["Bool"])) + 1)


def test_size_by_hand_with_a_primitive():
    b, i, s = (math.log2(len(dsl.PRODUCTIONS[t])) for t in ("Bool", "Int", "Sq"))
    want = 1 + b + (i + 2 * s) + (i + math.log2(72))  # lt( dist(K, k), 3 )
    assert bits("dist(K, k) < 3") == pytest.approx(want)


def test_naming_a_repeated_part_saves_bits():
    shared = dsl.size_bits(
        dsl.parse("def wins() -> Bool:\n    d = dist(K, k)\n    return d < 3 and d < 5 and d < 7\n")
    )
    assert shared < bits("dist(K, k) < 3 and dist(K, k) < 5 and dist(K, k) < 7")
    assert bits("tempo == 1") == bits("tempo == 63")


def test_fingerprint_is_pinned():
    """If this fails the language changed: bump DSL_VERSION, rescore everything, then update the pin."""
    assert dsl.fingerprint() == PINNED


PINNED = "09950c6270d21930"


# --- fuzz ----------------------------------------------------------------------------------------


class Gen:
    """Random typed programs as trees. Let appears only in tail position, as in parsed text."""

    def __init__(self, rng):
        self.rng = rng

    def program(self):
        self.defs = []
        for _ in range(self.rng.randrange(3)):
            params = tuple(self.rng.choice(dsl.VALUE_TYPES) for _ in range(self.rng.randrange(3)))
            ret = self.rng.choice(dsl.VALUE_TYPES)
            self.slots = len(params)
            vars_ = {t: [i for i, x in enumerate(params) if x == t] for t in dsl.VALUE_TYPES}
            self.defs.append(dsl.Def(params, ret, self.expr(ret, vars_, 3, True), self.slots))
        self.slots = 0
        body = self.expr("Bool", {t: [] for t in dsl.VALUE_TYPES}, 4, True)
        self.defs.append(dsl.Def((), "Bool", body, self.slots))
        return dsl.Program(tuple(self.defs))

    def expr(self, t, vars_, depth, tail=False):
        rng = self.rng
        prims = [p for p in dsl._TABLE if p.ret == t and not (depth <= 0 and p.args)]
        calls = [i for i, d in enumerate(self.defs) if d.ret == t]
        options = (
            ["lit"] * (t in ("Int", "Bool")) + ["var"] * bool(vars_[t]) + ["prim"] * 3 * bool(prims)
        )
        if depth > 0:
            options += ["if"] + ["let"] * tail + ["call"] * bool(calls)
            options += {"Bool": ["logic", "any"], "Int": ["count_if"]}.get(t, [])
        if not options:
            options = ["lit"]
        kind = rng.choice(options)
        if kind == "lit":
            return dsl.Lit(t, rng.random() < 0.5 if t == "Bool" else rng.randint(-8, 63))
        if kind == "var":
            return dsl.Var(t, rng.choice(vars_[t]))
        if kind == "prim":
            p = rng.choice(prims)
            return dsl.App(
                t,
                p.name,
                tuple(
                    dsl.Lit(a, rng.choice(dsl.ENUMS[a]))
                    if a in dsl.ENUMS
                    else self.expr(a, vars_, depth - 1)
                    for a in p.args
                ),
            )
        if kind == "if":
            return dsl.If(
                t,
                self.expr("Bool", vars_, depth - 1),
                self.expr(t, vars_, depth - 1, tail),
                self.expr(t, vars_, depth - 1, tail),
            )
        if kind == "logic":
            op = rng.choice(("and", "or", "not"))
            return dsl.Logic(
                "Bool",
                op,
                tuple(self.expr("Bool", vars_, depth - 1) for _ in range(1 if op == "not" else 2)),
            )
        if kind == "let":
            rt = rng.choice(dsl.VALUE_TYPES)
            rhs = self.expr(rt, vars_, depth - 1)
            slot, self.slots = self.slots, self.slots + 1
            inner = {k: [*v] for k, v in vars_.items()}
            inner[rt].append(slot)
            return dsl.Let(t, slot, rhs, self.expr(t, inner, depth - 1, True))
        if kind in ("any", "count_if"):
            over = self.expr("Field", vars_, depth - 1)
            slot, self.slots = self.slots, self.slots + 1
            inner = {k: [*v] for k, v in vars_.items()}
            inner["Sq"].append(slot)
            return dsl.Loop(t, kind, slot, over, self.expr("Bool", inner, depth - 1))
        i = rng.choice(calls)
        return dsl.Call(t, i, tuple(self.expr(a, vars_, depth - 1) for a in self.defs[i].params))


def outcome(fn, pos):
    c = Ctx(pos)
    try:
        return fn(c), c.ops
    except OpLimit:
        return "limit"


def test_fuzz_round_trip_and_evaluation():
    rng = random.Random(42)
    gen = Gen(rng)
    positions = [random_position(rng, 3) for _ in range(20)]
    done = ran = 0
    while done < 400:
        prog = gen.program()
        text = dsl.canonical(prog)
        try:
            again = dsl.parse(text)
        except DslError as e:
            assert any(w in str(e) for w in ("too large", "nested", "longer", "statements")), (
                str(e),
                text,
            )
            continue
        done += 1
        assert dsl.canonical(again) == text
        assert dsl.size_bits(again) == pytest.approx(dsl.size_bits(prog))
        f, g = dsl.compile_program(prog), dsl.compile_program(again)
        for pos in positions:
            a, b = outcome(f, pos), outcome(g, pos)
            assert a == b
            if a != "limit":
                ran += 1
                assert isinstance(a[0], bool) and a[1] <= dsl.CAP
    assert ran > 1000
