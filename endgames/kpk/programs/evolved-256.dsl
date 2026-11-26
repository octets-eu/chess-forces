def wins() -> Bool:
    """Found by search run r1 (2026-11-25, Haiku 5.5, 1,076 proposals): the best program within 256 operations. Verified against Syzygy."""
    f = file(P)
    r = rank(P)
    q = sq(f, 7)
    n = min(5, 7 - r)
    dq = dist(k, q)
    dkp = dist(k, P)
    dKP = dist(K, P)
    dKq = dist(K, q)
    blocked = k in path(strong, P)
    runs = n + 1 - tempo < dq and not blocked
    support = f > 0 and tempo == 0 and dKP <= 1 and dq == n + 1 and not blocked
    corner = f == 0 and dq <= n + 1 - tempo and dKq + tempo > dq
    front = sq(f, r + 2)
    ahead = front in king_f(K) or dist(K, front) < dist(k, front) + tempo
    loose = dkp + tempo < dKP
    side = abs(file(K) - f) <= 1 and rank(K) > r
    blockade = blocked and r < 6 and dKP > 1 and not side and not ahead
    cap = tempo < 1 and dkp == 1 and dKP > 1
    aligned = file(K) == file(k) or rank(K) == rank(k)
    opp = dist(K, k) == 2 and aligned and tempo == 0 and f > 0 and dKP <= dkp and rank(K) > r
    near = r >= 5 and f > 0 and dKq + tempo <= dq and not cap
    return (runs or support or (ahead and not loose) or (opp and not blockade) or near) and not blockade and not cap and not corner
