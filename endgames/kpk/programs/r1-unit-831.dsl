# Promoted 2026-11-26 from state/run-r1/unit-831-4426B-1259ops.dsl: 4,426.4 B (156.1 B program, 4,270.4 B exceptions), 5,363 errors, at most 1,259 operations, tier 4,096.
# Run r1 proposal 831 (Claude Haiku 5.5), rejected by its island for using more than 1,024 operations; it fits the 4,096 tier.
def wins() -> Bool:
    f = file(P)
    r = rank(P)
    q = sq(f, 7)
    n = min(5, 7 - r)
    blocked = k in path(strong, P)
    adj = P in king_f(K)
    front = sq(f, r + 2)
    runs = n + 1 - tempo < dist(k, q) and not blocked
    support = f > 0 and tempo == 0 and adj and dist(k, q) == n + 1 and not blocked
    ks = minus(king_f(front), king_f(P))
    free = compl(guard(weak))
    bk = compl(king_f(K))
    reach = any(steps(K, s, free) + tempo < steps(k, s, union(bk, one(s))) + tempo for s in ks) if f > 0 else dist(K, sq(1, 6)) < min(dist(k, sq(2, 7)), dist(k, sq(1, 7)), dist(k, sq(2, 6)), dist(k, sq(0, 7))) + tempo
    blockade = blocked and r < 6 and not adj and not (K in king_f(front)) and not (dist(K, front) < dist(k, front) + tempo)
    cap = tempo < 1 and k in king_f(P) and not adj
    aligned = file(K) == file(k) or rank(K) == rank(k)
    opp = f > 0 and dist(K, k) == 2 and aligned and tempo == 0 and dist(K, P) < dist(k, P)
    near = r >= 5 and f > 0 and dist(K, q) + tempo <= dist(k, q)
    return (runs or support or (reach and not dist(k, P) + tempo < dist(K, P)) or (opp and not blockade) or near) and not blockade and not cap
