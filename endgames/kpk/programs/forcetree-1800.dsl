# Promoted 2026-11-26 from state/force-trees/concepts-1800.dsl: 7,102.7 B (7,102.7 B program, 0.0 B exceptions), 0 errors, at most 1,325 operations, tier 4,096.
# A greedy entropy tree with 1,800 leaves over the 10 concepts of r1-unit-831 and the simple features of the tree baselines, written as DSL by scripts/force_trees.py; no model involved. Fits the language from version 0.3 on (size limited by grammar code, not characters).
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
    x0 = tempo
    x1 = file(P)
    x2 = rank(P)
    x3 = file(K)
    x4 = rank(K)
    x5 = file(k)
    x6 = rank(k)
    x7 = dist(K, P)
    x8 = dist(k, P)
    x9 = dist(K, k)
    x10 = dist(K, sq(file(P), 7))
    x11 = dist(k, sq(file(P), 7))
    x12 = dist(k, sq(file(P), rank(P) + 1))
    if not runs:
        if not reach:
            if x7 <= 2:
                if not support:
                    if x0 <= 0:
                        if x2 <= 4:
                            if not opp:
                                if x6 <= 3:
                                    if x12 <= 1:
                                        return False
                                    else:
                                        if x10 <= 5:
                                            if x8 <= 1:
                                                return False
                                            else:
                                                if not aligned:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x12 <= 2:
                                                            if x2 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                else:
                                                    if x5 <= 3:
                                                        if x3 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                        else:
                                            if x6 <= 2:
                                                if x10 <= 6:
                                                    if x8 <= 1:
                                                        return False
                                                    else:
                                                        if x6 <= 1:
                                                            if x3 <= 0:
                                                                if x5 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                        else:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                if x12 <= 2:
                                                                    if x2 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                else:
                                                    if x6 <= 1:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            if x8 <= 2:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                    else:
                                                        return False
                                            else:
                                                return False
                                else:
                                    if x4 <= 2:
                                        return False
                                    else:
                                        if x6 <= 4:
                                            if x12 <= 1:
                                                return False
                                            else:
                                                if x2 <= 3:
                                                    if not aligned:
                                                        return False
                                                    else:
                                                        if x3 <= 0:
                                                            if x9 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                else:
                                                    if x1 <= 0:
                                                        if x10 <= 3:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                        else:
                                            if x4 <= 4:
                                                return False
                                            else:
                                                if x7 <= 1:
                                                    if x1 <= 0:
                                                        if x6 <= 5:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    if x11 <= 2:
                                                        return False
                                                    else:
                                                        if not aligned:
                                                            return False
                                                        else:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                return True
                            else:
                                if x8 <= 2:
                                    return False
                                else:
                                    return True
                        else:
                            if not cap:
                                if not near:
                                    if x12 <= 2:
                                        if x10 <= 3:
                                            if x12 <= 1:
                                                if x4 <= 4:
                                                    return False
                                                else:
                                                    if not adj:
                                                        return False
                                                    else:
                                                        if not opp:
                                                            if not aligned:
                                                                if x1 <= 0:
                                                                    return False
                                                                else:
                                                                    if x12 <= 0:
                                                                        return True
                                                                    else:
                                                                        if not blocked:
                                                                            if x2 <= 5:
                                                                                if x5 <= 0:
                                                                                    if x6 <= 6:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x6 <= 6:
                                                                                    return False
                                                                                else:
                                                                                    if x3 <= 0:
                                                                                        return False
                                                                                    else:
                                                                                        if x3 <= 3:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 0:
                                                                                                        return False
                                                                                                    else:
                                                                                                        if x3 <= 2:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    if x5 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            if x3 <= 1:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            return False
                                                                        else:
                                                                            return False
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                            else:
                                                if x2 <= 5:
                                                    if x1 <= 0:
                                                        if x4 <= 6:
                                                            return False
                                                        else:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                if not aligned:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return True
                                                else:
                                                    if x4 <= 4:
                                                        return False
                                                    else:
                                                        if x10 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                        else:
                                            return False
                                    else:
                                        if x1 <= 0:
                                            if x9 <= 2:
                                                if x4 <= 4:
                                                    if not aligned:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                return False
                                        else:
                                            if x9 <= 3:
                                                if x3 <= 4:
                                                    if x6 <= 4:
                                                        return True
                                                    else:
                                                        if x5 <= 5:
                                                            if x3 <= 3:
                                                                if x5 <= 4:
                                                                    if x9 <= 2:
                                                                        if x3 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x6 <= 5:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 1:
                                                                                if x1 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    if x3 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                else:
                                    if x3 <= 0:
                                        if x5 <= 1:
                                            if x4 <= 6:
                                                if x2 <= 5:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                        else:
                                            return True
                                    else:
                                        return True
                            else:
                                return False
                    else:
                        if x1 <= 0:
                            if x6 <= 4:
                                if x5 <= 2:
                                    return False
                                else:
                                    if x4 <= 0:
                                        return False
                                    else:
                                        if x10 <= 4:
                                            return True
                                        else:
                                            if x6 <= 3:
                                                if x4 <= 1:
                                                    if x6 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                return False
                            else:
                                if x10 <= 3:
                                    if x6 <= 5:
                                        if x12 <= 2:
                                            return False
                                        else:
                                            return True
                                    else:
                                        if x2 <= 4:
                                            return False
                                        else:
                                            if x5 <= 1:
                                                return False
                                            else:
                                                if x3 <= 0:
                                                    return False
                                                else:
                                                    if x4 <= 4:
                                                        return False
                                                    else:
                                                        return True
                                else:
                                    return False
                        else:
                            if not blockade:
                                if x10 <= 3:
                                    if x9 <= 2:
                                        if x4 <= 4:
                                            if x11 <= 1:
                                                if x8 <= 1:
                                                    return False
                                                else:
                                                    if not aligned:
                                                        if x8 <= 2:
                                                            if not blocked:
                                                                if x7 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                if x8 <= 2:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            if x12 <= 1:
                                                if x6 <= 6:
                                                    return True
                                                else:
                                                    if not aligned:
                                                        if not adj:
                                                            return True
                                                        else:
                                                            if x12 <= 0:
                                                                return False
                                                            else:
                                                                if x5 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        if x11 <= 0:
                                                            if not adj:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                            else:
                                                return True
                                    else:
                                        if not blocked:
                                            if x2 <= 5:
                                                return True
                                            else:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            if x2 <= 5:
                                                if x8 <= 2:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                else:
                                    if x11 <= 1:
                                        if x9 <= 4:
                                            if x2 <= 3:
                                                if x9 <= 3:
                                                    return True
                                                else:
                                                    if x12 <= 2:
                                                        return False
                                                    else:
                                                        if not blocked:
                                                            if not aligned:
                                                                if x7 <= 1:
                                                                    return True
                                                                else:
                                                                    if x5 <= 0:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 0:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x4 <= 2:
                                                                                            if x5 <= 3:
                                                                                                if x3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                        else:
                                                                                            if x5 <= 3:
                                                                                                if x3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                            else:
                                                return False
                                        else:
                                            return False
                                    else:
                                        if not aligned:
                                            if x12 <= 1:
                                                if x10 <= 6:
                                                    if x11 <= 4:
                                                        if not blocked:
                                                            if not adj:
                                                                if x9 <= 2:
                                                                    return False
                                                                else:
                                                                    if x9 <= 3:
                                                                        if x2 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x4 <= 1:
                                                                                return False
                                                                            else:
                                                                                if x11 <= 2:
                                                                                    if x4 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x8 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    if x2 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        if x4 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x9 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if x11 <= 2:
                                                    if x4 <= 2:
                                                        if not adj:
                                                            if x2 <= 3:
                                                                if x10 <= 5:
                                                                    return True
                                                                else:
                                                                    if x2 <= 2:
                                                                        if x10 <= 6:
                                                                            if x6 <= 5:
                                                                                if not blocked:
                                                                                    if x5 <= 4:
                                                                                        if x2 <= 1:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x1 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        if x3 <= 2:
                                                                                                            if x5 <= 2:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            if x5 <= 2:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                                    else:
                                                                                                        if x3 <= 3:
                                                                                                            if x5 <= 3:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            if x5 <= 3:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                        else:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        if x5 <= 0:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                                    else:
                                                                                                        return True
                                                                                            else:
                                                                                                if x3 <= 0:
                                                                                                    if x5 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x2 <= 1:
                                                                                if x8 <= 4:
                                                                                    if x5 <= 4:
                                                                                        if x5 <= 1:
                                                                                            if x3 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                if x3 <= 4:
                                                                                                    if x5 <= 0:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            if x3 <= 0:
                                                                                                if x5 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                                        else:
                                                            if x4 <= 1:
                                                                if not blocked:
                                                                    if x6 <= 5:
                                                                        if x5 <= 4:
                                                                            if x2 <= 1:
                                                                                if x9 <= 4:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 1:
                                                                                        if x3 <= 2:
                                                                                            if x1 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                if x5 <= 0:
                                                                                                    if x3 <= 1:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    return False
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                if x5 <= 0:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                return True
                                                                                    else:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    if x1 <= 1:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                else:
                                                                                                    if x5 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        if x1 <= 2:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                        else:
                                                                                            return False
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    if x3 <= 2:
                                                                                        if x3 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x5 <= 0:
                                                                                                if x1 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        if x5 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 1:
                                                                                                if x1 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                            else:
                                                                                                if x5 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            if x3 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x3 <= 0:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 3:
                                                                                if x5 <= 4:
                                                                                    if x1 <= 1:
                                                                                        if x3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x3 <= 1:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                else:
                                                                    return False
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    if x3 <= 0:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            if x3 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if x3 <= 3:
                                                                                if x5 <= 4:
                                                                                    if x1 <= 2:
                                                                                        if x3 <= 1:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                    else:
                                                                                        if x3 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                    else:
                                                        if not adj:
                                                            return True
                                                        else:
                                                            if not blocked:
                                                                if x3 <= 0:
                                                                    return True
                                                                else:
                                                                    if x9 <= 2:
                                                                        if x3 <= 3:
                                                                            if x5 <= 4:
                                                                                if x1 <= 1:
                                                                                    if x3 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if x3 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if x5 <= 0:
                                                                                            return True
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                if x5 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x5 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x6 <= 5:
                                                                            return True
                                                                        else:
                                                                            if x1 <= 1:
                                                                                if x3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x3 <= 1:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            if x3 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                if x5 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                            else:
                                                                return True
                                                else:
                                                    if x4 <= 0:
                                                        if x12 <= 2:
                                                            if x6 <= 2:
                                                                if not adj:
                                                                    return True
                                                                else:
                                                                    if x9 <= 2:
                                                                        if x3 <= 3:
                                                                            if x5 <= 4:
                                                                                if x5 <= 0:
                                                                                    if x3 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x3 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if x2 <= 1:
                                                                    if x8 <= 2:
                                                                        if x7 <= 1:
                                                                            if x3 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 4:
                                                                                        if x1 <= 1:
                                                                                            if x3 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                if x3 <= 1:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x5 <= 2:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if not blocked:
                                                                            if x5 <= 4:
                                                                                if x5 <= 1:
                                                                                    if x3 <= 2:
                                                                                        if x5 <= 0:
                                                                                            if x1 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            if x5 <= 0:
                                                                                                if x1 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    if x3 <= 2:
                                                                                        if x1 <= 2:
                                                                                            if x5 <= 3:
                                                                                                if x1 <= 1:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        if x3 <= 1:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return False
                                                        else:
                                                            if x3 <= 2:
                                                                if x5 <= 2:
                                                                    if x3 <= 1:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if x5 <= 2:
                                                                    return True
                                                                else:
                                                                    if x5 <= 4:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 3:
                                                                            return True
                                                                        else:
                                                                            if x5 <= 5:
                                                                                return False
                                                                            else:
                                                                                if x3 <= 4:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x11 <= 3:
                                                                if x2 <= 3:
                                                                    if x8 <= 2:
                                                                        if x7 <= 1:
                                                                            if x9 <= 2:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 4:
                                                                                        if x5 <= 0:
                                                                                            if x3 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x3 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                if x1 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        if x5 <= 2:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        if x1 <= 2:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x10 <= 5:
                                                                                    return True
                                                                                else:
                                                                                    if x3 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 1:
                                                                                            if x3 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x3 <= 1:
                                                                                                if x5 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x5 <= 0:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x3 <= 3:
                                                                                                        if x5 <= 4:
                                                                                                            if x1 <= 2:
                                                                                                                if x3 <= 2:
                                                                                                                    return True
                                                                                                                else:
                                                                                                                    return False
                                                                                                            else:
                                                                                                                if x3 <= 2:
                                                                                                                    return False
                                                                                                                else:
                                                                                                                    return True
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                        else:
                                                                            if x9 <= 3:
                                                                                return False
                                                                            else:
                                                                                if x2 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    if x4 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                    else:
                                                                        if x3 <= 2:
                                                                            if x5 <= 2:
                                                                                if x3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 4:
                                                                                    if x1 <= 2:
                                                                                        if x1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                else:
                                                                    if x8 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x3 <= 2:
                                                                            if x5 <= 2:
                                                                                if x3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 4:
                                                                                    return False
                                                                                else:
                                                                                    if x3 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 4:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                            else:
                                                                if x9 <= 2:
                                                                    if x3 <= 3:
                                                                        if x5 <= 4:
                                                                            if x11 <= 4:
                                                                                if x2 <= 2:
                                                                                    if x1 <= 1:
                                                                                        if x3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x3 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x5 <= 2:
                                                                                                    if x3 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                else:
                                                                                    if x8 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        if x3 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x1 <= 2:
                                                                            return False
                                                                        else:
                                                                            if not adj:
                                                                                if x3 <= 4:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return False
                                                                else:
                                                                    return True
                                        else:
                                            if x9 <= 2:
                                                return False
                                            else:
                                                if x9 <= 3:
                                                    if x8 <= 2:
                                                        if x8 <= 1:
                                                            return True
                                                        else:
                                                            if x2 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                                else:
                                                    if x2 <= 4:
                                                        return False
                                                    else:
                                                        return True
                            else:
                                if x6 <= 6:
                                    return False
                                else:
                                    if x9 <= 3:
                                        if x12 <= 1:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return False
                else:
                    if x12 <= 1:
                        return False
                    else:
                        if x6 <= 6:
                            return True
                        else:
                            if x5 <= 0:
                                if x3 <= 1:
                                    return False
                                else:
                                    return True
                            else:
                                return True
            else:
                if x5 <= 4:
                    if x0 <= 0:
                        if x12 <= 2:
                            if x6 <= 1:
                                if x7 <= 3:
                                    if x9 <= 4:
                                        return False
                                    else:
                                        if x2 <= 1:
                                            return True
                                        else:
                                            return False
                                else:
                                    return False
                            else:
                                return False
                        else:
                            if x10 <= 3:
                                if not aligned:
                                    if x2 <= 3:
                                        return False
                                    else:
                                        if x9 <= 2:
                                            if x10 <= 1:
                                                return True
                                            else:
                                                if x6 <= 4:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            return False
                                else:
                                    if not near:
                                        if x10 <= 1:
                                            if x6 <= 6:
                                                return False
                                            else:
                                                if x10 <= 0:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            if x11 <= 1:
                                                return False
                                            else:
                                                if x7 <= 3:
                                                    if x11 <= 3:
                                                        if x9 <= 2:
                                                            if x3 <= 1:
                                                                if x2 <= 3:
                                                                    return True
                                                                else:
                                                                    if x4 <= 4:
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if x3 <= 3:
                                                                    if x6 <= 4:
                                                                        if x2 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x6 <= 6:
                                                                        if x2 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    if x10 <= 2:
                                                        if x9 <= 3:
                                                            if x11 <= 2:
                                                                return False
                                                            else:
                                                                if x3 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                    else:
                                        return True
                            else:
                                if x7 <= 3:
                                    if x8 <= 3:
                                        if x10 <= 4:
                                            if x3 <= 5:
                                                if x2 <= 2:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if x9 <= 3:
                                                        return False
                                                    else:
                                                        if x2 <= 4:
                                                            return False
                                                        else:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                            else:
                                                return True
                                        else:
                                            if x11 <= 5:
                                                if x2 <= 1:
                                                    if x4 <= 1:
                                                        return False
                                                    else:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    if x3 <= 5:
                                                        return False
                                                    else:
                                                        if x11 <= 3:
                                                            return False
                                                        else:
                                                            if x4 <= 0:
                                                                return False
                                                            else:
                                                                if x11 <= 4:
                                                                    if x4 <= 1:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                            else:
                                                return True
                                    else:
                                        return False
                                else:
                                    if not aligned:
                                        return False
                                    else:
                                        if x6 <= 3:
                                            if x4 <= 4:
                                                return False
                                            else:
                                                if x2 <= 3:
                                                    return False
                                                else:
                                                    if x9 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                        else:
                                            return False
                    else:
                        if x12 <= 1:
                            return False
                        else:
                            if x1 <= 0:
                                if x3 <= 1:
                                    if x2 <= 1:
                                        if x6 <= 5:
                                            if x5 <= 2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    return False
                            else:
                                if x10 <= 3:
                                    if x6 <= 5:
                                        if x4 <= 6:
                                            if x11 <= 4:
                                                if x8 <= 3:
                                                    if x9 <= 4:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if x10 <= 2:
                                                        if not blocked:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                            else:
                                                if x7 <= 4:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            return False
                                    else:
                                        if x11 <= 1:
                                            if x10 <= 2:
                                                if not blocked:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                        else:
                                            if x6 <= 6:
                                                if x2 <= 2:
                                                    return True
                                                else:
                                                    if x2 <= 4:
                                                        if x8 <= 2:
                                                            return False
                                                        else:
                                                            if not aligned:
                                                                return True
                                                            else:
                                                                if x2 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return True
                                            else:
                                                return True
                                else:
                                    if x7 <= 4:
                                        if x11 <= 1:
                                            return False
                                        else:
                                            if x7 <= 3:
                                                if x3 <= 4:
                                                    if x4 <= 2:
                                                        if x2 <= 2:
                                                            if x9 <= 3:
                                                                if x11 <= 3:
                                                                    if not blocked:
                                                                        if x8 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x9 <= 2:
                                                                                if x12 <= 2:
                                                                                    if x5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    if x6 <= 4:
                                                                                        if x2 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x2 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if x10 <= 5:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                    else:
                                                        if x6 <= 5:
                                                            if x9 <= 2:
                                                                if x2 <= 2:
                                                                    if x11 <= 2:
                                                                        if x5 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            if x9 <= 3:
                                                                if x8 <= 2:
                                                                    if x2 <= 4:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if x8 <= 3:
                                                                    if x12 <= 2:
                                                                        if x2 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                else:
                                                    if x5 <= 1:
                                                        if x9 <= 4:
                                                            return False
                                                        else:
                                                            if x4 <= 2:
                                                                if x2 <= 2:
                                                                    if x4 <= 0:
                                                                        if x2 <= 1:
                                                                            if x11 <= 2:
                                                                                if x8 <= 4:
                                                                                    if x1 <= 2:
                                                                                        if x5 <= 0:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x11 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x9 <= 5:
                                                                                    if x11 <= 4:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x4 <= 0:
                                                                        return False
                                                                    else:
                                                                        if x2 <= 3:
                                                                            if x4 <= 1:
                                                                                if x11 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if x12 <= 2:
                                                                                        if x11 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x11 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x4 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                            else:
                                                                return True
                                                    else:
                                                        if x5 <= 3:
                                                            return False
                                                        else:
                                                            if x4 <= 1:
                                                                if x2 <= 1:
                                                                    if x4 <= 0:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 5:
                                                                            if x9 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x11 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return False
                                                            else:
                                                                if x1 <= 2:
                                                                    if x2 <= 2:
                                                                        if x8 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x9 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x4 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x6 <= 5:
                                                                                return False
                                                                            else:
                                                                                if x2 <= 4:
                                                                                    if x2 <= 3:
                                                                                        if x12 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return True
                                                                else:
                                                                    return False
                                            else:
                                                if x12 <= 2:
                                                    return False
                                                else:
                                                    if x11 <= 2:
                                                        return False
                                                    else:
                                                        if x4 <= 0:
                                                            if x3 <= 6:
                                                                return False
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if x4 <= 5:
                                                                if x8 <= 4:
                                                                    if x5 <= 2:
                                                                        if x2 <= 3:
                                                                            return True
                                                                        else:
                                                                            if x10 <= 5:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x9 <= 3:
                                                                            if x8 <= 3:
                                                                                if x6 <= 6:
                                                                                    if x2 <= 1:
                                                                                        if x9 <= 2:
                                                                                            if x11 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                if x11 <= 4:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x6 <= 4:
                                                                                            return False
                                                                                        else:
                                                                                            if x2 <= 3:
                                                                                                if x6 <= 5:
                                                                                                    if x2 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if x9 <= 5:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                    else:
                                        return False
                else:
                    if x0 <= 0:
                        if not aligned:
                            if x3 <= 0:
                                if x5 <= 5:
                                    if x6 <= 1:
                                        if x2 <= 1:
                                            if x9 <= 5:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    if x10 <= 4:
                                        return True
                                    else:
                                        if x6 <= 3:
                                            if x8 <= 3:
                                                if x10 <= 5:
                                                    return True
                                                else:
                                                    if x11 <= 4:
                                                        return False
                                                    else:
                                                        if x11 <= 5:
                                                            if x4 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                            else:
                                                return False
                                        else:
                                            return False
                            else:
                                if x1 <= 0:
                                    if x10 <= 5:
                                        if x6 <= 3:
                                            if x9 <= 2:
                                                if x6 <= 2:
                                                    return True
                                                else:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        if x7 <= 3:
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                return False
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    return False
                        else:
                            if x4 <= 1:
                                if x3 <= 4:
                                    if x12 <= 3:
                                        return False
                                    else:
                                        return True
                                else:
                                    if x8 <= 5:
                                        return False
                                    else:
                                        if x6 <= 6:
                                            return False
                                        else:
                                            if x10 <= 6:
                                                if x1 <= 0:
                                                    return False
                                                else:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                return False
                            else:
                                if x4 <= 5:
                                    if x2 <= 1:
                                        if x6 <= 1:
                                            return True
                                        else:
                                            if x4 <= 4:
                                                if x1 <= 0:
                                                    if x6 <= 3:
                                                        if x3 <= 6:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if x8 <= 4:
                                                        if x7 <= 4:
                                                            if x9 <= 2:
                                                                if x12 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                    else:
                                                        if x6 <= 5:
                                                            if x9 <= 2:
                                                                return True
                                                            else:
                                                                if x10 <= 5:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return True
                                            else:
                                                if x6 <= 6:
                                                    return False
                                                else:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                    else:
                                        if x4 <= 2:
                                            if x3 <= 4:
                                                if x12 <= 3:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                        else:
                                            if x6 <= 5:
                                                if x4 <= 3:
                                                    if x2 <= 2:
                                                        if x5 <= 5:
                                                            if x7 <= 4:
                                                                if x12 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            if x1 <= 0:
                                                                if x6 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                    else:
                                                        if x3 <= 4:
                                                            if x12 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                else:
                                                    if x3 <= 5:
                                                        if x4 <= 4:
                                                            if x3 <= 2:
                                                                return False
                                                            else:
                                                                if x2 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                            else:
                                                if x9 <= 2:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x2 <= 3:
                                                            return True
                                                        else:
                                                            if x6 <= 6:
                                                                if x2 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                else:
                                                    if x8 <= 4:
                                                        if x2 <= 4:
                                                            return False
                                                        else:
                                                            if x6 <= 6:
                                                                return False
                                                            else:
                                                                if x2 <= 5:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            if x6 <= 6:
                                                                if x12 <= 5:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    if x4 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                else:
                                    if x3 <= 3:
                                        if x10 <= 2:
                                            return True
                                        else:
                                            return False
                                    else:
                                        return False
                    else:
                        if x5 <= 5:
                            if x3 <= 6:
                                if x10 <= 5:
                                    if x4 <= 5:
                                        if x4 <= 2:
                                            if x2 <= 3:
                                                if x11 <= 4:
                                                    if x2 <= 1:
                                                        if x9 <= 2:
                                                            if x3 <= 5:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if x3 <= 2:
                                                            return True
                                                        else:
                                                            if x2 <= 2:
                                                                if x6 <= 4:
                                                                    return False
                                                                else:
                                                                    if x9 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x9 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return False
                                                else:
                                                    if x6 <= 3:
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                if x6 <= 4:
                                                    if x3 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                        else:
                                            if x1 <= 0:
                                                return False
                                            else:
                                                if x6 <= 5:
                                                    if x9 <= 2:
                                                        if x4 <= 4:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                if x2 <= 2:
                                                                    if x11 <= 4:
                                                                        if x3 <= 5:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                    else:
                                                        if x3 <= 5:
                                                            return True
                                                        else:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    if x2 <= 2:
                                                        return True
                                                    else:
                                                        if x2 <= 4:
                                                            if x9 <= 3:
                                                                if x6 <= 6:
                                                                    if x8 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x11 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x10 <= 4:
                                                                                if x9 <= 2:
                                                                                    if x12 <= 3:
                                                                                        if x10 <= 3:
                                                                                            if x2 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x2 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if not aligned:
                                                                                        if x2 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if x3 <= 2:
                                                                    return True
                                                                else:
                                                                    if not aligned:
                                                                        return False
                                                                    else:
                                                                        if x2 <= 3:
                                                                            return False
                                                                        else:
                                                                            return True
                                                        else:
                                                            return True
                                    else:
                                        if x6 <= 5:
                                            if x2 <= 2:
                                                return False
                                            else:
                                                if x6 <= 3:
                                                    if x3 <= 5:
                                                        if x9 <= 3:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                        else:
                                            return True
                                else:
                                    if x2 <= 3:
                                        if x3 <= 3:
                                            if x11 <= 3:
                                                if x2 <= 2:
                                                    if x4 <= 0:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if x12 <= 4:
                                                    if x1 <= 1:
                                                        return True
                                                    else:
                                                        if x3 <= 0:
                                                            if x10 <= 6:
                                                                return True
                                                            else:
                                                                if x11 <= 4:
                                                                    if x2 <= 1:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return False
                                                else:
                                                    if x6 <= 2:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                        else:
                                            if x2 <= 1:
                                                if x11 <= 4:
                                                    if x10 <= 6:
                                                        if x9 <= 2:
                                                            return False
                                                        else:
                                                            if x9 <= 3:
                                                                return True
                                                            else:
                                                                if x9 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        if x12 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    if x6 <= 2:
                                                        if x4 <= 2:
                                                            return False
                                                        else:
                                                            if x9 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        return False
                                            else:
                                                return False
                                    else:
                                        return False
                            else:
                                return False
                        else:
                            if x4 <= 5:
                                if x4 <= 1:
                                    if x3 <= 4:
                                        if x12 <= 3:
                                            if x3 <= 0:
                                                if x2 <= 3:
                                                    if x2 <= 2:
                                                        return True
                                                    else:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                        else:
                                            return True
                                    else:
                                        if x8 <= 5:
                                            if x2 <= 1:
                                                if x4 <= 0:
                                                    return False
                                                else:
                                                    if x9 <= 2:
                                                        return False
                                                    else:
                                                        if x6 <= 4:
                                                            return True
                                                        else:
                                                            if x9 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                            else:
                                                if x3 <= 5:
                                                    if x5 <= 6:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                        else:
                                            return True
                                else:
                                    if x8 <= 4:
                                        if x9 <= 3:
                                            if x6 <= 5:
                                                if x2 <= 2:
                                                    if x9 <= 2:
                                                        if x4 <= 4:
                                                            if x2 <= 1:
                                                                if x4 <= 2:
                                                                    if not aligned:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x6 <= 4:
                                                                    return False
                                                                else:
                                                                    if not aligned:
                                                                        return True
                                                                    else:
                                                                        return False
                                                        else:
                                                            return False
                                                    else:
                                                        if not aligned:
                                                            if x6 <= 3:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                            else:
                                                if x6 <= 6:
                                                    if x2 <= 2:
                                                        return True
                                                    else:
                                                        if x4 <= 3:
                                                            if x2 <= 3:
                                                                return True
                                                            else:
                                                                if x3 <= 6:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if x7 <= 4:
                                                                if x8 <= 3:
                                                                    if x3 <= 6:
                                                                        if x2 <= 3:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x2 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                else:
                                                    return True
                                        else:
                                            if x9 <= 5:
                                                if x2 <= 3:
                                                    return False
                                                else:
                                                    if x10 <= 4:
                                                        if not aligned:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                    else:
                                        if x6 <= 4:
                                            if x6 <= 2:
                                                if not aligned:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if x7 <= 5:
                                                    return False
                                                else:
                                                    if x4 <= 3:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                        else:
                                            if x6 <= 6:
                                                if x2 <= 1:
                                                    return True
                                                else:
                                                    if x9 <= 3:
                                                        if x6 <= 5:
                                                            if x9 <= 2:
                                                                if not aligned:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                            else:
                                if x2 <= 2:
                                    return False
                                else:
                                    if x6 <= 3:
                                        if x4 <= 6:
                                            if not aligned:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                    else:
                                        return False
        else:
            if not cap:
                if x7 <= 2:
                    if x0 <= 0:
                        if x11 <= 3:
                            if x4 <= 2:
                                if x9 <= 6:
                                    if x8 <= 5:
                                        if x9 <= 3:
                                            if not adj:
                                                return False
                                            else:
                                                if not blocked:
                                                    if not aligned:
                                                        if x3 <= 0:
                                                            return True
                                                        else:
                                                            if x12 <= 2:
                                                                if x9 <= 2:
                                                                    if x8 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x1 <= 1:
                                                                            if x5 <= 1:
                                                                                if x3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 1:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x3 <= 1:
                                                                                if x5 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                if x5 <= 3:
                                                                                                    if x3 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x3 <= 3:
                                                                                                        if x5 <= 4:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        return False
                                                                else:
                                                                    if x8 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x4 <= 1:
                                                                                if x3 <= 1:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if x5 <= 3:
                                                                                                if x3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                            else:
                                                                                if x6 <= 4:
                                                                                    return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        if x5 <= 3:
                                                                                            if x3 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x3 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                            else:
                                                                if x2 <= 2:
                                                                    if x11 <= 2:
                                                                        if x1 <= 1:
                                                                            if x3 <= 1:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x5 <= 0:
                                                                                if x3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        if x5 <= 2:
                                                                                            if x3 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                    else:
                                                                                        if x5 <= 1:
                                                                                            if x3 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                if x5 <= 3:
                                                                                                    if x3 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x3 <= 3:
                                                                                                        if x5 <= 4:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        return False
                                                                    else:
                                                                        if x10 <= 5:
                                                                            return True
                                                                        else:
                                                                            if x2 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 5:
                                                                                        if x3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if x1 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                if x5 <= 2:
                                                                                                    if x3 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                else:
                                                                    if x9 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x6 <= 4:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 3:
                                                                                if x3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 5:
                                                                                        if x1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                return False
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                        else:
                                            if x9 <= 4:
                                                if x8 <= 4:
                                                    if x3 <= 0:
                                                        return True
                                                    else:
                                                        if x12 <= 2:
                                                            return True
                                                        else:
                                                            if x7 <= 1:
                                                                if x11 <= 2:
                                                                    if x1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x4 <= 1:
                                                                            if x1 <= 2:
                                                                                if x3 <= 2:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            if x3 <= 1:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x3 <= 3:
                                                                                            if x5 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                else:
                                                                    if x8 <= 3:
                                                                        if x3 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x1 <= 1:
                                                                                return False
                                                                            else:
                                                                                if x1 <= 2:
                                                                                    if x3 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if x6 <= 5:
                                                                                        if x10 <= 5:
                                                                                            return True
                                                                                        else:
                                                                                            if x6 <= 4:
                                                                                                if x10 <= 6:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        if x5 <= 3:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            return True
                                                                                                        else:
                                                                                                            if x3 <= 3:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    if x5 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x3 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                    else:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                if x3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if x11 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if x11 <= 1:
                                                    return False
                                                else:
                                                    if x8 <= 3:
                                                        return True
                                                    else:
                                                        if not aligned:
                                                            if x3 <= 0:
                                                                return True
                                                            else:
                                                                if x1 <= 1:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x7 <= 1:
                                                                            if x8 <= 4:
                                                                                return False
                                                                            else:
                                                                                if x11 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if x9 <= 5:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if x3 <= 3:
                                                                        if x5 <= 4:
                                                                            if x3 <= 2:
                                                                                if x5 <= 2:
                                                                                    if x3 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if x12 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            if x11 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                if x9 <= 5:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x3 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x1 <= 2:
                                                                                    if x8 <= 4:
                                                                                        return False
                                                                                    else:
                                                                                        if x9 <= 5:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        if x5 <= 3:
                                                                            return True
                                                                        else:
                                                                            if x7 <= 1:
                                                                                if x8 <= 4:
                                                                                    return False
                                                                                else:
                                                                                    if x11 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x9 <= 5:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                            else:
                                                                                return False
                                                        else:
                                                            return False
                                    else:
                                        return True
                                else:
                                    if x11 <= 2:
                                        return False
                                    else:
                                        if x3 <= 1:
                                            if x5 <= 2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            if x1 <= 1:
                                                return False
                                            else:
                                                if x5 <= 2:
                                                    if x3 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if x3 <= 3:
                                                        if x3 <= 2:
                                                            return True
                                                        else:
                                                            if x5 <= 5:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return False
                            else:
                                if x9 <= 3:
                                    if x10 <= 1:
                                        if x1 <= 1:
                                            if x5 <= 2:
                                                if x8 <= 1:
                                                    return True
                                                else:
                                                    if x10 <= 0:
                                                        return False
                                                    else:
                                                        if x5 <= 1:
                                                            if not near:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            if x2 <= 4:
                                                                if x1 <= 0:
                                                                    if x3 <= 0:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                            else:
                                                if x1 <= 0:
                                                    if x3 <= 0:
                                                        if x2 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                        else:
                                            return True
                                    else:
                                        if x12 <= 3:
                                            if x11 <= 1:
                                                if x9 <= 2:
                                                    if not blockade:
                                                        if x3 <= 4:
                                                            if not blocked:
                                                                if x2 <= 3:
                                                                    if not opp:
                                                                        if not adj:
                                                                            if x8 <= 3:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 3:
                                                                                        if x3 <= 0:
                                                                                            if x1 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x5 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    if x1 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                    else:
                                                                                        return True
                                                                        else:
                                                                            if x3 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 1:
                                                                                        if x3 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                if x1 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                return True
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                if x5 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if not adj:
                                                        return False
                                                    else:
                                                        if not blocked:
                                                            if not aligned:
                                                                if x3 <= 0:
                                                                    return True
                                                                else:
                                                                    if x3 <= 3:
                                                                        if x5 <= 1:
                                                                            if x3 <= 1:
                                                                                return False
                                                                            else:
                                                                                if x1 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x3 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                        else:
                                                                            if x3 <= 2:
                                                                                if x1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if x3 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                            else:
                                                if x10 <= 3:
                                                    if x12 <= 2:
                                                        if x4 <= 6:
                                                            if x8 <= 1:
                                                                return True
                                                            else:
                                                                if x12 <= 1:
                                                                    if x9 <= 2:
                                                                        if not blocked:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x4 <= 5:
                                                                        if not aligned:
                                                                            if x4 <= 4:
                                                                                if x6 <= 5:
                                                                                    if x9 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        if x7 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if x3 <= 4:
                                                                                                if x5 <= 4:
                                                                                                    if x5 <= 0:
                                                                                                        if x1 <= 1:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        if x1 <= 1:
                                                                                                            return True
                                                                                                        else:
                                                                                                            if x3 <= 0:
                                                                                                                return False
                                                                                                            else:
                                                                                                                if x1 <= 2:
                                                                                                                    if x5 <= 2:
                                                                                                                        return False
                                                                                                                    else:
                                                                                                                        return True
                                                                                                                else:
                                                                                                                    if x5 <= 2:
                                                                                                                        return True
                                                                                                                    else:
                                                                                                                        return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                                                else:
                                                                                    if x9 <= 2:
                                                                                        if x8 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 3:
                                                                                                if x5 <= 4:
                                                                                                    if x1 <= 1:
                                                                                                        if x3 <= 1:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                                    else:
                                                                                                        if x3 <= 1:
                                                                                                            return False
                                                                                                        else:
                                                                                                            if x5 <= 0:
                                                                                                                return True
                                                                                                            else:
                                                                                                                if x1 <= 2:
                                                                                                                    if x3 <= 2:
                                                                                                                        return True
                                                                                                                    else:
                                                                                                                        return False
                                                                                                                else:
                                                                                                                    if x3 <= 2:
                                                                                                                        return False
                                                                                                                    else:
                                                                                                                        return True
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        if x6 <= 6:
                                                                                            return True
                                                                                        else:
                                                                                            if x3 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x1 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        if x3 <= 2:
                                                                                                            if x5 <= 2:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            if x5 <= 2:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            if x3 <= 3:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            if x3 <= 3:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                            else:
                                                                                if x9 <= 2:
                                                                                    if x2 <= 4:
                                                                                        if x3 <= 0:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x2 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        if x2 <= 3:
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                if x4 <= 4:
                                                                    if x7 <= 1:
                                                                        if x11 <= 2:
                                                                            if x3 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 4:
                                                                                        if x1 <= 1:
                                                                                            if x3 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x3 <= 1:
                                                                                                if x5 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x5 <= 0:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        if x3 <= 2:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                                    else:
                                                                                                        if x3 <= 2:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x1 <= 0:
                                                                        if x9 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                        else:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                else:
                                                    if x3 <= 4:
                                                        if x2 <= 1:
                                                            if not blockade:
                                                                if x9 <= 2:
                                                                    if x11 <= 2:
                                                                        if not aligned:
                                                                            if not blocked:
                                                                                if x5 <= 3:
                                                                                    if x5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if x3 <= 0:
                                                                                            if x1 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x5 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    if x1 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x5 <= 4:
                                                                        if x12 <= 2:
                                                                            if x3 <= 0:
                                                                                if x1 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if x5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                        else:
                                                                            if x11 <= 2:
                                                                                if x5 <= 0:
                                                                                    if x1 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x1 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x3 <= 0:
                                                                                            return False
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                                        else:
                                                            if not adj:
                                                                return False
                                                            else:
                                                                if x11 <= 2:
                                                                    if x9 <= 2:
                                                                        if x2 <= 2:
                                                                            if x3 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x1 <= 1:
                                                                                    if x3 <= 1:
                                                                                        if x5 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x5 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                else:
                                                                                    if x5 <= 0:
                                                                                        if x3 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                if x5 <= 2:
                                                                                                    if x3 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x5 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        if x3 <= 2:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                            else:
                                                                                                if x5 <= 1:
                                                                                                    if x3 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            if x3 <= 3:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            if x3 <= 3:
                                                                                                                if x5 <= 4:
                                                                                                                    return False
                                                                                                                else:
                                                                                                                    return True
                                                                                                            else:
                                                                                                                return False
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x6 <= 5:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x8 <= 3:
                                                                                    if x1 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if x3 <= 1:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x1 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x5 <= 3:
                                                                                                        if x3 <= 3:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        if x3 <= 3:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                else:
                                                                                    if x3 <= 3:
                                                                                        if x5 <= 4:
                                                                                            if x1 <= 1:
                                                                                                if x3 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x5 <= 0:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x1 <= 2:
                                                                                                            if x3 <= 2:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                                        else:
                                                                                                            if x3 <= 2:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x5 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                else:
                                                                    if x2 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x9 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x6 <= 5:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 5:
                                                                                        if x3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if x1 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x5 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                    else:
                                                        if not opp:
                                                            if x2 <= 1:
                                                                if x5 <= 5:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                        else:
                                            return True
                                else:
                                    if x6 <= 6:
                                        return True
                                    else:
                                        if x12 <= 3:
                                            if x10 <= 3:
                                                return True
                                            else:
                                                if x9 <= 4:
                                                    if not adj:
                                                        if x11 <= 2:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        if x11 <= 2:
                                                            if x3 <= 0:
                                                                return True
                                                            else:
                                                                if x1 <= 1:
                                                                    return False
                                                                else:
                                                                    if x1 <= 2:
                                                                        if x3 <= 2:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x5 <= 3:
                                                                            if x3 <= 3:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x3 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
                                                        else:
                                                            if x2 <= 3:
                                                                return True
                                                            else:
                                                                if x3 <= 1:
                                                                    return True
                                                                else:
                                                                    if x1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 3:
                                                                            if x5 <= 5:
                                                                                if x3 <= 2:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
                                                else:
                                                    return True
                                        else:
                                            return True
                        else:
                            if x9 <= 3:
                                if x4 <= 1:
                                    if x9 <= 2:
                                        if not aligned:
                                            if x8 <= 3:
                                                if x2 <= 1:
                                                    if x4 <= 0:
                                                        return False
                                                    else:
                                                        if x12 <= 2:
                                                            return False
                                                        else:
                                                            if x7 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    return False
                                            else:
                                                if x2 <= 1:
                                                    return True
                                                else:
                                                    if x10 <= 6:
                                                        if x2 <= 2:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                        else:
                                            return True
                                    else:
                                        if x11 <= 4:
                                            if x4 <= 0:
                                                if x8 <= 3:
                                                    if not adj:
                                                        return False
                                                    else:
                                                        if x3 <= 3:
                                                            if x3 <= 1:
                                                                return True
                                                            else:
                                                                if x1 <= 1:
                                                                    return False
                                                                else:
                                                                    if x5 <= 5:
                                                                        if x5 <= 2:
                                                                            if x3 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x3 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return True
                                                        else:
                                                            return False
                                                else:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        if x3 <= 2:
                                                            return True
                                                        else:
                                                            if x5 <= 5:
                                                                return False
                                                            else:
                                                                if x3 <= 3:
                                                                    return True
                                                                else:
                                                                    if x5 <= 6:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 4:
                                                                            return True
                                                                        else:
                                                                            return False
                                            else:
                                                if x2 <= 2:
                                                    return True
                                                else:
                                                    if x6 <= 3:
                                                        return True
                                                    else:
                                                        if x3 <= 2:
                                                            return True
                                                        else:
                                                            if x3 <= 4:
                                                                if x5 <= 5:
                                                                    return False
                                                                else:
                                                                    if x3 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return False
                                        else:
                                            return True
                                else:
                                    if x3 <= 0:
                                        if x8 <= 1:
                                            return True
                                        else:
                                            if x1 <= 0:
                                                if x2 <= 3:
                                                    if x6 <= 2:
                                                        if x2 <= 2:
                                                            if x11 <= 5:
                                                                return False
                                                            else:
                                                                if x4 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if x1 <= 1:
                                                    return True
                                                else:
                                                    if x9 <= 2:
                                                        if x6 <= 1:
                                                            return True
                                                        else:
                                                            if x2 <= 2:
                                                                return False
                                                            else:
                                                                if x4 <= 4:
                                                                    return True
                                                                else:
                                                                    if x2 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                                    else:
                                                        return False
                                    else:
                                        if not aligned:
                                            if x4 <= 2:
                                                if x2 <= 3:
                                                    if x8 <= 3:
                                                        if not adj:
                                                            return False
                                                        else:
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                if x9 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return True
                                                else:
                                                    if x9 <= 2:
                                                        return False
                                                    else:
                                                        if x6 <= 4:
                                                            return True
                                                        else:
                                                            if x3 <= 2:
                                                                return True
                                                            else:
                                                                if x5 <= 5:
                                                                    return False
                                                                else:
                                                                    if x3 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x5 <= 6:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 4:
                                                                                return True
                                                                            else:
                                                                                return False
                                            else:
                                                return True
                                        else:
                                            if x8 <= 2:
                                                if x7 <= 1:
                                                    return True
                                                else:
                                                    if x4 <= 3:
                                                        if x9 <= 2:
                                                            return True
                                                        else:
                                                            if x12 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if x9 <= 2:
                                                            if x2 <= 2:
                                                                return False
                                                            else:
                                                                if x2 <= 3:
                                                                    if x6 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return False
                                            else:
                                                return True
                            else:
                                if x3 <= 2:
                                    return True
                                else:
                                    if x11 <= 4:
                                        if x4 <= 2:
                                            if x2 <= 1:
                                                return True
                                            else:
                                                if not adj:
                                                    if x6 <= 3:
                                                        return True
                                                    else:
                                                        if x3 <= 4:
                                                            if x1 <= 2:
                                                                if x10 <= 6:
                                                                    if x2 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            if x4 <= 1:
                                                                                return False
                                                                            else:
                                                                                if x2 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x3 <= 3:
                                                                                return True
                                                                            else:
                                                                                if x10 <= 5:
                                                                                    if x2 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return False
                                                                else:
                                                                    if x1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x10 <= 6:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    if x10 <= 5:
                                                                        if x2 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                                else:
                                                    return True
                                        else:
                                            return True
                                    else:
                                        return True
                    else:
                        if not blockade:
                            if x8 <= 2:
                                if x1 <= 0:
                                    if x3 <= 0:
                                        if not aligned:
                                            if not adj:
                                                if x6 <= 2:
                                                    return True
                                                else:
                                                    if x10 <= 2:
                                                        if x11 <= 3:
                                                            if x10 <= 1:
                                                                if x6 <= 4:
                                                                    return True
                                                                else:
                                                                    if x8 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x10 <= 0:
                                                                            return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                        else:
                                            return False
                                    else:
                                        if not aligned:
                                            if x5 <= 1:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return True
                                else:
                                    if x8 <= 1:
                                        if not adj:
                                            if x9 <= 2:
                                                if x10 <= 1:
                                                    return True
                                                else:
                                                    if x6 <= 3:
                                                        if not aligned:
                                                            if x3 <= 4:
                                                                if x5 <= 0:
                                                                    return True
                                                                else:
                                                                    if x5 <= 3:
                                                                        if x3 <= 0:
                                                                            if x5 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 2:
                                                                                    if x1 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                        else:
                                            return True
                                    else:
                                        if x11 <= 1:
                                            if x5 <= 0:
                                                if x4 <= 6:
                                                    return True
                                                else:
                                                    if x3 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                        else:
                                            return True
                            else:
                                return True
                        else:
                            return False
                else:
                    if x8 <= 3:
                        if x7 <= 3:
                            if x8 <= 2:
                                if x8 <= 1:
                                    return False
                                else:
                                    if x0 <= 0:
                                        if x2 <= 1:
                                            if x11 <= 5:
                                                if x9 <= 4:
                                                    if x12 <= 1:
                                                        return False
                                                    else:
                                                        if x1 <= 0:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                if x3 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                        else:
                                            if x6 <= 3:
                                                return False
                                            else:
                                                if x10 <= 2:
                                                    if x12 <= 1:
                                                        return False
                                                    else:
                                                        if x6 <= 5:
                                                            if x4 <= 6:
                                                                if x11 <= 2:
                                                                    return True
                                                                else:
                                                                    if x4 <= 5:
                                                                        if x1 <= 0:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                    else:
                                        if x9 <= 3:
                                            if x1 <= 0:
                                                if x12 <= 1:
                                                    return False
                                                else:
                                                    if x3 <= 2:
                                                        if x9 <= 2:
                                                            if x6 <= 2:
                                                                return True
                                                            else:
                                                                if x3 <= 0:
                                                                    return False
                                                                else:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        return False
                                                        else:
                                                            return True
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if x10 <= 1:
                                                    return True
                                                else:
                                                    if x2 <= 2:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x10 <= 2:
                                                                if not aligned:
                                                                    return True
                                                                else:
                                                                    if x6 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                                    else:
                                                        if x9 <= 2:
                                                            return False
                                                        else:
                                                            if x10 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                        else:
                                            return True
                            else:
                                if x9 <= 5:
                                    if x0 <= 0:
                                        if x10 <= 1:
                                            if x1 <= 0:
                                                if x3 <= 0:
                                                    if x9 <= 3:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                return True
                                        else:
                                            if x2 <= 2:
                                                if x3 <= 4:
                                                    if x3 <= 0:
                                                        if x1 <= 2:
                                                            if x9 <= 3:
                                                                if x9 <= 2:
                                                                    return True
                                                                else:
                                                                    if x11 <= 5:
                                                                        if x12 <= 2:
                                                                            if x1 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return True
                                                        else:
                                                            if x6 <= 2:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    if x4 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                                    else:
                                                        if x1 <= 1:
                                                            if x3 <= 2:
                                                                if x1 <= 0:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x11 <= 4:
                                                                            return False
                                                                        else:
                                                                            if x2 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x9 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if x2 <= 1:
                                                                    if x11 <= 4:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x4 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x9 <= 3:
                                                                            return False
                                                                        else:
                                                                            if x10 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                        else:
                                                            if x9 <= 3:
                                                                if x3 <= 1:
                                                                    if x1 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x6 <= 2:
                                                                            if x10 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if x3 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 2:
                                                                            if x6 <= 2:
                                                                                if x10 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return True
                                                else:
                                                    if x12 <= 2:
                                                        if x9 <= 4:
                                                            if x9 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x5 <= 2:
                                                                return True
                                                            else:
                                                                if x10 <= 3:
                                                                    if not aligned:
                                                                        if x9 <= 3:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                            else:
                                                if x10 <= 2:
                                                    if x9 <= 3:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if x9 <= 2:
                                                        if x6 <= 2:
                                                            return True
                                                        else:
                                                            if x2 <= 3:
                                                                return False
                                                            else:
                                                                if x4 <= 6:
                                                                    if x11 <= 3:
                                                                        if x2 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return False
                                    else:
                                        if not blocked:
                                            if x9 <= 2:
                                                if x10 <= 2:
                                                    if x3 <= 0:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                                else:
                                                    if x4 <= 4:
                                                        if x1 <= 0:
                                                            if x5 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if x2 <= 2:
                                                            return False
                                                        else:
                                                            if x11 <= 3:
                                                                if x2 <= 3:
                                                                    return False
                                                                else:
                                                                    if x6 <= 4:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return True
                                            else:
                                                return True
                                        else:
                                            return False
                                else:
                                    return True
                        else:
                            if x0 <= 0:
                                if x4 <= 5:
                                    if x10 <= 3:
                                        if x11 <= 5:
                                            if x12 <= 2:
                                                return False
                                            else:
                                                if x9 <= 3:
                                                    if x3 <= 0:
                                                        return False
                                                    else:
                                                        if x11 <= 3:
                                                            return True
                                                        else:
                                                            if x10 <= 2:
                                                                if x3 <= 4:
                                                                    if x5 <= 5:
                                                                        if x3 <= 3:
                                                                            if x5 <= 4:
                                                                                if x9 <= 2:
                                                                                    if x3 <= 2:
                                                                                        if x5 <= 3:
                                                                                            if x1 <= 1:
                                                                                                if x3 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if x11 <= 4:
                                                                                        return True
                                                                                    else:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 3:
                                                                                                if x3 <= 1:
                                                                                                    if x5 <= 1:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x5 <= 1:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                else:
                                                    return True
                                        else:
                                            return True
                                    else:
                                        return False
                                else:
                                    if x6 <= 4:
                                        return False
                                    else:
                                        if x11 <= 2:
                                            return False
                                        else:
                                            if x7 <= 4:
                                                if x3 <= 6:
                                                    if x6 <= 5:
                                                        if x2 <= 2:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                return False
                            else:
                                if x8 <= 2:
                                    if x12 <= 1:
                                        return False
                                    else:
                                        if x7 <= 4:
                                            if x2 <= 1:
                                                if x1 <= 0:
                                                    if x3 <= 3:
                                                        if x11 <= 4:
                                                            if x3 <= 1:
                                                                if x3 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if x11 <= 3:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x4 <= 6:
                                                            return True
                                                        else:
                                                            if x11 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    return False
                                        else:
                                            return False
                                else:
                                    if x7 <= 4:
                                        if x1 <= 0:
                                            if x10 <= 2:
                                                if x5 <= 2:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if x11 <= 4:
                                                    return False
                                                else:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        return False
                                        else:
                                            if not aligned:
                                                return True
                                            else:
                                                if x10 <= 3:
                                                    return False
                                                else:
                                                    return True
                                    else:
                                        if x4 <= 6:
                                            if x12 <= 2:
                                                return False
                                            else:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    if x9 <= 5:
                                                        return False
                                                    else:
                                                        return True
                                        else:
                                            if x6 <= 4:
                                                return False
                                            else:
                                                if x11 <= 2:
                                                    return False
                                                else:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                    else:
                        if x0 <= 0:
                            if x3 <= 4:
                                if x12 <= 4:
                                    if x7 <= 5:
                                        if x7 <= 4:
                                            if x5 <= 5:
                                                if x10 <= 3:
                                                    if not blockade:
                                                        if x10 <= 1:
                                                            return True
                                                        else:
                                                            if x11 <= 1:
                                                                if x9 <= 2:
                                                                    if x7 <= 3:
                                                                        if x10 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x6 <= 6:
                                                                                if not blocked:
                                                                                    if x5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            if x3 <= 0:
                                                                                                if x1 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x1 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if not blocked:
                                                                            if x10 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if x7 <= 3:
                                                                        if x8 <= 4:
                                                                            return False
                                                                        else:
                                                                            if x9 <= 3:
                                                                                if x4 <= 4:
                                                                                    if x6 <= 6:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x10 <= 2:
                                                                    if not aligned:
                                                                        return True
                                                                    else:
                                                                        if x11 <= 2:
                                                                            if x9 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x9 <= 3:
                                                                                    if x5 <= 4:
                                                                                        if x5 <= 0:
                                                                                            if x1 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x1 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                if x3 <= 0:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        if x1 <= 2:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                                    else:
                                                                                                        if x1 <= 2:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            return True
                                                                else:
                                                                    if x7 <= 3:
                                                                        if x2 <= 1:
                                                                            if x11 <= 2:
                                                                                if x9 <= 4:
                                                                                    if x5 <= 4:
                                                                                        if x9 <= 2:
                                                                                            if x6 <= 5:
                                                                                                return True
                                                                                            else:
                                                                                                if x3 <= 0:
                                                                                                    if x1 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                                else:
                                                                                                    if x3 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x1 <= 1:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                        else:
                                                                                            if x6 <= 5:
                                                                                                if x9 <= 3:
                                                                                                    if x5 <= 0:
                                                                                                        if x1 <= 1:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        if x1 <= 1:
                                                                                                            return True
                                                                                                        else:
                                                                                                            if x3 <= 0:
                                                                                                                return False
                                                                                                            else:
                                                                                                                if x1 <= 2:
                                                                                                                    if x3 <= 2:
                                                                                                                        return True
                                                                                                                    else:
                                                                                                                        return False
                                                                                                                else:
                                                                                                                    if x5 <= 2:
                                                                                                                        return True
                                                                                                                    else:
                                                                                                                        return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return True
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x11 <= 2:
                                                                                return False
                                                                            else:
                                                                                if not aligned:
                                                                                    if x9 <= 3:
                                                                                        if x4 <= 6:
                                                                                            if x2 <= 3:
                                                                                                if x4 <= 5:
                                                                                                    if x11 <= 5:
                                                                                                        if x8 <= 4:
                                                                                                            if x2 <= 2:
                                                                                                                if x4 <= 4:
                                                                                                                    return True
                                                                                                                else:
                                                                                                                    return False
                                                                                                            else:
                                                                                                                if x6 <= 4:
                                                                                                                    return True
                                                                                                                else:
                                                                                                                    if x4 <= 4:
                                                                                                                        return False
                                                                                                                    else:
                                                                                                                        return True
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        if x11 <= 5:
                                                                            return False
                                                                        else:
                                                                            if x4 <= 5:
                                                                                return True
                                                                            else:
                                                                                return False
                                                    else:
                                                        return False
                                                else:
                                                    if x11 <= 2:
                                                        return False
                                                    else:
                                                        if x10 <= 4:
                                                            if x2 <= 1:
                                                                if x4 <= 4:
                                                                    return True
                                                                else:
                                                                    if x6 <= 1:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x8 <= 4:
                                                                    if x9 <= 2:
                                                                        if x6 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x11 <= 4:
                                                                                return False
                                                                            else:
                                                                                if x2 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        if x2 <= 3:
                                                                            return False
                                                                        else:
                                                                            if x6 <= 6:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    return True
                                                        else:
                                                            if x8 <= 4:
                                                                return False
                                                            else:
                                                                if x9 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                            else:
                                                return True
                                        else:
                                            if x8 <= 4:
                                                if x4 <= 6:
                                                    if x11 <= 3:
                                                        return False
                                                    else:
                                                        if x10 <= 2:
                                                            return True
                                                        else:
                                                            if x5 <= 6:
                                                                return False
                                                            else:
                                                                return True
                                                else:
                                                    if x6 <= 5:
                                                        return False
                                                    else:
                                                        if x12 <= 3:
                                                            return False
                                                        else:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                            else:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    if x11 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                    else:
                                        return False
                                else:
                                    if x5 <= 5:
                                        if x4 <= 0:
                                            return False
                                        else:
                                            if x7 <= 4:
                                                if x10 <= 3:
                                                    return True
                                                else:
                                                    if x4 <= 4:
                                                        return True
                                                    else:
                                                        if x9 <= 4:
                                                            if x11 <= 5:
                                                                if x2 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                            else:
                                                if x11 <= 1:
                                                    if x10 <= 1:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    if x10 <= 3:
                                                        if x1 <= 2:
                                                            return True
                                                        else:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return False
                                    else:
                                        if x4 <= 0:
                                            if x3 <= 3:
                                                return True
                                            else:
                                                if x2 <= 2:
                                                    return True
                                                else:
                                                    if x1 <= 1:
                                                        return False
                                                    else:
                                                        return True
                                        else:
                                            return True
                            else:
                                if x5 <= 6:
                                    if x3 <= 6:
                                        if x1 <= 2:
                                            if x4 <= 5:
                                                if x4 <= 2:
                                                    if x8 <= 5:
                                                        if x2 <= 1:
                                                            if x10 <= 5:
                                                                if x11 <= 2:
                                                                    return False
                                                                else:
                                                                    if x6 <= 5:
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                    else:
                                                        if x9 <= 6:
                                                            if x7 <= 3:
                                                                return True
                                                            else:
                                                                if x11 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return False
                                                else:
                                                    if x5 <= 4:
                                                        if x8 <= 5:
                                                            return False
                                                        else:
                                                            if x10 <= 3:
                                                                return True
                                                            else:
                                                                if x7 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        if x2 <= 1:
                                                            if not aligned:
                                                                if x5 <= 5:
                                                                    return False
                                                                else:
                                                                    if x4 <= 4:
                                                                        return True
                                                                    else:
                                                                        if x11 <= 5:
                                                                            if x8 <= 5:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return True
                                                            else:
                                                                return True
                                                        else:
                                                            if x10 <= 3:
                                                                if x8 <= 4:
                                                                    if x2 <= 3:
                                                                        if x11 <= 3:
                                                                            return True
                                                                        else:
                                                                            if x6 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x9 <= 2:
                                                                                    if x11 <= 4:
                                                                                        if x6 <= 6:
                                                                                            if x2 <= 2:
                                                                                                if x6 <= 4:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x4 <= 4:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x2 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x11 <= 4:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if x8 <= 4:
                                                                    if x9 <= 2:
                                                                        if x11 <= 5:
                                                                            if x6 <= 4:
                                                                                if x2 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if x6 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        if x2 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x2 <= 3:
                                                                            return False
                                                                        else:
                                                                            if x9 <= 3:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if x12 <= 4:
                                                                        return True
                                                                    else:
                                                                        if x6 <= 2:
                                                                            if x9 <= 2:
                                                                                return True
                                                                            else:
                                                                                if not aligned:
                                                                                    if x6 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x2 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x4 <= 3:
                                                                                if x9 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    if x2 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                if x2 <= 2:
                                                                                    if x6 <= 4:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x4 <= 4:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                            else:
                                                if x7 <= 3:
                                                    if x6 <= 3:
                                                        if x9 <= 3:
                                                            if x2 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if x6 <= 4:
                                                            if x2 <= 3:
                                                                return False
                                                            else:
                                                                if x4 <= 6:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                else:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        if x8 <= 4:
                                                            return False
                                                        else:
                                                            if x6 <= 2:
                                                                if x4 <= 6:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                        else:
                                            if x11 <= 2:
                                                if x12 <= 4:
                                                    if x3 <= 5:
                                                        if x9 <= 3:
                                                            if x8 <= 4:
                                                                return False
                                                            else:
                                                                if x7 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if x7 <= 4:
                                                                return True
                                                            else:
                                                                if x8 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return False
                                                else:
                                                    if x4 <= 0:
                                                        return False
                                                    else:
                                                        if x4 <= 5:
                                                            return True
                                                        else:
                                                            if x11 <= 1:
                                                                return False
                                                            else:
                                                                if x10 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                            else:
                                                if x7 <= 4:
                                                    if x10 <= 4:
                                                        return True
                                                    else:
                                                        if not aligned:
                                                            return True
                                                        else:
                                                            if x9 <= 4:
                                                                return True
                                                            else:
                                                                if x12 <= 4:
                                                                    return False
                                                                else:
                                                                    if x10 <= 6:
                                                                        return True
                                                                    else:
                                                                        return False
                                                else:
                                                    if x12 <= 3:
                                                        return False
                                                    else:
                                                        if x7 <= 5:
                                                            return True
                                                        else:
                                                            if x8 <= 5:
                                                                return False
                                                            else:
                                                                return True
                                    else:
                                        return False
                                else:
                                    if x3 <= 5:
                                        if x4 <= 6:
                                            if x4 <= 0:
                                                if x2 <= 2:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                        else:
                                            if x12 <= 4:
                                                if x2 <= 2:
                                                    if x6 <= 5:
                                                        return False
                                                    else:
                                                        if x7 <= 5:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                    else:
                                        if x4 <= 2:
                                            if x2 <= 1:
                                                if x6 <= 5:
                                                    return False
                                                else:
                                                    if x4 <= 0:
                                                        return False
                                                    else:
                                                        if x6 <= 6:
                                                            if x4 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                            else:
                                                return False
                                        else:
                                            if x4 <= 5:
                                                if x2 <= 1:
                                                    if x4 <= 4:
                                                        return True
                                                    else:
                                                        if x6 <= 5:
                                                            if x6 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                else:
                                                    if x4 <= 3:
                                                        if x6 <= 3:
                                                            return True
                                                        else:
                                                            if x6 <= 6:
                                                                return False
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    if x2 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                                    else:
                                                        if x2 <= 3:
                                                            if x8 <= 4:
                                                                if not aligned:
                                                                    if x11 <= 5:
                                                                        if x9 <= 2:
                                                                            if x11 <= 4:
                                                                                if x6 <= 6:
                                                                                    if x2 <= 2:
                                                                                        if x4 <= 4:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x4 <= 4:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x2 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x4 <= 4:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x2 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x4 <= 4:
                                                                            return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                if x6 <= 1:
                                                                    return True
                                                                else:
                                                                    if x6 <= 6:
                                                                        if x4 <= 4:
                                                                            if x6 <= 4:
                                                                                return True
                                                                            else:
                                                                                if x2 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x2 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if x2 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x9 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                        else:
                                                            return True
                                            else:
                                                if x7 <= 3:
                                                    if x9 <= 3:
                                                        if x2 <= 3:
                                                            return False
                                                        else:
                                                            if x4 <= 6:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        return True
                                                else:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        if x6 <= 2:
                                                            if x1 <= 2:
                                                                if x4 <= 6:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                        else:
                            if x1 <= 0:
                                if x5 <= 2:
                                    return False
                                else:
                                    if x3 <= 3:
                                        if x12 <= 3:
                                            if x7 <= 5:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return True
                                    else:
                                        if x8 <= 4:
                                            if x9 <= 3:
                                                if x6 <= 2:
                                                    if x7 <= 4:
                                                        return True
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                return False
                                        else:
                                            if x3 <= 4:
                                                return True
                                            else:
                                                if x4 <= 5:
                                                    return True
                                                else:
                                                    return False
                            else:
                                if x7 <= 5:
                                    return True
                                else:
                                    if x12 <= 3:
                                        return False
                                    else:
                                        return True
            else:
                return False
    else:
        if not cap:
            if x10 <= 0:
                if x11 <= 3:
                    if x3 <= 0:
                        if not reach:
                            return False
                        else:
                            return True
                    else:
                        return True
                else:
                    return True
            else:
                return True
        else:
            return False
