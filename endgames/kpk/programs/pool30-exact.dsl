# Promoted 2026-11-26 from state/concepts-baseline/base-exact.dsl: 5,319.0 B (5,319.0 B program, 0.0 B exceptions), 0 errors, at most 1,235 operations, tier 4,096.
# An exact greedy entropy tree (1,139 leaves) over 30 atoms and the 500 most informative enumerated comparisons, written as DSL by chess-forces concepts baseline (src/chess_forces/concepts.py); no model call.
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
    if not (a16 + 1 < a13):
        if not (a29 + tempo - 1 < a26):
            if not (a25 + tempo < a24):
                if a0 <= 0:
                    if a23 <= 1:
                        return False
                    else:
                        if a1 <= 0:
                            if a25 <= 6:
                                if not (a24 + 1 < a29):
                                    if a6 <= 3:
                                        if not (a22 + 2 < a29):
                                            if not (a16 + 1 < a25):
                                                if a7 <= 3:
                                                    if not (a29 + 1 < a16):
                                                        return False
                                                    else:
                                                        if not (a10 + tempo + 1 < a29):
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    if a4 <= 5:
                                                        if not (a27 + tempo < a8):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        if a20 <= 2:
                                                            if not (a27 + tempo - 1 < a10):
                                                                if a8 <= 3:
                                                                    return True
                                                                else:
                                                                    if a4 <= 6:
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
                                            if not (a2 + tempo - 1 < a6):
                                                return True
                                            else:
                                                if not (a29 + tempo - 1 < a12):
                                                    return True
                                                else:
                                                    if a6 <= 1:
                                                        return True
                                                    else:
                                                        if a9 <= 5:
                                                            if a6 <= 2:
                                                                return True
                                                            else:
                                                                if a9 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                    else:
                                        if a2 <= 3:
                                            return False
                                        else:
                                            if not (a29 - 1 < a9):
                                                if not (a6 - 1 < a29):
                                                    if a2 <= 4:
                                                        return False
                                                    else:
                                                        if not (a16 < a14):
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    if a4 <= 6:
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                return False
                                else:
                                    if not (a25 < a16):
                                        if a11 <= 1:
                                            if not (a16 < a13):
                                                if a22 <= 1:
                                                    if a6 <= 4:
                                                        if not (a22 + tempo + 1 < a15):
                                                            return False
                                                        else:
                                                            if a6 <= 2:
                                                                if not (a17 + 2 < a15):
                                                                    if a3 <= 0:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if a4 <= 2:
                                                                    return False
                                                                else:
                                                                    if a7 <= 2:
                                                                        return True
                                                                    else:
                                                                        if not (a17 + 2 < a14):
                                                                            return False
                                                                        else:
                                                                            if a16 <= 4:
                                                                                return True
                                                                            else:
                                                                                if not (a6 + 1 < a14):
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                    else:
                                                        if not (a25 - 1 < a16):
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    if a23 <= 3:
                                                        if a3 <= 0:
                                                            if a19 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if not (a26 + tempo < a15):
                                                                if not (a5 + tempo < a6):
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
                                        if not (a17 + 2 < a25):
                                            return False
                                        else:
                                            if a24 <= 2:
                                                if a27 <= 3:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if not (a6 + tempo < a14):
                                                    if a22 <= 2:
                                                        if a6 <= 4:
                                                            if a3 <= 0:
                                                                if not (a9 < a15):
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a23 <= 4:
                                                                    return True
                                                                else:
                                                                    if a14 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                                        else:
                                                            return False
                                                    else:
                                                        if a25 <= 4:
                                                            if a6 <= 4:
                                                                if a27 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            if not (a26 + 1 < a15):
                                                                if a13 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                else:
                                                    if a6 <= 3:
                                                        if not (a17 + 2 < a15):
                                                            if a3 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a24 <= 4:
                                                                return True
                                                            else:
                                                                if a6 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        if a9 <= 3:
                                                            return True
                                                        else:
                                                            return False
                            else:
                                if a5 <= 3:
                                    if a3 <= 0:
                                        if not (a2 + tempo - 1 < a6):
                                            if not (a24 < a15):
                                                return True
                                            else:
                                                if not (a27 < a22):
                                                    if not (a8 + 1 < a13):
                                                        if not (a17 + 1 < a14):
                                                            if a5 <= 0:
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
                                        if not (a27 < a8):
                                            return True
                                        else:
                                            if not (a14 + tempo < a24):
                                                return False
                                            else:
                                                return True
                                else:
                                    return True
                        else:
                            if not (a26 + 1 < a15):
                                if not (a22 - 1 < a27):
                                    if not (a14 + tempo < a24):
                                        if not (a16 + tempo - 1 < a13):
                                            if not (a12 - 1 < a27):
                                                return True
                                            else:
                                                if a6 <= 5:
                                                    if not (a13 - 1 < a8):
                                                        return False
                                                    else:
                                                        if a9 <= 1:
                                                            if not (a13 + tempo < a8):
                                                                return False
                                                            else:
                                                                if a19 <= 2:
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
                                        if not (a8 + tempo + 1 < a29):
                                            if not (a27 + tempo - 1 < a6):
                                                return True
                                            else:
                                                return False
                                        else:
                                            return True
                                else:
                                    if not (a29 + tempo - 1 < a3):
                                        if a5 <= 1:
                                            if not (a17 + tempo + 2 < a29):
                                                if a28 <= 2:
                                                    if a25 <= 6:
                                                        if a7 <= 3:
                                                            if not (a14 + tempo - 1 < a22):
                                                                if a23 <= 4:
                                                                    return True
                                                                else:
                                                                    if not (a15 - 1 < a9):
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
                                            return True
                                    else:
                                        if a5 <= 2:
                                            if a3 <= 2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            if a25 <= 6:
                                                if not (a24 + 1 < a29):
                                                    if not (a15 + tempo - 1 < a28):
                                                        if a6 <= 5:
                                                            if not (a16 + 1 < a25):
                                                                if a7 <= 3:
                                                                    if a23 <= 5:
                                                                        return False
                                                                    else:
                                                                        if not (a16 + tempo - 1 < a13):
                                                                            return True
                                                                        else:
                                                                            if not (a6 + 1 < a12):
                                                                                if not (a16 + tempo < a25):
                                                                                    if a22 <= 5:
                                                                                        if a7 <= 2:
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
                                                                    if a22 <= 3:
                                                                        return True
                                                                    else:
                                                                        if a4 <= 5:
                                                                            if not (a6 + 2 < a29):
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if not (a14 + tempo - 1 < a16):
                                                                                if a4 <= 6:
                                                                                    if a16 <= 4:
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
                                                            if a23 <= 5:
                                                                if a2 <= 3:
                                                                    if a19 <= 3:
                                                                        return False
                                                                    else:
                                                                        if a7 <= 3:
                                                                            return False
                                                                        else:
                                                                            if not (a15 < a16):
                                                                                if not (a24 + tempo < a29):
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if a9 <= 3:
                                                                        return True
                                                                    else:
                                                                        if a7 <= 3:
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                if a13 <= 5:
                                                                    return True
                                                                else:
                                                                    if a4 <= 3:
                                                                        if not (a25 - 1 < a16):
                                                                            if a4 <= 2:
                                                                                return False
                                                                            else:
                                                                                if not (a23 + tempo < a6):
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if not (a29 - 1 < a9):
                                                                                return True
                                                                            else:
                                                                                if not (a14 + tempo < a6):
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        return True
                                                    else:
                                                        if a24 <= 2:
                                                            if not (a29 + tempo < a7):
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
                                if not (a26 < a25):
                                    if a5 <= 0:
                                        if a3 <= 1:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                                else:
                                    return True
                else:
                    if not (a25 - 1 < a16):
                        if a13 <= 2:
                            if a1 <= 0:
                                if not (a22 + 1 < a25):
                                    return True
                                else:
                                    if a6 <= 5:
                                        if not (a15 + tempo - 1 < a16):
                                            return True
                                        else:
                                            if a3 <= 0:
                                                return False
                                            else:
                                                return True
                                    else:
                                        return False
                            else:
                                return True
                        else:
                            if a15 <= 2:
                                if a3 <= 0:
                                    if not (a13 < a16):
                                        return True
                                    else:
                                        if a7 <= 2:
                                            return False
                                        else:
                                            return True
                                else:
                                    return True
                            else:
                                return True
                    else:
                        if a1 <= 0:
                            if not (a15 - 1 < a24):
                                if not (a17 + 2 < a25):
                                    if a13 <= 2:
                                        return False
                                    else:
                                        if a9 <= 2:
                                            return True
                                        else:
                                            return False
                                else:
                                    return True
                            else:
                                if a25 <= 5:
                                    if a6 <= 4:
                                        if a22 <= 3:
                                            if a6 <= 3:
                                                if not (a6 - 1 < a14):
                                                    if a19 <= 3:
                                                        if not (a29 + tempo - 1 < a11):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if a4 <= 1:
                                                        if a6 <= 2:
                                                            if not (a15 < a28):
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                    else:
                                                        if not (a15 + tempo + 1 < a9):
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if a24 <= 4:
                                                    if a14 <= 2:
                                                        if not (a8 - 1 < a29):
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                        else:
                                            if a6 <= 2:
                                                if a4 <= 5:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                if not (a2 + tempo - 1 < a6):
                                                    if not (a29 - 1 < a7):
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                    else:
                                        if a24 <= 3:
                                            if not (a15 + tempo + 1 < a6):
                                                if not (a15 + tempo - 1 < a22):
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                if a19 <= 1:
                                                    if not (a15 + tempo - 1 < a11):
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
                            if not (a28 + tempo - 1 < a29):
                                if a22 <= 3:
                                    if a10 <= 2:
                                        return True
                                    else:
                                        if a7 <= 4:
                                            if not (a24 - 1 < a27):
                                                if a23 <= 3:
                                                    return True
                                                else:
                                                    if not (a25 + tempo < a16):
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                return True
                                        else:
                                            return True
                                else:
                                    if a23 <= 5:
                                        if not (a29 + tempo < a7):
                                            if a4 <= 5:
                                                if a6 <= 2:
                                                    return True
                                                else:
                                                    if a6 <= 3:
                                                        return False
                                                    else:
                                                        if not (a13 < a24):
                                                            if not (a27 < a16):
                                                                if a7 <= 3:
                                                                    if a7 <= 2:
                                                                        if a23 <= 4:
                                                                            return False
                                                                        else:
                                                                            if not (a14 < a6):
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a23 <= 4:
                                                                        return False
                                                                    else:
                                                                        if not (a27 + 1 < a6):
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return True
                                                        else:
                                                            if not (a16 - 1 < a14):
                                                                if not (a15 + tempo < a16):
                                                                    if not (a15 < a9):
                                                                        return False
                                                                    else:
                                                                        if a7 <= 3:
                                                                            return True
                                                                        else:
                                                                            if a7 <= 4:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                            else:
                                                if a25 <= 5:
                                                    if not (a2 + tempo - 1 < a6):
                                                        if a7 <= 3:
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
                if a1 <= 0:
                    if a11 <= 4:
                        if not (a13 + tempo < a9):
                            if not (a16 < a15):
                                return False
                            else:
                                return True
                        else:
                            return False
                    else:
                        if a0 <= 0:
                            if not (a9 - 1 < a13):
                                return False
                            else:
                                if not (a6 < a2):
                                    return True
                                else:
                                    return False
                        else:
                            if not (a16 + tempo - 1 < a25):
                                if a22 <= 5:
                                    return False
                                else:
                                    return True
                            else:
                                return True
                else:
                    if not (a16 + tempo < a14):
                        if not (a15 + tempo + 1 < a9):
                            if not (a26 + 1 < a15):
                                if not (a25 + tempo - 1 < a22):
                                    if not (a29 + tempo - 1 < a3):
                                        if a5 <= 4:
                                            if a2 <= 2:
                                                if not (a14 - 1 < a22):
                                                    if a0 <= 0:
                                                        if not (a24 + tempo - 1 < a29):
                                                            if not (a14 + tempo < a24):
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                                else:
                                                    if not (a29 + 2 < a24):
                                                        if not (a29 + tempo + 1 < a16):
                                                            if a23 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                if a5 <= 1:
                                                    if a3 <= 1:
                                                        if a10 <= 2:
                                                            if a0 <= 0:
                                                                return False
                                                            else:
                                                                if not (a10 < a13):
                                                                    if a9 <= 3:
                                                                        if not (a14 + tempo < a16):
                                                                            return True
                                                                        else:
                                                                            if a1 <= 1:
                                                                                if a5 <= 0:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if not (a14 + tempo < a16):
                                                                            return False
                                                                        else:
                                                                            if a7 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if a5 <= 0:
                                                                        return True
                                                                    else:
                                                                        return False
                                                        else:
                                                            return False
                                                    else:
                                                        if a24 <= 4:
                                                            if not (a15 + tempo < a3):
                                                                if not (a13 + 1 < a9):
                                                                    return False
                                                                else:
                                                                    if not (a11 - 1 < a15):
                                                                        if a5 <= 0:
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
                                                    if a3 <= 1:
                                                        return True
                                                    else:
                                                        if not (a15 + 1 < a24):
                                                            return False
                                                        else:
                                                            if not (a15 + 1 < a9):
                                                                return True
                                                            else:
                                                                if not (a26 < a13):
                                                                    if a1 <= 1:
                                                                        if not (a15 + tempo - 1 < a16):
                                                                            if a3 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if not (a25 + tempo + 2 < a24):
                                                                            return True
                                                                        else:
                                                                            if a5 <= 2:
                                                                                if a3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if not (a15 + tempo < a3):
                                                                                    return True
                                                                                else:
                                                                                    if a3 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        if a5 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                else:
                                                                    if not (a15 - 1 < a8):
                                                                        return True
                                                                    else:
                                                                        if a5 <= 3:
                                                                            if a3 <= 2:
                                                                                if a5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a5 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            return True
                                        else:
                                            if not (a15 + tempo + 1 < a3):
                                                return True
                                            else:
                                                return False
                                    else:
                                        if a5 <= 2:
                                            if a3 <= 2:
                                                if not (a29 < a28):
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                        else:
                                            if not (a29 - 1 < a16):
                                                return True
                                            else:
                                                if not (a14 - 1 < a10):
                                                    if not (a13 + 1 < a24):
                                                        if not (a14 + tempo < a9):
                                                            return True
                                                        else:
                                                            if a23 <= 5:
                                                                if not (a12 - 1 < a27):
                                                                    if not (a19 - 1 < a29):
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                            else:
                                                                if not (a16 + tempo - 1 < a27):
                                                                    return True
                                                                else:
                                                                    if a1 <= 2:
                                                                        return False
                                                                    else:
                                                                        if not (a15 + tempo < a3):
                                                                            return True
                                                                        else:
                                                                            return False
                                                    else:
                                                        if not (a17 + 1 < a29):
                                                            if a7 <= 3:
                                                                return True
                                                            else:
                                                                if not (a25 - 1 < a8):
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                                                else:
                                                    if not (a27 + tempo < a16):
                                                        if a22 <= 2:
                                                            if not (a29 + tempo < a3):
                                                                if a1 <= 2:
                                                                    if not (a29 + tempo - 1 < a11):
                                                                        if not (a29 < a28):
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if not (a13 + tempo < a9):
                                                                    if not (a27 + tempo < a24):
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if a12 <= 5:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if not (a13 + 2 < a24):
                                                            if not (a29 + tempo + 1 < a16):
                                                                if not (a29 + 1 < a9):
                                                                    return False
                                                                else:
                                                                    if a7 <= 3:
                                                                        return True
                                                                    else:
                                                                        if a23 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                else:
                                    if a19 <= 3:
                                        if a9 <= 2:
                                            return True
                                        else:
                                            if not (a15 + tempo < a9):
                                                return True
                                            else:
                                                if not (a29 + tempo < a28):
                                                    if a13 <= 0:
                                                        return False
                                                    else:
                                                        if a5 <= 0:
                                                            if a3 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a3 <= 0:
                                                                if a5 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a1 <= 1:
                                                                    return False
                                                                else:
                                                                    if a5 <= 1:
                                                                        if not (a15 + tempo < a3):
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if not (a15 + tempo < a3):
                                                                            if a5 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a5 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                else:
                                                    return True
                                    else:
                                        return True
                            else:
                                if not (a17 + 1 < a15):
                                    if not (a25 + tempo - 1 < a22):
                                        return True
                                    else:
                                        if a0 <= 0:
                                            return False
                                        else:
                                            return True
                                else:
                                    return True
                        else:
                            if not (a8 + 1 < a13):
                                if not (a29 + tempo + 2 < a9):
                                    if a20 <= 3:
                                        if not (a27 + tempo + 2 < a24):
                                            if not (a10 + tempo < a15):
                                                if not (a22 + tempo - 1 < a25):
                                                    if a10 <= 3:
                                                        if a9 <= 4:
                                                            return True
                                                        else:
                                                            if not (a29 + tempo - 1 < a7):
                                                                return False
                                                            else:
                                                                if a1 <= 1:
                                                                    if a11 <= 2:
                                                                        if not (a27 - 1 < a22):
                                                                            if not (a8 < a15):
                                                                                return False
                                                                            else:
                                                                                if a5 <= 0:
                                                                                    if a3 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if a3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if not (a29 + 1 < a6):
                                                                        return True
                                                                    else:
                                                                        if not (a17 + 1 < a14):
                                                                            if not (a29 + tempo + 1 < a16):
                                                                                if a7 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    if not (a29 + tempo - 1 < a12):
                                                                                        return True
                                                                                    else:
                                                                                        if a3 <= 0:
                                                                                            if a5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if a5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if a1 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    if a3 <= 3:
                                                                                                        if a5 <= 3:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                                    else:
                                                                                                        if not (a5 + tempo < a6):
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if not (a29 + tempo < a7):
                                                                                return False
                                                                            else:
                                                                                if not (a14 + tempo + 1 < a6):
                                                                                    return True
                                                                                else:
                                                                                    if a7 <= 5:
                                                                                        if not (a27 - 1 < a8):
                                                                                            if not (a6 - 1 < a23):
                                                                                                if not (a15 + tempo + 1 < a3):
                                                                                                    if a5 <= 4:
                                                                                                        if a1 <= 2:
                                                                                                            if a3 <= 2:
                                                                                                                if a5 <= 2:
                                                                                                                    return False
                                                                                                                else:
                                                                                                                    return True
                                                                                                            else:
                                                                                                                if a5 <= 2:
                                                                                                                    return True
                                                                                                                else:
                                                                                                                    return False
                                                                                                        else:
                                                                                                            return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if a5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                            else:
                                                                                                if a5 <= 1:
                                                                                                    if a3 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if not (a29 + tempo - 1 < a3):
                                                                                                        if a5 <= 2:
                                                                                                            return False
                                                                                                        else:
                                                                                                            if a3 <= 1:
                                                                                                                return True
                                                                                                            else:
                                                                                                                if a5 <= 3:
                                                                                                                    return False
                                                                                                                else:
                                                                                                                    return True
                                                                                                    else:
                                                                                                        if a5 <= 2:
                                                                                                            if not (a15 + tempo < a3):
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            return False
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if not (a29 + tempo + 2 < a6):
                                                                                            return True
                                                                                        else:
                                                                                            if a5 <= 2:
                                                                                                if not (a29 + tempo - 1 < a3):
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if a3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                    else:
                                                        return False
                                                else:
                                                    if not (a15 + tempo - 1 < a28):
                                                        if not (a25 - 1 < a26):
                                                            return True
                                                        else:
                                                            if a3 <= 0:
                                                                return True
                                                            else:
                                                                if not (a29 + tempo - 1 < a3):
                                                                    if a5 <= 4:
                                                                        if a1 <= 1:
                                                                            if a3 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if a1 <= 2:
                                                                                if a3 <= 1:
                                                                                    if a5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a3 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        if a5 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                            else:
                                                                                if a3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a5 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                                    else:
                                                        if not (a25 + 2 < a24):
                                                            return True
                                                        else:
                                                            if not (a15 + tempo < a3):
                                                                if a5 <= 4:
                                                                    if not (a26 + 1 < a13):
                                                                        if a3 <= 3:
                                                                            if a5 <= 2:
                                                                                if a3 <= 2:
                                                                                    if a3 <= 1:
                                                                                        if not (a29 - 1 < a7):
                                                                                            if not (a13 + tempo + 2 < a24):
                                                                                                if a5 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if a5 <= 0:
                                                                                                    return True
                                                                                                else:
                                                                                                    if not (a22 + tempo - 1 < a15):
                                                                                                        return True
                                                                                                    else:
                                                                                                        if not (a29 - 1 < a24):
                                                                                                            if a24 <= 6:
                                                                                                                if a5 <= 1:
                                                                                                                    return True
                                                                                                                else:
                                                                                                                    return False
                                                                                                            else:
                                                                                                                return False
                                                                                                        else:
                                                                                                            if a3 <= 0:
                                                                                                                if a5 <= 1:
                                                                                                                    return False
                                                                                                                else:
                                                                                                                    return True
                                                                                                            else:
                                                                                                                if a5 <= 1:
                                                                                                                    return True
                                                                                                                else:
                                                                                                                    return False
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a5 <= 0:
                                                                                            return True
                                                                                        else:
                                                                                            if a1 <= 2:
                                                                                                if a5 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a3 <= 2:
                                                                                    if a3 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if a5 <= 3:
                                                                                            if not (a11 - 1 < a15):
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
                                                                    if a3 <= 3:
                                                                        return True
                                                                    else:
                                                                        if a1 <= 2:
                                                                            if a5 <= 5:
                                                                                return False
                                                                            else:
                                                                                if a3 <= 4:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                if a5 <= 4:
                                                                    if not (a27 + 1 < a24):
                                                                        if not (a26 + 1 < a13):
                                                                            if not (a5 + tempo < a6):
                                                                                return False
                                                                            else:
                                                                                if a5 <= 3:
                                                                                    if a5 <= 2:
                                                                                        if a1 <= 2:
                                                                                            if not (a10 + tempo - 1 < a15):
                                                                                                return True
                                                                                            else:
                                                                                                if a5 <= 0:
                                                                                                    return True
                                                                                                else:
                                                                                                    if not (a29 - 1 < a24):
                                                                                                        if a3 <= 2:
                                                                                                            if a5 <= 1:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            return False
                                                                                                    else:
                                                                                                        if a1 <= 1:
                                                                                                            if a5 <= 1:
                                                                                                                return False
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
                                                                                        if not (a15 + tempo + 1 < a3):
                                                                                            return False
                                                                                        else:
                                                                                            if a1 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                if not (a15 + tempo - 1 < a26):
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
                                                if a24 <= 6:
                                                    if a3 <= 0:
                                                        if a5 <= 1:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if not (a17 + 2 < a25):
                                                            if a1 <= 1:
                                                                if a3 <= 1:
                                                                    if not (a15 - 1 < a8):
                                                                        return True
                                                                    else:
                                                                        if a24 <= 5:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    return False
                                                            else:
                                                                if a7 <= 2:
                                                                    if not (a26 + tempo + 1 < a15):
                                                                        if a24 <= 5:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if not (a29 + tempo + 1 < a6):
                                                                        if a6 <= 5:
                                                                            return True
                                                                        else:
                                                                            if a26 <= 0:
                                                                                return True
                                                                            else:
                                                                                if not (a15 + tempo < a3):
                                                                                    if a5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a5 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                    else:
                                                                        if not (a29 + tempo < a7):
                                                                            return False
                                                                        else:
                                                                            if a6 <= 5:
                                                                                return True
                                                                            else:
                                                                                if a7 <= 4:
                                                                                    if not (a27 + tempo + 1 < a24):
                                                                                        if a14 <= 2:
                                                                                            if a1 <= 2:
                                                                                                if not (a15 + tempo < a3):
                                                                                                    if a5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if a5 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                            else:
                                                                                                if a3 <= 3:
                                                                                                    if a5 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if a5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                        else:
                                                                                            if not (a29 + tempo < a3):
                                                                                                if a5 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if a5 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if a6 <= 6:
                                                                                        return True
                                                                                    else:
                                                                                        if a5 <= 2:
                                                                                            if a3 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if not (a29 + tempo - 1 < a3):
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                        else:
                                                            return False
                                                else:
                                                    if not (a16 + 1 < a29):
                                                        return False
                                                    else:
                                                        if not (a10 + 1 < a15):
                                                            if not (a15 + tempo + 1 < a3):
                                                                if a5 <= 3:
                                                                    if a1 <= 2:
                                                                        if not (a17 + 1 < a14):
                                                                            if a5 <= 0:
                                                                                return False
                                                                            else:
                                                                                if a5 <= 2:
                                                                                    if not (a15 + tempo < a3):
                                                                                        if a5 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a5 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if a5 <= 0:
                                                                                if a3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a3 <= 1:
                                                                                    if a5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if a1 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if a5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                else:
                                                                                    if a5 <= 1:
                                                                                        if a3 <= 2:
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
                                                                if a5 <= 3:
                                                                    if not (a8 < a15):
                                                                        if a5 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a5 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                        else:
                                            if a7 <= 4:
                                                if not (a26 + tempo - 1 < a13):
                                                    if a5 <= 0:
                                                        return True
                                                    else:
                                                        if a1 <= 1:
                                                            return False
                                                        else:
                                                            if a5 <= 1:
                                                                if not (a29 + tempo < a3):
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if not (a29 + tempo - 1 < a3):
                                                                    if a5 <= 2:
                                                                        return False
                                                                    else:
                                                                        if a3 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a5 <= 3:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if a5 <= 2:
                                                                        if a3 <= 4:
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
                                        if not (a14 + tempo + 1 < a9):
                                            return True
                                        else:
                                            if a26 <= 3:
                                                if not (a14 + tempo + 2 < a24):
                                                    if not (a8 + tempo < a15):
                                                        if not (a13 - 1 < a10):
                                                            return True
                                                        else:
                                                            if not (a12 - 1 < a27):
                                                                if not (a29 + tempo < a7):
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                    else:
                                                        if not (a29 + tempo - 1 < a3):
                                                            if not (a27 + tempo + 1 < a9):
                                                                if not (a13 + 2 < a24):
                                                                    return False
                                                                else:
                                                                    if a3 <= 0:
                                                                        if a5 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a1 <= 1:
                                                                            if a5 <= 1:
                                                                                if a3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if not (a26 + tempo + 1 < a15):
                                                                                    return False
                                                                                else:
                                                                                    if a5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                        else:
                                                                            if not (a5 + tempo < a6):
                                                                                if not (a15 + tempo + 1 < a3):
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if a5 <= 0:
                                                                                    if a3 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a3 <= 1:
                                                                                        if a5 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if a5 <= 1:
                                                                                            if a3 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if not (a15 + tempo < a3):
                                                                                                if a5 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if not (a15 + tempo + 1 < a3):
                                                                                                    return False
                                                                                                else:
                                                                                                    if a5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                            else:
                                                                return True
                                                        else:
                                                            if not (a17 + tempo + 2 < a27):
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    return False
                                            else:
                                                return False
                                else:
                                    if not (a25 + tempo - 1 < a10):
                                        if not (a29 + tempo - 1 < a3):
                                            if a5 <= 3:
                                                if not (a13 - 1 < a22):
                                                    if not (a15 + 2 < a28):
                                                        if a3 <= 2:
                                                            if a5 <= 2:
                                                                if not (a28 + tempo - 1 < a15):
                                                                    if a5 <= 0:
                                                                        if a3 <= 1:
                                                                            if not (a15 + tempo - 1 < a11):
                                                                                if not (a6 - 1 < a23):
                                                                                    return True
                                                                                else:
                                                                                    if not (a27 + 2 < a24):
                                                                                        if a1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if a1 <= 1:
                                                                                if not (a29 - 1 < a26):
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if a11 <= 2:
                                                                            if a24 <= 6:
                                                                                if not (a27 - 1 < a22):
                                                                                    if a3 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if a5 <= 1:
                                                                                            if a1 <= 2:
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
                                                                if a3 <= 1:
                                                                    if a1 <= 1:
                                                                        return True
                                                                    else:
                                                                        if not (a15 + tempo - 1 < a28):
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if not (a27 + 2 < a24):
                                                                        if a1 <= 2:
                                                                            if not (a26 + tempo + 1 < a15):
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
                                                    if a5 <= 2:
                                                        return False
                                                    else:
                                                        if a24 <= 6:
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if a5 <= 4:
                                                    if a3 <= 2:
                                                        if a1 <= 2:
                                                            return True
                                                        else:
                                                            if a9 <= 6:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if not (a13 - 1 < a26):
                                                            if not (a8 + tempo < a29):
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                else:
                                                    return True
                                        else:
                                            if a5 <= 1:
                                                if a3 <= 3:
                                                    if not (a14 + tempo + 2 < a24):
                                                        if a1 <= 2:
                                                            return True
                                                        else:
                                                            if not (a6 < a27):
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if not (a17 + 1 < a14):
                                                            if not (a15 < a28):
                                                                if a5 <= 0:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a1 <= 1:
                                                                return False
                                                            else:
                                                                if a5 <= 0:
                                                                    return True
                                                                else:
                                                                    if not (a27 < a6):
                                                                        return False
                                                                    else:
                                                                        if a1 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                else:
                                                    if a1 <= 2:
                                                        if a5 <= 0:
                                                            return True
                                                        else:
                                                            if not (a27 + tempo + 2 < a24):
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        return True
                                            else:
                                                if not (a15 + tempo < a28):
                                                    if not (a0 + 2 < a29):
                                                        if not (a25 - 1 < a8):
                                                            if a5 <= 4:
                                                                if not (a15 + tempo - 1 < a28):
                                                                    if a24 <= 6:
                                                                        if not (a14 + tempo + 2 < a24):
                                                                            if a5 <= 2:
                                                                                return True
                                                                            else:
                                                                                if not (a15 + tempo < a3):
                                                                                    if a5 <= 3:
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
                                                                if a3 <= 3:
                                                                    return True
                                                                else:
                                                                    if not (a15 + tempo - 1 < a11):
                                                                        if not (a6 - 1 < a23):
                                                                            return True
                                                                        else:
                                                                            if not (a16 - 1 < a27):
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if not (a15 + tempo < a3):
                                                                            if a1 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                        else:
                                                            if a5 <= 2:
                                                                if a3 <= 4:
                                                                    return False
                                                                else:
                                                                    if not (a15 < a28):
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
                                        if not (a14 + tempo + 2 < a24):
                                            if a6 <= 6:
                                                if a1 <= 1:
                                                    return False
                                                else:
                                                    if a5 <= 0:
                                                        if not (a29 + tempo < a3):
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if not (a29 + tempo < a3):
                                                            if a5 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a5 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                            else:
                                                if a13 <= 2:
                                                    return False
                                                else:
                                                    if a1 <= 2:
                                                        return False
                                                    else:
                                                        if not (a29 + tempo - 1 < a3):
                                                            if a5 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a5 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                        else:
                                            return False
                            else:
                                if not (a15 + tempo - 1 < a28):
                                    if not (a15 + tempo + 2 < a24):
                                        return True
                                    else:
                                        if a7 <= 2:
                                            if not (a13 + tempo + 1 < a9):
                                                return True
                                            else:
                                                if not (a26 + tempo + 1 < a15):
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            if a12 <= 5:
                                                return True
                                            else:
                                                if a13 <= 3:
                                                    if a3 <= 1:
                                                        return True
                                                    else:
                                                        if not (a1 + 2 < a29):
                                                            if a3 <= 3:
                                                                if a5 <= 5:
                                                                    if a5 <= 2:
                                                                        if a3 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a3 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a5 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                else:
                                                    return True
                                else:
                                    if a7 <= 2:
                                        if not (a28 - 1 < a15):
                                            if not (a14 + tempo + 2 < a24):
                                                if not (a27 < a16):
                                                    return True
                                                else:
                                                    if not (a29 + tempo < a3):
                                                        if a5 <= 5:
                                                            if a3 <= 3:
                                                                if a5 <= 4:
                                                                    if a3 <= 1:
                                                                        if not (a5 + tempo < a6):
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if a5 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a1 <= 1:
                                                                                if not (a12 < a6):
                                                                                    if a3 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if a5 <= 2:
                                                                                    if not (a29 + tempo - 1 < a3):
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if not (a29 + tempo - 1 < a3):
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
                                                if not (a15 + tempo - 1 < a11):
                                                    if not (a13 + tempo + 2 < a24):
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if not (a13 + 2 < a24):
                                                        if not (a26 + tempo < a15):
                                                            if not (a29 + tempo < a3):
                                                                if a5 <= 4:
                                                                    if a3 <= 0:
                                                                        return True
                                                                    else:
                                                                        if a5 <= 0:
                                                                            if a3 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a3 <= 1:
                                                                                if a5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a1 <= 1:
                                                                                    if not (a2 + tempo - 1 < a6):
                                                                                        if a3 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if a5 <= 3:
                                                                                        if a3 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if a5 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                if a1 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    if a5 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                    else:
                                                                                        if not (a29 + tempo - 1 < a3):
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                else:
                                                                    if a1 <= 2:
                                                                        if a3 <= 3:
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
                                                        if a24 <= 6:
                                                            return True
                                                        else:
                                                            return False
                                        else:
                                            return False
                                    else:
                                        if not (a13 + tempo + 1 < a24):
                                            return True
                                        else:
                                            if a3 <= 1:
                                                if a5 <= 1:
                                                    if a29 <= 1:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if a1 <= 1:
                                                    if a28 <= 3:
                                                        return False
                                                    else:
                                                        if a3 <= 2:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    if a3 <= 3:
                                                        if a5 <= 5:
                                                            if a28 <= 3:
                                                                if a6 <= 4:
                                                                    if not (a13 + 2 < a24):
                                                                        return True
                                                                    else:
                                                                        if not (a22 + tempo < a15):
                                                                            if a5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if a5 <= 4:
                                                                                    if not (a29 + tempo - 1 < a3):
                                                                                        if a1 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if a5 <= 0:
                                                                                if a3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a3 <= 2:
                                                                                    if not (a5 + tempo < a6):
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return False
                                                                else:
                                                                    if not (a17 + tempo + 2 < a27):
                                                                        if not (a29 + tempo < a7):
                                                                            if not (a5 + tempo < a6):
                                                                                if a3 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if not (a29 + tempo - 1 < a3):
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if not (a29 + tempo + 2 < a9):
                                                                                if a1 <= 2:
                                                                                    if not (a29 + tempo - 1 < a3):
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if not (a29 + tempo - 1 < a3):
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                if a1 <= 2:
                                                                                    if a3 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if a3 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                    else:
                                                                        if not (a29 + tempo - 1 < a3):
                                                                            if a1 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if a5 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if a5 <= 3:
                                                            return True
                                                        else:
                                                            if not (a29 + tempo < a3):
                                                                if a1 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a15 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                    else:
                        if not (a22 + 1 < a13):
                            if not (a13 + tempo < a10):
                                if not (a29 + tempo - 1 < a3):
                                    if not (a22 < a29):
                                        return False
                                    else:
                                        if a5 <= 0:
                                            return False
                                        else:
                                            return True
                                else:
                                    return False
                            else:
                                return False
                        else:
                            if a3 <= 2:
                                return True
                            else:
                                if not (a26 + tempo + 1 < a29):
                                    if a3 <= 4:
                                        if a5 <= 6:
                                            if a3 <= 3:
                                                if a5 <= 5:
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
            if not (a25 + tempo - 1 < a16):
                if a0 <= 0:
                    if not (a6 + 1 < a23):
                        if not (a27 < a26):
                            if not (a12 - 1 < a27):
                                if a1 <= 0:
                                    if a5 <= 3:
                                        if a3 <= 0:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                                else:
                                    return True
                            else:
                                if a22 <= 2:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if not (a29 + tempo < a7):
                                            if not (a29 + tempo + 1 < a6):
                                                if a4 <= 6:
                                                    return True
                                                else:
                                                    if a5 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                if not (a15 + tempo + 1 < a3):
                                                    if a5 <= 5:
                                                        if not (a15 + tempo < a3):
                                                            if a5 <= 4:
                                                                if not (a29 + tempo - 1 < a3):
                                                                    if a5 <= 2:
                                                                        if a3 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a1 <= 2:
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
                                    if a19 <= 4:
                                        if not (a17 + 2 < a25):
                                            if a7 <= 5:
                                                if a4 <= 6:
                                                    if not (a1 + 2 < a29):
                                                        if not (a11 - 1 < a15):
                                                            if a7 <= 3:
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
                                                return True
                                        else:
                                            if not (a8 < a27):
                                                if a1 <= 0:
                                                    if not (a6 < a2):
                                                        return False
                                                    else:
                                                        if a7 <= 2:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    if not (a29 + 1 < a6):
                                                        if a7 <= 5:
                                                            if a4 <= 5:
                                                                if a4 <= 2:
                                                                    return False
                                                                else:
                                                                    if not (a16 < a29):
                                                                        return False
                                                                    else:
                                                                        if a4 <= 3:
                                                                            if a16 <= 4:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return True
                                                            else:
                                                                return False
                                                        else:
                                                            if a8 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if a4 <= 4:
                                                            if a4 <= 3:
                                                                return False
                                                            else:
                                                                if a11 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            if a6 <= 5:
                                                                if a20 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                            else:
                                                return False
                                    else:
                                        if not (a15 < a24):
                                            return True
                                        else:
                                            return False
                        else:
                            if not (a22 + 1 < a13):
                                return False
                            else:
                                if not (a15 + tempo + 1 < a22):
                                    return False
                                else:
                                    return True
                    else:
                        if a13 <= 6:
                            if not (a26 + tempo - 1 < a29):
                                return False
                            else:
                                if a20 <= 3:
                                    if a8 <= 2:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            if a22 <= 1:
                                                if a5 <= 0:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                    else:
                                        if a4 <= 4:
                                            if not (a16 + tempo + 1 < a25):
                                                if a7 <= 5:
                                                    return False
                                                else:
                                                    if a25 <= 5:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                return True
                                        else:
                                            if a8 <= 3:
                                                if a7 <= 5:
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
                    if not (a16 < a13):
                        if a13 <= 5:
                            if not (a14 + tempo < a10):
                                if not (a13 + tempo < a16):
                                    if a8 <= 2:
                                        if not (a29 + 2 < a28):
                                            if a1 <= 0:
                                                if not (a16 < a29):
                                                    return False
                                                else:
                                                    if a9 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                if not (a27 < a8):
                                                    return True
                                                else:
                                                    if a7 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                        else:
                                            return False
                                    else:
                                        if a7 <= 4:
                                            if a20 <= 3:
                                                if a6 <= 5:
                                                    if a11 <= 5:
                                                        return False
                                                    else:
                                                        if a6 <= 4:
                                                            return False
                                                        else:
                                                            if a5 <= 5:
                                                                return False
                                                            else:
                                                                if a4 <= 1:
                                                                    return False
                                                                else:
                                                                    if not (a29 + tempo < a22):
                                                                        return True
                                                                    else:
                                                                        return False
                                                else:
                                                    if a1 <= 0:
                                                        return False
                                                    else:
                                                        if a23 <= 2:
                                                            return True
                                                        else:
                                                            if not (a13 + 1 < a24):
                                                                if a7 <= 3:
                                                                    return True
                                                                else:
                                                                    if a9 <= 5:
                                                                        return False
                                                                    else:
                                                                        if not (a27 + 1 < a6):
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return False
                                            else:
                                                return True
                                        else:
                                            if a28 <= 4:
                                                if not (a29 + 1 < a22):
                                                    if a1 <= 1:
                                                        return False
                                                    else:
                                                        if a5 <= 5:
                                                            if a6 <= 6:
                                                                return True
                                                            else:
                                                                if a24 <= 4:
                                                                    return True
                                                                else:
                                                                    if a5 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                        else:
                                                            return False
                                                else:
                                                    if a16 <= 5:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                if not (a29 + tempo - 1 < a7):
                                                    if not (a27 + 1 < a6):
                                                        return False
                                                    else:
                                                        if a1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                else:
                                    if a1 <= 0:
                                        if a5 <= 2:
                                            if not (a13 + tempo - 1 < a22):
                                                return True
                                            else:
                                                return False
                                        else:
                                            if a16 <= 5:
                                                if not (a12 - 1 < a27):
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                    else:
                                        if not (a15 + tempo < a6):
                                            if a20 <= 3:
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
                        return True
            else:
                if not (a15 + tempo < a11):
                    if not (a14 + tempo < a10):
                        if not (a13 + tempo + 1 < a24):
                            if not (a29 + tempo < a7):
                                if not (a16 + 1 < a23):
                                    if a24 <= 2:
                                        if a2 <= 1:
                                            if not (a14 + tempo < a26):
                                                if not (a22 + 1 < a25):
                                                    if a5 <= 3:
                                                        if a1 <= 0:
                                                            if a3 <= 0:
                                                                return False
                                                            else:
                                                                if not (a29 + tempo + 1 < a6):
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if not (a29 + 1 < a28):
                                                                return True
                                                            else:
                                                                if not (a13 + tempo < a10):
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return True
                                                else:
                                                    if a3 <= 4:
                                                        if a5 <= 5:
                                                            if a3 <= 3:
                                                                if a5 <= 4:
                                                                    if a3 <= 0:
                                                                        return False
                                                                    else:
                                                                        if a3 <= 2:
                                                                            if a5 <= 3:
                                                                                if a6 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if a1 <= 1:
                                                                                        if a3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a3 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a1 <= 2:
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
                                                return False
                                        else:
                                            if not (a22 + 2 < a29):
                                                if a6 <= 5:
                                                    if a11 <= 2:
                                                        return False
                                                    else:
                                                        if not (a27 + 1 < a6):
                                                            return False
                                                        else:
                                                            if not (a1 + 2 < a29):
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    if a1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                return True
                                    else:
                                        if a4 <= 5:
                                            if a1 <= 0:
                                                if a6 <= 2:
                                                    if a20 <= 3:
                                                        return False
                                                    else:
                                                        if not (a25 + tempo < a16):
                                                            if not (a14 + tempo + 1 < a24):
                                                                if a12 <= 5:
                                                                    return True
                                                                else:
                                                                    if a4 <= 4:
                                                                        return True
                                                                    else:
                                                                        if a7 <= 3:
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
                                                if not (a13 + tempo < a22):
                                                    if not (a29 + tempo < a9):
                                                        if not (a14 + 1 < a24):
                                                            if not (a23 + tempo - 1 < a16):
                                                                if a7 <= 3:
                                                                    return True
                                                                else:
                                                                    if not (a17 + 2 < a14):
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if a20 <= 3:
                                                                    if a4 <= 4:
                                                                        if not (a16 + tempo - 1 < a15):
                                                                            if a23 <= 4:
                                                                                if a7 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    if not (a28 - 1 < a15):
                                                                                        if a7 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if not (a29 + tempo + 2 < a6):
                                                                                if a4 <= 3:
                                                                                    if a4 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if a11 <= 4:
                                                                                            return False
                                                                                        else:
                                                                                            if not (a15 + tempo < a6):
                                                                                                return True
                                                                                            else:
                                                                                                if not (a15 + tempo + 1 < a6):
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
                                                                    if a4 <= 4:
                                                                        if a25 <= 2:
                                                                            return False
                                                                        else:
                                                                            if a4 <= 1:
                                                                                if not (a6 - 1 < a12):
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if a4 <= 2:
                                                                                    if a6 <= 5:
                                                                                        if not (a29 + tempo - 1 < a6):
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        if not (a13 + tempo < a16):
                                                                            if not (a27 + tempo < a16):
                                                                                if a7 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if not (a10 - 1 < a15):
                                                                                        return True
                                                                                    else:
                                                                                        if a6 <= 1:
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
                                                        if not (a29 + 1 < a16):
                                                            return False
                                                        else:
                                                            if a23 <= 4:
                                                                if not (a6 + tempo - 1 < a12):
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                else:
                                                    return False
                                        else:
                                            if not (a24 < a29):
                                                return False
                                            else:
                                                if a11 <= 3:
                                                    return False
                                                else:
                                                    if a9 <= 3:
                                                        return True
                                                    else:
                                                        return False
                                else:
                                    return True
                            else:
                                if not (a14 + tempo < a22):
                                    if not (a25 + tempo < a24):
                                        if not (a27 + tempo - 1 < a24):
                                            if a6 <= 5:
                                                if not (a24 - 1 < a13):
                                                    if a7 <= 4:
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
                                        if a6 <= 6:
                                            if not (a14 + tempo < a9):
                                                if not (a13 + tempo < a10):
                                                    if a7 <= 3:
                                                        return False
                                                    else:
                                                        if not (a14 + tempo + 1 < a6):
                                                            if a7 <= 4:
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
                                            if not (a27 + tempo - 1 < a24):
                                                return False
                                            else:
                                                if a1 <= 0:
                                                    return False
                                                else:
                                                    if a7 <= 3:
                                                        return False
                                                    else:
                                                        if not (a22 < a14):
                                                            if a7 <= 4:
                                                                if a10 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                if a11 <= 3:
                                                                    return True
                                                                else:
                                                                    if not (a27 + tempo - 1 < a22):
                                                                        return True
                                                                    else:
                                                                        if a16 <= 5:
                                                                            if a7 <= 6:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if not (a16 + tempo - 1 < a25):
                                                                                return True
                                                                            else:
                                                                                return False
                                                        else:
                                                            return True
                                else:
                                    if not (a13 + tempo < a16):
                                        if a16 <= 5:
                                            return False
                                        else:
                                            if a24 <= 3:
                                                if not (a17 + tempo + 2 < a15):
                                                    return True
                                                else:
                                                    if not (a24 + 1 < a29):
                                                        if a7 <= 6:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                            else:
                                                if not (a6 + tempo < a14):
                                                    return True
                                                else:
                                                    return False
                                    else:
                                        if not (a25 + tempo < a24):
                                            if a6 <= 5:
                                                if not (a15 + 1 < a16):
                                                    if not (a1 + 2 < a29):
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a19 <= 4:
                                                        if not (a14 + 1 < a6):
                                                            return False
                                                        else:
                                                            if not (a26 + tempo < a25):
                                                                return True
                                                            else:
                                                                if a16 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        if a13 <= 2:
                                                            if a5 <= 4:
                                                                if not (a15 + tempo - 1 < a9):
                                                                    return True
                                                                else:
                                                                    if a7 <= 4:
                                                                        if not (a11 + tempo - 1 < a15):
                                                                            return False
                                                                        else:
                                                                            if a7 <= 3:
                                                                                if a3 <= 4:
                                                                                    if not (a15 + tempo < a3):
                                                                                        if a1 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if a5 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                if a1 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                    else:
                                                                                        if a1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if not (a29 + tempo + 1 < a3):
                                                                                                return True
                                                                                            else:
                                                                                                if a1 <= 2:
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
                                                            return True
                                            else:
                                                return True
                                        else:
                                            return False
                        else:
                            if a12 <= 3:
                                if not (a29 + tempo < a7):
                                    if not (a17 + 2 < a13):
                                        if a1 <= 0:
                                            return False
                                        else:
                                            if not (a27 + tempo - 1 < a26):
                                                if not (a26 + tempo - 1 < a25):
                                                    if not (a29 + tempo + 1 < a16):
                                                        return True
                                                    else:
                                                        if not (a15 + 1 < a9):
                                                            return False
                                                        else:
                                                            if not (a25 + tempo + 2 < a24):
                                                                return False
                                                            else:
                                                                if not (a14 + tempo < a9):
                                                                    if a5 <= 3:
                                                                        if a3 <= 4:
                                                                            if not (a29 + tempo + 1 < a3):
                                                                                if a5 <= 2:
                                                                                    if a1 <= 2:
                                                                                        if a3 <= 1:
                                                                                            if a5 <= 1:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if a5 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if a5 <= 2:
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
                                                if not (a29 + tempo < a28):
                                                    if not (a17 + 1 < a15):
                                                        return True
                                                    else:
                                                        if not (a29 + tempo - 1 < a7):
                                                            if a16 <= 4:
                                                                return False
                                                            else:
                                                                if not (a29 + 1 < a6):
                                                                    if a20 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                        else:
                                                            return False
                                                else:
                                                    if not (a23 + tempo - 1 < a16):
                                                        if not (a29 + 2 < a9):
                                                            if not (a14 < a10):
                                                                if not (a27 - 1 < a8):
                                                                    if a5 <= 0:
                                                                        if not (a13 + tempo < a16):
                                                                            return False
                                                                        else:
                                                                            if a3 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if a3 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a1 <= 1:
                                                                                return False
                                                                            else:
                                                                                if not (a29 + tempo - 1 < a3):
                                                                                    if a5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if a1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if not (a29 + tempo < a9):
                                                                                                if not (a15 + tempo + 1 < a3):
                                                                                                    if a5 <= 3:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if a5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                            else:
                                                                                                if a5 <= 3:
                                                                                                    if not (a29 + tempo + 1 < a3):
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if not (a29 + tempo < a3):
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
                                        return False
                                else:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if a9 <= 3:
                                            if not (a29 + tempo < a16):
                                                if a1 <= 1:
                                                    if a4 <= 6:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                        else:
                                            if a7 <= 5:
                                                if not (a17 + 1 < a29):
                                                    if a7 <= 4:
                                                        if not (a27 < a8):
                                                            if a7 <= 3:
                                                                if not (a26 - 1 < a29):
                                                                    if a5 <= 3:
                                                                        if not (a14 + tempo + 2 < a24):
                                                                            return True
                                                                        else:
                                                                            if a24 <= 6:
                                                                                if a5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if a1 <= 2:
                                                                                        if a5 <= 2:
                                                                                            if a5 <= 1:
                                                                                                if a1 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if a1 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if a5 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                            else:
                                                                                if not (a13 + tempo - 1 < a8):
                                                                                    return True
                                                                                else:
                                                                                    if a5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if a1 <= 2:
                                                                                            if a5 <= 2:
                                                                                                if a5 <= 1:
                                                                                                    if a1 <= 1:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if a1 <= 1:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if a5 <= 2:
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
                                                    return False
                                            else:
                                                return True
                            else:
                                if not (a13 + tempo < a22):
                                    if not (a29 + 1 < a16):
                                        if a15 <= 3:
                                            if a1 <= 2:
                                                return False
                                            else:
                                                if a7 <= 5:
                                                    return False
                                                else:
                                                    if not (a5 + tempo < a6):
                                                        return False
                                                    else:
                                                        return True
                                        else:
                                            return False
                                    else:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            if not (a27 + tempo + 1 < a9):
                                                if not (a17 + 1 < a29):
                                                    if not (a14 + tempo + 2 < a24):
                                                        if a5 <= 4:
                                                            if a5 <= 1:
                                                                if not (a15 + tempo + 1 < a3):
                                                                    if not (a29 + tempo < a7):
                                                                        if not (a15 + tempo < a3):
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if a7 <= 3:
                                                                        return False
                                                                    else:
                                                                        if not (a14 + tempo + 1 < a6):
                                                                            if a7 <= 4:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return True
                                                            else:
                                                                if a1 <= 2:
                                                                    if a5 <= 2:
                                                                        return False
                                                                    else:
                                                                        if not (a29 + tempo < a7):
                                                                            if a2 <= 1:
                                                                                if not (a29 + tempo < a9):
                                                                                    return False
                                                                                else:
                                                                                    if a3 <= 4:
                                                                                        return True
                                                                                    else:
                                                                                        if a5 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if not (a15 + tempo < a3):
                                                                                if a5 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    return False
                                                        else:
                                                            if not (a15 + tempo + 1 < a3):
                                                                return True
                                                            else:
                                                                if not (a29 + tempo < a7):
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return False
                                                else:
                                                    if a16 <= 5:
                                                        if a7 <= 5:
                                                            return False
                                                        else:
                                                            if not (a22 < a14):
                                                                if a7 <= 6:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                    else:
                                                        if not (a6 < a27):
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if a5 <= 0:
                                                    if not (a15 + tempo + 1 < a3):
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a3 <= 2:
                                                        if a5 <= 4:
                                                            if a5 <= 3:
                                                                return False
                                                            else:
                                                                if a1 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a5 <= 1:
                                                            if a1 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                else:
                                    if not (a13 + tempo < a9):
                                        if a7 <= 2:
                                            return False
                                        else:
                                            return True
                                    else:
                                        if not (a29 + tempo - 1 < a28):
                                            if a4 <= 5:
                                                if not (a29 - 1 < a7):
                                                    if a5 <= 3:
                                                        if not (a29 + tempo + 1 < a3):
                                                            if a1 <= 0:
                                                                return False
                                                            else:
                                                                if a5 <= 0:
                                                                    return True
                                                                else:
                                                                    if not (a29 + tempo - 1 < a3):
                                                                        if a1 <= 1:
                                                                            return True
                                                                        else:
                                                                            if a1 <= 2:
                                                                                if a5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if a1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if a3 <= 3:
                                                                                return True
                                                                            else:
                                                                                if a1 <= 2:
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
                        if not (a22 + 1 < a13):
                            if not (a23 + tempo - 1 < a16):
                                if a8 <= 2:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if not (a13 + tempo < a8):
                                            if a6 <= 6:
                                                return False
                                            else:
                                                if a3 <= 0:
                                                    return False
                                                else:
                                                    if a3 <= 3:
                                                        if a1 <= 1:
                                                            if a3 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            if a3 <= 1:
                                                                return False
                                                            else:
                                                                if not (a14 < a16):
                                                                    if a1 <= 2:
                                                                        if a3 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if a3 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    if a3 <= 2:
                                                                        if a1 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if a1 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                    else:
                                                        return False
                                        else:
                                            if a4 <= 6:
                                                if not (a14 + tempo < a16):
                                                    return True
                                                else:
                                                    if a3 <= 0:
                                                        return True
                                                    else:
                                                        if a3 <= 3:
                                                            if a3 <= 1:
                                                                if a5 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a1 <= 1:
                                                                    return True
                                                                else:
                                                                    if a1 <= 2:
                                                                        if a3 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a3 <= 2:
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
                    if not (a29 + tempo < a10):
                        if not (a13 + tempo + 1 < a9):
                            if not (a22 - 1 < a15):
                                if not (a14 + tempo + 1 < a9):
                                    if not (a13 < a22):
                                        return False
                                    else:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            if a5 <= 0:
                                                if not (a13 + tempo < a22):
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                else:
                                    return False
                            else:
                                if a1 <= 0:
                                    return False
                                else:
                                    return True
                        else:
                            return False
                    else:
                        if not (a26 + 1 < a13):
                            return False
                        else:
                            if a11 <= 3:
                                if not (a6 < a27):
                                    return False
                                else:
                                    if not (a8 + 1 < a13):
                                        return False
                                    else:
                                        return True
                            else:
                                return False
    else:
        if a24 <= 0:
            if not (a14 + tempo + 1 < a6):
                return True
            else:
                if a5 <= 3:
                    if a5 <= 1:
                        return True
                    else:
                        if not (a16 + tempo + 1 < a14):
                            return True
                        else:
                            return False
                else:
                    return True
        else:
            return True
