"""The endgame folder decides the task: everything in endgames/kpk/ is a KPK program or model."""

from pathlib import Path

import pytest

from chess_forces import endgames, score


def test_folder_of_a_path():
    kpk = endgames.KPK
    assert endgames.of_path(kpk.programs / "human.dsl") is kpk
    assert endgames.of_path(kpk.trees / "tree-002.dsl") is kpk
    assert endgames.of_path(Path(__file__)) is None


@pytest.mark.parametrize(
    "path",
    sorted(endgames.KPK.programs.glob("*.dsl")) + sorted(endgames.KPK.trees.glob("*.dsl")),
    ids=lambda p: p.name,
)
def test_every_program_in_the_kpk_folder_scores_on_kpk(path):
    r = score.score(path.read_text(), endgames.KPK.task())
    assert r.task == "kpk" and r.tier is not None


def test_syzygy_operations_estimate_is_recorded():
    """endgames/kpk/syzygy.json comes from scripts/syzygy_ops.py; the report reads it."""
    import json

    est = json.loads(endgames.KPK.syzygy_ops.read_text())
    assert est["estimate"] is True and est["positions"] == 165_676
    assert 0 < est["ops_mean"] <= est["ops_max"] <= 4_096


def test_the_kpk_folder_holds_its_parts():
    kpk = endgames.KPK
    assert kpk.programs.is_dir() and kpk.trees.is_dir() and kpk.nets.is_dir()
    assert (kpk.nets / "sweep.json").exists()
