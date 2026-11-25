"""Scorer tests. Reference numbers come from an earlier, separate python-chess measurement."""

import json
import math
from pathlib import Path

import pytest

from chess_forces import score as s
from chess_forces.dsl import DslError
from chess_forces.kpk import N_POSITIONS, N_WINS

PROGRAMS = Path(__file__).resolve().parents[1] / "programs"
SQUARE = (PROGRAMS / "square.dsl").read_text()
ALWAYS = (PROGRAMS / "always_win.dsl").read_text()


@pytest.fixture(scope="module")
def kpk():
    return s.kpk_task()


def test_task_is_the_verified_table(kpk):
    assert kpk.n == len(kpk.positions) == N_POSITIONS
    assert sum(kpk.truth) == N_WINS


def test_always_win_matches_the_independent_counts(kpk):
    r = s.score(ALWAYS, kpk)
    assert (r.errors, r.false_wins, r.missed_wins) == (54_394, 54_394, 0)
    assert r.bits_exceptions / 8 == pytest.approx(
        18_910.72 + math.log2(N_POSITIONS + 1) / 8, abs=0.01
    )
    assert r.ops_max == s.EXCEPTION_LOOKUP_OPS and r.tier == 64


def test_rule_of_the_square_matches_the_independent_counts(kpk):
    r = s.score(SQUARE, kpk)
    assert (r.errors, r.false_wins, r.missed_wins) == (30_006, 544, 29_462)
    assert r.bits_exceptions / 8 == pytest.approx(
        14_133.26 + math.log2(N_POSITIONS + 1) / 8, abs=0.01
    )
    assert r.bytes_total < s.score(ALWAYS, kpk).bytes_total


def test_exception_formula():
    assert s.log2_choose(10, 0) == 0.0 and s.log2_choose(10, 10) == 0.0
    for n in (1, 5, 40, 300):
        for k in range(0, n + 1, max(1, n // 13)):
            assert s.log2_choose(n, k) == pytest.approx(math.log2(math.comb(n, k)), abs=1e-7)
    assert s.exception_bits(300, 7) == pytest.approx(
        math.log2(math.comb(300, 7)) + math.log2(301), abs=1e-7
    )


def test_tier_includes_the_exception_lookup(kpk):
    r = s.score(SQUARE, kpk)
    assert r.ops_max - s.EXCEPTION_LOOKUP_OPS <= 64 < r.ops_max <= 256 and r.tier == 256


def test_error_groups_cover_every_error_with_real_positions(kpk):
    import chess

    r = s.score(SQUARE, kpk, clusters=10_000)
    assert sum(n for _, n, _ in r.clusters) == r.errors
    assert len(r.samples) == 12
    for fen in [*r.samples, *(f for _, _, f in r.clusters)]:
        assert chess.Board(fen).is_valid()


def test_every_sample_is_really_misclassified(kpk):
    import chess

    from chess_forces import kpk as table
    from chess_forces.dsl import Ctx, compile_program, parse

    truth, run = table.generate(), compile_program(parse(SQUARE))
    r = s.score(SQUARE, kpk, clusters=10_000)
    for fen in [*r.samples, *(f for _, _, f in r.clusters)]:
        b = chess.Board(fen)
        p, wk, bk = (b.pieces(chess.PAWN, True).pop(), b.king(True), b.king(False))
        key = (int(b.turn), p, wk, bk)
        assert key in truth, fen
        assert run(Ctx(_pos(key))) != truth[key], fen


def _pos(key):
    from chess_forces.dsl import Position

    stm, p, wk, bk = key
    return Position([("strong", "king", wk), ("weak", "king", bk), ("strong", "pawn", p)], stm)


def test_mean_operations_are_the_average_over_all_positions(kpk):
    from chess_forces.dsl import Ctx, compile_program, parse

    run = compile_program(parse(SQUARE))
    total = 0
    for pos in kpk.positions:
        c = Ctx(pos)
        run(c)
        total += c.ops
    r = s.score(SQUARE, kpk)
    assert r.ops_mean == pytest.approx(total / kpk.n + s.EXCEPTION_LOOKUP_OPS)
    assert r.ops_mean < r.ops_max


def test_tier_boundaries():
    assert [s.tier_for(x) for x in (1, 64, 65, 256, 257, 1024, 4096, 4097)] == [
        64,
        64,
        256,
        256,
        1024,
        1024,
        4096,
        None,
    ]


def test_over_budget_program_is_rejected_with_a_position(kpk):
    heavy = (
        "def wins() -> Bool:\n    return any(any(any(dist(a, b) == inf for a in compl(one(k)))"
        " for b in compl(one(K))) for c in compl(one(P)))\n"
    )
    with pytest.raises(s.OverBudget, match="over 4096 operations on .* [wb] - -"):
        s.score(heavy, kpk)


def test_bad_text_is_a_clean_rejection(kpk):
    with pytest.raises(DslError):
        s.score("import os", kpk)


def test_scores_are_deterministic_and_complete(kpk):
    a, b = s.score(SQUARE, kpk).to_json(), s.score(SQUARE, kpk).to_json()
    assert a == b
    assert {"bytes_total", "tier", "dsl", "table_sha256", "program_hash", "samples"} <= json.loads(
        a
    ).keys()
