# Promoted 2026-11-26 from state/enumerated/both-0256.dsl: 2,568.5 B (1,587.1 B program, 981.5 B exceptions), 870 errors, at most 2,367 operations, tier 4,096.
# A greedy entropy tree with 256 leaves over 30 atoms, 500 enumerated comparisons and the 10 concepts of r1-unit-831, written as DSL by scripts/enumerate_concepts.py; no model involved.
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
    a0 = tempo
    a1 = file(P)
    a2 = rank(P)
    a3 = file(K)
    a4 = rank(K)
    a5 = file(k)
    a6 = rank(k)
    a7 = dist(K, k)
    a8 = dist(K, P)
    a9 = dist(K, sq(file(P), 7))
    a10 = dist(K, sq(file(P), rank(P) + 1))
    a11 = dist(K, sq(file(P), rank(P) + 2))
    a12 = dist(k, P)
    a13 = dist(k, sq(file(P), 7))
    a14 = dist(k, sq(file(P), rank(P) + 1))
    a15 = dist(k, sq(file(P), rank(P) + 2))
    a16 = dist(P, sq(file(P), 7))
    a17 = dist(P, sq(file(P), rank(P) + 1))
    a19 = dist(sq(file(P), 7), sq(file(P), rank(P) + 1))
    a20 = dist(sq(file(P), 7), sq(file(P), rank(P) + 2))
    a22 = steps(K, P, compl(guard(weak)))
    a23 = steps(k, P, compl(king_f(K)))
    a24 = steps(K, sq(file(P), 7), compl(guard(weak)))
    a25 = steps(k, sq(file(P), 7), compl(king_f(K)))
    a26 = steps(K, sq(file(P), rank(P) + 1), compl(guard(weak)))
    a27 = steps(k, sq(file(P), rank(P) + 1), compl(king_f(K)))
    a28 = steps(K, sq(file(P), rank(P) + 2), compl(guard(weak)))
    a29 = steps(k, sq(file(P), rank(P) + 2), compl(king_f(K)))
    if not runs:
        if not (a14 + tempo < a10):
            if not reach:
                if a16 <= 2:
                    if a1 <= 0:
                        if not (a29 + tempo - 1 < a9):
                            if a3 <= 0:
                                if not (a27 + tempo + 1 < a6):
                                    return False
                                else:
                                    return True
                            else:
                                return True
                        else:
                            return False
                    else:
                        if not (a25 + tempo < a22):
                            if not (a25 + tempo < a26):
                                if not (a17 + 1 < a14):
                                    return True
                                else:
                                    if not (a29 + tempo < a7):
                                        return True
                                    else:
                                        return True
                            else:
                                if not (a15 + tempo + 1 < a11):
                                    if a6 <= 5:
                                        return False
                                    else:
                                        if not (a15 + tempo - 1 < a10):
                                            return True
                                        else:
                                            return True
                                else:
                                    return False
                        else:
                            if not cap:
                                if not (a15 < a10):
                                    return True
                                else:
                                    return False
                            else:
                                return False
                else:
                    if not (a15 + tempo < a11):
                        if a1 <= 0:
                            if not (a13 + tempo < a24):
                                if a6 <= 4:
                                    if not (a26 + 1 < a25):
                                        if a4 <= 5:
                                            return False
                                        else:
                                            return False
                                    else:
                                        if not aligned:
                                            if not (a24 + tempo - 1 < a15):
                                                return True
                                            else:
                                                if not (a16 + 1 < a25):
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            if not (a17 + 2 < a15):
                                                if a3 <= 0:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                else:
                                    if a24 <= 3:
                                        return False
                                    else:
                                        return False
                            else:
                                return False
                        else:
                            if not (a8 < a25):
                                if not (a13 + tempo < a22):
                                    if a4 <= 1:
                                        if not (a22 + tempo - 1 < a29):
                                            if a5 <= 1:
                                                if a3 <= 4:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if not (a29 + tempo - 1 < a3):
                                                    if a5 <= 4:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a20 <= 3:
                                                        return False
                                                    else:
                                                        if not (a14 + 2 < a24):
                                                            if not (a27 + 1 < a6):
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a4 <= 0:
                                                                return False
                                                            else:
                                                                if a23 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                        else:
                                            if not (a13 + tempo - 1 < a26):
                                                if not aligned:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                    else:
                                        if a4 <= 5:
                                            if not (a14 + tempo < a9):
                                                if a6 <= 5:
                                                    if a19 <= 3:
                                                        return False
                                                    else:
                                                        if not (a29 + tempo - 1 < a7):
                                                            if a6 <= 4:
                                                                if a2 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                if a8 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            return False
                                                else:
                                                    if a20 <= 2:
                                                        if a7 <= 3:
                                                            if a6 <= 6:
                                                                return False
                                                            else:
                                                                if not (a23 + tempo - 1 < a16):
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if a8 <= 3:
                                                                return False
                                                            else:
                                                                return False
                                                    else:
                                                        if not (a12 - 1 < a27):
                                                            return True
                                                        else:
                                                            if a4 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                            else:
                                                if not (a17 + 1 < a14):
                                                    if a7 <= 4:
                                                        if not (a27 + tempo - 1 < a26):
                                                            if not blockade:
                                                                if not (a29 + tempo + 2 < a24):
                                                                    if not opp:
                                                                        if not (a29 + tempo - 1 < a7):
                                                                            return False
                                                                        else:
                                                                            if not aligned:
                                                                                return True
                                                                            else:
                                                                                if not (a15 < a11):
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
                                                            if not aligned:
                                                                if not (a29 + tempo - 1 < a12):
                                                                    return False
                                                                else:
                                                                    if a7 <= 3:
                                                                        if not (a27 + tempo + 1 < a26):
                                                                            return True
                                                                        else:
                                                                            if not (a29 + tempo < a7):
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
                                                    if a7 <= 5:
                                                        if not (a15 + 1 < a16):
                                                            return False
                                                        else:
                                                            if not (a29 + tempo - 1 < a7):
                                                                if not (a29 + 1 < a6):
                                                                    if not (a6 + tempo - 1 < a23):
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
                                    if a9 <= 2:
                                        if a7 <= 2:
                                            if not (a29 + tempo < a22):
                                                return True
                                            else:
                                                return False
                                        else:
                                            if not (a13 + tempo < a9):
                                                return True
                                            else:
                                                return False
                                    else:
                                        if not (a15 + tempo + 2 < a28):
                                            if not (a15 + tempo - 1 < a24):
                                                if a6 <= 5:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                        else:
                                            return True
                            else:
                                if not aligned:
                                    if not (a11 + tempo - 1 < a15):
                                        if not blockade:
                                            if a3 <= 3:
                                                if a5 <= 4:
                                                    if not (a25 + tempo < a24):
                                                        return True
                                                    else:
                                                        if a28 <= 52:
                                                            if not blocked:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            if not (a27 + tempo - 1 < a8):
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    return True
                                            else:
                                                if a5 <= 2:
                                                    return True
                                                else:
                                                    if not (a29 + tempo < a3):
                                                        if a1 <= 2:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if not (a22 < a13):
                                                            return True
                                                        else:
                                                            if not (a15 + tempo + 2 < a28):
                                                                return False
                                                            else:
                                                                return True
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    if not (a28 - 1 < a29):
                                        if a26 <= 1:
                                            return True
                                        else:
                                            return False
                                    else:
                                        if not (a22 + 1 < a25):
                                            if not (a8 + 1 < a15):
                                                if a26 <= 5:
                                                    if not opp:
                                                        if not (a10 + tempo - 1 < a29):
                                                            return False
                                                        else:
                                                            if a26 <= 4:
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
                                            if not (a27 + tempo - 1 < a16):
                                                if not (a11 + tempo - 1 < a15):
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                    else:
                        if not (a13 + tempo + 1 < a24):
                            if not (a15 + tempo < a26):
                                if a1 <= 0:
                                    return False
                                else:
                                    return True
                            else:
                                return False
                        else:
                            return False
            else:
                if not (a14 + tempo < a22):
                    if not (a29 + tempo - 1 < a11):
                        if not (a29 + tempo - 1 < a3):
                            if a5 <= 4:
                                if not (a15 + tempo + 2 < a9):
                                    if a0 <= 0:
                                        if not (a24 + 1 < a29):
                                            if a20 <= 3:
                                                if a7 <= 2:
                                                    if not (a10 + 1 < a29):
                                                        return True
                                                    else:
                                                        if a10 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    if not (a17 + 1 < a15):
                                                        return False
                                                    else:
                                                        if a7 <= 4:
                                                            if not (a26 + 1 < a29):
                                                                if not (a29 + tempo < a7):
                                                                    if not (a8 < a27):
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
                                                if not (a14 - 1 < a8):
                                                    if not (a14 + tempo + 1 < a9):
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    if not (a25 + 2 < a26):
                                                        return True
                                                    else:
                                                        return False
                                        else:
                                            if a3 <= 0:
                                                if a7 <= 3:
                                                    if a1 <= 0:
                                                        if not (a2 - 1 < a6):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                if a25 <= 2:
                                                    if not (a22 + tempo < a13):
                                                        return True
                                                    else:
                                                        if not (a26 + 1 < a15):
                                                            return True
                                                        else:
                                                            return True
                                                else:
                                                    return True
                                    else:
                                        if a1 <= 0:
                                            if not (a15 - 1 < a24):
                                                if a23 <= 2:
                                                    return True
                                                else:
                                                    return True
                                            else:
                                                if not (a8 + 1 < a13):
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            if not (a29 + tempo - 1 < a22):
                                                return True
                                            else:
                                                if a9 <= 2:
                                                    return True
                                                else:
                                                    if not (a24 - 1 < a15):
                                                        return True
                                                    else:
                                                        return False
                                else:
                                    if not (a25 + tempo - 1 < a10):
                                        if not (a26 + tempo < a15):
                                            return True
                                        else:
                                            if not (a14 + 1 < a6):
                                                return True
                                            else:
                                                return False
                                    else:
                                        return False
                            else:
                                if a28 <= 4:
                                    if not (a15 + tempo + 1 < a3):
                                        if a5 <= 5:
                                            if a11 <= 2:
                                                return True
                                            else:
                                                if a0 <= 0:
                                                    if a11 <= 3:
                                                        if a25 <= 3:
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
                                        return True
                                else:
                                    if a4 <= 5:
                                        return True
                                    else:
                                        return False
                        else:
                            if a0 <= 0:
                                if not (a8 + 1 < a13):
                                    if not (a14 + tempo + 1 < a9):
                                        if not (a5 + tempo < a6):
                                            if not (a24 + 1 < a29):
                                                if not (a16 + tempo + 1 < a25):
                                                    if a6 <= 5:
                                                        if not (a26 + tempo + 1 < a29):
                                                            if not (a2 - 1 < a6):
                                                                return False
                                                            else:
                                                                if a19 <= 4:
                                                                    return False
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a23 <= 5:
                                                            return False
                                                        else:
                                                            if a25 <= 5:
                                                                return True
                                                            else:
                                                                return True
                                                else:
                                                    return True
                                            else:
                                                return True
                                        else:
                                            if not (a22 - 1 < a15):
                                                if not (a13 + tempo < a9):
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                if a16 <= 5:
                                                    if not (a14 + tempo < a9):
                                                        if a5 <= 2:
                                                            return True
                                                        else:
                                                            if not (a19 - 1 < a15):
                                                                return True
                                                            else:
                                                                return True
                                                    else:
                                                        if a5 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    return True
                                    else:
                                        if a5 <= 1:
                                            if a24 <= 6:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return False
                                else:
                                    if not (a26 + tempo + 1 < a29):
                                        if a5 <= 2:
                                            return True
                                        else:
                                            if a22 <= 2:
                                                return False
                                            else:
                                                if a25 <= 6:
                                                    return True
                                                else:
                                                    return True
                                    else:
                                        return True
                            else:
                                if not (a27 < a22):
                                    return True
                                else:
                                    if a9 <= 2:
                                        return True
                                    else:
                                        if not (a16 - 1 < a25):
                                            return True
                                        else:
                                            return False
                    else:
                        if not (a13 + tempo < a10):
                            if not (a29 + tempo < a7):
                                if not (a8 + tempo + 1 < a29):
                                    if not (a15 + 1 < a9):
                                        if a2 <= 1:
                                            if not (a17 + 1 < a15):
                                                return False
                                            else:
                                                return True
                                        else:
                                            if not (a16 + 1 < a25):
                                                if not (a29 + tempo + 2 < a6):
                                                    return False
                                                else:
                                                    if a14 <= 2:
                                                        return False
                                                    else:
                                                        if not (a9 - 1 < a13):
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                return True
                                    else:
                                        return False
                                else:
                                    if a7 <= 2:
                                        if not (a13 + tempo < a24):
                                            return True
                                        else:
                                            return False
                                    else:
                                        if a3 <= 3:
                                            if a5 <= 5:
                                                return True
                                            else:
                                                return True
                                        else:
                                            return False
                            else:
                                if not (a13 + tempo + 1 < a9):
                                    if not (a15 + tempo < a11):
                                        if not (a0 + 2 < a27):
                                            return True
                                        else:
                                            if a7 <= 5:
                                                if not (a27 + tempo - 1 < a26):
                                                    if not (a29 + tempo + 2 < a6):
                                                        return True
                                                    else:
                                                        if not (a24 - 1 < a15):
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
                                    if not (a12 + tempo < a6):
                                        return True
                                    else:
                                        if not (a29 + tempo - 1 < a3):
                                            if a5 <= 2:
                                                return False
                                            else:
                                                if not (a5 + tempo < a6):
                                                    return True
                                                else:
                                                    return True
                                        else:
                                            if a5 <= 1:
                                                if a7 <= 3:
                                                    if not (a10 < a15):
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a3 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                if a1 <= 2:
                                                    return False
                                                else:
                                                    if not (a29 + tempo < a3):
                                                        return True
                                                    else:
                                                        return False
                        else:
                            return False
                else:
                    if not cap:
                        if a20 <= 3:
                            if not (a27 + tempo < a22):
                                return True
                            else:
                                if not (a15 + 1 < a6):
                                    if not (a15 + tempo - 1 < a8):
                                        if not (a29 + tempo - 1 < a7):
                                            return False
                                        else:
                                            return True
                                    else:
                                        return False
                                else:
                                    if not (a13 + tempo < a16):
                                        if not (a15 + tempo - 1 < a8):
                                            if a7 <= 2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                    else:
                                        if not (a29 + tempo < a9):
                                            if not (a12 - 1 < a27):
                                                if not (a13 + tempo < a9):
                                                    if a1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if a19 <= 3:
                                                    if a6 <= 5:
                                                        if a13 <= 2:
                                                            if not (a19 - 1 < a15):
                                                                if a1 <= 0:
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
                                                    if a1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                        else:
                                            return False
                        else:
                            if not (a24 + 1 < a29):
                                if not (a1 + 2 < a29):
                                    if not (a15 + tempo < a11):
                                        if not (a25 + tempo < a24):
                                            if not (a17 + tempo + 2 < a15):
                                                if a7 <= 3:
                                                    return True
                                                else:
                                                    return True
                                            else:
                                                if a7 <= 5:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    if not (a17 + tempo + 2 < a15):
                                        return True
                                    else:
                                        return False
                            else:
                                return True
                    else:
                        return False
        else:
            if not (a22 + 1 < a13):
                if a8 <= 2:
                    if a20 <= 51:
                        return False
                    else:
                        if not (a27 < a12):
                            if not (a16 + 1 < a23):
                                return False
                            else:
                                return False
                        else:
                            if not (a23 + tempo - 1 < a16):
                                if a1 <= 0:
                                    return False
                                else:
                                    return True
                            else:
                                return False
                else:
                    return False
            else:
                if a28 <= 3:
                    if a19 <= 4:
                        return False
                    else:
                        if not (a23 - 1 < a6):
                            return True
                        else:
                            return False
                else:
                    return False
    else:
        if not cap:
            if a24 <= 0:
                if not (a14 + tempo + 1 < a6):
                    return True
                else:
                    return True
            else:
                return True
        else:
            return False
