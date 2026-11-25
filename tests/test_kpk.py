import os
from pathlib import Path

import pytest

from chess_forces import kpk

TABLES = Path(os.environ.get("SYZYGY_PATH", Path(__file__).resolve().parents[2] / "syzygy"))


@pytest.fixture(scope="module")
def win():
    return kpk.generate()


def test_counts_and_published_hash(win):
    assert len(win) == kpk.N_POSITIONS
    assert sum(win.values()) == kpk.N_WINS
    assert kpk.digest(win) == kpk.SHA256


@pytest.mark.skipif(not (TABLES / "KPvK.rtbw").exists(), reason="Syzygy tables not found")
def test_every_position_matches_syzygy(win):
    """Independent check: python-chess reads the table, own code generated it."""
    import chess
    import chess.syzygy

    with chess.syzygy.open_tablebase(str(TABLES)) as tb:
        for (stm, p, wk, bk), expected in win.items():
            b = chess.Board(None)
            b.set_piece_at(p, chess.Piece(chess.PAWN, True))
            b.set_piece_at(wk, chess.Piece(chess.KING, True))
            b.set_piece_at(bk, chess.Piece(chess.KING, False))
            b.turn = bool(stm)
            assert b.is_valid(), b.fen()
            wdl = tb.probe_wdl(b)
            assert expected == ((wdl == 2) if stm else (wdl == -2)), b.fen()
