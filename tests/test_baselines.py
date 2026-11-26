"""Baselines: the tree-to-program translation and the frontier are checked; nets are run by the report."""

import numpy as np

from chess_forces import baselines, report, score
from chess_forces.baselines import Point


def test_saved_trees_are_what_training_gives_now():
    """endgames/kpk/trees holds the tree baselines; retraining must give the same text, so a library
    change is noticed. train_trees raises if a program and its tree disagree on any position."""
    task = score.kpk_task()
    trained = baselines.train_trees(task)
    for n, text in trained.items():
        assert baselines.tree_path(n).read_text() == text
    assert sorted(baselines.TREES_DIR.glob("tree-*.dsl")) == [
        baselines.tree_path(n) for n in trained
    ]
    points = baselines.tree_points(task)
    assert [p.kind for p in points] == ["learned"] * len(trained)
    assert all(p.ops_max is not None for p in points)
    assert points[-1].errors < points[0].errors and points[-1].bytes_total < points[0].bytes_total


def test_every_exact_net_is_shown():
    """Nets without errors are kept and plotted even when they are not on the frontier."""
    pts = baselines.net_points(score.kpk_task())
    exact = [p for p in pts if p.errors == 0]
    assert len(exact) >= 29
    assert min(p.bytes_total for p in exact) < 3_800
    assert len({p.name for p in pts}) == len(pts)  # names stay unique


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


def test_promoted_r1_programs_are_pinned():
    """Promoted on 2026-11-26 from local files of run r1; frozen so a language change is noticed."""
    task = score.kpk_task()
    t = score.score((report.PROGRAMS / "r1-trimmed-966.dsl").read_text(), task)
    assert t.errors == 5_398 and t.ops_max == 1_019 and t.tier == 1024
    u = score.score((report.PROGRAMS / "r1-unit-831.dsl").read_text(), task)
    assert u.errors == 5_363 and u.ops_max == 1_259 and u.tier == 4096
    assert u.bytes_total < t.bytes_total < 4_431
    f = score.score((report.PROGRAMS / "forcetree-0064.dsl").read_text(), task)
    assert f.errors == 4_505 and f.ops_max == 1_355 and f.tier == 4096
    g = score.score((report.PROGRAMS / "forcetree-0256.dsl").read_text(), task)
    assert g.errors == 2_378 and g.ops_max == 1_357 and g.bytes_total < 3_400
    e = score.score((report.PROGRAMS / "forcetree-1800.dsl").read_text(), task)
    assert e.errors == 0 and e.ops_max == 1_325 and e.bytes_total < 7_824  # exact, below Syzygy
