def wins() -> Bool:
    """Found by search run r1 (2026-11-25, Haiku 5.5, 1,076 proposals): the best program within 1,024 operations (also best at 4,096). Verified against Syzygy."""
    f = file(P)
    r = rank(P)
    n = min(5, 7 - r)
    q = sq(f, 7)
    blocked = k in path(strong, P)
    adj = P in king_f(K)
    front = sq(f, r + 2)
    runs = n + 1 - tempo < dist(k, q) and not blocked
    support = f > 0 and tempo == 0 and adj and dist(k, q) == n + 1 and not blocked
    ks = minus(king_f(front), king_f(P))
    free = compl(king_f(k))
    corner = min(min(dist(k, sq(0, 7)), dist(k, sq(1, 7))), min(dist(k, sq(0, 6)), dist(k, sq(2, 7))))
    reach = any(steps(K, s, free) + tempo < dist(k, s) + tempo for s in ks) if f > 0 else dist(K, sq(1, 6)) < corner + tempo
    blockade = blocked and r < 6 and not adj and not (K in king_f(front)) and not (dist(K, front) < dist(k, front) + tempo)
    cap = tempo < 1 and k in king_f(P) and not adj
    opp = f > 0 and dist(K, k) == 2 and (file(K) == file(k) or rank(K) == rank(k)) and tempo == 0 and dist(K, P) < dist(k, P)
    near = r >= 5 and f > 0 and dist(K, q) + tempo <= dist(k, q)
    return (runs or support or (reach and not dist(k, P) + tempo < dist(K, P)) or opp or near) and not blockade and not cap
