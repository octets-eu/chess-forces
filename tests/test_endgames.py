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


def test_the_kpk_folder_holds_its_parts():
    kpk = endgames.KPK
    assert kpk.programs.is_dir() and kpk.trees.is_dir() and kpk.nets.is_dir()
    assert (kpk.nets / "sweep.json").exists()
