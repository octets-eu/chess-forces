"""Board geometry on 64 squares. Square = rank * 8 + file. No chess library, no side effects."""

FILES = range(8)


def file_of(s: int) -> int:
    return s & 7


def rank_of(s: int) -> int:
    return s >> 3


def _king_moves(s: int) -> tuple[int, ...]:
    f, r = file_of(s), rank_of(s)
    return tuple(
        (r + dr) * 8 + f + df
        for dr in (-1, 0, 1)
        for df in (-1, 0, 1)
        if (dr or df) and 0 <= f + df < 8 and 0 <= r + dr < 8
    )


KING_MOVES = tuple(_king_moves(s) for s in range(64))
KING_SET = tuple(frozenset(m) for m in KING_MOVES)

ROOK_DIRS = ((1, 0), (-1, 0), (0, 1), (0, -1))
QUEEN_DIRS = ROOK_DIRS + ((1, 1), (1, -1), (-1, 1), (-1, -1))


def white_pawn_attacks(p: int) -> frozenset[int]:
    """Squares a white pawn on p attacks (files clipped)."""
    return frozenset(p + 8 + d for d in (-1, 1) if 0 <= file_of(p) + d < 8)


def ray_attacks(s: int, dirs, occupied) -> set[int]:
    """Squares reached along dirs from s, stopping on (and including) the first occupied square."""
    out: set[int] = set()
    for df, dr in dirs:
        f, r = file_of(s) + df, rank_of(s) + dr
        while 0 <= f < 8 and 0 <= r < 8:
            q = r * 8 + f
            out.add(q)
            if q in occupied:
                break
            f, r = f + df, r + dr
    return out
