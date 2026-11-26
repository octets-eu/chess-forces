"""promote copies a program into the endgame folder only when it beats the best of its tier."""

import datetime
import shutil

from chess_forces import endgames, promote, score

KPK = endgames.KPK


def _folder(tmp_path, names):
    eg = endgames.Endgame("kpk", "KPvK", root=tmp_path)
    eg.programs.mkdir(parents=True)
    for n in names:
        shutil.copy(KPK.programs / f"{n}.dsl", eg.programs)
    return eg


def test_better_programs_are_promoted_worse_ones_kept_out(tmp_path):
    eg = _folder(tmp_path, ["human", "evolved-256"])
    src = tmp_path / "in"
    src.mkdir()
    for n in ("evolved-1024", "square"):
        shutil.copy(KPK.programs / f"{n}.dsl", src / f"cand-{n}.dsl")
    (src / "bad.dsl").write_text("def wins() -> Bool:\n    return nonsense\n")
    day = datetime.date(2026, 11, 26)
    out = promote.promote(
        [
            src / "cand-evolved-1024.dsl",
            src / "cand-evolved-1024.dsl",
            src / "cand-square.dsl",
            src / "bad.dsl",
        ],
        eg,
        prefix="t-",
        today=day,
    )
    assert out[0].promoted == eg.programs / "t-cand-evolved-1024.dsl"
    assert out[1].promoted is None and "already" in out[1].reason  # the same program
    assert out[2].promoted is None and "tier" in out[2].reason
    assert out[3].promoted is None and out[3].reason.startswith("rejected")
    text = out[0].promoted.read_text()
    assert text.startswith("# Promoted 2026-11-26 from cand-evolved-1024.dsl: ")
    task = KPK.task()
    a = score.score(text, task)
    b = score.score((KPK.programs / "evolved-1024.dsl").read_text(), task)
    assert (a.bits_total, a.errors, a.ops_max) == (b.bits_total, b.errors, b.ops_max)
