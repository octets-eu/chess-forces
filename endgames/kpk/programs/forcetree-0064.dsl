# Promoted 2026-11-26 from state/force-trees/concepts-0064.dsl: 4,136.6 B (405.5 B program, 3,731.2 B exceptions), 4,505 errors, at most 1,355 operations, tier 4,096.
# A greedy entropy tree with 64 leaves over the 10 concepts of r1-unit-831 and the simple features of the tree baselines, written as DSL by scripts/force_trees.py; no model involved.
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
                                        return False
                                else:
                                    return False
                            else:
                                return True
                        else:
                            if not cap:
                                if not near:
                                    return False
                                else:
                                    return True
                            else:
                                return False
                    else:
                        if x1 <= 0:
                            return False
                        else:
                            if not blockade:
                                if x10 <= 3:
                                    return True
                                else:
                                    if x11 <= 1:
                                        return False
                                    else:
                                        if not aligned:
                                            if x12 <= 1:
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
                if x5 <= 4:
                    if x0 <= 0:
                        return False
                    else:
                        if x12 <= 1:
                            return False
                        else:
                            if x1 <= 0:
                                return False
                            else:
                                if x10 <= 3:
                                    return False
                                else:
                                    if x7 <= 4:
                                        return False
                                    else:
                                        return False
                else:
                    if x0 <= 0:
                        if not aligned:
                            return False
                        else:
                            return False
                    else:
                        if x5 <= 5:
                            if x3 <= 6:
                                return False
                            else:
                                return False
                        else:
                            return False
        else:
            if not cap:
                if x7 <= 2:
                    if x0 <= 0:
                        if x11 <= 3:
                            if x10 <= 4:
                                if x9 <= 3:
                                    if x10 <= 1:
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
                        if not blockade:
                            if x8 <= 2:
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
                                            return True
                                        else:
                                            return False
                                    else:
                                        return True
                            else:
                                if x9 <= 5:
                                    if x0 <= 0:
                                        return True
                                    else:
                                        return True
                                else:
                                    return True
                        else:
                            if x0 <= 0:
                                if x4 <= 5:
                                    if x10 <= 3:
                                        return False
                                    else:
                                        return False
                                else:
                                    if x6 <= 4:
                                        return False
                                    else:
                                        return False
                            else:
                                if x8 <= 2:
                                    if x12 <= 1:
                                        return False
                                    else:
                                        return False
                                else:
                                    if x7 <= 4:
                                        return True
                                    else:
                                        return False
                    else:
                        if x0 <= 0:
                            if x3 <= 4:
                                if x12 <= 4:
                                    if x7 <= 5:
                                        if x7 <= 4:
                                            if x5 <= 5:
                                                if x10 <= 3:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                        else:
                                            if x8 <= 4:
                                                return False
                                            else:
                                                return True
                                    else:
                                        return False
                                else:
                                    return True
                            else:
                                if x5 <= 6:
                                    return False
                                else:
                                    if x3 <= 5:
                                        return True
                                    else:
                                        return False
                        else:
                            if x1 <= 0:
                                return True
                            else:
                                return True
            else:
                return False
    else:
        if not cap:
            return True
        else:
            return False
