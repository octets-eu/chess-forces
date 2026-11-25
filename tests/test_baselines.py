"""Baselines: the tree-to-program translation and the frontier are checked; nets are run by the report."""

import numpy as np

from chess_forces import baselines, report, score
from chess_forces.baselines import Point


def test_tree_program_reproduces_the_tree_and_is_counted_in_dsl_units():
    task = score.kpk_task()
    points = baselines.tree_points(task, leaves=(2, 8))
    # tree_points raises if the program and the tree disagree on any position
    assert points[0].kind == "learned" and points[0].ops_max is not None
    assert points[1].errors < points[0].errors
    assert points[1].bytes_total < points[0].bytes_total


def test_human_rules_are_pinned():
    """The hand-written rule set is frozen; if this moves, the program or the language changed."""
    text = (report.PROGRAMS / "human.dsl").read_text()
    r = score.score(text, score.kpk_task())
    assert r.errors == 7_590 and r.false_wins == 5_299
    assert 80 < r.bits_program / 8 < 81
    assert r.ops_max == 273 and r.tier == 1024


def test_frontier_is_monotone_and_ignores_unknown_operations():
    def p(name, b, o, est=False):
        return Point(name, "learned", b, 0.0, 0, o, o, est, False)

    pts = [
        p("a", 1000, 10),
        p("b", 500, 100),
        p("c", 600, 50),
        p("d", 400, 1000),
        p("est", 100, 5, est=True),
        p("no ops", 50, None),
    ]
    assert [x.name for x in report.pareto(pts)] == ["a", "c", "b", "d"]


def test_feature_matrix_matches_the_language():
    """Spot check of numpy features against the interpreter's own values."""
    task = score.kpk_task()
    m = baselines.feature_matrix(task)
    assert m.shape == (task.n, len(baselines.FEATURES))
    pos = task.positions[1000]
    assert m[1000, 0] == pos.tempo and np.all(m[1000] >= 0)


def test_evolved_programs_are_pinned():
    """Found by search run r1; frozen so a language change is noticed."""
    task = score.kpk_task()
    a = score.score((report.PROGRAMS / "evolved-256.dsl").read_text(), task)
    assert a.errors == 6_977 and a.ops_max == 232 and a.tier == 256
    b = score.score((report.PROGRAMS / "evolved-1024.dsl").read_text(), task)
    assert b.errors == 5_426 and b.ops_max == 959 and b.tier == 1024
    assert b.bytes_total < a.bytes_total < 5_500
