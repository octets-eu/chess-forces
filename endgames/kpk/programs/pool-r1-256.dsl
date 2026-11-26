# Promoted 2026-11-26 from state/concepts-baseline/stronger-r1-256.dsl: 1,834.5 B (1,606.3 B program, 228.2 B exceptions), 158 errors, at most 2,856 operations, tier 4,096.
# A greedy entropy tree with 256 leaves over the concept pool: 45 atoms, the 500 most informative enumerated comparisons and sums, and the 10 concepts of r1-unit-831, written as DSL by chess-forces concepts baseline (src/chess_forces/concepts.py); no model call.
def wins() -> Bool:
    a0 = tempo
    a1 = file(P)
    a4 = rank(K)
    a5 = file(k)
    a6 = rank(k)
    a7 = dist(K, k)
    a8 = dist(K, P)
    a9 = dist(K, sq(file(P), 7))
    a10 = dist(K, sq(file(P), rank(P) + 1))
    a11 = dist(K, sq(file(P), rank(P) + 2))
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
    a30 = steps(k, sq(file(P), 7), compl(union(king_f(K), guard(strong))))
    a31 = steps(k, sq(file(P), rank(P) + 1), compl(union(king_f(K), guard(strong))))
    a32 = steps(k, sq(file(P), rank(P) + 2), compl(union(king_f(K), guard(strong))))
    a33 = file(K) - file(k)
    a34 = rank(K) - rank(k)
    a35 = file(K) - file(P)
    a36 = rank(K) - rank(P)
    a37 = file(k) - file(P)
    a38 = rank(k) - rank(P)
    a39 = abs(file(K) - file(k))
    a40 = abs(rank(K) - rank(k))
    a41 = count(minus(king_f(k), guard(strong)))
    a42 = count(inter(king_f(k), guard(strong)))
    a44 = count(path(strong, P))
    r1_blocked = k in path(strong, P)
    r1_adj = P in king_f(K)
    r1_f = file(P)
    r1_r = rank(P)
    r1_q = sq(r1_f, 7)
    r1_n = min(5, 7 - r1_r)
    r1_runs = r1_n + 1 - tempo < dist(k, r1_q) and (not r1_blocked)
    r1_front = sq(r1_f, r1_r + 2)
    r1_ks = minus(king_f(r1_front), king_f(P))
    r1_free = compl(guard(weak))
    r1_bk = compl(king_f(K))
    r1_reach = any((steps(K, s, r1_free) + tempo < steps(k, s, union(r1_bk, one(s))) + tempo for s in r1_ks)) if r1_f > 0 else dist(K, sq(1, 6)) < min(dist(k, sq(2, 7)), dist(k, sq(1, 7)), dist(k, sq(2, 6)), dist(k, sq(0, 7))) + tempo
    r1_blockade = r1_blocked and r1_r < 6 and (not r1_adj) and (not K in king_f(r1_front)) and (not dist(K, r1_front) < dist(k, r1_front) + tempo)
    r1_aligned = file(K) == file(k) or rank(K) == rank(k)
    r1_opp = r1_f > 0 and dist(K, k) == 2 and r1_aligned and (tempo == 0) and (dist(K, P) < dist(k, P))
    r1_support = r1_f > 0 and tempo == 0 and r1_adj and (dist(k, r1_q) == r1_n + 1) and (not r1_blocked)
    r1_cap = tempo < 1 and k in king_f(P) and (not r1_adj)
    r1_near = r1_r >= 5 and r1_f > 0 and (dist(K, r1_q) + tempo <= dist(k, r1_q))
    r1_wins = (r1_runs or r1_support or (r1_reach and (not dist(k, P) + tempo < dist(K, P))) or (r1_opp and (not r1_blockade)) or r1_near) and (not r1_blockade) and (not r1_cap)
    if not r1_wins:
        if not (a32 + tempo < a10):
            if not (a25 + tempo < a22):
                if a1 <= 0:
                    if a34 <= -2:
                        if a9 <= 2:
                            if not (a14 + tempo - 1 < a16):
                                return True
                            else:
                                return False
                        else:
                            return False
                    else:
                        if a40 <= 0:
                            if a5 <= 3:
                                if a35 <= 0:
                                    return False
                                else:
                                    if a15 <= 2:
                                        return False
                                    else:
                                        return True
                            else:
                                return True
                        else:
                            if a20 <= 3:
                                if not (a38 + a26 < a27):
                                    return False
                                else:
                                    if a0 <= 0:
                                        if a7 <= 2:
                                            if a33 <= -2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                    else:
                                        if a14 <= 2:
                                            return False
                                        else:
                                            return True
                            else:
                                if a9 <= 2:
                                    if a37 <= 3:
                                        return True
                                    else:
                                        return True
                                else:
                                    if a0 <= 0:
                                        if not (a31 + tempo - 1 < a10):
                                            return False
                                        else:
                                            if a36 <= 3:
                                                return True
                                            else:
                                                return False
                                    else:
                                        if not (a22 + tempo < a15):
                                            return False
                                        else:
                                            return True
                else:
                    if not (a32 + tempo < a11):
                        if a39 <= 1:
                            if a36 <= -1:
                                if a20 <= 0:
                                    if a28 <= 4:
                                        return True
                                    else:
                                        if not (a32 + 1 < a26):
                                            return False
                                        else:
                                            return True
                                else:
                                    if not (a15 + 1 < a11):
                                        if a38 <= 5:
                                            if not (a31 + tempo < a24):
                                                if a8 <= 3:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                        else:
                                            return True
                                    else:
                                        if not (a29 + tempo < a26):
                                            return True
                                        else:
                                            return False
                            else:
                                if a4 <= 5:
                                    if a38 <= 4:
                                        if a34 <= -4:
                                            return False
                                        else:
                                            if a38 <= 2:
                                                if a16 <= 5:
                                                    if not (a27 + tempo < a16):
                                                        if not (a29 + a31 < a6):
                                                            if not (a29 + tempo - 1 < a9):
                                                                if a38 <= 0:
                                                                    return True
                                                                else:
                                                                    if not (a29 + tempo < a6):
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
                                                    if a38 <= 1:
                                                        if a42 <= 0:
                                                            if a38 <= 0:
                                                                return True
                                                            else:
                                                                if not (a26 + tempo - 1 < a32):
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                                                    else:
                                                        if not (a25 + tempo - 1 < a16):
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if not (a28 - 1 < a29):
                                                    return True
                                                else:
                                                    if a4 <= 4:
                                                        if not (a10 + tempo - 1 < a15):
                                                            if a34 <= -3:
                                                                return True
                                                            else:
                                                                if a39 <= 0:
                                                                    if a36 <= 1:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                        else:
                                                            if not (a42 + tempo + 1 < a29):
                                                                return True
                                                            else:
                                                                if a25 <= 3:
                                                                    return False
                                                                else:
                                                                    if a7 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                    else:
                                                        return True
                                    else:
                                        if a36 <= 0:
                                            if not (a28 + tempo - 1 < a32):
                                                return True
                                            else:
                                                if a38 <= 5:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            return True
                                else:
                                    if not (a29 - 1 < a38):
                                        if a44 <= 5:
                                            if not (a15 + tempo - 1 < a22):
                                                return False
                                            else:
                                                return False
                                        else:
                                            if a9 <= 2:
                                                return True
                                            else:
                                                return False
                                    else:
                                        if not (a24 < a32):
                                            return False
                                        else:
                                            return True
                        else:
                            if not (a27 + tempo < a26):
                                if a11 <= 3:
                                    if a4 <= 6:
                                        if not r1_blocked:
                                            if not (a10 + tempo < a15):
                                                if not (a31 + tempo - 1 < (dist(k, P))):
                                                    if a4 <= 5:
                                                        if a41 <= 1:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a38 <= 1:
                                                            if a15 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                else:
                                                    if not (a30 + tempo - 1 < a26):
                                                        if a34 <= 1:
                                                            if a4 <= 0:
                                                                if not (a29 + a15 < a6):
                                                                    return True
                                                                else:
                                                                    if a37 <= 1:
                                                                        if a37 <= -2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return True
                                                        else:
                                                            if a19 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if a39 <= 4:
                                                            if a11 <= 2:
                                                                if not (a30 < a26):
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                            else:
                                                if a40 <= 1:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            return False
                                    else:
                                        if not (a38 < a27):
                                            return True
                                        else:
                                            return False
                                else:
                                    if a30 <= 2:
                                        return False
                                    else:
                                        if a35 <= 3:
                                            return True
                                        else:
                                            if a4 <= 6:
                                                return True
                                            else:
                                                return False
                            else:
                                if a19 <= 4:
                                    if not (a29 + a15 < a6):
                                        return False
                                    else:
                                        return True
                                else:
                                    if not (a6 + 1 < a29):
                                        return True
                                    else:
                                        return False
                    else:
                        if not (a15 + tempo + 1 < a9):
                            if not (a29 + a15 < a6):
                                if not (a14 + tempo < a26):
                                    if a39 <= 1:
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
                if not (a16 + tempo - 1 < a30):
                    if a9 <= 3:
                        if a5 <= 4:
                            if a8 <= 2:
                                if not (a27 + tempo < a16):
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if not (a10 + tempo - 1 < a15):
                                            return True
                                        else:
                                            if a4 <= 4:
                                                if not (a27 - 1 < a38):
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if not (a30 + tempo - 1 < a16):
                                                    return True
                                                else:
                                                    if a34 <= -1:
                                                        if a42 <= 3:
                                                            return True
                                                        else:
                                                            if a42 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return False
                                else:
                                    if not (a13 + tempo - 1 < a16):
                                        return True
                                    else:
                                        if a41 <= 1:
                                            return False
                                        else:
                                            return False
                            else:
                                if not (a32 + tempo < a8):
                                    return False
                                else:
                                    if a39 <= 2:
                                        if a37 <= 3:
                                            return False
                                        else:
                                            return False
                                    else:
                                        if a9 <= 2:
                                            if not (a31 - 1 < a38):
                                                return False
                                            else:
                                                return True
                                        else:
                                            if a7 <= 4:
                                                return False
                                            else:
                                                if not (a31 - 1 < a38):
                                                    return False
                                                else:
                                                    return True
                        else:
                            if a16 <= 5:
                                if not (a38 < a31):
                                    if not (a14 + tempo < a26):
                                        return True
                                    else:
                                        return False
                                else:
                                    return False
                            else:
                                if not (a32 + tempo < a26):
                                    return True
                                else:
                                    return False
                    else:
                        if a10 <= 2:
                            if a38 <= 0:
                                return True
                            else:
                                return False
                        else:
                            if a37 <= -3:
                                return True
                            else:
                                return False
                else:
                    if a8 <= 1:
                        if a42 <= 2:
                            return False
                        else:
                            return False
                    else:
                        return False
        else:
            if not (a29 + tempo < a28):
                if not (a31 + tempo < a26):
                    if not (a30 + tempo + 1 < a24):
                        if a1 <= 0:
                            return False
                        else:
                            if a9 <= 2:
                                return True
                            else:
                                return False
                    else:
                        if not (a11 - 1 < a15):
                            if a9 <= 2:
                                if not r1_blockade:
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
        if not r1_runs:
            if a33 <= -2:
                if not (a32 + tempo < a24):
                    if a5 <= 3:
                        if a1 <= 0:
                            if a15 <= 2:
                                if not (a13 + tempo - 1 < a16):
                                    return True
                                else:
                                    if not (a14 + tempo - 1 < a6):
                                        return True
                                    else:
                                        return False
                            else:
                                if a0 <= 0:
                                    if a39 <= 2:
                                        return True
                                    else:
                                        if a38 <= -1:
                                            return True
                                        else:
                                            return False
                                else:
                                    return True
                        else:
                            return True
                    else:
                        if not (a30 + tempo - 1 < a26):
                            return True
                        else:
                            if a35 <= -3:
                                if not (a31 + tempo < a24):
                                    if not (a25 + tempo < a26):
                                        return True
                                    else:
                                        return True
                                else:
                                    return False
                            else:
                                return True
                else:
                    if not (a32 + tempo < a11):
                        if a33 <= -3:
                            if not (a13 + tempo - 1 < a26):
                                return True
                            else:
                                if a0 <= 0:
                                    if not (a22 - 1 < a13):
                                        if not (a10 + tempo < a32):
                                            return False
                                        else:
                                            if a36 <= 0:
                                                return False
                                            else:
                                                return True
                                    else:
                                        if a33 <= -4:
                                            if a40 <= 6:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return False
                                else:
                                    return True
                        else:
                            if a0 <= 0:
                                if not (a10 + 1 < a32):
                                    if not (a22 + tempo + 1 < a29):
                                        if a35 <= -2:
                                            if not (a26 < a29):
                                                return False
                                            else:
                                                if a36 <= 0:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            return True
                                    else:
                                        return False
                                else:
                                    if a30 <= 2:
                                        if not (a15 + tempo + 1 < a9):
                                            return True
                                        else:
                                            return False
                                    else:
                                        if a7 <= 6:
                                            return True
                                        else:
                                            if not (a23 < a6):
                                                return False
                                            else:
                                                return True
                            else:
                                return True
                    else:
                        return False
            else:
                if a0 <= 0:
                    if not (a8 + 1 < a32):
                        if a37 <= -2:
                            if not (a32 + tempo < a11):
                                if a33 <= 1:
                                    if not r1_opp:
                                        if not (a17 + 2 < a29):
                                            if not (a29 + 2 < a24):
                                                if a44 <= 5:
                                                    if not r1_reach:
                                                        return True
                                                    else:
                                                        if not (a27 + tempo - 1 < a26):
                                                            if not (a13 - 1 < a16):
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
                                            if not (a14 + tempo + 1 < a24):
                                                return True
                                            else:
                                                return False
                                    else:
                                        return True
                                else:
                                    if not (a30 < a26):
                                        if not (a27 + tempo < a26):
                                            return True
                                        else:
                                            return False
                                    else:
                                        if a9 <= 2:
                                            return True
                                        else:
                                            if not (a29 + tempo - 1 < a10):
                                                return True
                                            else:
                                                if a30 <= 2:
                                                    return False
                                                else:
                                                    if a39 <= 6:
                                                        return True
                                                    else:
                                                        return False
                            else:
                                return False
                        else:
                            if a25 <= 6:
                                if a38 <= 4:
                                    if a4 <= 2:
                                        if (count(inter(king_f(K), king_f(k)))) <= 2:
                                            return False
                                        else:
                                            if not (a38 + tempo + 2 < a23):
                                                return True
                                            else:
                                                return False
                                    else:
                                        if not (a16 + tempo + 1 < a25):
                                            if a41 <= 2:
                                                if not (a27 + tempo + 1 < a24):
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                if a37 <= 1:
                                                    if not (a15 + tempo < a24):
                                                        return False
                                                    else:
                                                        return False
                                                else:
                                                    if not r1_opp:
                                                        if a4 <= 5:
                                                            if not (a15 + tempo < a9):
                                                                if a19 <= 2:
                                                                    if not (a38 + 2 < a31):
                                                                        if a9 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if a34 <= 3:
                                                                        if a23 <= 5:
                                                                            if a19 <= 4:
                                                                                return False
                                                                            else:
                                                                                if a4 <= 4:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if not (a38 + tempo + 2 < a27):
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if not (a24 < a29):
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return False
                                                        else:
                                                            if not (a38 + a14 < a27):
                                                                return False
                                                            else:
                                                                if not (a14 + tempo - 1 < a26):
                                                                    if a36 <= 3:
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
                                    if not (a26 + tempo < a29):
                                        if not (a13 < a26):
                                            if a36 <= 0:
                                                return False
                                            else:
                                                return True
                                        else:
                                            if a35 <= 1:
                                                return True
                                            else:
                                                return False
                                    else:
                                        if a36 <= 0:
                                            if a38 <= 5:
                                                return False
                                            else:
                                                if a7 <= 6:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            return True
                            else:
                                return True
                    else:
                        if not (a15 + tempo + 1 < a9):
                            if a22 <= 1:
                                if not (a17 + 1 < a15):
                                    if a38 <= 3:
                                        return True
                                    else:
                                        if a39 <= 1:
                                            return False
                                        else:
                                            return True
                                else:
                                    if not (a38 + a14 < a27):
                                        if a35 <= -1:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                            else:
                                if a41 <= 0:
                                    return False
                                else:
                                    return True
                        else:
                            if a39 <= 1:
                                if not r1_opp:
                                    if a16 <= 5:
                                        return False
                                    else:
                                        if a28 <= 2:
                                            if not r1_adj:
                                                return True
                                            else:
                                                if not (a42 + 2 < a15):
                                                    return False
                                                else:
                                                    if a29 <= 3:
                                                        return False
                                                    else:
                                                        return True
                                        else:
                                            return False
                                else:
                                    return True
                            else:
                                if not (a15 + a38 < a32):
                                    if a33 <= 2:
                                        if a36 <= -1:
                                            return False
                                        else:
                                            return True
                                    else:
                                        if a34 <= -7:
                                            if a37 <= -3:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return True
                                else:
                                    return True
                else:
                    if a34 <= 1:
                        if a1 <= 0:
                            if not (a29 < a8):
                                return True
                            else:
                                return False
                        else:
                            return True
                    else:
                        if not (a28 + tempo - 1 < a29):
                            if a22 <= 3:
                                return True
                            else:
                                if a39 <= 2:
                                    if a25 <= 5:
                                        if not (a27 - 1 < a6):
                                            if a40 <= 3:
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
                            return True
        else:
            if a24 <= 0:
                if a13 <= 3:
                    if (file(K)) <= 0:
                        if not r1_reach:
                            return False
                        else:
                            return True
                    else:
                        return True
                else:
                    return True
            else:
                return True
