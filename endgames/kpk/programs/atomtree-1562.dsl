# Promoted 2026-11-26 from state/enumerated/atoms-1562.dsl: 6,005.2 B (6,005.2 B program, 0.0 B exceptions), 0 errors, at most 1,210 operations, tier 4,096.
# An exact greedy entropy tree (1,562 leaves) over 30 atoms only (files, ranks, distances, king walks), written as DSL by scripts/enumerate_concepts.py; no model involved.
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
    if a29 <= 3:
        if a28 <= 3:
            if a0 <= 0:
                if a23 <= 1:
                    return False
                else:
                    if a28 <= 2:
                        if a4 <= 5:
                            if a24 <= 6:
                                if a7 <= 3:
                                    if a23 <= 52:
                                        if a25 <= 6:
                                            if a27 <= 2:
                                                if a25 <= 5:
                                                    return False
                                                else:
                                                    if a4 <= 4:
                                                        if a19 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                if a9 <= 3:
                                                    if a1 <= 0:
                                                        if a16 <= 2:
                                                            return True
                                                        else:
                                                            if a3 <= 1:
                                                                if a3 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                    else:
                                                        if a2 <= 3:
                                                            if a8 <= 3:
                                                                if a22 <= 2:
                                                                    if a13 <= 2:
                                                                        if a7 <= 2:
                                                                            return True
                                                                        else:
                                                                            if a16 <= 4:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                            else:
                                                                if a3 <= 4:
                                                                    if a25 <= 5:
                                                                        if a29 <= 2:
                                                                            if a7 <= 2:
                                                                                return True
                                                                            else:
                                                                                if a5 <= 4:
                                                                                    if a5 <= 0:
                                                                                        if a1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if a1 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if a3 <= 0:
                                                                                                return False
                                                                                            else:
                                                                                                if a5 <= 2:
                                                                                                    if a1 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if a1 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a5 <= 5:
                                                                            if a3 <= 3:
                                                                                if a5 <= 4:
                                                                                    if a3 <= 1:
                                                                                        if a5 <= 2:
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
                                                    if a14 <= 2:
                                                        if a1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a27 <= 3:
                                                            return False
                                                        else:
                                                            if a25 <= 2:
                                                                if a1 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                        else:
                                            if a29 <= 2:
                                                return False
                                            else:
                                                return True
                                    else:
                                        if a1 <= 0:
                                            if a24 <= 2:
                                                if a29 <= 2:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                        else:
                                            if a29 <= 2:
                                                if a26 <= 50:
                                                    if a7 <= 2:
                                                        return False
                                                    else:
                                                        if a12 <= 2:
                                                            return True
                                                        else:
                                                            if a3 <= 0:
                                                                return True
                                                            else:
                                                                if a1 <= 1:
                                                                    return False
                                                                else:
                                                                    if a5 <= 0:
                                                                        if a3 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a3 <= 1:
                                                                            return True
                                                                        else:
                                                                            if a1 <= 2:
                                                                                return False
                                                                            else:
                                                                                if a2 <= 1:
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
                                                                                    if a2 <= 2:
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
                                                                                        if a9 <= 3:
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
                                                    return True
                                            else:
                                                return True
                                else:
                                    if a12 <= 3:
                                        if a22 <= 2:
                                            return True
                                        else:
                                            if a14 <= 2:
                                                if a25 <= 6:
                                                    if a29 <= 2:
                                                        if a6 <= 1:
                                                            return True
                                                        else:
                                                            if a10 <= 2:
                                                                if a25 <= 3:
                                                                    return True
                                                                else:
                                                                    if a20 <= 3:
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
                                        if a9 <= 3:
                                            return True
                                        else:
                                            if a1 <= 0:
                                                return False
                                            else:
                                                if a29 <= 2:
                                                    if a24 <= 5:
                                                        if a6 <= 5:
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
                                                                    if a5 <= 0:
                                                                        if a3 <= 2:
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
                                                                            if a1 <= 2:
                                                                                return False
                                                                            else:
                                                                                if a5 <= 3:
                                                                                    if a3 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a3 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                    else:
                                                        if a5 <= 4:
                                                            if a3 <= 3:
                                                                if a5 <= 3:
                                                                    if a22 <= 1:
                                                                        if a3 <= 0:
                                                                            if a5 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a3 <= 2:
                                                                                return False
                                                                            else:
                                                                                if a5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if a3 <= 1:
                                                                        if a1 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return False
                                                            else:
                                                                if a5 <= 1:
                                                                    if a1 <= 2:
                                                                        if a5 <= 0:
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
                                                                return False
                                                else:
                                                    if a9 <= 4:
                                                        if a27 <= 3:
                                                            if a7 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if a22 <= 1:
                                                            if a25 <= 2:
                                                                if a3 <= 0:
                                                                    return True
                                                                else:
                                                                    if a1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if a3 <= 1:
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
                                                                                    if a5 <= 3:
                                                                                        if a3 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if a3 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a1 <= 1:
                                                                if a7 <= 4:
                                                                    if a14 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                            else:
                                                                if a16 <= 5:
                                                                    if a7 <= 4:
                                                                        return False
                                                                    else:
                                                                        if a23 <= 4:
                                                                            return True
                                                                        else:
                                                                            if a3 <= 0:
                                                                                if a5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
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
                                                                    if a4 <= 1:
                                                                        if a7 <= 4:
                                                                            return False
                                                                        else:
                                                                            if a12 <= 4:
                                                                                return True
                                                                            else:
                                                                                if a3 <= 0:
                                                                                    if a5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
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
                                if a12 <= 4:
                                    return False
                                else:
                                    if a7 <= 4:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            if a8 <= 3:
                                                return True
                                            else:
                                                if a7 <= 2:
                                                    if a3 <= 4:
                                                        if a5 <= 0:
                                                            return True
                                                        else:
                                                            if a5 <= 3:
                                                                if a5 <= 1:
                                                                    if a1 <= 1:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a1 <= 1:
                                                                        return True
                                                                    else:
                                                                        if a3 <= 0:
                                                                            return False
                                                                        else:
                                                                            if a5 <= 2:
                                                                                if a1 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a1 <= 2:
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
                            if a6 <= 5:
                                if a22 <= 3:
                                    if a7 <= 3:
                                        return False
                                    else:
                                        if a23 <= 2:
                                            if a22 <= 2:
                                                return True
                                            else:
                                                if a25 <= 2:
                                                    if a20 <= 1:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                        else:
                                            return True
                                else:
                                    if a6 <= 4:
                                        return False
                                    else:
                                        if a16 <= 4:
                                            return False
                                        else:
                                            if a15 <= 2:
                                                return False
                                            else:
                                                if a1 <= 0:
                                                    return False
                                                else:
                                                    return True
                            else:
                                if a25 <= 1:
                                    return False
                                else:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if a14 <= 2:
                                            if a22 <= 3:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return True
                    else:
                        if a25 <= 2:
                            if a19 <= 1:
                                if a26 <= 2:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        return True
                                else:
                                    return False
                            else:
                                if a24 <= 2:
                                    if a23 <= 4:
                                        return False
                                    else:
                                        return True
                                else:
                                    return False
                        else:
                            if a29 <= 2:
                                if a6 <= 1:
                                    if a22 <= 4:
                                        if a1 <= 0:
                                            if a3 <= 1:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return True
                                    else:
                                        return False
                                else:
                                    if a22 <= 2:
                                        if a2 <= 1:
                                            return False
                                        else:
                                            if a20 <= 1:
                                                if a1 <= 0:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if a6 <= 3:
                                                    if a16 <= 4:
                                                        if a1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a25 <= 4:
                                                            return False
                                                        else:
                                                            if a1 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                else:
                                                    return False
                                    else:
                                        return False
                            else:
                                if a13 <= 6:
                                    if a4 <= 5:
                                        if a1 <= 0:
                                            if a25 <= 5:
                                                return False
                                            else:
                                                if a19 <= 4:
                                                    return False
                                                else:
                                                    if a3 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                        else:
                                            if a7 <= 5:
                                                if a26 <= 2:
                                                    if a20 <= 0:
                                                        return True
                                                    else:
                                                        if a3 <= 1:
                                                            if a5 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a1 <= 1:
                                                                if a27 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                if a12 <= 2:
                                                                    return True
                                                                else:
                                                                    if a7 <= 2:
                                                                        return False
                                                                    else:
                                                                        if a13 <= 4:
                                                                            if a5 <= 2:
                                                                                if a3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a3 <= 3:
                                                                                    if a1 <= 2:
                                                                                        if a3 <= 2:
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
                                                    if a23 <= 4:
                                                        if a7 <= 2:
                                                            if a23 <= 3:
                                                                if a25 <= 6:
                                                                    if a20 <= 0:
                                                                        return True
                                                                    else:
                                                                        if a2 <= 1:
                                                                            if a13 <= 4:
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
                                                            if a9 <= 3:
                                                                if a20 <= 3:
                                                                    if a2 <= 4:
                                                                        return False
                                                                    else:
                                                                        if a14 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    if a25 <= 5:
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                                    else:
                                                        if a7 <= 4:
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if a12 <= 4:
                                                    return True
                                                else:
                                                    if a4 <= 1:
                                                        if a3 <= 1:
                                                            if a5 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a5 <= 2:
                                                                if a3 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a3 <= 3:
                                                                    if a5 <= 4:
                                                                        return False
                                                                    else:
                                                                        if a3 <= 2:
                                                                            return True
                                                                        else:
                                                                            if a5 <= 5:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return True
                                    else:
                                        if a6 <= 5:
                                            if a7 <= 5:
                                                return False
                                            else:
                                                if a8 <= 3:
                                                    return True
                                                else:
                                                    if a6 <= 4:
                                                        return False
                                                    else:
                                                        if a8 <= 4:
                                                            if a2 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                        else:
                                            if a23 <= 4:
                                                if a10 <= 3:
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
                if a29 <= 2:
                    if a6 <= 1:
                        return True
                    else:
                        if a1 <= 0:
                            if a24 <= 3:
                                if a4 <= 5:
                                    if a25 <= 5:
                                        if a13 <= 4:
                                            if a2 <= 4:
                                                return False
                                            else:
                                                if a11 <= 2:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            if a20 <= 3:
                                                if a26 <= 2:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                    else:
                                        return True
                                else:
                                    if a26 <= 2:
                                        return True
                                    else:
                                        return False
                            else:
                                return False
                        else:
                            if a22 <= 4:
                                if a24 <= 6:
                                    if a22 <= 3:
                                        if a24 <= 3:
                                            if a20 <= 3:
                                                return True
                                            else:
                                                if a23 <= 3:
                                                    return True
                                                else:
                                                    if a11 <= 2:
                                                        return True
                                                    else:
                                                        if a7 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                        else:
                                            if a25 <= 3:
                                                if a28 <= 2:
                                                    if a23 <= 3:
                                                        return True
                                                    else:
                                                        if a8 <= 1:
                                                            if a2 <= 1:
                                                                if a7 <= 3:
                                                                    return True
                                                                else:
                                                                    if a5 <= 4:
                                                                        if a5 <= 1:
                                                                            if a3 <= 1:
                                                                                if a1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if a5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a3 <= 1:
                                                                                return True
                                                                            else:
                                                                                if a5 <= 2:
                                                                                    if a3 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a3 <= 2:
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
                                                                        return True
                                                            else:
                                                                return True
                                                        else:
                                                            if a12 <= 3:
                                                                return False
                                                            else:
                                                                if a7 <= 3:
                                                                    return True
                                                                else:
                                                                    if a1 <= 1:
                                                                        if a5 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if a9 <= 5:
                                                                            if a19 <= 4:
                                                                                if a2 <= 2:
                                                                                    if a4 <= 2:
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
                                                                                            if a5 <= 3:
                                                                                                if a3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if a3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                    else:
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
                                                                                                    if a5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                            else:
                                                                                return True
                                                                        else:
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
                                                                                if a5 <= 1:
                                                                                    if a3 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        return True
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
                                                    if a7 <= 4:
                                                        if a2 <= 1:
                                                            if a24 <= 5:
                                                                return False
                                                            else:
                                                                if a4 <= 1:
                                                                    return False
                                                                else:
                                                                    if a5 <= 4:
                                                                        if a3 <= 5:
                                                                            if a5 <= 3:
                                                                                if a3 <= 4:
                                                                                    if a5 <= 1:
                                                                                        if a3 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a1 <= 2:
                                                                                            if a5 <= 2:
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
                                                                        return True
                                                        else:
                                                            if a9 <= 3:
                                                                return True
                                                            else:
                                                                if a11 <= 2:
                                                                    return False
                                                                else:
                                                                    if a23 <= 51:
                                                                        if a6 <= 6:
                                                                            if a9 <= 4:
                                                                                if a12 <= 2:
                                                                                    if a7 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a12 <= 3:
                                                                                    if a1 <= 1:
                                                                                        if a22 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if a7 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        if a7 <= 3:
                                                                                            if a10 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if a12 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                if a10 <= 2:
                                                                                                    if a2 <= 2:
                                                                                                        if a1 <= 2:
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
                                                                                                        if a5 <= 0:
                                                                                                            if a3 <= 2:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            if a3 <= 0:
                                                                                                                return True
                                                                                                            else:
                                                                                                                if a1 <= 2:
                                                                                                                    return False
                                                                                                                else:
                                                                                                                    if a5 <= 3:
                                                                                                                        if a3 <= 3:
                                                                                                                            return False
                                                                                                                        else:
                                                                                                                            return True
                                                                                                                    else:
                                                                                                                        if a3 <= 3:
                                                                                                                            return True
                                                                                                                        else:
                                                                                                                            return False
                                                                                                else:
                                                                                                    return False
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if a26 <= 2:
                                                                                if a1 <= 1:
                                                                                    return False
                                                                                else:
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
                                                                                        if a5 <= 3:
                                                                                            if a3 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if a3 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if a3 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a1 <= 1:
                                                                                if a3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if a3 <= 1:
                                                                                    if a5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if a1 <= 2:
                                                                                            if a3 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if a3 <= 2:
                                                                                                if a5 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if a3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    if a5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                    else:
                                                        if a14 <= 2:
                                                            return True
                                                        else:
                                                            if a19 <= 4:
                                                                if a24 <= 4:
                                                                    return True
                                                                else:
                                                                    if a8 <= 1:
                                                                        if a3 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a3 <= 3:
                                                                                if a5 <= 4:
                                                                                    if a1 <= 1:
                                                                                        if a3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a3 <= 1:
                                                                                            if a5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if a5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if a6 <= 6:
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
                                                                                    return True
                                                                            else:
                                                                                if a5 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                    else:
                                                                        if a1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if a5 <= 0:
                                                                                if a3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a3 <= 0:
                                                                                    if a5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if a5 <= 3:
                                                                                            if a3 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if a3 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                            else:
                                                                return True
                                            else:
                                                if a7 <= 2:
                                                    if a28 <= 2:
                                                        return True
                                                    else:
                                                        if a6 <= 2:
                                                            return True
                                                        else:
                                                            if a9 <= 5:
                                                                return True
                                                            else:
                                                                if a3 <= 3:
                                                                    if a5 <= 4:
                                                                        if a3 <= 1:
                                                                            if a5 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if a1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if a3 <= 2:
                                                                                        if a5 <= 2:
                                                                                            return False
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
                                        if a12 <= 2:
                                            if a20 <= 3:
                                                if a6 <= 3:
                                                    return False
                                                else:
                                                    if a16 <= 4:
                                                        if a13 <= 2:
                                                            if a8 <= 3:
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
                                            if a28 <= 2:
                                                return True
                                            else:
                                                if a7 <= 4:
                                                    return False
                                                else:
                                                    return True
                                else:
                                    if a28 <= 2:
                                        if a7 <= 3:
                                            return True
                                        else:
                                            if a24 <= 53:
                                                return False
                                            else:
                                                if a13 <= 0:
                                                    return False
                                                else:
                                                    if a5 <= 0:
                                                        if a3 <= 1:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a2 <= 2:
                                                            if a5 <= 3:
                                                                if a3 <= 3:
                                                                    if a1 <= 2:
                                                                        if a5 <= 2:
                                                                            if a8 <= 1:
                                                                                if a3 <= 0:
                                                                                    if a5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a3 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if a5 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if a3 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if a5 <= 2:
                                                                        if a1 <= 2:
                                                                            if a5 <= 1:
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
                                                                    return False
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
                                                                        if a3 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
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
                                        if a24 <= 7:
                                            if a27 <= 2:
                                                if a11 <= 2:
                                                    return False
                                                else:
                                                    if a7 <= 4:
                                                        if a4 <= 0:
                                                            if a8 <= 2:
                                                                if a6 <= 2:
                                                                    if a7 <= 2:
                                                                        if a3 <= 3:
                                                                            if a5 <= 4:
                                                                                if a3 <= 1:
                                                                                    if a1 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if a5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if a1 <= 1:
                                                                                            return False
                                                                                        else:
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
                                                                            return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a23 <= 51:
                                                                        if a7 <= 3:
                                                                            return False
                                                                        else:
                                                                            if a23 <= 2:
                                                                                return True
                                                                            else:
                                                                                if a1 <= 1:
                                                                                    return False
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
                                                                                                    if a5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                    else:
                                                                        if a3 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a3 <= 3:
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
                                                                                                if a5 <= 2:
                                                                                                    return True
                                                                                                else:
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
                                                        return True
                                            else:
                                                if a4 <= 0:
                                                    if a5 <= 4:
                                                        if a5 <= 1:
                                                            if a3 <= 1:
                                                                return False
                                                            else:
                                                                if a1 <= 1:
                                                                    return False
                                                                else:
                                                                    if a5 <= 0:
                                                                        return True
                                                                    else:
                                                                        if a1 <= 2:
                                                                            return False
                                                                        else:
                                                                            if a3 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                        else:
                                                            if a3 <= 2:
                                                                if a5 <= 2:
                                                                    return False
                                                                else:
                                                                    if a1 <= 2:
                                                                        if a5 <= 3:
                                                                            if a1 <= 1:
                                                                                if a3 <= 1:
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
                                                        if a3 <= 3:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    return False
                                        else:
                                            return False
                            else:
                                if a8 <= 2:
                                    if a7 <= 2:
                                        if a23 <= 50:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                                else:
                                    if a14 <= 2:
                                        if a20 <= 3:
                                            return False
                                        else:
                                            if a10 <= 3:
                                                if a13 <= 4:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                    else:
                                        if a9 <= 2:
                                            return True
                                        else:
                                            if a7 <= 4:
                                                return False
                                            else:
                                                return True
                else:
                    if a14 <= 2:
                        return True
                    else:
                        if a1 <= 0:
                            if a24 <= 3:
                                if a13 <= 5:
                                    if a13 <= 2:
                                        return False
                                    else:
                                        if a28 <= 2:
                                            if a24 <= 2:
                                                return True
                                            else:
                                                if a6 <= 5:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            if a16 <= 2:
                                                return True
                                            else:
                                                if a2 <= 1:
                                                    if a9 <= 2:
                                                        return True
                                                    else:
                                                        if a22 <= 4:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    if a22 <= 3:
                                                        if a6 <= 5:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        if a23 <= 3:
                                                            if a7 <= 4:
                                                                return False
                                                            else:
                                                                if a16 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                                else:
                                    return True
                            else:
                                if a6 <= 4:
                                    if a4 <= 2:
                                        if a6 <= 2:
                                            if a9 <= 6:
                                                return True
                                            else:
                                                if a6 <= 1:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            if a24 <= 5:
                                                if a6 <= 3:
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
                            if a28 <= 2:
                                return True
                            else:
                                if a25 <= 1:
                                    if a7 <= 5:
                                        if a8 <= 4:
                                            return True
                                        else:
                                            if a9 <= 2:
                                                if a7 <= 2:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                    else:
                                        return False
                                else:
                                    if a4 <= 6:
                                        if a20 <= 1:
                                            return True
                                        else:
                                            if a25 <= 5:
                                                if a8 <= 2:
                                                    if a13 <= 2:
                                                        if a22 <= 1:
                                                            if a3 <= 0:
                                                                return True
                                                            else:
                                                                if a1 <= 1:
                                                                    if a3 <= 1:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if a3 <= 1:
                                                                        if a5 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a5 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a3 <= 3:
                                                                                if a5 <= 4:
                                                                                    if a20 <= 3:
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
                                                                                    return True
                                                                            else:
                                                                                if a5 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                        else:
                                                            if a1 <= 1:
                                                                return False
                                                            else:
                                                                if a1 <= 2:
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
                                                                    if a2 <= 1:
                                                                        if a5 <= 3:
                                                                            if a3 <= 3:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a3 <= 3:
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
                                                        return True
                                                else:
                                                    if a7 <= 4:
                                                        if a27 <= 3:
                                                            if a9 <= 2:
                                                                return True
                                                            else:
                                                                if a7 <= 2:
                                                                    if a25 <= 4:
                                                                        return False
                                                                    else:
                                                                        if a19 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if a7 <= 3:
                                                                        if a25 <= 4:
                                                                            if a8 <= 3:
                                                                                if a9 <= 4:
                                                                                    return True
                                                                                else:
                                                                                    if a4 <= 0:
                                                                                        return False
                                                                                    else:
                                                                                        if a20 <= 3:
                                                                                            if a6 <= 4:
                                                                                                return False
                                                                                            else:
                                                                                                if a19 <= 3:
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
                                                                        if a25 <= 4:
                                                                            return False
                                                                        else:
                                                                            if a20 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a24 <= 5:
                                                            if a6 <= 6:
                                                                return True
                                                            else:
                                                                if a19 <= 3:
                                                                    if a7 <= 5:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                        else:
                                                            if a12 <= 3:
                                                                return True
                                                            else:
                                                                if a9 <= 6:
                                                                    if a20 <= 3:
                                                                        if a7 <= 5:
                                                                            return False
                                                                        else:
                                                                            if a6 <= 6:
                                                                                return True
                                                                            else:
                                                                                if a1 <= 1:
                                                                                    return False
                                                                                else:
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
                                                                    if a7 <= 5:
                                                                        return False
                                                                    else:
                                                                        if a27 <= 3:
                                                                            return True
                                                                        else:
                                                                            if a1 <= 1:
                                                                                return False
                                                                            else:
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
                                        if a6 <= 4:
                                            if a7 <= 5:
                                                if a22 <= 4:
                                                    if a22 <= 3:
                                                        return True
                                                    else:
                                                        if a7 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                            else:
                                                if a25 <= 5:
                                                    if a2 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                        else:
                                            if a8 <= 4:
                                                if a7 <= 4:
                                                    if a22 <= 3:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                return True
        else:
            if a29 <= 2:
                if a13 <= 5:
                    if a22 <= 2:
                        if a0 <= 0:
                            if a2 <= 4:
                                return False
                            else:
                                if a7 <= 2:
                                    if a25 <= 0:
                                        return False
                                    else:
                                        if a9 <= 3:
                                            if a27 <= 1:
                                                return False
                                            else:
                                                if a1 <= 0:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            return False
                                else:
                                    return False
                        else:
                            if a7 <= 3:
                                if a15 <= 0:
                                    if a4 <= 4:
                                        return False
                                    else:
                                        if a8 <= 1:
                                            if a5 <= 0:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                else:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if a11 <= 2:
                                            if a7 <= 2:
                                                if a6 <= 6:
                                                    if a23 <= 2:
                                                        return False
                                                    else:
                                                        if a4 <= 4:
                                                            if a24 <= 5:
                                                                if a23 <= 51:
                                                                    return False
                                                                else:
                                                                    if a2 <= 2:
                                                                        return True
                                                                    else:
                                                                        if a24 <= 4:
                                                                            return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                if a22 <= 1:
                                                                    if a19 <= 3:
                                                                        if a5 <= 0:
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
                                                                                    if a1 <= 2:
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
                                                                        if a16 <= 5:
                                                                            return False
                                                                        else:
                                                                            if a24 <= 6:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    if a2 <= 2:
                                                                        return True
                                                                    else:
                                                                        if a5 <= 3:
                                                                            if a3 <= 4:
                                                                                if a5 <= 1:
                                                                                    if a1 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a1 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if a3 <= 0:
                                                                                            return False
                                                                                        else:
                                                                                            if a1 <= 2:
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
                                                            return False
                                                else:
                                                    if a27 <= 50:
                                                        return True
                                                    else:
                                                        if a5 <= 0:
                                                            return False
                                                        else:
                                                            if a3 <= 0:
                                                                return True
                                                            else:
                                                                if a1 <= 1:
                                                                    return False
                                                                else:
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
                                                if a24 <= 5:
                                                    return True
                                                else:
                                                    if a4 <= 3:
                                                        if a22 <= 1:
                                                            return True
                                                        else:
                                                            if a5 <= 3:
                                                                if a6 <= 3:
                                                                    return True
                                                                else:
                                                                    if a24 <= 6:
                                                                        if a5 <= 0:
                                                                            return True
                                                                        else:
                                                                            if a5 <= 2:
                                                                                if a1 <= 2:
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
                                                                                if a1 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                    else:
                                                                        if a2 <= 2:
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
                                                        if a4 <= 6:
                                                            return True
                                                        else:
                                                            if a5 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                        else:
                                            if a2 <= 4:
                                                if a11 <= 3:
                                                    return False
                                                else:
                                                    if a7 <= 2:
                                                        return True
                                                    else:
                                                        if a13 <= 4:
                                                            if a16 <= 4:
                                                                if a13 <= 3:
                                                                    if a9 <= 5:
                                                                        if a13 <= 2:
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
                                                return True
                            else:
                                if a24 <= 4:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        return True
                                else:
                                    if a13 <= 3:
                                        if a24 <= 5:
                                            if a25 <= 2:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                                    else:
                                        if a25 <= 4:
                                            if a9 <= 6:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return True
                    else:
                        if a26 <= 3:
                            if a11 <= 2:
                                if a0 <= 0:
                                    return False
                                else:
                                    if a7 <= 2:
                                        if a8 <= 3:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                            else:
                                if a20 <= 0:
                                    if a0 <= 0:
                                        return False
                                    else:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            return True
                                else:
                                    if a23 <= 2:
                                        if a7 <= 4:
                                            return False
                                        else:
                                            if a0 <= 0:
                                                return False
                                            else:
                                                if a6 <= 4:
                                                    if a19 <= 2:
                                                        return True
                                                    else:
                                                        if a13 <= 3:
                                                            return False
                                                        else:
                                                            if a19 <= 3:
                                                                return True
                                                            else:
                                                                if a25 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                else:
                                                    return False
                                    else:
                                        return False
                        else:
                            if a10 <= 2:
                                if a22 <= 3:
                                    if a8 <= 2:
                                        return False
                                    else:
                                        if a0 <= 0:
                                            return False
                                        else:
                                            return True
                                else:
                                    if a27 <= 50:
                                        return False
                                    else:
                                        if a2 <= 4:
                                            return False
                                        else:
                                            if a5 <= 0:
                                                return False
                                            else:
                                                return True
                            else:
                                if a22 <= 3:
                                    if a24 <= 5:
                                        if a6 <= 5:
                                            return False
                                        else:
                                            if a4 <= 2:
                                                return False
                                            else:
                                                if a0 <= 0:
                                                    return False
                                                else:
                                                    if a1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                    else:
                                        return False
                                else:
                                    return False
                else:
                    if a0 <= 0:
                        return False
                    else:
                        return True
            else:
                if a0 <= 0:
                    if a6 <= 0:
                        if a23 <= 1:
                            return False
                        else:
                            return True
                    else:
                        if a26 <= 3:
                            if a2 <= 4:
                                if a13 <= 3:
                                    return False
                                else:
                                    if a12 <= 2:
                                        return False
                                    else:
                                        if a24 <= 5:
                                            if a1 <= 0:
                                                return False
                                            else:
                                                return True
                                        else:
                                            if a13 <= 4:
                                                return False
                                            else:
                                                if a13 <= 5:
                                                    if a19 <= 3:
                                                        if a1 <= 0:
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
                                if a12 <= 2:
                                    return False
                                else:
                                    if a1 <= 0:
                                        return False
                                    else:
                                        if a7 <= 3:
                                            if a6 <= 4:
                                                return True
                                            else:
                                                if a11 <= 3:
                                                    return True
                                                else:
                                                    if a22 <= 2:
                                                        if a3 <= 4:
                                                            if a5 <= 5:
                                                                if a3 <= 3:
                                                                    if a5 <= 4:
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
                            return False
                else:
                    if a14 <= 2:
                        return True
                    else:
                        if a16 <= 2:
                            return True
                        else:
                            if a13 <= 5:
                                if a28 <= 4:
                                    if a25 <= 2:
                                        if a8 <= 5:
                                            return False
                                        else:
                                            if a24 <= 3:
                                                return True
                                            else:
                                                if a9 <= 2:
                                                    if a7 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                    else:
                                        if a1 <= 0:
                                            if a25 <= 3:
                                                return False
                                            else:
                                                if a20 <= 2:
                                                    if a25 <= 4:
                                                        if a20 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    if a23 <= 4:
                                                        if a13 <= 4:
                                                            return False
                                                        else:
                                                            if a3 <= 3:
                                                                return False
                                                            else:
                                                                if a20 <= 3:
                                                                    return False
                                                                else:
                                                                    if a8 <= 4:
                                                                        return True
                                                                    else:
                                                                        return False
                                                    else:
                                                        if a13 <= 2:
                                                            return False
                                                        else:
                                                            return True
                                        else:
                                            if a22 <= 4:
                                                if a7 <= 6:
                                                    if a8 <= 2:
                                                        if a3 <= 2:
                                                            if a5 <= 2:
                                                                if a3 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                        else:
                                                            if a5 <= 2:
                                                                return True
                                                            else:
                                                                if a3 <= 4:
                                                                    if a5 <= 5:
                                                                        if a3 <= 3:
                                                                            if a1 <= 1:
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
                                                        if a9 <= 4:
                                                            if a12 <= 3:
                                                                if a10 <= 3:
                                                                    return False
                                                                else:
                                                                    if a7 <= 4:
                                                                        if a19 <= 3:
                                                                            if a25 <= 4:
                                                                                if a24 <= 5:
                                                                                    if a4 <= 5:
                                                                                        if a7 <= 3:
                                                                                            if a6 <= 6:
                                                                                                if a19 <= 2:
                                                                                                    if a4 <= 4:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if a6 <= 4:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a25 <= 3:
                                                                                            return False
                                                                                        else:
                                                                                            if a16 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if a13 <= 4:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if a7 <= 3:
                                                                    return True
                                                                else:
                                                                    if a12 <= 4:
                                                                        return False
                                                                    else:
                                                                        return True
                                                        else:
                                                            if a7 <= 5:
                                                                if a12 <= 4:
                                                                    if a7 <= 3:
                                                                        if a22 <= 3:
                                                                            return False
                                                                        else:
                                                                            if a13 <= 3:
                                                                                if a20 <= 3:
                                                                                    if a6 <= 4:
                                                                                        return False
                                                                                    else:
                                                                                        if a2 <= 2:
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
                                                                if a23 <= 3:
                                                                    return True
                                                                else:
                                                                    if a1 <= 2:
                                                                        return False
                                                                    else:
                                                                        if a10 <= 3:
                                                                            if a4 <= 0:
                                                                                if a5 <= 3:
                                                                                    if a3 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a3 <= 3:
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
                                                                            return False
                                                else:
                                                    if a4 <= 0:
                                                        if a6 <= 6:
                                                            return True
                                                        else:
                                                            if a8 <= 2:
                                                                if a3 <= 2:
                                                                    if a5 <= 2:
                                                                        if a3 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a5 <= 2:
                                                                        return True
                                                                    else:
                                                                        if a3 <= 4:
                                                                            if a1 <= 2:
                                                                                if a3 <= 3:
                                                                                    if a5 <= 4:
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
                                                                if a1 <= 2:
                                                                    return False
                                                                else:
                                                                    if a5 <= 3:
                                                                        if a3 <= 3:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a3 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                    else:
                                                        return True
                                            else:
                                                if a6 <= 5:
                                                    if a22 <= 5:
                                                        if a16 <= 5:
                                                            if a7 <= 6:
                                                                return False
                                                            else:
                                                                if a6 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            if a8 <= 4:
                                                                return True
                                                            else:
                                                                if a7 <= 5:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                else:
                                    if a25 <= 3:
                                        return False
                                    else:
                                        if a16 <= 4:
                                            if a16 <= 3:
                                                return True
                                            else:
                                                if a6 <= 2:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            return False
                            else:
                                return True
    else:
        if a27 <= 2:
            if a0 <= 0:
                if a26 <= 2:
                    if a23 <= 1:
                        return False
                    else:
                        if a20 <= 3:
                            if a6 <= 4:
                                if a25 <= 4:
                                    if a13 <= 3:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return False
                                else:
                                    return False
                            else:
                                if a23 <= 2:
                                    if a2 <= 3:
                                        if a1 <= 0:
                                            return False
                                        else:
                                            return True
                                    else:
                                        if a6 <= 5:
                                            return False
                                        else:
                                            if a1 <= 0:
                                                return False
                                            else:
                                                return True
                                else:
                                    return True
                        else:
                            if a1 <= 0:
                                if a15 <= 2:
                                    if a25 <= 5:
                                        return False
                                    else:
                                        return True
                                else:
                                    return True
                            else:
                                if a6 <= 6:
                                    return True
                                else:
                                    if a5 <= 0:
                                        if a3 <= 1:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                else:
                    if a23 <= 50:
                        if a22 <= 2:
                            if a9 <= 2:
                                if a5 <= 0:
                                    return False
                                else:
                                    return True
                            else:
                                return False
                        else:
                            return False
                    else:
                        if a6 <= 6:
                            return False
                        else:
                            if a1 <= 0:
                                return False
                            else:
                                if a25 <= 0:
                                    if a3 <= 0:
                                        return True
                                    else:
                                        if a3 <= 3:
                                            if a5 <= 1:
                                                if a3 <= 1:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if a3 <= 1:
                                                    return True
                                                else:
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
                                                    if a5 <= 1:
                                                        if a3 <= 2:
                                                            return True
                                                        else:
                                                            return False
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
                if a14 <= 1:
                    if a10 <= 3:
                        if a22 <= 51:
                            return True
                        else:
                            if a24 <= 2:
                                return False
                            else:
                                if a10 <= 2:
                                    if a14 <= 0:
                                        if a19 <= 2:
                                            if a4 <= 6:
                                                if a5 <= 0:
                                                    return False
                                                else:
                                                    if a23 <= 50:
                                                        return True
                                                    else:
                                                        if a3 <= 0:
                                                            return False
                                                        else:
                                                            if a3 <= 3:
                                                                if a3 <= 1:
                                                                    if a1 <= 1:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if a5 <= 1:
                                                                        return False
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
                                                                return False
                                            else:
                                                return False
                                        else:
                                            return False
                                    else:
                                        return True
                                else:
                                    if a13 <= 0:
                                        if a8 <= 2:
                                            if a1 <= 0:
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
                    if a15 <= 2:
                        if a1 <= 0:
                            if a3 <= 0:
                                if a7 <= 2:
                                    if a13 <= 4:
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
            if a2 <= 3:
                if a25 <= 5:
                    if a10 <= 3:
                        if a1 <= 0:
                            if a24 <= 4:
                                if a25 <= 3:
                                    if a0 <= 0:
                                        return False
                                    else:
                                        if a5 <= 2:
                                            return False
                                        else:
                                            if a9 <= 2:
                                                return True
                                            else:
                                                if a6 <= 5:
                                                    if a9 <= 3:
                                                        return True
                                                    else:
                                                        if a6 <= 4:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    return False
                                else:
                                    if a4 <= 3:
                                        if a6 <= 3:
                                            if a15 <= 3:
                                                if a3 <= 0:
                                                    if a0 <= 0:
                                                        return False
                                                    else:
                                                        if a14 <= 2:
                                                            if a25 <= 4:
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
                                            if a0 <= 0:
                                                return False
                                            else:
                                                if a25 <= 4:
                                                    if a6 <= 4:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                    else:
                                        if a0 <= 0:
                                            if a15 <= 4:
                                                if a9 <= 2:
                                                    if a23 <= 3:
                                                        if a3 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                                else:
                                                    if a6 <= 4:
                                                        if a26 <= 2:
                                                            if a23 <= 3:
                                                                if a3 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a15 <= 2:
                                                                    return False
                                                                else:
                                                                    if a10 <= 0:
                                                                        if a6 <= 2:
                                                                            return True
                                                                        else:
                                                                            if a14 <= 3:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        return True
                                                        else:
                                                            if a22 <= 3:
                                                                if a7 <= 3:
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
                                            if a23 <= 2:
                                                if a25 <= 4:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                            else:
                                if a6 <= 3:
                                    if a4 <= 1:
                                        if a0 <= 0:
                                            return False
                                        else:
                                            if a4 <= 0:
                                                return False
                                            else:
                                                if a6 <= 2:
                                                    return True
                                                else:
                                                    if a11 <= 3:
                                                        return False
                                                    else:
                                                        if a14 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                    else:
                                        if a0 <= 0:
                                            if a6 <= 2:
                                                if a26 <= 0:
                                                    if a12 <= 3:
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
                                    if a16 <= 4:
                                        if a12 <= 4:
                                            return False
                                        else:
                                            if a0 <= 0:
                                                return False
                                            else:
                                                return True
                                    else:
                                        return False
                        else:
                            if a0 <= 0:
                                if a28 <= 2:
                                    if a15 <= 2:
                                        if a23 <= 1:
                                            return False
                                        else:
                                            if a22 <= 1:
                                                if a12 <= 2:
                                                    return True
                                                else:
                                                    if a24 <= 5:
                                                        if a10 <= 0:
                                                            if a4 <= 2:
                                                                if a25 <= 2:
                                                                    if a5 <= 4:
                                                                        if a5 <= 1:
                                                                            if a1 <= 1:
                                                                                return False
                                                                            else:
                                                                                if a5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if a3 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                        else:
                                                                            if a5 <= 2:
                                                                                return False
                                                                            else:
                                                                                if a3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if a3 <= 2:
                                                                                        if a5 <= 3:
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
                                                            if a7 <= 2:
                                                                return False
                                                            else:
                                                                if a14 <= 2:
                                                                    return True
                                                                else:
                                                                    if a3 <= 0:
                                                                        if a5 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if a1 <= 1:
                                                                            if a5 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if a24 <= 3:
                                                                                if a5 <= 0:
                                                                                    if a3 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a3 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if a1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if a5 <= 3:
                                                                                                if a3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if a3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                            else:
                                                                                if a16 <= 5:
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
                                                        if a26 <= 0:
                                                            return False
                                                        else:
                                                            if a25 <= 0:
                                                                return False
                                                            else:
                                                                if a13 <= 1:
                                                                    if a2 <= 2:
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
                                                                                        if a3 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if a3 <= 2:
                                                                                            if a5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                if a5 <= 3:
                                                                                                    if a3 <= 1:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            if a5 <= 2:
                                                                                                if a3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                                    else:
                                                                        if a1 <= 1:
                                                                            if a5 <= 1:
                                                                                if a3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a3 <= 1:
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
                                                                                if a3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if a1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if a5 <= 3:
                                                                                            if a3 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if a3 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                else:
                                                                    return False
                                            else:
                                                return True
                                    else:
                                        if a23 <= 1:
                                            return False
                                        else:
                                            return True
                                else:
                                    if a15 <= 4:
                                        if a3 <= 3:
                                            if a5 <= 5:
                                                if a7 <= 6:
                                                    if a28 <= 3:
                                                        return True
                                                    else:
                                                        if a23 <= 1:
                                                            return False
                                                        else:
                                                            if a14 <= 1:
                                                                return True
                                                            else:
                                                                if a26 <= 0:
                                                                    if a24 <= 5:
                                                                        return False
                                                                    else:
                                                                        if a2 <= 2:
                                                                            return True
                                                                        else:
                                                                            if a5 <= 0:
                                                                                return False
                                                                            else:
                                                                                if a5 <= 3:
                                                                                    if a5 <= 1:
                                                                                        if a1 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if a5 <= 2:
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
                                                                                    return False
                                                                else:
                                                                    if a3 <= 2:
                                                                        if a23 <= 51:
                                                                            return True
                                                                        else:
                                                                            if a5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if a5 <= 1:
                                                                                    if a1 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if a1 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if a5 <= 3:
                                                                                            if a24 <= 4:
                                                                                                return True
                                                                                            else:
                                                                                                if a24 <= 5:
                                                                                                    if a19 <= 4:
                                                                                                        if a1 <= 2:
                                                                                                            return False
                                                                                                        else:
                                                                                                            if a5 <= 2:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                                    else:
                                                                                                        if a5 <= 2:
                                                                                                            return False
                                                                                                        else:
                                                                                                            if a1 <= 2:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                                else:
                                                                                                    if a9 <= 4:
                                                                                                        if a3 <= 1:
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
                                                                        if a10 <= 2:
                                                                            if a5 <= 1:
                                                                                return True
                                                                            else:
                                                                                if a5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            return False
                                                else:
                                                    if a13 <= 2:
                                                        return False
                                                    else:
                                                        if a5 <= 4:
                                                            if a23 <= 52:
                                                                return False
                                                            else:
                                                                if a3 <= 1:
                                                                    return True
                                                                else:
                                                                    if a3 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                        else:
                                                            if a3 <= 2:
                                                                return True
                                                            else:
                                                                if a23 <= 5:
                                                                    return False
                                                                else:
                                                                    if a25 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                            else:
                                                return True
                                        else:
                                            if a23 <= 5:
                                                if a26 <= 2:
                                                    return True
                                                else:
                                                    if a22 <= 2:
                                                        if a3 <= 4:
                                                            if a1 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        if a12 <= 4:
                                                            if a6 <= 2:
                                                                if a2 <= 2:
                                                                    return False
                                                                else:
                                                                    if a8 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                                        else:
                                                            if a7 <= 4:
                                                                return True
                                                            else:
                                                                return False
                                            else:
                                                if a7 <= 6:
                                                    if a26 <= 1:
                                                        if a5 <= 2:
                                                            return True
                                                        else:
                                                            if a5 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                                else:
                                                    if a25 <= 2:
                                                        return False
                                                    else:
                                                        if a5 <= 2:
                                                            return True
                                                        else:
                                                            if a13 <= 3:
                                                                return False
                                                            else:
                                                                if a8 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                    else:
                                        return True
                            else:
                                if a15 <= 1:
                                    if a24 <= 4:
                                        return True
                                    else:
                                        if a24 <= 5:
                                            if a6 <= 4:
                                                return True
                                            else:
                                                if a3 <= 0:
                                                    return False
                                                else:
                                                    if a5 <= 3:
                                                        if a3 <= 3:
                                                            if a3 <= 1:
                                                                if a5 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a5 <= 1:
                                                                    return True
                                                                else:
                                                                    if a1 <= 1:
                                                                        return False
                                                                    else:
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
                                                        return False
                                        else:
                                            if a24 <= 6:
                                                return False
                                            else:
                                                if a4 <= 4:
                                                    if a25 <= 1:
                                                        if a1 <= 1:
                                                            if a5 <= 0:
                                                                if a3 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if a3 <= 0:
                                                                    return True
                                                                else:
                                                                    if a10 <= 0:
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
                                                            if a26 <= 0:
                                                                if a5 <= 1:
                                                                    return True
                                                                else:
                                                                    if a5 <= 3:
                                                                        if a1 <= 2:
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
                                                                if a5 <= 1:
                                                                    if a3 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a3 <= 1:
                                                                        return True
                                                                    else:
                                                                        if a1 <= 2:
                                                                            if a5 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if a5 <= 2:
                                                                                if a3 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if a5 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    if a3 <= 3:
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
                            if a5 <= 5:
                                if a24 <= 4:
                                    if a23 <= 4:
                                        if a6 <= 5:
                                            return False
                                        else:
                                            if a7 <= 2:
                                                if a1 <= 0:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                    else:
                                        if a24 <= 3:
                                            if a13 <= 4:
                                                if a9 <= 2:
                                                    if a27 <= 4:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a25 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                return True
                                        else:
                                            if a3 <= 4:
                                                if a6 <= 2:
                                                    if a16 <= 4:
                                                        if a7 <= 4:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                            else:
                                                if a13 <= 3:
                                                    return False
                                                else:
                                                    return True
                                else:
                                    if a28 <= 4:
                                        if a5 <= 4:
                                            return False
                                        else:
                                            if a25 <= 4:
                                                if a9 <= 5:
                                                    if a3 <= 5:
                                                        if a2 <= 1:
                                                            if a23 <= 4:
                                                                if a6 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            if a9 <= 4:
                                                                if a2 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                    else:
                                                        return False
                                                else:
                                                    if a12 <= 5:
                                                        return False
                                                    else:
                                                        if a13 <= 3:
                                                            return False
                                                        else:
                                                            if a24 <= 6:
                                                                return True
                                                            else:
                                                                return False
                                            else:
                                                return False
                                    else:
                                        return False
                            else:
                                if a3 <= 4:
                                    if a23 <= 4:
                                        if a28 <= 3:
                                            if a2 <= 1:
                                                return True
                                            else:
                                                if a6 <= 5:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            return False
                                    else:
                                        if a3 <= 3:
                                            if a14 <= 4:
                                                if a28 <= 3:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                        else:
                                            if a5 <= 6:
                                                if a24 <= 5:
                                                    if a13 <= 4:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                else:
                                    if a23 <= 5:
                                        if a9 <= 5:
                                            if a6 <= 5:
                                                if a4 <= 3:
                                                    if a2 <= 2:
                                                        if a7 <= 2:
                                                            if a3 <= 5:
                                                                return False
                                                            else:
                                                                if a20 <= 3:
                                                                    if a4 <= 2:
                                                                        return False
                                                                    else:
                                                                        if a24 <= 4:
                                                                            return False
                                                                        else:
                                                                            if a24 <= 5:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    if a24 <= 6:
                                                                        if a1 <= 1:
                                                                            return True
                                                                        else:
                                                                            if a9 <= 4:
                                                                                return True
                                                                            else:
                                                                                if a1 <= 2:
                                                                                    if a3 <= 6:
                                                                                        if a24 <= 5:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if a29 <= 4:
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
                                                    if a3 <= 5:
                                                        if a5 <= 6:
                                                            if a20 <= 2:
                                                                if a6 <= 2:
                                                                    if a7 <= 4:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            if a29 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if a22 <= 4:
                                                            if a15 <= 4:
                                                                return False
                                                            else:
                                                                if a6 <= 2:
                                                                    if a19 <= 3:
                                                                        if a7 <= 4:
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
                                                if a7 <= 4:
                                                    if a23 <= 4:
                                                        if a7 <= 2:
                                                            if a9 <= 4:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                    else:
                                                        if a16 <= 4:
                                                            if a4 <= 3:
                                                                return False
                                                            else:
                                                                if a22 <= 4:
                                                                    if a27 <= 4:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                        else:
                                                            if a26 <= 4:
                                                                if a15 <= 4:
                                                                    return True
                                                                else:
                                                                    if a16 <= 5:
                                                                        if a6 <= 6:
                                                                            if a4 <= 5:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                            else:
                                                                if a15 <= 4:
                                                                    return False
                                                                else:
                                                                    if a19 <= 4:
                                                                        if a6 <= 6:
                                                                            if a7 <= 2:
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
                                        if a9 <= 5:
                                            if a29 <= 4:
                                                if a10 <= 4:
                                                    if a13 <= 3:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                        else:
                                            if a4 <= 0:
                                                return False
                                            else:
                                                if a28 <= 5:
                                                    if a13 <= 4:
                                                        if a13 <= 3:
                                                            return False
                                                        else:
                                                            if a8 <= 4:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                        else:
                            if a26 <= 4:
                                if a27 <= 4:
                                    if a28 <= 3:
                                        return True
                                    else:
                                        if a22 <= 3:
                                            if a1 <= 0:
                                                if a13 <= 4:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if a3 <= 3:
                                                    return True
                                                else:
                                                    if a25 <= 4:
                                                        if a1 <= 1:
                                                            return False
                                                        else:
                                                            if a3 <= 4:
                                                                return True
                                                            else:
                                                                if a3 <= 5:
                                                                    if a5 <= 6:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return True
                                        else:
                                            if a24 <= 5:
                                                if a22 <= 4:
                                                    if a5 <= 4:
                                                        if a6 <= 3:
                                                            if a16 <= 4:
                                                                if a4 <= 6:
                                                                    return True
                                                                else:
                                                                    if a25 <= 4:
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if a6 <= 2:
                                                                    if a4 <= 5:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                    else:
                                                        if a23 <= 4:
                                                            if a6 <= 2:
                                                                if a16 <= 4:
                                                                    return True
                                                                else:
                                                                    if a4 <= 5:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if a7 <= 3:
                                                                    if a7 <= 2:
                                                                        if a25 <= 4:
                                                                            return False
                                                                        else:
                                                                            if a2 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if a6 <= 5:
                                                                            if a16 <= 5:
                                                                                if a4 <= 6:
                                                                                    if a19 <= 3:
                                                                                        if a9 <= 4:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if a4 <= 4:
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
                                                            return True
                                                else:
                                                    return False
                                            else:
                                                if a20 <= 3:
                                                    return False
                                                else:
                                                    if a24 <= 6:
                                                        if a7 <= 2:
                                                            return False
                                                        else:
                                                            if a1 <= 0:
                                                                return False
                                                            else:
                                                                if a12 <= 4:
                                                                    if a6 <= 4:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return False
                                else:
                                    if a1 <= 0:
                                        if a20 <= 2:
                                            return True
                                        else:
                                            if a24 <= 4:
                                                if a13 <= 4:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                    else:
                                        return True
                            else:
                                if a25 <= 4:
                                    if a24 <= 3:
                                        return True
                                    else:
                                        if a26 <= 5:
                                            if a5 <= 4:
                                                if a9 <= 2:
                                                    if a13 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if a24 <= 4:
                                                        if a7 <= 6:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                            else:
                                                if a6 <= 4:
                                                    if a19 <= 4:
                                                        return False
                                                    else:
                                                        if a22 <= 5:
                                                            if a4 <= 0:
                                                                return False
                                                            else:
                                                                if a24 <= 7:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                else:
                                                    if a9 <= 5:
                                                        if a4 <= 5:
                                                            if a13 <= 3:
                                                                return False
                                                            else:
                                                                if a19 <= 3:
                                                                    if a4 <= 3:
                                                                        if a7 <= 3:
                                                                            if a6 <= 5:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if a7 <= 3:
                                                                        return True
                                                                    else:
                                                                        if a23 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        if a16 <= 5:
                                                            return False
                                                        else:
                                                            if a12 <= 4:
                                                                return False
                                                            else:
                                                                if a25 <= 3:
                                                                    return False
                                                                else:
                                                                    if a23 <= 5:
                                                                        if a24 <= 6:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                        else:
                                            return False
                                else:
                                    if a19 <= 3:
                                        return True
                                    else:
                                        if a24 <= 4:
                                            if a24 <= 3:
                                                return True
                                            else:
                                                if a29 <= 4:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            if a5 <= 5:
                                                if a6 <= 2:
                                                    if a24 <= 6:
                                                        if a7 <= 3:
                                                            if a20 <= 3:
                                                                if a27 <= 4:
                                                                    return False
                                                                else:
                                                                    if a3 <= 5:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if a26 <= 5:
                                                                    return True
                                                                else:
                                                                    if a23 <= 4:
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
                                                if a6 <= 5:
                                                    if a4 <= 5:
                                                        if a4 <= 1:
                                                            if a9 <= 6:
                                                                if a2 <= 1:
                                                                    if a7 <= 2:
                                                                        return False
                                                                    else:
                                                                        if a7 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            if a7 <= 2:
                                                                if a2 <= 1:
                                                                    if a4 <= 4:
                                                                        if a4 <= 2:
                                                                            if a26 <= 5:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if a6 <= 4:
                                                                        return False
                                                                    else:
                                                                        if a8 <= 5:
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                if a19 <= 4:
                                                                    if a23 <= 4:
                                                                        return False
                                                                    else:
                                                                        if a26 <= 5:
                                                                            return True
                                                                        else:
                                                                            if a4 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return False
                                                else:
                                                    if a4 <= 2:
                                                        if a19 <= 4:
                                                            if a4 <= 1:
                                                                return False
                                                            else:
                                                                if a7 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            if a9 <= 6:
                                                                return True
                                                            else:
                                                                if a7 <= 6:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return True
                else:
                    if a0 <= 0:
                        if a13 <= 6:
                            if a19 <= 3:
                                if a23 <= 1:
                                    return False
                                else:
                                    if a15 <= 3:
                                        if a3 <= 0:
                                            if a1 <= 0:
                                                if a6 <= 2:
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
                                if a11 <= 4:
                                    if a23 <= 1:
                                        return False
                                    else:
                                        if a11 <= 2:
                                            if a9 <= 4:
                                                if a5 <= 3:
                                                    if a3 <= 0:
                                                        if a13 <= 5:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                if a1 <= 0:
                                                    if a6 <= 2:
                                                        if a12 <= 2:
                                                            return False
                                                        else:
                                                            if a6 <= 1:
                                                                if a3 <= 0:
                                                                    if a7 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if a9 <= 5:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                        else:
                                            if a23 <= 4:
                                                if a4 <= 6:
                                                    if a25 <= 6:
                                                        if a24 <= 2:
                                                            return True
                                                        else:
                                                            if a7 <= 5:
                                                                if a4 <= 5:
                                                                    if a13 <= 5:
                                                                        if a4 <= 4:
                                                                            if a2 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if a16 <= 5:
                                                                            if a22 <= 3:
                                                                                if a7 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if a5 <= 4:
                                                                                        if a3 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if a3 <= 2:
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
                                                    if a6 <= 5:
                                                        return False
                                                    else:
                                                        if a5 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                if a4 <= 2:
                                                    if a1 <= 0:
                                                        if a6 <= 2:
                                                            if a24 <= 6:
                                                                if a6 <= 1:
                                                                    return True
                                                                else:
                                                                    if a4 <= 1:
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
                                                    if a11 <= 3:
                                                        if a5 <= 3:
                                                            if a3 <= 0:
                                                                if a1 <= 0:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                    else:
                                                        if a23 <= 5:
                                                            if a29 <= 4:
                                                                return False
                                                            else:
                                                                if a9 <= 3:
                                                                    return True
                                                                else:
                                                                    if a25 <= 6:
                                                                        if a7 <= 3:
                                                                            return False
                                                                        else:
                                                                            if a4 <= 5:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return True
                                                        else:
                                                            if a5 <= 3:
                                                                if a1 <= 0:
                                                                    if a24 <= 0:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                else:
                                    if a25 <= 6:
                                        if a5 <= 6:
                                            if a6 <= 2:
                                                if a3 <= 6:
                                                    if a4 <= 5:
                                                        if a29 <= 4:
                                                            return False
                                                        else:
                                                            if a19 <= 4:
                                                                if a7 <= 3:
                                                                    return False
                                                                else:
                                                                    if a3 <= 5:
                                                                        if a5 <= 5:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if a4 <= 3:
                                                                    return False
                                                                else:
                                                                    if a26 <= 5:
                                                                        if a12 <= 5:
                                                                            return True
                                                                        else:
                                                                            if a6 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if a14 <= 5:
                                                                            return False
                                                                        else:
                                                                            if a6 <= 1:
                                                                                return True
                                                                            else:
                                                                                if a4 <= 4:
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
                                            if a6 <= 5:
                                                if a4 <= 5:
                                                    if a4 <= 1:
                                                        return False
                                                    else:
                                                        if a2 <= 1:
                                                            if a6 <= 1:
                                                                return True
                                                            else:
                                                                if a4 <= 4:
                                                                    if a3 <= 6:
                                                                        if a4 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if a7 <= 3:
                                                                if a6 <= 4:
                                                                    return False
                                                                else:
                                                                    if a3 <= 6:
                                                                        return False
                                                                    else:
                                                                        if a4 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                if a3 <= 6:
                                                                    return True
                                                                else:
                                                                    return False
                                                else:
                                                    return False
                                            else:
                                                if a4 <= 2:
                                                    if a19 <= 4:
                                                        return False
                                                    else:
                                                        if a4 <= 0:
                                                            return False
                                                        else:
                                                            if a6 <= 6:
                                                                if a7 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                else:
                                                    if a6 <= 6:
                                                        if a19 <= 4:
                                                            if a26 <= 5:
                                                                if a7 <= 2:
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
                            if a23 <= 1:
                                return False
                            else:
                                return True
                    else:
                        if a13 <= 2:
                            if a1 <= 0:
                                return False
                            else:
                                return True
                        else:
                            return True
            else:
                if a15 <= 4:
                    if a0 <= 0:
                        if a27 <= 3:
                            if a24 <= 0:
                                if a3 <= 0:
                                    if a13 <= 3:
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
                                    if a6 <= 3:
                                        if a24 <= 4:
                                            return True
                                        else:
                                            if a13 <= 4:
                                                return False
                                            else:
                                                return True
                                    else:
                                        if a16 <= 2:
                                            if a15 <= 3:
                                                if a3 <= 0:
                                                    if a6 <= 4:
                                                        if a23 <= 2:
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
                                            if a28 <= 2:
                                                if a25 <= 3:
                                                    return False
                                                else:
                                                    if a11 <= 0:
                                                        if a12 <= 3:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a9 <= 2:
                                                            if a10 <= 0:
                                                                if a5 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                        else:
                                                            if a6 <= 4:
                                                                return True
                                                            else:
                                                                return False
                                            else:
                                                return False
                                else:
                                    if a24 <= 4:
                                        return True
                                    else:
                                        if a3 <= 2:
                                            if a20 <= 0:
                                                if a5 <= 1:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                        else:
                                            if a29 <= 4:
                                                if a3 <= 4:
                                                    if a1 <= 2:
                                                        if a1 <= 1:
                                                            return False
                                                        else:
                                                            if a3 <= 3:
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
                                if a2 <= 4:
                                    if a25 <= 4:
                                        if a10 <= 3:
                                            if a3 <= 2:
                                                return True
                                            else:
                                                if a4 <= 3:
                                                    if a6 <= 6:
                                                        return False
                                                    else:
                                                        if a9 <= 4:
                                                            if a3 <= 3:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                else:
                                                    if a4 <= 6:
                                                        if a1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if a7 <= 3:
                                                            return False
                                                        else:
                                                            return True
                                        else:
                                            if a24 <= 4:
                                                if a6 <= 6:
                                                    return False
                                                else:
                                                    if a4 <= 4:
                                                        return False
                                                    else:
                                                        if a5 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                return False
                                    else:
                                        if a23 <= 2:
                                            return False
                                        else:
                                            return True
                                else:
                                    if a23 <= 2:
                                        return False
                                    else:
                                        return True
                    else:
                        if a13 <= 2:
                            if a1 <= 0:
                                if a6 <= 5:
                                    if a19 <= 1:
                                        if a5 <= 1:
                                            if a9 <= 0:
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
                            return True
                else:
                    if a9 <= 0:
                        if a13 <= 3:
                            if a3 <= 0:
                                if a6 <= 4:
                                    return True
                                else:
                                    if a0 <= 0:
                                        if a5 <= 0:
                                            return True
                                        else:
                                            return False
                                    else:
                                        if a6 <= 5:
                                            return True
                                        else:
                                            if a12 <= 2:
                                                return False
                                            else:
                                                return True
                            else:
                                return True
                        else:
                            return True
                    else:
                        return True
