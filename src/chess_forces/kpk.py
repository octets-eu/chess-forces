"""KPK truth table by retrograde analysis, own rules only.

White has king and pawn, Black a king. Pawn files a-d (the board is mirrored), both sides to move.
Slot order defines the published hash: side to move (White, Black), pawn (by file a-d, then rank
2-7), white king 0..63, black king 0..63. Bits cover legal slots only, most significant bit first,
1 = White wins. Draws include stalemate and losing the pawn; castling and the 50-move rule do not
arise.
"""

import hashlib

from .board import (
    KING_MOVES,
    KING_SET,
    QUEEN_DIRS,
    ROOK_DIRS,
    rank_of,
    ray_attacks,
    white_pawn_attacks,
)

WHITE, BLACK = 1, 0
PAWN_SQUARES = tuple(r * 8 + f for f in range(4) for r in range(1, 7))
N_POSITIONS = 165_676
N_WINS = 111_282
SHA256 = "03e8133653f26b75f2924bc5b66cb37e6702c88c9d7bdbdf7b61c76c666293c0"

Key = tuple[int, int, int, int]  # (side to move, pawn, white king, black king)


def legal(stm: int, p: int, wk: int, bk: int) -> bool:
    """Reachable without the side that just moved having left its king in check."""
    if p == wk or p == bk or wk == bk or bk in KING_SET[wk]:
        return False
    return not (stm == WHITE and bk in white_pawn_attacks(p))


def _promotion_wins(q: int, wk: int, bk: int) -> bool:
    """A queen or rook just landed on q, Black to move: won unless it can be taken or it stalemates."""
    for dirs in (QUEEN_DIRS, ROOK_DIRS):
        hits = ray_attacks(q, dirs, {wk})
        check = bk in ray_attacks(q, dirs, {wk, bk})
        escapes = [t for t in KING_MOVES[bk] if t not in KING_SET[wk] and (t == q or t not in hits)]
        if q in escapes:
            continue
        if escapes or check:
            return True
    return False


def generate() -> dict[Key, bool]:
    """Every legal KPK position -> does White win with best play? Promotes pawns from rank 7 down."""
    win: dict[Key, bool] = {}
    for p in sorted(PAWN_SQUARES, key=lambda s: -rank_of(s)):
        hits = white_pawn_attacks(p)
        states = [
            (s, wk, bk)
            for s in (WHITE, BLACK)
            for wk in range(64)
            for bk in range(64)
            if legal(s, p, wk, bk)
        ]
        cur = dict.fromkeys(states, False)
        changed = True
        while changed:
            changed = False
            for x in states:
                if cur[x]:
                    continue
                stm, wk, bk = x
                value = (
                    _white_wins(cur, win, p, wk, bk) if stm else _black_lost(cur, p, hits, wk, bk)
                )
                if value:
                    cur[x] = True
                    changed = True
        for (stm, wk, bk), v in cur.items():
            win[(stm, p, wk, bk)] = v
    return win


def _white_wins(cur, win, p: int, wk: int, bk: int) -> bool:
    for t in KING_MOVES[wk]:
        if t not in (p, bk) and t not in KING_SET[bk] and cur.get((BLACK, t, bk)):
            return True
    if p + 8 in (wk, bk):
        return False
    if rank_of(p) == 6:
        return _promotion_wins(p + 8, wk, bk)
    if win.get((BLACK, p + 8, wk, bk)):
        return True
    return rank_of(p) == 1 and p + 16 not in (wk, bk) and bool(win.get((BLACK, p + 16, wk, bk)))


def _black_lost(cur, p: int, hits, wk: int, bk: int) -> bool:
    any_move = False
    for t in KING_MOVES[bk]:
        if t in KING_SET[wk] or t in hits or t == wk:
            continue
        any_move = True
        if t == p or not cur.get((WHITE, wk, t)):
            return False
    return any_move or bk in hits


def iter_slots():
    """Legal positions in canonical order."""
    for stm in (WHITE, BLACK):
        for p in PAWN_SQUARES:
            for wk in range(64):
                for bk in range(64):
                    if legal(stm, p, wk, bk):
                        yield (stm, p, wk, bk)


def pack(win: dict[Key, bool]) -> bytes:
    """Canonical bitbase: one bit per legal position in iter_slots order."""
    out, byte, n = bytearray(), 0, 0
    for k in iter_slots():
        byte = byte << 1 | win[k]
        n += 1
        if n % 8 == 0:
            out.append(byte)
            byte = 0
    if n % 8:
        out.append(byte << (8 - n % 8))
    return bytes(out)


def digest(win: dict[Key, bool]) -> str:
    return hashlib.sha256(pack(win)).hexdigest()
