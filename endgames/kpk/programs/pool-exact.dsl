# Promoted 2026-11-26 from state/concepts-baseline/stronger-exact.dsl: 2,781.5 B (2,781.5 B program, 0.0 B exceptions), 0 errors, at most 1,896 operations, tier 4,096.
# An exact greedy entropy tree (545 leaves) over 45 atoms and the 500 most informative enumerated comparisons and sums, no model-found concept, written as DSL by chess-forces concepts baseline (src/chess_forces/concepts.py); no model call.
def wins() -> Bool:
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
    a43 = count(inter(king_f(K), king_f(k)))
    a44 = count(path(strong, P))
    if not (a32 + tempo - 1 < a26):
        if not (a16 + 1 < a13):
            if not (a25 + tempo + 1 < a24):
                if a39 <= 1:
                    if not (a38 + 1 < a0):
                        if a23 <= 1:
                            return False
                        else:
                            if not (a31 + tempo - 1 < a12):
                                if not (a25 - 1 < a16):
                                    if not (a29 < a26):
                                        if a41 <= 0:
                                            if not (a14 + tempo - 1 < a10):
                                                return True
                                            else:
                                                return False
                                        else:
                                            if a9 <= 0:
                                                if a3 <= 0:
                                                    if a39 <= 0:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                    else:
                                        if a2 <= 1:
                                            return True
                                        else:
                                            return False
                                else:
                                    if not (a28 + tempo - 1 < a29):
                                        if a25 <= 5:
                                            if not (a26 + tempo - 1 < a32):
                                                if not (a32 < a22):
                                                    if a24 <= 3:
                                                        if a1 <= 0:
                                                            if a34 <= 0:
                                                                if a9 <= 2:
                                                                    if not (a17 + 1 < a31):
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
                                                        if a1 <= 0:
                                                            if not (a38 + a6 < a29):
                                                                return False
                                                            else:
                                                                if a7 <= 3:
                                                                    if a34 <= 2:
                                                                        return False
                                                                    else:
                                                                        if a6 <= 2:
                                                                            return True
                                                                        else:
                                                                            if a38 <= 0:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    return False
                                                        else:
                                                            if not (a32 + tempo < a24):
                                                                if a4 <= 5:
                                                                    if a23 <= 3:
                                                                        return True
                                                                    else:
                                                                        if a36 <= -1:
                                                                            return False
                                                                        else:
                                                                            if a38 <= 4:
                                                                                if a40 <= 3:
                                                                                    if a43 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if a38 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if a36 <= 3:
                                                                        if not (a38 + tempo + 2 < a27):
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if not (a29 < a26):
                                                                    if a36 <= -1:
                                                                        return False
                                                                    else:
                                                                        if a2 <= 3:
                                                                            if not (a27 + tempo < a16):
                                                                                return False
                                                                            else:
                                                                                if not (a27 + tempo < a24):
                                                                                    return True
                                                                                else:
                                                                                    if not (a32 + tempo < a9):
                                                                                        return False
                                                                                    else:
                                                                                        if a7 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    return True
                                                else:
                                                    if a2 <= 1:
                                                        if not (a17 + 2 < a32):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                            else:
                                                if a1 <= 0:
                                                    if not (a32 < a24):
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                        else:
                                            return True
                                    else:
                                        if a1 <= 0:
                                            if a34 <= 0:
                                                if a25 <= 5:
                                                    if not (a15 + tempo - 1 < a24):
                                                        if not (a24 < a32):
                                                            return False
                                                        else:
                                                            if not (a26 + tempo < a15):
                                                                if a13 <= 3:
                                                                    if not (a16 < a27):
                                                                        return False
                                                                    else:
                                                                        if not (a16 < a29):
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if not (a10 + tempo - 1 < a15):
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                                    else:
                                                        return False
                                                else:
                                                    if not (a32 + tempo - 1 < a16):
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                        else:
                                            if not (a22 + tempo < a15):
                                                return True
                                            else:
                                                if a36 <= 1:
                                                    if not (a15 + tempo < a24):
                                                        if not (a32 - 1 < a24):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    return True
                            else:
                                if a2 <= 1:
                                    if not (a16 < a30):
                                        if a1 <= 0:
                                            if not (a22 + 1 < a13):
                                                if not (a38 + a26 < a29):
                                                    if not (a10 + tempo < a32):
                                                        if not (a32 - 1 < a24):
                                                            if a28 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if a40 <= 4:
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                        else:
                                            if not (a32 + 1 < a6):
                                                if not (a26 + 1 < a32):
                                                    if a38 <= 4:
                                                        if not (a22 + 1 < a13):
                                                            if a23 <= 5:
                                                                return False
                                                            else:
                                                                if not (a16 + tempo - 1 < a27):
                                                                    return True
                                                                else:
                                                                    if a4 <= 2:
                                                                        return False
                                                                    else:
                                                                        if a4 <= 5:
                                                                            if not (a6 + 1 < a29):
                                                                                return True
                                                                            else:
                                                                                if not (a38 + a26 < a30):
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a4 <= 1:
                                                            if not (a32 < a24):
                                                                if not (a6 + tempo - 1 < a32):
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
                                        return True
                                else:
                                    if not (a16 + tempo + 1 < a25):
                                        if not (a32 + tempo + 1 < a6):
                                            if a34 <= 3:
                                                if a38 <= 3:
                                                    return False
                                                else:
                                                    if a41 <= 4:
                                                        if a36 <= 0:
                                                            return False
                                                        else:
                                                            if a1 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if a40 <= 2:
                                                            if a1 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                            else:
                                                if a36 <= 3:
                                                    if not (a31 + tempo - 1 < a10):
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                        else:
                                            if a1 <= 0:
                                                if a24 <= 2:
                                                    if not (a16 + tempo < a27):
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if not (a31 + tempo < a24):
                                                    if a38 <= 4:
                                                        if a27 <= 3:
                                                            if a34 <= -4:
                                                                if not (a11 + tempo - 1 < a32):
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a4 <= 6:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if a4 <= 4:
                                                                if a20 <= 1:
                                                                    if a41 <= 7:
                                                                        if a38 <= 2:
                                                                            if a24 <= 3:
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
                                                        if a29 <= 4:
                                                            return True
                                                        else:
                                                            if a34 <= -5:
                                                                return False
                                                            else:
                                                                return True
                                                else:
                                                    if not (a15 + 1 < a24):
                                                        return False
                                                    else:
                                                        if not (a26 < a13):
                                                            if a11 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                    else:
                                        if a36 <= 2:
                                            return True
                                        else:
                                            return False
                    else:
                        return True
                else:
                    if a1 <= 0:
                        if not (a15 + tempo - 1 < a24):
                            if not (a14 + tempo < a6):
                                if a34 <= -1:
                                    if a41 <= 5:
                                        return True
                                    else:
                                        if a4 <= 3:
                                            if a0 <= 0:
                                                if a9 <= 4:
                                                    if a5 <= 5:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if a37 <= 5:
                                                    if a34 <= -2:
                                                        if not (a14 - 1 < a16):
                                                            return True
                                                        else:
                                                            if a9 <= 4:
                                                                if a14 <= 4:
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
                                            return True
                                else:
                                    if a23 <= 3:
                                        if a0 <= 0:
                                            if not (a32 + tempo + 1 < a41):
                                                if a3 <= 0:
                                                    if a38 <= -1:
                                                        if not (a17 + 1 < a27):
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
                                            if not (a17 + 1 < a15):
                                                if not (a22 + 1 < a13):
                                                    if not (a31 + tempo - 1 < a26):
                                                        if not (a16 < a25):
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
                                        return True
                            else:
                                if a15 <= 2:
                                    if not (a13 + tempo - 1 < a16):
                                        if not (a38 + 1 < a12):
                                            return False
                                        else:
                                            return True
                                    else:
                                        return False
                                else:
                                    if a4 <= 4:
                                        if not (a25 + tempo - 1 < a16):
                                            if a36 <= 0:
                                                if a0 <= 0:
                                                    return False
                                                else:
                                                    if not (a13 - 1 < a16):
                                                        return True
                                                    else:
                                                        if not (a42 + 1 < a29):
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                return True
                                        else:
                                            if a36 <= 1:
                                                if a12 <= 3:
                                                    if a34 <= -2:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if a5 <= 4:
                                                    if a0 <= 0:
                                                        return False
                                                    else:
                                                        if a4 <= 3:
                                                            return False
                                                        else:
                                                            if a37 <= 3:
                                                                if a6 <= 5:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                else:
                                                    if a4 <= 3:
                                                        if not (a16 + tempo - 1 < a13):
                                                            if a0 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                    else:
                                        if a5 <= 3:
                                            if a0 <= 0:
                                                if not (a42 + 2 < a15):
                                                    if a30 <= 3:
                                                        if not (a12 - 1 < a16):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        if a37 <= 2:
                                                            if not (a29 - 1 < a16):
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                else:
                                                    if not (a38 + 2 < a23):
                                                        return False
                                                    else:
                                                        if not (a13 + tempo - 1 < a26):
                                                            if a6 <= 4:
                                                                if not (a12 - 1 < a16):
                                                                    return True
                                                                else:
                                                                    if a35 <= 0:
                                                                        if not (a6 - 1 < a15):
                                                                            return False
                                                                        else:
                                                                            if not (a27 + tempo - 1 < a12):
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
                                                if a13 <= 2:
                                                    if a27 <= 3:
                                                        return True
                                                    else:
                                                        if not (a38 + tempo + 1 < a12):
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return True
                                        else:
                                            return True
                        else:
                            if a34 <= -1:
                                if not (a13 + tempo - 1 < a16):
                                    if a19 <= 4:
                                        if a0 <= 0:
                                            return False
                                        else:
                                            if not (a16 < a25):
                                                if a40 <= 1:
                                                    if not (a38 + 2 < a14):
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
                                    if a40 <= 1:
                                        if a0 <= 0:
                                            return False
                                        else:
                                            if a15 <= 2:
                                                return False
                                            else:
                                                return True
                                    else:
                                        return False
                            else:
                                if not (a12 + tempo - 1 < a6):
                                    if a15 <= 3:
                                        if a0 <= 0:
                                            if not (a26 + 1 < a29):
                                                if a4 <= 0:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                if not (a16 < a30):
                                                    if a3 <= 0:
                                                        if a6 <= 1:
                                                            if a36 <= 1:
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
                                            if not (a38 + 1 < a12):
                                                if not (a38 + tempo + 2 < a23):
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                    else:
                                        return True
                                else:
                                    if a35 <= 0:
                                        if not (a13 + tempo - 1 < a16):
                                            if not (a29 + tempo + 1 < a41):
                                                return True
                                            else:
                                                return False
                                        else:
                                            return False
                                    else:
                                        if not (a29 + tempo < a16):
                                            if not (a31 + tempo < a6):
                                                return True
                                            else:
                                                return False
                                        else:
                                            return False
                    else:
                        if not (a31 + tempo - 1 < a10):
                            if a39 <= 2:
                                if a0 <= 0:
                                    if a23 <= 1:
                                        return False
                                    else:
                                        if not (a26 + 1 < a32):
                                            if not (a22 + tempo + 1 < a29):
                                                return True
                                            else:
                                                if not (a32 + tempo < a9):
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
                            if a0 <= 0:
                                if a23 <= 1:
                                    return False
                                else:
                                    if not (a15 + tempo < a24):
                                        if not (a25 + tempo < a26):
                                            if a36 <= 2:
                                                return True
                                            else:
                                                if a44 <= 5:
                                                    if not (a27 - 1 < a38):
                                                        if a28 <= 2:
                                                            return False
                                                        else:
                                                            if not (a29 < a8):
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
                                if not (a15 + 1 < a8):
                                    return True
                                else:
                                    if not (a38 + a6 < a31):
                                        return False
                                    else:
                                        return True
            else:
                if a1 <= 0:
                    if a26 <= 4:
                        return False
                    else:
                        if not (a16 + tempo < a27):
                            if not (a16 + tempo - 1 < a25):
                                return False
                            else:
                                return True
                        else:
                            return False
                else:
                    if a36 <= 1:
                        if a33 <= -3:
                            if not (a30 + tempo - 1 < a26):
                                if a37 <= 1:
                                    if not (a14 + tempo + 2 < a24):
                                        return True
                                    else:
                                        return False
                                else:
                                    return True
                            else:
                                if not (a16 + tempo < a27):
                                    if not (a29 + tempo + 1 < a9):
                                        return True
                                    else:
                                        if a36 <= -1:
                                            if not (a32 + tempo < a41):
                                                return True
                                            else:
                                                if a33 <= -5:
                                                    if a40 <= 6:
                                                        return True
                                                    else:
                                                        if a25 <= 2:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                        else:
                                            if not (a13 + tempo < a22):
                                                return True
                                            else:
                                                if not (a32 + a29 < a6):
                                                    if a26 <= 2:
                                                        if not (a22 + tempo + 1 < a29):
                                                            if a4 <= 1:
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
                                    return False
                        else:
                            if a0 <= 0:
                                if a26 <= 3:
                                    if not (a26 + tempo + 1 < a32):
                                        if a33 <= 2:
                                            if a36 <= 0:
                                                if a12 <= 5:
                                                    return False
                                                else:
                                                    if a9 <= 6:
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                if not (a31 + tempo + 1 < a6):
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            if not (a25 - 1 < a26):
                                                return True
                                            else:
                                                if a36 <= -1:
                                                    if a39 <= 5:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a33 <= 3:
                                                        if a36 <= 0:
                                                            if not (a17 + 2 < a32):
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                    else:
                                        if a39 <= 1:
                                            if not (a15 + 1 < a9):
                                                if a44 <= 4:
                                                    if a9 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if a42 <= 2:
                                                    if a15 <= 2:
                                                        if a41 <= 4:
                                                            if not (a15 - 1 < a10):
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        if not (a32 + 2 < a24):
                                                            if a19 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a11 <= 2:
                                                                if a34 <= -6:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                else:
                                                    return True
                                        else:
                                            if not (a32 + tempo + 2 < a24):
                                                return True
                                            else:
                                                if a34 <= -7:
                                                    if not (a25 + tempo - 1 < a26):
                                                        if a22 <= 1:
                                                            if a33 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                                else:
                                                    if a20 <= 3:
                                                        return False
                                                    else:
                                                        if not (a25 - 1 < a22):
                                                            return True
                                                        else:
                                                            if a15 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                else:
                                    return False
                            else:
                                if not (a11 + tempo - 1 < a15):
                                    if a39 <= 1:
                                        if a36 <= -1:
                                            if not (a26 < a30):
                                                if a31 <= 4:
                                                    return False
                                                else:
                                                    if not (a38 + tempo < a32):
                                                        return True
                                                    else:
                                                        if not (a32 - 1 < a16):
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if not (a10 + tempo - 1 < a29):
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            if not (a29 + 1 < a28):
                                                if a39 <= 0:
                                                    if a2 <= 3:
                                                        if a40 <= 2:
                                                            return False
                                                        else:
                                                            if a34 <= -4:
                                                                if a40 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                                else:
                                                    if not (a29 + tempo + 2 < a24):
                                                        return True
                                                    else:
                                                        if a40 <= 3:
                                                            return True
                                                        else:
                                                            if a24 <= 6:
                                                                if not (a26 + tempo - 1 < a32):
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                            else:
                                                return True
                                    else:
                                        if not (a30 + tempo - 1 < a26):
                                            if not (a31 + tempo + 2 < a24):
                                                return True
                                            else:
                                                if a25 <= 2:
                                                    if a37 <= -2:
                                                        return True
                                                    else:
                                                        if a37 <= 1:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return True
                                        else:
                                            if a36 <= -1:
                                                if a26 <= 3:
                                                    if a33 <= 4:
                                                        return False
                                                    else:
                                                        if not (a11 - 1 < a15):
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return True
                                            else:
                                                if a29 <= 2:
                                                    if a36 <= 0:
                                                        if a39 <= 2:
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
            if a9 <= 0:
                if a7 <= 3:
                    if a1 <= 0:
                        if not (a38 + 1 < a0):
                            if not (a16 + tempo + 1 < a13):
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
        if not (a38 + 1 < a0):
            if not (a16 < a27):
                if not (a32 + tempo < a11):
                    if not (a14 + tempo < a26):
                        if not (a25 + tempo + 1 < a24):
                            if a39 <= 1:
                                if a20 <= 3:
                                    if not (a31 - 1 < a38):
                                        if a4 <= 4:
                                            if not (a15 + tempo < a9):
                                                if a1 <= 0:
                                                    if not (a16 + 1 < a30):
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a38 <= 2:
                                                        if not (a32 + 1 < a28):
                                                            if not (a16 + 1 < a25):
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if a34 <= -3:
                                                            if not (a26 - 1 < a15):
                                                                if a7 <= 3:
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
                                        if a1 <= 0:
                                            return False
                                        else:
                                            if a42 <= 0:
                                                if not (a29 + tempo < a9):
                                                    if a38 <= 4:
                                                        if not (a15 + tempo < a24):
                                                            if not (a22 - 1 < a25):
                                                                if a7 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a36 <= 0:
                                                            if not (a26 + tempo - 1 < a32):
                                                                if a40 <= 5:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                else:
                                                    if a23 <= 4:
                                                        return False
                                                    else:
                                                        if not (a32 + a15 < a6):
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                return True
                                else:
                                    if not (a25 + tempo - 1 < a16):
                                        return True
                                    else:
                                        if a1 <= 0:
                                            if not (a30 + tempo - 1 < a22):
                                                if a36 <= 3:
                                                    return True
                                                else:
                                                    if not (a22 + 1 < a13):
                                                        if not (a29 < a10):
                                                            if a32 <= 4:
                                                                return False
                                                            else:
                                                                if a40 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if a40 <= 3:
                                                                return True
                                                            else:
                                                                if a33 <= -1:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return True
                                            else:
                                                if a34 <= 0:
                                                    return False
                                                else:
                                                    if a36 <= 3:
                                                        return True
                                                    else:
                                                        if a9 <= 3:
                                                            if a11 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a4 <= 5:
                                                                if a42 <= 1:
                                                                    if a34 <= 3:
                                                                        if not (a11 + tempo - 1 < a15):
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
                                            if a36 <= 3:
                                                if a36 <= 0:
                                                    if not (a32 + 1 < a6):
                                                        if not (a32 + tempo < a9):
                                                            if not (a15 < a6):
                                                                if not (a29 + 1 < a24):
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
                                                    if not (a30 + tempo < a26):
                                                        if a36 <= 1:
                                                            if a40 <= 3:
                                                                if a24 <= 5:
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
                                                if not (a17 + tempo + 2 < a15):
                                                    if not (a29 - 1 < a24):
                                                        if not (a15 < a10):
                                                            if not (a38 + 2 < a15):
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if a36 <= 4:
                                                            if not (a29 + tempo - 1 < a10):
                                                                return False
                                                            else:
                                                                if a22 <= 5:
                                                                    if not (a11 + tempo - 1 < a15):
                                                                        return True
                                                                    else:
                                                                        if not (a16 + tempo - 1 < a25):
                                                                            return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                else:
                                                    if a4 <= 5:
                                                        if a7 <= 3:
                                                            if not (a27 + tempo < a16):
                                                                if not (a6 + tempo < a29):
                                                                    return True
                                                                else:
                                                                    if not (a32 + tempo < a41):
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
                                if a34 <= 1:
                                    if not (a30 + tempo < a26):
                                        if a1 <= 0:
                                            if a5 <= 2:
                                                return False
                                            else:
                                                if a11 <= 2:
                                                    if not (a27 + tempo + 1 < a6):
                                                        if not (a30 + tempo - 1 < a22):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if not (a31 + tempo + 1 < a6):
                                                        return True
                                                    else:
                                                        if not (a32 + tempo < a41):
                                                            return True
                                                        else:
                                                            if not (a11 + tempo - 1 < a32):
                                                                return True
                                                            else:
                                                                if a38 <= 4:
                                                                    return False
                                                                else:
                                                                    if a13 <= 3:
                                                                        if a42 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                        else:
                                            if not (a31 + tempo - 1 < a10):
                                                if a6 <= 5:
                                                    if a24 <= 2:
                                                        return True
                                                    else:
                                                        if a42 <= 0:
                                                            if a28 <= 51:
                                                                if a39 <= 4:
                                                                    if not (a11 - 1 < a32):
                                                                        return False
                                                                    else:
                                                                        if a7 <= 3:
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
                                                return True
                                    else:
                                        if a24 <= 2:
                                            if not (a15 + tempo < a28):
                                                if a7 <= 3:
                                                    if not (a42 + tempo + 1 < a29):
                                                        return True
                                                    else:
                                                        if a35 <= 1:
                                                            if a35 <= -2:
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
                                            if a36 <= 4:
                                                return False
                                            else:
                                                if a7 <= 4:
                                                    return False
                                                else:
                                                    if not (a13 + tempo + 1 < a26):
                                                        if a35 <= 3:
                                                            return True
                                                        else:
                                                            if a36 <= 5:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if a8 <= 5:
                                                            return False
                                                        else:
                                                            if a9 <= 3:
                                                                if not (a17 + tempo + 2 < a29):
                                                                    return True
                                                                else:
                                                                    if a39 <= 5:
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                else:
                                    if a19 <= 4:
                                        if not (a38 < a31):
                                            if a1 <= 0:
                                                return False
                                            else:
                                                return True
                                        else:
                                            if not (a29 + tempo < a8):
                                                return True
                                            else:
                                                return False
                                    else:
                                        if a1 <= 0:
                                            if a36 <= 4:
                                                if not (a30 + tempo - 1 < a16):
                                                    return True
                                                else:
                                                    if a3 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                return True
                                        else:
                                            return True
                        else:
                            if a12 <= 3:
                                if a39 <= 2:
                                    if a38 <= 2:
                                        return False
                                    else:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            if a7 <= 3:
                                                if a39 <= 1:
                                                    if not (a42 + tempo + 1 < a29):
                                                        return True
                                                    else:
                                                        if a28 <= 3:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    if a30 <= 0:
                                                        if not (a32 + 1 < a8):
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
                                if not (a30 + tempo < a22):
                                    if a39 <= 3:
                                        if a36 <= 0:
                                            if not (a14 + tempo + 1 < a24):
                                                if not (a32 + a15 < a6):
                                                    if a1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if not (a15 + tempo + 1 < a9):
                                                    if a38 <= 2:
                                                        if a26 <= 6:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a3 <= 5:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                        else:
                                            if a39 <= 1:
                                                if a8 <= 2:
                                                    return False
                                                else:
                                                    if a1 <= 0:
                                                        return False
                                                    else:
                                                        if not (a43 + 2 < a32):
                                                            return True
                                                        else:
                                                            if not (a31 + tempo - 1 < a26):
                                                                return True
                                                            else:
                                                                if not (a8 - 1 < a32):
                                                                    return True
                                                                else:
                                                                    return False
                                            else:
                                                return False
                                    else:
                                        if not (a31 + tempo + 1 < a6):
                                            if a39 <= 4:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return True
                                else:
                                    if a9 <= 2:
                                        if not (a11 + tempo - 1 < a15):
                                            if a39 <= 2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            if a4 <= 5:
                                                if a8 <= 3:
                                                    return False
                                                else:
                                                    if a35 <= 1:
                                                        if a35 <= -2:
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
                        if not (a23 + tempo - 1 < a6):
                            if not (a15 + a13 < a26):
                                if not (a13 + tempo - 1 < a22):
                                    if a44 <= 5:
                                        return False
                                    else:
                                        if not (a13 + tempo - 1 < a16):
                                            return True
                                        else:
                                            if a8 <= 4:
                                                if not (a32 + tempo + 1 < a28):
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                else:
                                    if a34 <= -1:
                                        if not (a31 + tempo - 1 < a12):
                                            return True
                                        else:
                                            if a39 <= 1:
                                                if a1 <= 0:
                                                    return False
                                                else:
                                                    if a41 <= 2:
                                                        if a41 <= 1:
                                                            if not (a27 + tempo < a16):
                                                                if a43 <= 2:
                                                                    if a13 <= 0:
                                                                        return False
                                                                    else:
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
                            if a10 <= 2:
                                if a39 <= 2:
                                    if not (a15 + tempo + 1 < a22):
                                        if not (a15 + 1 < a22):
                                            if not (a27 + tempo < a16):
                                                if not (a31 < a16):
                                                    return False
                                                else:
                                                    if a4 <= 6:
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
                                        if not (a13 + tempo - 1 < a22):
                                            if not (a27 < a6):
                                                return True
                                            else:
                                                return False
                                        else:
                                            return False
                                else:
                                    if not (a16 + tempo - 1 < a30):
                                        if a34 <= 2:
                                            if a41 <= 3:
                                                if a4 <= 6:
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
                                if a8 <= 2:
                                    if a13 <= 0:
                                        if not (a27 + tempo < a16):
                                            if a41 <= 2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    if not (a32 + 2 < a24):
                                        return False
                                    else:
                                        if not (a31 + tempo + 2 < a24):
                                            if a1 <= 0:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                else:
                    if a6 <= 1:
                        if not (a16 + tempo - 1 < a13):
                            return True
                        else:
                            if a6 <= 0:
                                if not (a31 + tempo - 1 < a12):
                                    return False
                                else:
                                    return True
                            else:
                                return False
                    else:
                        if not (a15 + tempo < a10):
                            if a44 <= 2:
                                if a6 <= 5:
                                    return False
                                else:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if not (a31 + tempo < a16):
                                            return True
                                        else:
                                            return False
                            else:
                                return False
                        else:
                            return False
            else:
                if not (a16 + 1 < a14):
                    if a0 <= 0:
                        if not (a29 + tempo < a10):
                            if a40 <= 1:
                                if a42 <= 2:
                                    if not (a15 < a26):
                                        return True
                                    else:
                                        if a25 <= 1:
                                            if a5 <= 0:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                else:
                                    if a41 <= 0:
                                        return False
                                    else:
                                        return True
                            else:
                                if not (a15 + tempo + 1 < a9):
                                    if a28 <= 6:
                                        if a26 <= 3:
                                            if a1 <= 0:
                                                return False
                                            else:
                                                if a39 <= 1:
                                                    if a41 <= 5:
                                                        if not (a38 + 1 < a12):
                                                            return True
                                                        else:
                                                            if not (a11 + tempo - 1 < a32):
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                        else:
                                            if not (a30 + tempo - 1 < a26):
                                                return True
                                            else:
                                                if a38 <= 2:
                                                    return False
                                                else:
                                                    if a36 <= 0:
                                                        return False
                                                    else:
                                                        if a1 <= 0:
                                                            return False
                                                        else:
                                                            if a36 <= 4:
                                                                return True
                                                            else:
                                                                return False
                                    else:
                                        if a5 <= 1:
                                            if a1 <= 0:
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
                        if not (a38 < a29):
                            if a43 <= 1:
                                if a41 <= 2:
                                    return False
                                else:
                                    return True
                            else:
                                if not (a13 < a22):
                                    return False
                                else:
                                    if a42 <= 2:
                                        return False
                                    else:
                                        return True
                        else:
                            if a9 <= 0:
                                if a1 <= 0:
                                    return False
                                else:
                                    return True
                            else:
                                return True
                else:
                    return True
        else:
            return True
