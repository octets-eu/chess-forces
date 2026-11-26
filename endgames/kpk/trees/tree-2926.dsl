def wins() -> Bool:
    """Decision tree, 2926 leaves: scikit-learn DecisionTreeClassifier(max_leaf_nodes=None, criterion="entropy", random_state=0) on all positions, written by chess-forces trees. Learned, not a force program."""
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
    if x12 <= 2:
        if x0 <= 0:
            if x7 <= 2:
                if x12 <= 1:
                    if x7 <= 1:
                        if x4 <= 4:
                            if x9 <= 2:
                                if x11 <= 2:
                                    if x2 <= 3:
                                        if x10 <= 3:
                                            return True
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    if x4 <= 2:
                                        if x11 <= 5:
                                            if x4 <= 1:
                                                return False
                                            else:
                                                if x6 <= 3:
                                                    if x6 <= 2:
                                                        return True
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    return False
                                        else:
                                            if x4 <= 0:
                                                return False
                                            else:
                                                return True
                                    else:
                                        if x6 <= 3:
                                            return True
                                        else:
                                            if x10 <= 3:
                                                return True
                                            else:
                                                if x8 <= 1:
                                                    return False
                                                else:
                                                    return True
                            else:
                                return False
                        else:
                            if x4 <= 5:
                                if x2 <= 5:
                                    if x11 <= 0:
                                        return False
                                    else:
                                        if x1 <= 0:
                                            return False
                                        else:
                                            if x5 <= 0:
                                                if x6 <= 5:
                                                    return True
                                                else:
                                                    if x8 <= 1:
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
                                            if x11 <= 0:
                                                if x3 <= 0:
                                                    return True
                                                else:
                                                    if x3 <= 3:
                                                        if x1 <= 1:
                                                            if x3 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x3 <= 1:
                                                                return True
                                                            else:
                                                                if x3 <= 2:
                                                                    if x5 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x1 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                if x3 <= 0:
                                                    return False
                                                else:
                                                    if x3 <= 3:
                                                        if x3 <= 1:
                                                            if x1 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            if x1 <= 1:
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
                                                        return False
                            else:
                                if x8 <= 1:
                                    return True
                                else:
                                    if x5 <= 0:
                                        return False
                                    else:
                                        return True
                    else:
                        if x8 <= 1:
                            return False
                        else:
                            if x9 <= 2:
                                if x10 <= 1:
                                    if x5 <= 0:
                                        if x4 <= 6:
                                            return True
                                        else:
                                            return False
                                    else:
                                        return True
                                else:
                                    if x11 <= 1:
                                        return False
                                    else:
                                        if x10 <= 4:
                                            if x3 <= 4:
                                                if x5 <= 3:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x5 <= 0:
                                                            return True
                                                        else:
                                                            if x2 <= 2:
                                                                if x2 <= 1:
                                                                    if x1 <= 1:
                                                                        if x3 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x5 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 0:
                                                                                return False
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                else:
                                                                    if x4 <= 3:
                                                                        return False
                                                                    else:
                                                                        if x5 <= 1:
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
                                                                if x4 <= 4:
                                                                    return False
                                                                else:
                                                                    if x3 <= 0:
                                                                        if x1 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 1:
                                                                                return True
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
                                                return False
                                        else:
                                            return False
                            else:
                                return False
                else:
                    if x4 <= 2:
                        if x6 <= 2:
                            if x7 <= 1:
                                if x4 <= 0:
                                    if x11 <= 5:
                                        return False
                                    else:
                                        if x1 <= 0:
                                            if x11 <= 6:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return True
                                else:
                                    if x1 <= 0:
                                        if x11 <= 6:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                            else:
                                if x9 <= 3:
                                    if x4 <= 1:
                                        return False
                                    else:
                                        if x8 <= 1:
                                            return False
                                        else:
                                            return True
                                else:
                                    if x10 <= 6:
                                        if x2 <= 2:
                                            return True
                                        else:
                                            if x10 <= 5:
                                                return True
                                            else:
                                                return False
                                    else:
                                        if x2 <= 1:
                                            if x11 <= 5:
                                                return False
                                            else:
                                                return True
                                        else:
                                            return False
                        else:
                            if x11 <= 2:
                                if x2 <= 2:
                                    if x10 <= 5:
                                        if x9 <= 3:
                                            if x7 <= 1:
                                                if x5 <= 3:
                                                    if x3 <= 2:
                                                        if x5 <= 2:
                                                            return False
                                                        else:
                                                            if x3 <= 0:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x5 <= 1:
                                                            if x3 <= 3:
                                                                if x5 <= 0:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                else:
                                                    if x3 <= 2:
                                                        if x3 <= 1:
                                                            return True
                                                        else:
                                                            if x5 <= 4:
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
                                    return False
                            else:
                                if x10 <= 5:
                                    if x2 <= 3:
                                        if x11 <= 3:
                                            if x2 <= 2:
                                                if x1 <= 0:
                                                    return False
                                                else:
                                                    if x9 <= 3:
                                                        if x7 <= 1:
                                                            if x9 <= 2:
                                                                if x8 <= 2:
                                                                    return False
                                                                else:
                                                                    if x3 <= 0:
                                                                        if x5 <= 0:
                                                                            return True
                                                                        else:
                                                                            if x5 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if x5 <= 3:
                                                                            if x3 <= 2:
                                                                                if x1 <= 2:
                                                                                    if x1 <= 1:
                                                                                        if x3 <= 1:
                                                                                            if x5 <= 0:
                                                                                                return False
                                                                                            else:
                                                                                                if x5 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                        else:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x5 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x5 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                    else:
                                                                                        if x3 <= 1:
                                                                                            if x5 <= 0:
                                                                                                return False
                                                                                            else:
                                                                                                if x5 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                        else:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x5 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x5 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                else:
                                                                                    if x5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 2:
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
                                                                            if x3 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x1 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if x3 <= 3:
                                                                                        if x5 <= 4:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x5 <= 4:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x2 <= 1:
                                                                if x9 <= 2:
                                                                    if x5 <= 0:
                                                                        return True
                                                                    else:
                                                                        if x5 <= 4:
                                                                            if x3 <= 0:
                                                                                return False
                                                                            else:
                                                                                if x3 <= 4:
                                                                                    if x5 <= 3:
                                                                                        if x3 <= 3:
                                                                                            if x5 <= 1:
                                                                                                if x1 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x5 <= 2:
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
                                                                return False
                                                    else:
                                                        return True
                                            else:
                                                return False
                                        else:
                                            if x1 <= 0:
                                                return False
                                            else:
                                                return True
                                    else:
                                        return False
                                else:
                                    if x2 <= 1:
                                        if x10 <= 6:
                                            if x9 <= 3:
                                                if x7 <= 1:
                                                    if x9 <= 2:
                                                        return False
                                                    else:
                                                        if x11 <= 3:
                                                            if x5 <= 3:
                                                                if x3 <= 2:
                                                                    if x3 <= 0:
                                                                        if x5 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x5 <= 1:
                                                                        if x1 <= 2:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x3 <= 2:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x5 <= 4:
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
                                        return False
                    else:
                        if x7 <= 1:
                            if x8 <= 2:
                                if x1 <= 0:
                                    if x8 <= 1:
                                        if x10 <= 0:
                                            if x5 <= 0:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return True
                                    else:
                                        if x6 <= 2:
                                            if x6 <= 1:
                                                return True
                                            else:
                                                if x2 <= 2:
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
                                                    if x2 <= 5:
                                                        if x11 <= 2:
                                                            return False
                                                        else:
                                                            if x10 <= 1:
                                                                return True
                                                            else:
                                                                if x11 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return True
                                else:
                                    if x6 <= 4:
                                        return True
                                    else:
                                        if x4 <= 3:
                                            if x2 <= 3:
                                                if x9 <= 2:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                        else:
                                            if x9 <= 2:
                                                if x6 <= 5:
                                                    return True
                                                else:
                                                    if x10 <= 1:
                                                        return True
                                                    else:
                                                        if x2 <= 5:
                                                            if x6 <= 6:
                                                                if x2 <= 4:
                                                                    if x10 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                        else:
                                                            if x3 <= 1:
                                                                if x1 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                            else:
                                                return True
                            else:
                                if x10 <= 2:
                                    if x1 <= 0:
                                        return False
                                    else:
                                        return True
                                else:
                                    if x9 <= 3:
                                        if x1 <= 0:
                                            return False
                                        else:
                                            if x11 <= 1:
                                                if x9 <= 2:
                                                    if x5 <= 0:
                                                        if x3 <= 0:
                                                            return True
                                                        else:
                                                            if x3 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if x3 <= 3:
                                                            if x3 <= 1:
                                                                if x5 <= 2:
                                                                    if x5 <= 1:
                                                                        if x3 <= 0:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x3 <= 0:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x5 <= 1:
                                                                    if x3 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x1 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x3 <= 2:
                                                                            if x5 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                        else:
                                                            if x5 <= 2:
                                                                return True
                                                            else:
                                                                if x5 <= 3:
                                                                    return False
                                                                else:
                                                                    return True
                                                else:
                                                    return False
                                            else:
                                                if x3 <= 0:
                                                    if x5 <= 1:
                                                        if x5 <= 0:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    if x1 <= 1:
                                                        if x9 <= 2:
                                                            if x3 <= 1:
                                                                if x5 <= 2:
                                                                    if x5 <= 0:
                                                                        return False
                                                                    else:
                                                                        if x5 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x5 <= 2:
                                                                    if x5 <= 0:
                                                                        return True
                                                                    else:
                                                                        if x5 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return False
                                                    else:
                                                        if x9 <= 2:
                                                            if x3 <= 1:
                                                                if x5 <= 0:
                                                                    return False
                                                                else:
                                                                    if x5 <= 1:
                                                                        return True
                                                                    else:
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
                                                                            if x4 <= 3:
                                                                                if x3 <= 2:
                                                                                    if x5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            if x5 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                else:
                                                                                    if x5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if x5 <= 3:
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
                                                                                    if x5 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x5 <= 4:
                                                                            if x5 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            return False
                                                        else:
                                                            if x6 <= 5:
                                                                return True
                                                            else:
                                                                if x10 <= 3:
                                                                    if x6 <= 6:
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
                                                                    if x1 <= 2:
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
                            if x8 <= 1:
                                return False
                            else:
                                if x11 <= 2:
                                    if x10 <= 2:
                                        if x11 <= 1:
                                            if x10 <= 1:
                                                return True
                                            else:
                                                if x2 <= 3:
                                                    if x9 <= 2:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            if x3 <= 4:
                                                                if x5 <= 0:
                                                                    return True
                                                                else:
                                                                    if x5 <= 3:
                                                                        if x1 <= 1:
                                                                            if x3 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if x3 <= 0:
                                                                                return False
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        if x1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x1 <= 2:
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
                                            if x1 <= 0:
                                                if x2 <= 5:
                                                    if x3 <= 0:
                                                        return False
                                                    else:
                                                        if x10 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    return True
                                            else:
                                                if x9 <= 2:
                                                    if x10 <= 1:
                                                        return True
                                                    else:
                                                        if x4 <= 6:
                                                            if x3 <= 0:
                                                                if x2 <= 5:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x2 <= 5:
                                                                return False
                                                            else:
                                                                return True
                                                else:
                                                    return True
                                    else:
                                        if x10 <= 3:
                                            if x2 <= 5:
                                                if x11 <= 1:
                                                    return False
                                                else:
                                                    if x9 <= 3:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            if x2 <= 4:
                                                                if x2 <= 3:
                                                                    if x6 <= 5:
                                                                        if x3 <= 4:
                                                                            if x5 <= 4:
                                                                                if x9 <= 2:
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
                                                                                                if x1 <= 1:
                                                                                                    if x5 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x5 <= 1:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x5 <= 2:
                                                                                                            if x1 <= 2:
                                                                                                                return False
                                                                                                            else:
                                                                                                                return True
                                                                                                        else:
                                                                                                            if x1 <= 2:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
                                                                                        else:
                                                                                            return True
                                                                                else:
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
                                                                    return False
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                            else:
                                                return False
                                        else:
                                            if x2 <= 3:
                                                if x9 <= 3:
                                                    if x2 <= 2:
                                                        if x5 <= 4:
                                                            if x9 <= 2:
                                                                if x1 <= 0:
                                                                    return False
                                                                else:
                                                                    if x5 <= 0:
                                                                        return True
                                                                    else:
                                                                        if x3 <= 0:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 4:
                                                                                if x5 <= 3:
                                                                                    if x3 <= 3:
                                                                                        if x5 <= 1:
                                                                                            if x3 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                if x5 <= 2:
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
                                                    return True
                                            else:
                                                return False
                                else:
                                    if x9 <= 3:
                                        if x10 <= 1:
                                            if x3 <= 0:
                                                if x1 <= 0:
                                                    if x11 <= 3:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                return True
                                        else:
                                            if x2 <= 3:
                                                if x1 <= 0:
                                                    if x6 <= 1:
                                                        if x10 <= 3:
                                                            if x3 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        if x10 <= 3:
                                                            if x6 <= 2:
                                                                if x2 <= 2:
                                                                    if x3 <= 0:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x4 <= 4:
                                                                            return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                if x3 <= 0:
                                                                    return False
                                                                else:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        return False
                                                        else:
                                                            return False
                                                else:
                                                    if x3 <= 4:
                                                        if x8 <= 2:
                                                            if x10 <= 3:
                                                                if x6 <= 3:
                                                                    if x5 <= 4:
                                                                        if x3 <= 0:
                                                                            if x5 <= 1:
                                                                                if x9 <= 2:
                                                                                    if x11 <= 4:
                                                                                        return False
                                                                                    else:
                                                                                        if x2 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 2:
                                                                                    if x1 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        if x3 <= 1:
                                                                                            if x9 <= 2:
                                                                                                if x2 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x10 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            return True
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 3:
                                                                                            if x2 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                if x10 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            if x3 <= 3:
                                                                                                return True
                                                                                            else:
                                                                                                if x4 <= 4:
                                                                                                    if x2 <= 2:
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
                                                            if x5 <= 4:
                                                                if x9 <= 2:
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
                                                                                if x1 <= 1:
                                                                                    if x3 <= 2:
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
                                                                                if x5 <= 2:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                            else:
                                                                return True
                                                    else:
                                                        if x11 <= 4:
                                                            return False
                                                        else:
                                                            if x10 <= 3:
                                                                if x2 <= 2:
                                                                    return False
                                                                else:
                                                                    if x4 <= 4:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return True
                                            else:
                                                if x9 <= 2:
                                                    if x11 <= 3:
                                                        if x4 <= 4:
                                                            return False
                                                        else:
                                                            if x2 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                    else:
                                        if x2 <= 4:
                                            return True
                                        else:
                                            if x4 <= 3:
                                                return False
                                            else:
                                                return True
            else:
                if x11 <= 6:
                    if x10 <= 3:
                        if x12 <= 1:
                            return False
                        else:
                            if x4 <= 5:
                                if x2 <= 1:
                                    if x6 <= 1:
                                        return True
                                    else:
                                        if x7 <= 3:
                                            if x9 <= 4:
                                                if x11 <= 3:
                                                    if x3 <= 4:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            if x5 <= 4:
                                                                if x9 <= 2:
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
                                                                                if x1 <= 1:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            if x1 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    if x1 <= 1:
                                                                        if x3 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x5 <= 0:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 0:
                                                                                if x9 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                            else:
                                                                return True
                                                    else:
                                                        if x5 <= 1:
                                                            if x1 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                else:
                                                    if x9 <= 2:
                                                        if x3 <= 0:
                                                            if x5 <= 0:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            if x3 <= 2:
                                                                return True
                                                            else:
                                                                if x1 <= 0:
                                                                    return False
                                                                else:
                                                                    if x3 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 4:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 5:
                                                                                    if x5 <= 4:
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
                                    if x10 <= 2:
                                        if x11 <= 3:
                                            if x1 <= 0:
                                                return False
                                            else:
                                                if x8 <= 2:
                                                    return True
                                                else:
                                                    if x9 <= 3:
                                                        if x3 <= 4:
                                                            if x5 <= 4:
                                                                if x9 <= 2:
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
                                                                                if x1 <= 1:
                                                                                    if x5 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x5 <= 1:
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
                                                                            return True
                                                                else:
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
                                                            return False
                                                    else:
                                                        return True
                                        else:
                                            return False
                                    else:
                                        return False
                            else:
                                if x11 <= 2:
                                    if x7 <= 3:
                                        if x10 <= 2:
                                            if x10 <= 1:
                                                if x6 <= 5:
                                                    if x2 <= 3:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return False
                                                else:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                if x9 <= 3:
                                                    return False
                                                else:
                                                    if x6 <= 5:
                                                        if x2 <= 3:
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
                        if x6 <= 1:
                            if x7 <= 3:
                                if x8 <= 1:
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
                    if x8 <= 1:
                        return False
                    else:
                        return True
        else:
            if x11 <= 5:
                if x12 <= 1:
                    if x7 <= 2:
                        if x4 <= 3:
                            if x11 <= 2:
                                if x2 <= 3:
                                    if x4 <= 2:
                                        return False
                                    else:
                                        if x9 <= 2:
                                            if x7 <= 1:
                                                if x1 <= 0:
                                                    return False
                                                else:
                                                    if x5 <= 0:
                                                        if x3 <= 1:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        if x3 <= 0:
                                                            if x5 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x1 <= 1:
                                                                return False
                                                            else:
                                                                if x5 <= 1:
                                                                    if x3 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x3 <= 2:
                                                                        if x5 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x1 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        if x5 <= 2:
                                                                            if x3 <= 3:
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
                                if x4 <= 1:
                                    if x10 <= 6:
                                        if x11 <= 4:
                                            if x2 <= 1:
                                                if x9 <= 2:
                                                    if x7 <= 1:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            if x5 <= 0:
                                                                if x3 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x5 <= 3:
                                                                    if x3 <= 1:
                                                                        if x5 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x1 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        if x3 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 2:
                                                                                if x5 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
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
                                                    return True
                                            else:
                                                return False
                                        else:
                                            if x2 <= 1:
                                                return False
                                            else:
                                                return True
                                    else:
                                        return False
                                else:
                                    if x12 <= 0:
                                        return False
                                    else:
                                        if x6 <= 3:
                                            if x8 <= 1:
                                                return True
                                            else:
                                                if x9 <= 2:
                                                    if x7 <= 1:
                                                        return True
                                                    else:
                                                        if x10 <= 4:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                if x3 <= 4:
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
                                                                                if x1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if x5 <= 1:
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
                                                            return False
                                                else:
                                                    return True
                                        else:
                                            if x4 <= 2:
                                                if x2 <= 3:
                                                    if x9 <= 2:
                                                        if x7 <= 1:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                if x5 <= 0:
                                                                    if x3 <= 1:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x5 <= 3:
                                                                        if x3 <= 1:
                                                                            if x5 <= 1:
                                                                                return False
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    if x1 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if x3 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    if x5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
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
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if x7 <= 1:
                                                    return True
                                                else:
                                                    if x9 <= 2:
                                                        return False
                                                    else:
                                                        return True
                        else:
                            if x12 <= 0:
                                if x2 <= 5:
                                    return False
                                else:
                                    if x1 <= 0:
                                        return False
                                    else:
                                        if x4 <= 6:
                                            if x7 <= 1:
                                                if x3 <= 0:
                                                    return False
                                                else:
                                                    if x3 <= 3:
                                                        if x1 <= 1:
                                                            if x3 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            if x3 <= 1:
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
                                                        return False
                                            else:
                                                return True
                                        else:
                                            return False
                            else:
                                if x10 <= 1:
                                    if x1 <= 0:
                                        if x10 <= 0:
                                            return False
                                        else:
                                            return True
                                    else:
                                        return True
                                else:
                                    if x9 <= 2:
                                        if x11 <= 1:
                                            if x7 <= 1:
                                                if x4 <= 4:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x5 <= 0:
                                                            if x3 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x5 <= 3:
                                                                if x3 <= 1:
                                                                    if x5 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if x3 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x5 <= 2:
                                                                            if x1 <= 2:
                                                                                if x5 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                if x3 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                else:
                                                    if x6 <= 6:
                                                        return True
                                                    else:
                                                        if x5 <= 0:
                                                            return False
                                                        else:
                                                            if x11 <= 0:
                                                                return True
                                                            else:
                                                                if x3 <= 0:
                                                                    return True
                                                                else:
                                                                    if x1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x5 <= 1:
                                                                            if x3 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x3 <= 1:
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
                                                if x6 <= 6:
                                                    return False
                                                else:
                                                    if x11 <= 0:
                                                        return False
                                                    else:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                        else:
                                            if x7 <= 1:
                                                return True
                                            else:
                                                if x11 <= 3:
                                                    if x4 <= 5:
                                                        if x5 <= 3:
                                                            if x3 <= 4:
                                                                if x1 <= 0:
                                                                    return False
                                                                else:
                                                                    if x5 <= 0:
                                                                        return True
                                                                    else:
                                                                        if x6 <= 4:
                                                                            if x3 <= 0:
                                                                                if x1 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if x5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            if x1 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x1 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                        else:
                                                                            if x10 <= 2:
                                                                                if x5 <= 1:
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
                                                                                                if x3 <= 2:
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
                                                    if x3 <= 4:
                                                        if x5 <= 0:
                                                            return True
                                                        else:
                                                            if x5 <= 3:
                                                                if x3 <= 3:
                                                                    if x5 <= 2:
                                                                        if x3 <= 2:
                                                                            if x1 <= 1:
                                                                                if x3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                if x3 <= 1:
                                                                                    if x3 <= 0:
                                                                                        return False
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if x1 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
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
                                        if x11 <= 0:
                                            return False
                                        else:
                                            if x1 <= 0:
                                                return False
                                            else:
                                                if x2 <= 5:
                                                    if x4 <= 6:
                                                        return True
                                                    else:
                                                        if x1 <= 1:
                                                            if x11 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                                else:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        return False
                    else:
                        if x10 <= 3:
                            if x8 <= 1:
                                return False
                            else:
                                if x7 <= 3:
                                    if x10 <= 2:
                                        if x9 <= 2:
                                            if x10 <= 1:
                                                return True
                                            else:
                                                if x6 <= 4:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x3 <= 4:
                                                            if x5 <= 0:
                                                                return True
                                                            else:
                                                                if x5 <= 3:
                                                                    if x1 <= 1:
                                                                        if x3 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x3 <= 0:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 1:
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
                                                    return False
                                        else:
                                            return True
                                    else:
                                        if x2 <= 1:
                                            if x9 <= 3:
                                                if x1 <= 0:
                                                    return False
                                                else:
                                                    if x5 <= 0:
                                                        return True
                                                    else:
                                                        if x3 <= 5:
                                                            if x5 <= 3:
                                                                if x9 <= 2:
                                                                    if x3 <= 4:
                                                                        if x5 <= 1:
                                                                            if x1 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x1 <= 1:
                                                                                if x3 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x3 <= 0:
                                                                                    return False
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        if x1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x1 <= 1:
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
                    if x8 <= 1:
                        return True
                    else:
                        if x2 <= 5:
                            if x7 <= 3:
                                if x4 <= 2:
                                    if x6 <= 4:
                                        if x10 <= 6:
                                            if x6 <= 3:
                                                if x9 <= 2:
                                                    if x2 <= 3:
                                                        if x7 <= 2:
                                                            if x1 <= 0:
                                                                if x6 <= 2:
                                                                    if x2 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                            else:
                                                                if x4 <= 1:
                                                                    if x11 <= 4:
                                                                        if x3 <= 0:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 3:
                                                                                if x2 <= 2:
                                                                                    if x7 <= 1:
                                                                                        if x2 <= 1:
                                                                                            return True
                                                                                        else:
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
                                                                                    if x5 <= 3:
                                                                                        if x5 <= 0:
                                                                                            return True
                                                                                        else:
                                                                                            if x3 <= 1:
                                                                                                if x1 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                            else:
                                                                                if x1 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if x3 <= 4:
                                                                                        if x7 <= 1:
                                                                                            if x2 <= 1:
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
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                if x2 <= 4:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x7 <= 1:
                                                            if x9 <= 2:
                                                                if x2 <= 2:
                                                                    if x2 <= 1:
                                                                        if x5 <= 4:
                                                                            if x5 <= 0:
                                                                                if x3 <= 0:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    return True
                                                                                                else:
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
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                        else:
                                                                            return True
                                                                    else:
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
                                                                            return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x8 <= 2:
                                                                    if x4 <= 1:
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
                                                                    return True
                                                        else:
                                                            if x9 <= 3:
                                                                if x2 <= 1:
                                                                    if x7 <= 2:
                                                                        if x9 <= 2:
                                                                            if x5 <= 0:
                                                                                return False
                                                                            else:
                                                                                if x5 <= 4:
                                                                                    if x3 <= 0:
                                                                                        if x5 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x5 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                if x3 <= 3:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    if x3 <= 4:
                                                                                                        if x5 <= 3:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                                                    else:
                                                                                                        if x5 <= 3:
                                                                                                            return False
                                                                                                        else:
                                                                                                            return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x5 <= 3:
                                                                                if x10 <= 5:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if x5 <= 1:
                                                                                            if x1 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x1 <= 1:
                                                                                                return True
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
                                                                        if x5 <= 4:
                                                                            if x3 <= 5:
                                                                                if x5 <= 3:
                                                                                    if x3 <= 4:
                                                                                        if x5 <= 1:
                                                                                            if x3 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                if x1 <= 2:
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
                                                                    if x4 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x2 <= 3:
                                                                            return False
                                                                        else:
                                                                            if x7 <= 2:
                                                                                if x9 <= 2:
                                                                                    if x3 <= 0:
                                                                                        return False
                                                                                    else:
                                                                                        if x3 <= 4:
                                                                                            if x5 <= 0:
                                                                                                return True
                                                                                            else:
                                                                                                if x5 <= 4:
                                                                                                    if x3 <= 3:
                                                                                                        if x5 <= 3:
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
                                                                if x10 <= 5:
                                                                    if x8 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x7 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x9 <= 4:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if x2 <= 2:
                                                                        if x7 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x9 <= 4:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        return False
                                                else:
                                                    return True
                                        else:
                                            if x11 <= 4:
                                                if x2 <= 1:
                                                    if x9 <= 4:
                                                        if x7 <= 2:
                                                            if x8 <= 2:
                                                                if x9 <= 3:
                                                                    if x7 <= 1:
                                                                        if x1 <= 0:
                                                                            return False
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
                                                                                                    if x5 <= 3:
                                                                                                        return True
                                                                                                    else:
                                                                                                        if x3 <= 3:
                                                                                                            return True
                                                                                                        else:
                                                                                                            return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x5 <= 3:
                                                                    if x3 <= 2:
                                                                        if x5 <= 2:
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
                                                                            if x1 <= 1:
                                                                                if x3 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x5 <= 1:
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
                                                                            return False
                                                                else:
                                                                    if x3 <= 3:
                                                                        if x5 <= 4:
                                                                            if x1 <= 2:
                                                                                if x3 <= 2:
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
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if x9 <= 2:
                                                    if x2 <= 2:
                                                        if x7 <= 2:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                if x3 <= 3:
                                                                    if x3 <= 0:
                                                                        return False
                                                                    else:
                                                                        if x2 <= 1:
                                                                            if x7 <= 1:
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
                                                                            if x5 <= 3:
                                                                                if x5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x3 <= 1:
                                                                                        if x1 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x3 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    if x2 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 4:
                                                                            if x1 <= 2:
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
                                        if x7 <= 1:
                                            if x9 <= 3:
                                                if x1 <= 0:
                                                    return False
                                                else:
                                                    if x8 <= 2:
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
                                                        return True
                                            else:
                                                if x11 <= 1:
                                                    return False
                                                else:
                                                    if x10 <= 5:
                                                        if x1 <= 0:
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
                                                        if x5 <= 3:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                if x5 <= 1:
                                                                    if x3 <= 2:
                                                                        if x5 <= 0:
                                                                            if x3 <= 1:
                                                                                return False
                                                                            else:
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
                                                            if x3 <= 2:
                                                                if x1 <= 2:
                                                                    return True
                                                                else:
                                                                    if x5 <= 4:
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if x5 <= 4:
                                                                    return False
                                                                else:
                                                                    if x3 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                        else:
                                            if x2 <= 3:
                                                if x4 <= 1:
                                                    if x2 <= 2:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            if x9 <= 4:
                                                                if x7 <= 2:
                                                                    if x1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x5 <= 0:
                                                                            if x3 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 3:
                                                                                if x3 <= 4:
                                                                                    return False
                                                                                else:
                                                                                    if x5 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                if x3 <= 2:
                                                                                    if x5 <= 4:
                                                                                        if x1 <= 2:
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
                                                    if x11 <= 1:
                                                        return False
                                                    else:
                                                        if x9 <= 4:
                                                            if x7 <= 2:
                                                                if x1 <= 0:
                                                                    return False
                                                                else:
                                                                    if x2 <= 2:
                                                                        if x5 <= 3:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x9 <= 3:
                                                                                    if x5 <= 1:
                                                                                        if x1 <= 1:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x1 <= 1:
                                                                                            return True
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
                                                                            return True
                                                                    else:
                                                                        if x9 <= 3:
                                                                            return False
                                                                        else:
                                                                            if x6 <= 5:
                                                                                return True
                                                                            else:
                                                                                if x1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if x5 <= 0:
                                                                                        if x3 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x3 <= 0:
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
                                                                if x2 <= 2:
                                                                    if x5 <= 4:
                                                                        if x9 <= 3:
                                                                            if x1 <= 0:
                                                                                return False
                                                                            else:
                                                                                if x3 <= 5:
                                                                                    if x5 <= 3:
                                                                                        if x3 <= 4:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x1 <= 2:
                                                                                                    if x5 <= 2:
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
                                    if x8 <= 2:
                                        if x1 <= 0:
                                            if x6 <= 4:
                                                if x2 <= 3:
                                                    if x11 <= 4:
                                                        if x10 <= 2:
                                                            if x11 <= 3:
                                                                if x3 <= 0:
                                                                    return False
                                                                else:
                                                                    if x10 <= 1:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x2 <= 2:
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
                                                            if x7 <= 1:
                                                                if x2 <= 2:
                                                                    return False
                                                                else:
                                                                    if x11 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x3 <= 2:
                                                            return True
                                                        else:
                                                            if x2 <= 2:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                else:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        if x11 <= 3:
                                                            if x2 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                            else:
                                                if x10 <= 2:
                                                    if x3 <= 0:
                                                        if x2 <= 4:
                                                            return False
                                                        else:
                                                            if x6 <= 5:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x7 <= 2:
                                                            return True
                                                        else:
                                                            if x10 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    return False
                                        else:
                                            if x9 <= 3:
                                                if x7 <= 2:
                                                    if x10 <= 3:
                                                        return True
                                                    else:
                                                        if x11 <= 2:
                                                            if x2 <= 4:
                                                                if x7 <= 1:
                                                                    if x2 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x9 <= 2:
                                                                            if x3 <= 3:
                                                                                if x5 <= 4:
                                                                                    if x3 <= 1:
                                                                                        if x1 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x5 <= 0:
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
                                                                            if x6 <= 5:
                                                                                return True
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
                                                                                                            if x5 <= 2:
                                                                                                                return True
                                                                                                            else:
                                                                                                                return False
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
                                                                if x9 <= 2:
                                                                    if x3 <= 0:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 4:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 4:
                                                                                    if x3 <= 3:
                                                                                        if x5 <= 3:
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
                                                            return True
                                                else:
                                                    if x10 <= 1:
                                                        return True
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x9 <= 2:
                                                                if x4 <= 6:
                                                                    if x4 <= 3:
                                                                        return False
                                                                    else:
                                                                        if x2 <= 4:
                                                                            if x4 <= 5:
                                                                                if x10 <= 2:
                                                                                    if x11 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        if x3 <= 0:
                                                                                            return False
                                                                                        else:
                                                                                            if x3 <= 4:
                                                                                                if x5 <= 0:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 4:
                                                                                                        if x3 <= 3:
                                                                                                            if x5 <= 3:
                                                                                                                if x3 <= 1:
                                                                                                                    if x1 <= 2:
                                                                                                                        return True
                                                                                                                    else:
                                                                                                                        return False
                                                                                                                else:
                                                                                                                    if x1 <= 2:
                                                                                                                        if x3 <= 2:
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
                                                                                    if x2 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x11 <= 3:
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
                                                                    return False
                                                            else:
                                                                if x10 <= 2:
                                                                    return True
                                                                else:
                                                                    if x2 <= 4:
                                                                        if x11 <= 3:
                                                                            return False
                                                                        else:
                                                                            if x2 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x11 <= 4:
                                                                                    if x2 <= 3:
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
                                        if x1 <= 0:
                                            return False
                                        else:
                                            if x10 <= 2:
                                                if x9 <= 2:
                                                    if x2 <= 3:
                                                        if x10 <= 1:
                                                            return True
                                                        else:
                                                            if x4 <= 5:
                                                                if x5 <= 3:
                                                                    if x5 <= 0:
                                                                        return True
                                                                    else:
                                                                        if x3 <= 4:
                                                                            if x11 <= 1:
                                                                                if x5 <= 1:
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
                                                                                if x7 <= 2:
                                                                                    return True
                                                                                else:
                                                                                    if x3 <= 0:
                                                                                        if x1 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x3 <= 3:
                                                                                            if x1 <= 1:
                                                                                                if x5 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x1 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x3 <= 2:
                                                                                                        return False
                                                                                                    else:
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
                                                                return False
                                                    else:
                                                        if x4 <= 6:
                                                            return True
                                                        else:
                                                            if x10 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    return True
                                            else:
                                                if x7 <= 2:
                                                    if x9 <= 3:
                                                        if x9 <= 2:
                                                            if x7 <= 1:
                                                                if x5 <= 4:
                                                                    if x11 <= 1:
                                                                        if x1 <= 1:
                                                                            if x5 <= 0:
                                                                                if x3 <= 0:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 0:
                                                                                    return True
                                                                                else:
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
                                                                            if x5 <= 1:
                                                                                if x3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 1:
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
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return True
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
                                                                            if x5 <= 0:
                                                                                if x3 <= 0:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    return True
                                                                                                else:
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
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if x3 <= 3:
                                                                    if x5 <= 3:
                                                                        if x6 <= 5:
                                                                            if x5 <= 0:
                                                                                if x3 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x1 <= 2:
                                                                                    if x5 <= 2:
                                                                                        if x11 <= 2:
                                                                                            if x3 <= 1:
                                                                                                if x1 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    if x5 <= 1:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                            else:
                                                                                                if x5 <= 1:
                                                                                                    if x1 <= 1:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    return True
                                                                                        else:
                                                                                            if x5 <= 1:
                                                                                                if x1 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x1 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                    else:
                                                                                        if x3 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                else:
                                                                                    if x5 <= 2:
                                                                                        if x3 <= 2:
                                                                                            if x5 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            if x11 <= 1:
                                                                                if x5 <= 2:
                                                                                    if x1 <= 2:
                                                                                        if x1 <= 1:
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
                                                                                    return False
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x5 <= 4:
                                                                        if x1 <= 2:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x3 <= 4:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        return False
                                                        else:
                                                            if x10 <= 3:
                                                                return True
                                                            else:
                                                                if x11 <= 1:
                                                                    if x7 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x5 <= 3:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x1 <= 2:
                                                                                    if x5 <= 2:
                                                                                        if x5 <= 1:
                                                                                            if x1 <= 1:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x1 <= 1:
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
                                                                    return True
                                                    else:
                                                        if x11 <= 1:
                                                            return False
                                                        else:
                                                            if x2 <= 3:
                                                                return True
                                                            else:
                                                                if x10 <= 3:
                                                                    return True
                                                                else:
                                                                    if x7 <= 1:
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
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 0:
                                                                                if x3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 0:
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
                                                    if x11 <= 1:
                                                        return False
                                                    else:
                                                        if x9 <= 4:
                                                            if x2 <= 2:
                                                                if x11 <= 2:
                                                                    if x9 <= 2:
                                                                        if x4 <= 3:
                                                                            if x5 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if x5 <= 4:
                                                                                        if x3 <= 4:
                                                                                            return True
                                                                                        else:
                                                                                            if x1 <= 2:
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
                                                                    if x4 <= 3:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 3:
                                                                            if x3 <= 0:
                                                                                if x1 <= 2:
                                                                                    if x9 <= 2:
                                                                                        if x1 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                            else:
                                                                                if x5 <= 3:
                                                                                    if x5 <= 0:
                                                                                        return True
                                                                                    else:
                                                                                        if x1 <= 1:
                                                                                            if x5 <= 2:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                if x1 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                return True
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                if x1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    if x3 <= 5:
                                                                                        if x1 <= 2:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 4:
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
                                                                if x9 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                            else:
                                if x11 <= 2:
                                    if x10 <= 3:
                                        if x7 <= 4:
                                            if x10 <= 1:
                                                if x1 <= 0:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                if x9 <= 2:
                                                    return False
                                                else:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        if x9 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                        else:
                                            return False
                                    else:
                                        return False
                                else:
                                    if x2 <= 2:
                                        if x7 <= 4:
                                            if x10 <= 3:
                                                if x4 <= 5:
                                                    if x11 <= 4:
                                                        if x10 <= 2:
                                                            if x9 <= 2:
                                                                if x1 <= 0:
                                                                    if x11 <= 3:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 0:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    if x3 <= 4:
                                                                        if x3 <= 0:
                                                                            if x1 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 4:
                                                                                    if x3 <= 3:
                                                                                        if x5 <= 3:
                                                                                            if x1 <= 1:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    if x1 <= 2:
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
                                                                                            return True
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x9 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                                else:
                                                    if x11 <= 3:
                                                        if x9 <= 2:
                                                            if x10 <= 1:
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
                                            return False
                                    else:
                                        if x2 <= 4:
                                            if x6 <= 3:
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
                            if x10 <= 0:
                                if x3 <= 0:
                                    if x6 <= 5:
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
        if x11 <= 3:
            if x2 <= 5:
                if x10 <= 4:
                    if x7 <= 3:
                        if x1 <= 0:
                            if x8 <= 3:
                                if x0 <= 0:
                                    if x10 <= 2:
                                        if x3 <= 0:
                                            if x6 <= 4:
                                                if x2 <= 4:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                        else:
                                            if x10 <= 1:
                                                return True
                                            else:
                                                if x2 <= 4:
                                                    if x6 <= 5:
                                                        if x4 <= 5:
                                                            return True
                                                        else:
                                                            if x7 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                    else:
                                        if x6 <= 4:
                                            if x9 <= 2:
                                                if x4 <= 3:
                                                    return False
                                                else:
                                                    if x3 <= 2:
                                                        return True
                                                    else:
                                                        if x2 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                return False
                                        else:
                                            return False
                                else:
                                    if x10 <= 2:
                                        return True
                                    else:
                                        if x2 <= 4:
                                            if x6 <= 4:
                                                if x3 <= 2:
                                                    return True
                                                else:
                                                    if x2 <= 3:
                                                        return False
                                                    else:
                                                        return True
                                            else:
                                                if x4 <= 3:
                                                    return False
                                                else:
                                                    if x6 <= 5:
                                                        if x4 <= 5:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                        else:
                                            return True
                            else:
                                if x5 <= 2:
                                    return False
                                else:
                                    if x10 <= 2:
                                        if x0 <= 0:
                                            if x4 <= 5:
                                                return False
                                            else:
                                                if x9 <= 2:
                                                    return True
                                                else:
                                                    return False
                                        else:
                                            return True
                                    else:
                                        if x6 <= 5:
                                            if x4 <= 3:
                                                return False
                                            else:
                                                if x0 <= 0:
                                                    return False
                                                else:
                                                    return True
                                        else:
                                            return False
                        else:
                            if x11 <= 2:
                                if x8 <= 4:
                                    if x0 <= 0:
                                        if x9 <= 2:
                                            if x3 <= 4:
                                                if x5 <= 3:
                                                    if x7 <= 2:
                                                        if x5 <= 0:
                                                            return True
                                                        else:
                                                            if x3 <= 0:
                                                                if x1 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                if x3 <= 3:
                                                                    if x1 <= 1:
                                                                        if x3 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if x3 <= 1:
                                                                            if x1 <= 2:
                                                                                return True
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    if x1 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                    else:
                                                        if x10 <= 1:
                                                            return True
                                                        else:
                                                            if x6 <= 6:
                                                                if x5 <= 0:
                                                                    return True
                                                                else:
                                                                    if x4 <= 3:
                                                                        return False
                                                                    else:
                                                                        if x10 <= 2:
                                                                            if x11 <= 1:
                                                                                if x1 <= 1:
                                                                                    if x5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x3 <= 0:
                                                                                        return False
                                                                                    else:
                                                                                        if x5 <= 1:
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
                                                                                return True
                                                                        else:
                                                                            if x6 <= 5:
                                                                                if x5 <= 1:
                                                                                    if x1 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x1 <= 1:
                                                                                        if x3 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
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
                                                                                                if x3 <= 2:
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
                                                    return False
                                                else:
                                                    if x3 <= 5:
                                                        return True
                                                    else:
                                                        return False
                                        else:
                                            if x11 <= 1:
                                                if x7 <= 1:
                                                    if x9 <= 3:
                                                        if x11 <= 0:
                                                            return False
                                                        else:
                                                            if x6 <= 6:
                                                                if x5 <= 0:
                                                                    if x3 <= 1:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x3 <= 0:
                                                                        if x5 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 1:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 1:
                                                                                    if x3 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x1 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x5 <= 2:
                                                                                            if x3 <= 3:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x3 <= 2:
                                                                                                if x5 <= 3:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                return False
                                                            else:
                                                                if x3 <= 0:
                                                                    if x5 <= 1:
                                                                        return False
                                                                    else:
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
                                                                                if x3 <= 2:
                                                                                    if x5 <= 3:
                                                                                        if x3 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    return False
                                                                    else:
                                                                        if x5 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                            else:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    if x7 <= 2:
                                                        if x9 <= 3:
                                                            if x3 <= 4:
                                                                if x7 <= 1:
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
                                                                                            if x10 <= 3:
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
                                                                                        if x5 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                else:
                                                                    if x6 <= 6:
                                                                        if x10 <= 3:
                                                                            return True
                                                                        else:
                                                                            if x6 <= 5:
                                                                                if x5 <= 4:
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
                                                                                                if x5 <= 2:
                                                                                                    if x1 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x1 <= 2:
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
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                if x10 <= 3:
                                                                    return True
                                                                else:
                                                                    if x3 <= 0:
                                                                        if x5 <= 1:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 0:
                                                                                if x3 <= 2:
                                                                                    return False
                                                                                else:
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
                                                        if x6 <= 5:
                                                            if x4 <= 3:
                                                                return False
                                                            else:
                                                                if x3 <= 4:
                                                                    if x9 <= 4:
                                                                        if x5 <= 4:
                                                                            if x1 <= 1:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 3:
                                                                                        if x1 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            if x5 <= 2:
                                                                                                return True
                                                                                            else:
                                                                                                return False
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x5 <= 1:
                                                                        if x9 <= 4:
                                                                            if x1 <= 2:
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
                                        if x7 <= 2:
                                            if x9 <= 3:
                                                return True
                                            else:
                                                if x11 <= 0:
                                                    return False
                                                else:
                                                    if x11 <= 1:
                                                        if x5 <= 0:
                                                            if x3 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x3 <= 0:
                                                                if x5 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x1 <= 1:
                                                                    return False
                                                                else:
                                                                    if x5 <= 1:
                                                                        if x3 <= 2:
                                                                            return False
                                                                        else:
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
                                                        if x2 <= 2:
                                                            return True
                                                        else:
                                                            if x7 <= 1:
                                                                return True
                                                            else:
                                                                if x10 <= 3:
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
                                            if x10 <= 2:
                                                return True
                                            else:
                                                if x11 <= 1:
                                                    return False
                                                else:
                                                    if x9 <= 4:
                                                        if x4 <= 3:
                                                            if x9 <= 3:
                                                                if x6 <= 5:
                                                                    if x9 <= 2:
                                                                        if x5 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x1 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x5 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        if x1 <= 2:
                                                                                            return True
                                                                                        else:
                                                                                            if x5 <= 4:
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
                                                            if x6 <= 5:
                                                                if x3 <= 3:
                                                                    if x3 <= 0:
                                                                        if x1 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 4:
                                                                            return True
                                                                        else:
                                                                            if x1 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x3 <= 5:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                else:
                                    if x0 <= 0:
                                        if x7 <= 2:
                                            return True
                                        else:
                                            if x12 <= 4:
                                                if x9 <= 2:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        if x6 <= 6:
                                                            if x3 <= 3:
                                                                if x3 <= 0:
                                                                    if x1 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x3 <= 5:
                                                                    if x1 <= 2:
                                                                        if x3 <= 4:
                                                                            if x1 <= 1:
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
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        if x2 <= 1:
                                                            if x10 <= 3:
                                                                if x3 <= 5:
                                                                    if x9 <= 4:
                                                                        if x11 <= 1:
                                                                            if x9 <= 3:
                                                                                if x5 <= 0:
                                                                                    return True
                                                                                else:
                                                                                    if x1 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        if x5 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            if x5 <= 3:
                                                                                                if x5 <= 2:
                                                                                                    if x1 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x1 <= 2:
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
                                                                return False
                                                        else:
                                                            return False
                                            else:
                                                return True
                                    else:
                                        return True
                            else:
                                if x9 <= 3:
                                    if x10 <= 2:
                                        if x7 <= 2:
                                            return True
                                        else:
                                            if x10 <= 1:
                                                return True
                                            else:
                                                if x4 <= 5:
                                                    return True
                                                else:
                                                    if x0 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                    else:
                                        if x0 <= 0:
                                            if x2 <= 2:
                                                if x10 <= 3:
                                                    return True
                                                else:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        if x7 <= 1:
                                                            return True
                                                        else:
                                                            if x6 <= 5:
                                                                if x7 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                            else:
                                                if x7 <= 1:
                                                    if x4 <= 3:
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
                                                    if x2 <= 4:
                                                        if x6 <= 5:
                                                            return False
                                                        else:
                                                            if x4 <= 4:
                                                                if x4 <= 3:
                                                                    return False
                                                                else:
                                                                    if x8 <= 3:
                                                                        if x7 <= 2:
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
                                                        if x4 <= 6:
                                                            if x4 <= 3:
                                                                if x7 <= 2:
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
                                            if x7 <= 2:
                                                return True
                                            else:
                                                if x9 <= 2:
                                                    if x8 <= 3:
                                                        if x2 <= 4:
                                                            if x10 <= 3:
                                                                if x4 <= 6:
                                                                    if x2 <= 3:
                                                                        if x2 <= 2:
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
                                                    return True
                                else:
                                    if x6 <= 6:
                                        return True
                                    else:
                                        if x10 <= 3:
                                            return True
                                        else:
                                            if x8 <= 4:
                                                if x2 <= 4:
                                                    if x0 <= 0:
                                                        if x9 <= 4:
                                                            if x7 <= 1:
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
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        if x7 <= 2:
                                                            return True
                                                        else:
                                                            if x2 <= 3:
                                                                if x9 <= 5:
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
                        if x10 <= 2:
                            if x6 <= 5:
                                if x7 <= 5:
                                    if x0 <= 0:
                                        if x4 <= 5:
                                            if x5 <= 3:
                                                if x9 <= 3:
                                                    if x3 <= 4:
                                                        if x3 <= 0:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                if x1 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if x11 <= 2:
                                                                if x1 <= 0:
                                                                    return False
                                                                else:
                                                                    if x3 <= 2:
                                                                        if x1 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
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
                                                                return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if x11 <= 2:
                                                    if x3 <= 1:
                                                        if x9 <= 3:
                                                            if x1 <= 2:
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
                                            if x7 <= 4:
                                                if x4 <= 6:
                                                    if x6 <= 4:
                                                        return False
                                                    else:
                                                        if x1 <= 0:
                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                    else:
                                        if x7 <= 4:
                                            if x11 <= 2:
                                                if x9 <= 2:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        if x5 <= 3:
                                                            if x5 <= 0:
                                                                return True
                                                            else:
                                                                if x3 <= 4:
                                                                    if x3 <= 0:
                                                                        if x1 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x3 <= 3:
                                                                            if x1 <= 1:
                                                                                if x5 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x5 <= 2:
                                                                                    return True
                                                                                else:
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
                                                                    return False
                                                        else:
                                                            return True
                                                else:
                                                    return True
                                            else:
                                                return True
                                        else:
                                            if x4 <= 6:
                                                if x11 <= 2:
                                                    if x9 <= 2:
                                                        if x10 <= 1:
                                                            if x1 <= 0:
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
                                                if x6 <= 4:
                                                    return False
                                                else:
                                                    if x1 <= 0:
                                                        return False
                                                    else:
                                                        return True
                                else:
                                    return False
                            else:
                                if x1 <= 0:
                                    if x5 <= 2:
                                        return False
                                    else:
                                        if x0 <= 0:
                                            if x9 <= 2:
                                                if x4 <= 5:
                                                    return False
                                                else:
                                                    if x6 <= 6:
                                                        if x4 <= 6:
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
                                    if x11 <= 1:
                                        if x0 <= 0:
                                            if x4 <= 5:
                                                if x6 <= 6:
                                                    if x9 <= 2:
                                                        if x3 <= 4:
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
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 1:
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
                                                                    return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if x10 <= 1:
                                                    if x6 <= 6:
                                                        if x4 <= 6:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                        else:
                                            if x4 <= 5:
                                                return True
                                            else:
                                                if x10 <= 1:
                                                    return True
                                                else:
                                                    if x9 <= 2:
                                                        if x4 <= 6:
                                                            if x6 <= 6:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                    else:
                                        if x4 <= 6:
                                            return True
                                        else:
                                            if x6 <= 6:
                                                if x0 <= 0:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                return True
                        else:
                            if x0 <= 0:
                                if x10 <= 3:
                                    if x9 <= 5:
                                        if x12 <= 4:
                                            return False
                                        else:
                                            if x4 <= 5:
                                                if x1 <= 0:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                    else:
                                        if x6 <= 6:
                                            if x4 <= 5:
                                                return True
                                            else:
                                                if x6 <= 5:
                                                    if x7 <= 4:
                                                        if x2 <= 2:
                                                            if x6 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if x7 <= 4:
                                                        return True
                                                    else:
                                                        if x4 <= 6:
                                                            return True
                                                        else:
                                                            return False
                                        else:
                                            return True
                                else:
                                    return False
                            else:
                                if x9 <= 6:
                                    if x8 <= 5:
                                        if x11 <= 2:
                                            if x10 <= 3:
                                                if x9 <= 4:
                                                    if x7 <= 4:
                                                        if x12 <= 3:
                                                            return False
                                                        else:
                                                            if x1 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return False
                                                else:
                                                    if x7 <= 5:
                                                        return True
                                                    else:
                                                        if x6 <= 5:
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                return False
                                        else:
                                            if x2 <= 4:
                                                if x9 <= 5:
                                                    if x4 <= 5:
                                                        if x3 <= 4:
                                                            return False
                                                        else:
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                if x4 <= 3:
                                                                    if x2 <= 3:
                                                                        if x9 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x9 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
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
                                                    if x7 <= 5:
                                                        if x6 <= 4:
                                                            if x4 <= 6:
                                                                return True
                                                            else:
                                                                if x7 <= 4:
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
                                                return True
                                    else:
                                        if x1 <= 0:
                                            return False
                                        else:
                                            if x7 <= 5:
                                                return True
                                            else:
                                                if x9 <= 4:
                                                    return False
                                                else:
                                                    if x10 <= 3:
                                                        return True
                                                    else:
                                                        return False
                                else:
                                    if x7 <= 4:
                                        return True
                                    else:
                                        if x6 <= 5:
                                            if x4 <= 6:
                                                return True
                                            else:
                                                if x7 <= 5:
                                                    if x6 <= 4:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                        else:
                                            return True
                else:
                    if x7 <= 2:
                        if x1 <= 0:
                            return False
                        else:
                            if x0 <= 0:
                                if x2 <= 1:
                                    if x4 <= 0:
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
                                                            if x1 <= 2:
                                                                if x3 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                    else:
                                        if x12 <= 4:
                                            if x4 <= 1:
                                                if x11 <= 2:
                                                    if x11 <= 1:
                                                        return False
                                                    else:
                                                        if x12 <= 3:
                                                            if x5 <= 3:
                                                                if x3 <= 3:
                                                                    if x7 <= 1:
                                                                        if x3 <= 0:
                                                                            if x5 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x5 <= 0:
                                                                                if x3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x5 <= 1:
                                                                        if x1 <= 2:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x3 <= 2:
                                                                    if x1 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x5 <= 4:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if x3 <= 0:
                                                                if x5 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x1 <= 1:
                                                                    return False
                                                                else:
                                                                    if x5 <= 0:
                                                                        if x3 <= 2:
                                                                            return False
                                                                        else:
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
                                                    if x7 <= 1:
                                                        return True
                                                    else:
                                                        if x9 <= 4:
                                                            return False
                                                        else:
                                                            if x8 <= 4:
                                                                return True
                                                            else:
                                                                if x3 <= 0:
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
                                                if x9 <= 3:
                                                    if x7 <= 1:
                                                        if x11 <= 2:
                                                            if x5 <= 3:
                                                                if x3 <= 2:
                                                                    if x5 <= 2:
                                                                        if x5 <= 0:
                                                                            if x3 <= 1:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x3 <= 0:
                                                                                if x5 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x3 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if x5 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x3 <= 3:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                            else:
                                                                if x3 <= 2:
                                                                    return True
                                                                else:
                                                                    if x5 <= 4:
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
                                                    return True
                                        else:
                                            return True
                                else:
                                    if x11 <= 1:
                                        return False
                                    else:
                                        if x7 <= 1:
                                            if x11 <= 2:
                                                if x4 <= 1:
                                                    return False
                                                else:
                                                    if x2 <= 2:
                                                        if x3 <= 0:
                                                            return True
                                                        else:
                                                            if x1 <= 1:
                                                                return False
                                                            else:
                                                                if x5 <= 0:
                                                                    if x3 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x9 <= 4:
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
                                                        return False
                                            else:
                                                if x3 <= 1:
                                                    return True
                                                else:
                                                    if x1 <= 1:
                                                        if x4 <= 1:
                                                            return False
                                                        else:
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x4 <= 1:
                                                            if x3 <= 3:
                                                                if x5 <= 5:
                                                                    if x12 <= 3:
                                                                        if x9 <= 3:
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
                                                                            if x8 <= 3:
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
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                if x9 <= 2:
                                                                    return False
                                                                else:
                                                                    if x6 <= 4:
                                                                        return True
                                                                    else:
                                                                        if x9 <= 3:
                                                                            if x3 <= 3:
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
                                                                            if x6 <= 5:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 3:
                                                                                    if x5 <= 5:
                                                                                        if x9 <= 4:
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
                                                                                    if x5 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                        else:
                                            if x10 <= 6:
                                                if x2 <= 2:
                                                    if x1 <= 1:
                                                        return False
                                                    else:
                                                        if x9 <= 3:
                                                            return False
                                                        else:
                                                            if x6 <= 4:
                                                                return True
                                                            else:
                                                                if x11 <= 2:
                                                                    if x10 <= 5:
                                                                        if x6 <= 6:
                                                                            if x1 <= 2:
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
                                                                            if x5 <= 0:
                                                                                if x3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x3 <= 0:
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
                                                                        return False
                                                                else:
                                                                    if x9 <= 4:
                                                                        return False
                                                                    else:
                                                                        if x6 <= 5:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x1 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    if x12 <= 3:
                                                                                        if x10 <= 5:
                                                                                            return True
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
                                                                                        if x10 <= 5:
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
                                                    if x4 <= 1:
                                                        return False
                                                    else:
                                                        if x2 <= 3:
                                                            if x9 <= 4:
                                                                return False
                                                            else:
                                                                if x8 <= 3:
                                                                    return True
                                                                else:
                                                                    if x11 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 0:
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
                                                            return False
                                            else:
                                                return False
                            else:
                                if x11 <= 2:
                                    if x2 <= 1:
                                        if x10 <= 6:
                                            if x6 <= 5:
                                                if x10 <= 5:
                                                    return True
                                                else:
                                                    if x5 <= 3:
                                                        if x5 <= 0:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x3 <= 3:
                                                                if x7 <= 1:
                                                                    if x5 <= 2:
                                                                        if x5 <= 1:
                                                                            if x3 <= 1:
                                                                                return False
                                                                            else:
                                                                                if x1 <= 1:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if x3 <= 0:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x3 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    if x5 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x3 <= 0:
                                                                            return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                if x5 <= 2:
                                                                    if x1 <= 2:
                                                                        if x5 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                                                    else:
                                                        if x3 <= 3:
                                                            return True
                                                        else:
                                                            if x5 <= 4:
                                                                return False
                                                            else:
                                                                if x7 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                            else:
                                                return True
                                        else:
                                            if x8 <= 5:
                                                if x11 <= 1:
                                                    return False
                                                else:
                                                    if x8 <= 4:
                                                        if x5 <= 4:
                                                            if x5 <= 1:
                                                                if x3 <= 1:
                                                                    return False
                                                                else:
                                                                    if x1 <= 1:
                                                                        return False
                                                                    else:
                                                                        if x5 <= 0:
                                                                            return True
                                                                        else:
                                                                            if x1 <= 2:
                                                                                return False
                                                                            else:
                                                                                if x3 <= 2:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                            else:
                                                                if x3 <= 2:
                                                                    if x5 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x1 <= 2:
                                                                            if x5 <= 3:
                                                                                if x1 <= 1:
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
                                                        if x7 <= 1:
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
                                                                                    if x5 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        if x3 <= 3:
                                                                                            return True
                                                                                        else:
                                                                                            return False
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
                                                return True
                                    else:
                                        if x4 <= 1:
                                            if x11 <= 1:
                                                return False
                                            else:
                                                if x7 <= 1:
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
                                                                        if x5 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                else:
                                                    if x10 <= 6:
                                                        if x2 <= 2:
                                                            if x1 <= 1:
                                                                return False
                                                            else:
                                                                if x9 <= 5:
                                                                    if x1 <= 2:
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
                                                                    if x5 <= 0:
                                                                        if x3 <= 2:
                                                                            return False
                                                                        else:
                                                                            return True
                                                                    else:
                                                                        if x3 <= 0:
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
                                                            return False
                                                    else:
                                                        return False
                                        else:
                                            if x8 <= 4:
                                                if x11 <= 1:
                                                    if x6 <= 6:
                                                        if x5 <= 0:
                                                            if x3 <= 1:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x5 <= 3:
                                                                if x3 <= 3:
                                                                    if x1 <= 2:
                                                                        if x5 <= 2:
                                                                            if x7 <= 1:
                                                                                if x3 <= 0:
                                                                                    if x5 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x3 <= 2:
                                                                                        return False
                                                                                    else:
                                                                                        if x5 <= 1:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if x3 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x5 <= 2:
                                                                        if x1 <= 2:
                                                                            if x5 <= 1:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            return True
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
                                                    if x7 <= 1:
                                                        if x9 <= 4:
                                                            return True
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
                                                        if x1 <= 1:
                                                            return False
                                                        else:
                                                            if x6 <= 6:
                                                                if x5 <= 0:
                                                                    if x3 <= 2:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    if x3 <= 0:
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
                                                                if x3 <= 0:
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
                                                return True
                                else:
                                    if x7 <= 1:
                                        return True
                                    else:
                                        if x2 <= 1:
                                            return True
                                        else:
                                            if x3 <= 2:
                                                if x5 <= 2:
                                                    if x3 <= 1:
                                                        if x2 <= 3:
                                                            if x4 <= 1:
                                                                if x2 <= 2:
                                                                    if x4 <= 0:
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
                                                if x5 <= 2:
                                                    return True
                                                else:
                                                    if x5 <= 4:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
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
                                                        if x3 <= 3:
                                                            return True
                                                        else:
                                                            if x10 <= 6:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    if x4 <= 1:
                                                                        if x1 <= 2:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 4:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                    else:
                                                                        if x2 <= 3:
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
                                                                if x3 <= 4:
                                                                    if x5 <= 5:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return False
                    else:
                        if x2 <= 4:
                            if x7 <= 4:
                                if x8 <= 5:
                                    if x2 <= 2:
                                        if x0 <= 0:
                                            if x11 <= 2:
                                                return False
                                            else:
                                                if x7 <= 3:
                                                    if x9 <= 5:
                                                        if x4 <= 1:
                                                            return False
                                                        else:
                                                            if x2 <= 1:
                                                                if x1 <= 0:
                                                                    return False
                                                                else:
                                                                    if x9 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x12 <= 3:
                                                                            return False
                                                                        else:
                                                                            return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x10 <= 6:
                                                            if x6 <= 6:
                                                                return True
                                                            else:
                                                                if x1 <= 2:
                                                                    return False
                                                                else:
                                                                    if x4 <= 1:
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
                                                                        return True
                                                        else:
                                                            if x2 <= 1:
                                                                if x8 <= 4:
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
                                                                return False
                                                else:
                                                    return False
                                        else:
                                            if x1 <= 0:
                                                return False
                                            else:
                                                if x11 <= 2:
                                                    if x7 <= 3:
                                                        if x10 <= 6:
                                                            if x8 <= 4:
                                                                if x11 <= 1:
                                                                    return False
                                                                else:
                                                                    if x9 <= 4:
                                                                        if x9 <= 3:
                                                                            if x5 <= 4:
                                                                                if x3 <= 5:
                                                                                    if x5 <= 3:
                                                                                        if x3 <= 4:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                            else:
                                                                                                if x1 <= 2:
                                                                                                    if x5 <= 2:
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
                                                                            return False
                                                                    else:
                                                                        if x2 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x10 <= 5:
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
                                                                if x9 <= 5:
                                                                    return True
                                                                else:
                                                                    if x11 <= 1:
                                                                        return False
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
                                                            if x2 <= 1:
                                                                if x11 <= 1:
                                                                    return False
                                                                else:
                                                                    if x5 <= 1:
                                                                        if x3 <= 4:
                                                                            return False
                                                                        else:
                                                                            if x5 <= 0:
                                                                                return True
                                                                            else:
                                                                                if x3 <= 5:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                    else:
                                                                        if x5 <= 4:
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
                                                    if x1 <= 2:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            if x2 <= 1:
                                                                if x12 <= 3:
                                                                    if x9 <= 3:
                                                                        if x9 <= 2:
                                                                            if x7 <= 3:
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
                                                                if x10 <= 5:
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
                                                        if x9 <= 5:
                                                            if x12 <= 3:
                                                                if x9 <= 3:
                                                                    if x6 <= 4:
                                                                        if x2 <= 1:
                                                                            if x10 <= 5:
                                                                                if x3 <= 6:
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
                                                            if x6 <= 5:
                                                                return True
                                                            else:
                                                                if x4 <= 1:
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
                                                                    return True
                                    else:
                                        if x4 <= 1:
                                            if x10 <= 6:
                                                if x2 <= 3:
                                                    if x1 <= 2:
                                                        return False
                                                    else:
                                                        if x0 <= 0:
                                                            return False
                                                        else:
                                                            if x11 <= 2:
                                                                return False
                                                            else:
                                                                if x9 <= 5:
                                                                    return False
                                                                else:
                                                                    if x6 <= 6:
                                                                        return True
                                                                    else:
                                                                        if x9 <= 6:
                                                                            if x7 <= 3:
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
                                                                                return False
                                                                        else:
                                                                            return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                        else:
                                            if x9 <= 5:
                                                if x11 <= 2:
                                                    if x11 <= 1:
                                                        return False
                                                    else:
                                                        if x0 <= 0:
                                                            return False
                                                        else:
                                                            if x5 <= 1:
                                                                if x3 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                if x3 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                else:
                                                    return False
                                            else:
                                                if x0 <= 0:
                                                    if x2 <= 3:
                                                        if x7 <= 3:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if x11 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                else:
                                    if x1 <= 0:
                                        return False
                                    else:
                                        if x0 <= 0:
                                            if x7 <= 3:
                                                if x9 <= 6:
                                                    return True
                                                else:
                                                    if x11 <= 2:
                                                        return False
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
                                                return False
                                        else:
                                            return True
                            else:
                                return False
                        else:
                            if x0 <= 0:
                                return False
                            else:
                                return True
            else:
                if x10 <= 0:
                    if x1 <= 0:
                        if x6 <= 4:
                            return True
                        else:
                            if x0 <= 0:
                                return False
                            else:
                                return True
                    else:
                        return True
                else:
                    return True
        else:
            if x2 <= 3:
                if x11 <= 5:
                    if x3 <= 4:
                        if x5 <= 5:
                            if x10 <= 3:
                                if x8 <= 3:
                                    if x7 <= 3:
                                        if x0 <= 0:
                                            if x7 <= 2:
                                                if x1 <= 0:
                                                    if x3 <= 0:
                                                        if x11 <= 4:
                                                            return False
                                                        else:
                                                            if x2 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                            else:
                                                if x9 <= 3:
                                                    if x2 <= 1:
                                                        if x3 <= 0:
                                                            if x5 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                                    else:
                                                        if x10 <= 2:
                                                            if x3 <= 0:
                                                                return False
                                                            else:
                                                                if x10 <= 1:
                                                                    return True
                                                                else:
                                                                    if x4 <= 5:
                                                                        if x3 <= 3:
                                                                            if x5 <= 4:
                                                                                if x9 <= 2:
                                                                                    if x3 <= 2:
                                                                                        if x5 <= 3:
                                                                                            if x5 <= 1:
                                                                                                if x3 <= 1:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x3 <= 1:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if x6 <= 2:
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
                                                                        return False
                                                        else:
                                                            if x4 <= 4:
                                                                if x2 <= 2:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                else:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        if x2 <= 2:
                                                            return True
                                                        else:
                                                            return False
                                        else:
                                            if x9 <= 2:
                                                if x4 <= 4:
                                                    return True
                                                else:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        if x2 <= 2:
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                return True
                                    else:
                                        if x0 <= 0:
                                            if x4 <= 5:
                                                if x10 <= 2:
                                                    if x9 <= 3:
                                                        if x3 <= 0:
                                                            return False
                                                        else:
                                                            if x3 <= 3:
                                                                if x5 <= 4:
                                                                    if x9 <= 2:
                                                                        if x3 <= 2:
                                                                            if x5 <= 3:
                                                                                if x5 <= 1:
                                                                                    if x3 <= 1:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x3 <= 1:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        if x11 <= 4:
                                                                            return True
                                                                        else:
                                                                            if x1 <= 0:
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
                                                                                    if x1 <= 2:
                                                                                        if x3 <= 2:
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
                                                return False
                                        else:
                                            if x7 <= 4:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    if x11 <= 4:
                                                        return False
                                                    else:
                                                        if x4 <= 5:
                                                            return True
                                                        else:
                                                            if x9 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                            else:
                                                if x4 <= 6:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                else:
                                    if x0 <= 0:
                                        if x12 <= 4:
                                            if x7 <= 4:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    if x7 <= 3:
                                                        if x5 <= 4:
                                                            if x6 <= 4:
                                                                if x4 <= 4:
                                                                    return True
                                                                else:
                                                                    if x2 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x6 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x4 <= 5:
                                                                                return True
                                                                            else:
                                                                                return False
                                                            else:
                                                                return False
                                                        else:
                                                            if x3 <= 3:
                                                                return True
                                                            else:
                                                                if x8 <= 4:
                                                                    if x11 <= 4:
                                                                        if x4 <= 5:
                                                                            if x9 <= 2:
                                                                                if x6 <= 6:
                                                                                    if x6 <= 4:
                                                                                        if x2 <= 2:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                                    else:
                                                                                        if x2 <= 2:
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
                                                                        if x9 <= 2:
                                                                            return True
                                                                        else:
                                                                            if x2 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                else:
                                                                    return True
                                                    else:
                                                        return False
                                            else:
                                                if x4 <= 6:
                                                    if x10 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    if x6 <= 5:
                                                        return False
                                                    else:
                                                        if x2 <= 1:
                                                            return False
                                                        else:
                                                            if x1 <= 0:
                                                                if x6 <= 6:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                        else:
                                            if x5 <= 4:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return True
                                    else:
                                        return True
                            else:
                                if x1 <= 0:
                                    if x11 <= 4:
                                        if x6 <= 4:
                                            if x4 <= 1:
                                                return False
                                            else:
                                                if x7 <= 2:
                                                    if x0 <= 0:
                                                        if x4 <= 2:
                                                            return False
                                                        else:
                                                            if x6 <= 3:
                                                                if x3 <= 0:
                                                                    if x5 <= 3:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x6 <= 3:
                                                            return True
                                                        else:
                                                            if x10 <= 4:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        if x0 <= 0:
                                                            return False
                                                        else:
                                                            if x6 <= 3:
                                                                if x5 <= 3:
                                                                    return False
                                                                else:
                                                                    if x4 <= 6:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                return False
                                        else:
                                            return False
                                    else:
                                        if x0 <= 0:
                                            if x6 <= 3:
                                                if x10 <= 5:
                                                    if x4 <= 4:
                                                        if x6 <= 2:
                                                            if x12 <= 3:
                                                                if x9 <= 2:
                                                                    if x7 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                            else:
                                                                if x3 <= 3:
                                                                    return True
                                                                else:
                                                                    if x5 <= 4:
                                                                        if x2 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x2 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        return True
                                                        else:
                                                            if x4 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                    else:
                                                        if x2 <= 2:
                                                            return False
                                                        else:
                                                            if x5 <= 4:
                                                                return False
                                                            else:
                                                                if x4 <= 5:
                                                                    return True
                                                                else:
                                                                    if x4 <= 6:
                                                                        if x6 <= 2:
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
                                            if x2 <= 2:
                                                if x10 <= 4:
                                                    if x8 <= 4:
                                                        if x4 <= 5:
                                                            if x8 <= 3:
                                                                if x3 <= 2:
                                                                    return True
                                                                else:
                                                                    if x2 <= 1:
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
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            if x6 <= 2:
                                                                return True
                                                            else:
                                                                if x4 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                else:
                                    if x7 <= 2:
                                        if x10 <= 5:
                                            if x9 <= 2:
                                                if x2 <= 2:
                                                    return True
                                                else:
                                                    if x10 <= 4:
                                                        return True
                                                    else:
                                                        if x0 <= 0:
                                                            if x11 <= 4:
                                                                if x7 <= 1:
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
                                            if x0 <= 0:
                                                if x8 <= 3:
                                                    if x7 <= 1:
                                                        if x9 <= 2:
                                                            if x2 <= 1:
                                                                if x10 <= 6:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                                        else:
                                                            if x10 <= 6:
                                                                return True
                                                            else:
                                                                if x11 <= 4:
                                                                    if x3 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x1 <= 1:
                                                                            return False
                                                                        else:
                                                                            if x3 <= 3:
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
                                                        if x4 <= 0:
                                                            if x9 <= 4:
                                                                return False
                                                            else:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if x6 <= 2:
                                                                return True
                                                            else:
                                                                if x9 <= 4:
                                                                    return False
                                                                else:
                                                                    if x2 <= 2:
                                                                        return True
                                                                    else:
                                                                        return False
                                                else:
                                                    if x3 <= 2:
                                                        return True
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x4 <= 0:
                                                                return False
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                            else:
                                                if x9 <= 3:
                                                    if x7 <= 1:
                                                        return True
                                                    else:
                                                        if x8 <= 3:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                if x3 <= 3:
                                                                    if x5 <= 4:
                                                                        if x3 <= 1:
                                                                            if x5 <= 2:
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
                                                                            if x1 <= 2:
                                                                                if x3 <= 2:
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
                                                                        return True
                                                                else:
                                                                    if x4 <= 0:
                                                                        return False
                                                                    else:
                                                                        if x2 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                        else:
                                                            return True
                                                else:
                                                    return True
                                    else:
                                        if x0 <= 0:
                                            if x8 <= 4:
                                                if x10 <= 4:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return False
                                            else:
                                                if x9 <= 4:
                                                    return True
                                                else:
                                                    if x12 <= 4:
                                                        return False
                                                    else:
                                                        if x9 <= 6:
                                                            return True
                                                        else:
                                                            return False
                                        else:
                                            if x8 <= 3:
                                                if x6 <= 2:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                if x10 <= 6:
                                                    return True
                                                else:
                                                    if x3 <= 3:
                                                        return True
                                                    else:
                                                        if x2 <= 2:
                                                            return True
                                                        else:
                                                            if x6 <= 2:
                                                                return True
                                                            else:
                                                                return False
                        else:
                            if x12 <= 4:
                                if x7 <= 4:
                                    if x10 <= 6:
                                        if x8 <= 3:
                                            if x4 <= 5:
                                                if x10 <= 5:
                                                    if x9 <= 2:
                                                        if x10 <= 4:
                                                            return True
                                                        else:
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                if x11 <= 4:
                                                                    if x0 <= 0:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                    else:
                                                        return True
                                                else:
                                                    if x0 <= 0:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x11 <= 4:
                                                                if x2 <= 2:
                                                                    if x3 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    return False
                                                            else:
                                                                if x9 <= 2:
                                                                    if x7 <= 1:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                    else:
                                                        return True
                                            else:
                                                if x0 <= 0:
                                                    if x7 <= 3:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                        else:
                                            if x4 <= 1:
                                                if x3 <= 3:
                                                    return True
                                                else:
                                                    if x2 <= 2:
                                                        return True
                                                    else:
                                                        if x0 <= 0:
                                                            if x1 <= 2:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return True
                                            else:
                                                return True
                                    else:
                                        if x0 <= 0:
                                            if x2 <= 2:
                                                if x12 <= 3:
                                                    if x2 <= 1:
                                                        if x3 <= 3:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                                else:
                                                    if x3 <= 3:
                                                        return True
                                                    else:
                                                        if x1 <= 2:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                            else:
                                                return False
                                        else:
                                            if x12 <= 3:
                                                if x2 <= 2:
                                                    return True
                                                else:
                                                    if x6 <= 2:
                                                        return True
                                                    else:
                                                        return False
                                            else:
                                                return True
                                else:
                                    if x0 <= 0:
                                        if x4 <= 6:
                                            if x8 <= 3:
                                                return False
                                            else:
                                                return True
                                        else:
                                            if x6 <= 5:
                                                return False
                                            else:
                                                if x7 <= 5:
                                                    return True
                                                else:
                                                    return False
                                    else:
                                        if x12 <= 3:
                                            if x4 <= 6:
                                                return True
                                            else:
                                                return False
                                        else:
                                            return True
                            else:
                                if x4 <= 0:
                                    if x3 <= 3:
                                        return True
                                    else:
                                        if x2 <= 2:
                                            return True
                                        else:
                                            if x1 <= 1:
                                                if x0 <= 0:
                                                    return False
                                                else:
                                                    return True
                                            else:
                                                return True
                                else:
                                    return True
                    else:
                        if x7 <= 4:
                            if x0 <= 0:
                                if x7 <= 3:
                                    if x10 <= 5:
                                        if x12 <= 4:
                                            if x7 <= 2:
                                                return True
                                            else:
                                                if x5 <= 2:
                                                    return True
                                                else:
                                                    if x4 <= 2:
                                                        if x8 <= 4:
                                                            return False
                                                        else:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x8 <= 3:
                                                                if x4 <= 4:
                                                                    if x2 <= 2:
                                                                        return False
                                                                    else:
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
                                                                if x10 <= 2:
                                                                    return True
                                                                else:
                                                                    if x8 <= 4:
                                                                        if x10 <= 3:
                                                                            if x6 <= 2:
                                                                                if x2 <= 2:
                                                                                    if x4 <= 4:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x9 <= 2:
                                                                                    if x4 <= 5:
                                                                                        if x6 <= 6:
                                                                                            if x5 <= 6:
                                                                                                if x6 <= 4:
                                                                                                    if x2 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
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
                                        if x12 <= 4:
                                            if x7 <= 2:
                                                if x2 <= 1:
                                                    if x12 <= 3:
                                                        if x9 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                                    else:
                                                        return True
                                                else:
                                                    if x4 <= 0:
                                                        return False
                                                    else:
                                                        if x2 <= 2:
                                                            if x5 <= 6:
                                                                if x5 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return True
                                                        else:
                                                            if x6 <= 2:
                                                                if x5 <= 3:
                                                                    return True
                                                                else:
                                                                    return False
                                                            else:
                                                                return False
                                            else:
                                                if x5 <= 2:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            if x6 <= 2:
                                                                return True
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                else:
                                                    return False
                                        else:
                                            if x10 <= 6:
                                                return True
                                            else:
                                                if x2 <= 2:
                                                    if x11 <= 4:
                                                        if x7 <= 2:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                else:
                                    if x10 <= 5:
                                        if x8 <= 4:
                                            if x9 <= 2:
                                                if x6 <= 5:
                                                    if x12 <= 3:
                                                        return False
                                                    else:
                                                        if x10 <= 2:
                                                            return True
                                                        else:
                                                            if x4 <= 4:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    if x4 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x5 <= 5:
                                                                            if x2 <= 2:
                                                                                if x6 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                            else:
                                                                                if x4 <= 3:
                                                                                    return False
                                                                                else:
                                                                                    return True
                                                                        else:
                                                                            if x5 <= 6:
                                                                                if x2 <= 2:
                                                                                    if x11 <= 4:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if x6 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                if x2 <= 2:
                                                                                    if x11 <= 4:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                                else:
                                                                                    if x11 <= 4:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                            else:
                                                                return False
                                                else:
                                                    return True
                                            else:
                                                if x10 <= 2:
                                                    if x5 <= 6:
                                                        if x2 <= 1:
                                                            if x5 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    if x2 <= 1:
                                                        if x10 <= 3:
                                                            if x9 <= 4:
                                                                return False
                                                            else:
                                                                return True
                                                        else:
                                                            return False
                                                    else:
                                                        return False
                                        else:
                                            if x2 <= 1:
                                                if x6 <= 5:
                                                    if x4 <= 2:
                                                        return False
                                                    else:
                                                        if x6 <= 3:
                                                            if x10 <= 3:
                                                                return True
                                                            else:
                                                                if x4 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            return True
                                                else:
                                                    return True
                                            else:
                                                if x10 <= 4:
                                                    if x10 <= 3:
                                                        return True
                                                    else:
                                                        if x6 <= 6:
                                                            if x6 <= 2:
                                                                if x9 <= 2:
                                                                    return True
                                                                else:
                                                                    if x2 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x4 <= 6:
                                                                            return True
                                                                        else:
                                                                            return False
                                                            else:
                                                                if x4 <= 5:
                                                                    if x4 <= 3:
                                                                        return False
                                                                    else:
                                                                        if x6 <= 4:
                                                                            if x2 <= 2:
                                                                                return False
                                                                            else:
                                                                                return True
                                                                        else:
                                                                            if x2 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    return False
                                                        else:
                                                            if x2 <= 2:
                                                                return True
                                                            else:
                                                                if x4 <= 4:
                                                                    return False
                                                                else:
                                                                    return True
                                                else:
                                                    return False
                                    else:
                                        if x8 <= 5:
                                            return False
                                        else:
                                            if x9 <= 6:
                                                return True
                                            else:
                                                return False
                            else:
                                if x12 <= 4:
                                    if x7 <= 3:
                                        if x10 <= 5:
                                            if x4 <= 4:
                                                return True
                                            else:
                                                if x2 <= 2:
                                                    if x12 <= 3:
                                                        if x9 <= 2:
                                                            if x10 <= 2:
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
                                            if x8 <= 3:
                                                if x5 <= 2:
                                                    if x2 <= 2:
                                                        return True
                                                    else:
                                                        if x6 <= 2:
                                                            return True
                                                        else:
                                                            if x10 <= 6:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    if x7 <= 2:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            if x4 <= 0:
                                                                return False
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        if x11 <= 4:
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
                                                    if x4 <= 0:
                                                        if x9 <= 2:
                                                            return True
                                                        else:
                                                            if x1 <= 2:
                                                                return False
                                                            else:
                                                                if x3 <= 5:
                                                                    return True
                                                                else:
                                                                    return False
                                                    else:
                                                        return True
                                    else:
                                        if x4 <= 1:
                                            if x5 <= 2:
                                                if x2 <= 2:
                                                    return True
                                                else:
                                                    if x10 <= 6:
                                                        return True
                                                    else:
                                                        if x6 <= 2:
                                                            return True
                                                        else:
                                                            return False
                                            else:
                                                if x6 <= 2:
                                                    if x2 <= 2:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    if x2 <= 1:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            if x6 <= 3:
                                                                return False
                                                            else:
                                                                if x6 <= 4:
                                                                    return True
                                                                else:
                                                                    if x6 <= 5:
                                                                        return False
                                                                    else:
                                                                        return True
                                                    else:
                                                        return False
                                        else:
                                            if x5 <= 2:
                                                return True
                                            else:
                                                if x10 <= 2:
                                                    return True
                                                else:
                                                    if x8 <= 4:
                                                        if x11 <= 4:
                                                            if x12 <= 3:
                                                                return False
                                                            else:
                                                                if x10 <= 3:
                                                                    return True
                                                                else:
                                                                    if x9 <= 3:
                                                                        if x6 <= 5:
                                                                            if x9 <= 2:
                                                                                if x10 <= 4:
                                                                                    if x4 <= 5:
                                                                                        if x2 <= 1:
                                                                                            if x6 <= 4:
                                                                                                return False
                                                                                            else:
                                                                                                return True
                                                                                        else:
                                                                                            if x6 <= 4:
                                                                                                if x2 <= 2:
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
                                                                                if x2 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    if x4 <= 6:
                                                                                        if x5 <= 5:
                                                                                            if x6 <= 4:
                                                                                                if x2 <= 2:
                                                                                                    return False
                                                                                                else:
                                                                                                    return True
                                                                                            else:
                                                                                                if x2 <= 2:
                                                                                                    return True
                                                                                                else:
                                                                                                    return False
                                                                                        else:
                                                                                            if x5 <= 6:
                                                                                                if x6 <= 4:
                                                                                                    if x2 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x2 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                            else:
                                                                                                if x6 <= 4:
                                                                                                    if x2 <= 2:
                                                                                                        return False
                                                                                                    else:
                                                                                                        return True
                                                                                                else:
                                                                                                    if x2 <= 2:
                                                                                                        return True
                                                                                                    else:
                                                                                                        return False
                                                                                    else:
                                                                                        return False
                                                                        else:
                                                                            if x9 <= 2:
                                                                                if x4 <= 4:
                                                                                    if x2 <= 2:
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
                                                            if x2 <= 2:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    if x12 <= 3:
                                                                        return False
                                                                    else:
                                                                        if x9 <= 3:
                                                                            return True
                                                                        else:
                                                                            if x10 <= 3:
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
                            if x0 <= 0:
                                if x5 <= 5:
                                    if x3 <= 5:
                                        if x6 <= 2:
                                            if x12 <= 4:
                                                return False
                                            else:
                                                if x9 <= 2:
                                                    if x4 <= 2:
                                                        return False
                                                    else:
                                                        if x2 <= 1:
                                                            return True
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
                                        return False
                                else:
                                    if x10 <= 5:
                                        if x6 <= 5:
                                            if x3 <= 5:
                                                if x5 <= 6:
                                                    return False
                                                else:
                                                    if x8 <= 4:
                                                        if x4 <= 6:
                                                            return True
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                            else:
                                                if x4 <= 4:
                                                    if x8 <= 4:
                                                        return False
                                                    else:
                                                        if x9 <= 2:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                if x4 <= 2:
                                                                    return False
                                                                else:
                                                                    if x4 <= 3:
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
                                                            return False
                                                else:
                                                    return False
                                        else:
                                            if x11 <= 4:
                                                if x5 <= 6:
                                                    return False
                                                else:
                                                    if x7 <= 5:
                                                        return True
                                                    else:
                                                        if x12 <= 4:
                                                            return False
                                                        else:
                                                            return True
                                            else:
                                                if x4 <= 3:
                                                    if x2 <= 1:
                                                        return True
                                                    else:
                                                        if x4 <= 2:
                                                            return False
                                                        else:
                                                            if x9 <= 3:
                                                                return False
                                                            else:
                                                                if x2 <= 2:
                                                                    return True
                                                                else:
                                                                    return False
                                                else:
                                                    return True
                                    else:
                                        if x8 <= 5:
                                            return False
                                        else:
                                            if x7 <= 5:
                                                if x9 <= 6:
                                                    if x11 <= 4:
                                                        return False
                                                    else:
                                                        return True
                                                else:
                                                    return False
                                            else:
                                                return False
                            else:
                                if x11 <= 4:
                                    if x10 <= 5:
                                        if x5 <= 4:
                                            if x5 <= 1:
                                                if x4 <= 6:
                                                    return True
                                                else:
                                                    return False
                                            else:
                                                return False
                                        else:
                                            if x8 <= 4:
                                                if x10 <= 3:
                                                    if x12 <= 3:
                                                        if x10 <= 2:
                                                            if x9 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                                    else:
                                                        return True
                                                else:
                                                    if x4 <= 5:
                                                        if x6 <= 3:
                                                            return False
                                                        else:
                                                            if x9 <= 3:
                                                                if x6 <= 5:
                                                                    if x2 <= 2:
                                                                        if x6 <= 4:
                                                                            if x2 <= 1:
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
                                        if x7 <= 5:
                                            if x2 <= 1:
                                                if x5 <= 4:
                                                    return False
                                                else:
                                                    if x8 <= 5:
                                                        if x4 <= 0:
                                                            return False
                                                        else:
                                                            if x6 <= 3:
                                                                return False
                                                            else:
                                                                if x6 <= 4:
                                                                    return True
                                                                else:
                                                                    if x6 <= 5:
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
                                    if x2 <= 2:
                                        if x5 <= 5:
                                            if x10 <= 5:
                                                if x4 <= 6:
                                                    if x1 <= 2:
                                                        if x8 <= 3:
                                                            return False
                                                        else:
                                                            if x6 <= 2:
                                                                if x9 <= 3:
                                                                    if x2 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x12 <= 4:
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
                                                if x4 <= 3:
                                                    return False
                                                else:
                                                    if x3 <= 6:
                                                        if x4 <= 5:
                                                            if x2 <= 1:
                                                                if x5 <= 4:
                                                                    return False
                                                                else:
                                                                    if x6 <= 2:
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
                                            if x3 <= 5:
                                                if x12 <= 3:
                                                    if x4 <= 6:
                                                        return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if x6 <= 5:
                                                    if x10 <= 6:
                                                        if x4 <= 5:
                                                            if x4 <= 1:
                                                                if x2 <= 1:
                                                                    if x9 <= 2:
                                                                        return False
                                                                    else:
                                                                        if x6 <= 4:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    return False
                                                            else:
                                                                if x9 <= 2:
                                                                    if x4 <= 4:
                                                                        if x4 <= 2:
                                                                            if x7 <= 5:
                                                                                return False
                                                                            else:
                                                                                if x2 <= 1:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                                        else:
                                                                            if x2 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x8 <= 4:
                                                                                    return False
                                                                                else:
                                                                                    if x6 <= 3:
                                                                                        if x10 <= 5:
                                                                                            return True
                                                                                        else:
                                                                                            return False
                                                                                    else:
                                                                                        if x7 <= 5:
                                                                                            return False
                                                                                        else:
                                                                                            return True
                                                                    else:
                                                                        return False
                                                                else:
                                                                    if x2 <= 1:
                                                                        return True
                                                                    else:
                                                                        if x8 <= 4:
                                                                            return False
                                                                        else:
                                                                            if x10 <= 5:
                                                                                return True
                                                                            else:
                                                                                if x4 <= 3:
                                                                                    return True
                                                                                else:
                                                                                    return False
                                                        else:
                                                            if x10 <= 4:
                                                                if x12 <= 4:
                                                                    if x5 <= 6:
                                                                        return False
                                                                    else:
                                                                        if x10 <= 3:
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
                                                        if x2 <= 1:
                                                            if x4 <= 0:
                                                                if x8 <= 5:
                                                                    return False
                                                                else:
                                                                    return True
                                                            else:
                                                                return True
                                                        else:
                                                            if x4 <= 1:
                                                                return False
                                                            else:
                                                                if x6 <= 6:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return True
                                    else:
                                        return True
                else:
                    if x11 <= 6:
                        if x0 <= 0:
                            if x2 <= 2:
                                if x3 <= 5:
                                    if x5 <= 6:
                                        if x10 <= 4:
                                            if x12 <= 4:
                                                if x4 <= 5:
                                                    if x3 <= 3:
                                                        if x5 <= 3:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                if x7 <= 2:
                                                                    return True
                                                                else:
                                                                    if x10 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x10 <= 3:
                                                                            return False
                                                                        else:
                                                                            return True
                                                        else:
                                                            return True
                                                    else:
                                                        if x1 <= 1:
                                                            if x8 <= 3:
                                                                if x7 <= 3:
                                                                    if x9 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x2 <= 1:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                else:
                                                                    if x10 <= 3:
                                                                        return True
                                                                    else:
                                                                        return False
                                                            else:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    if x7 <= 3:
                                                                        return True
                                                                    else:
                                                                        if x4 <= 3:
                                                                            return True
                                                                        else:
                                                                            return False
                                                        else:
                                                            if x2 <= 1:
                                                                return True
                                                            else:
                                                                if x5 <= 5:
                                                                    if x5 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x3 <= 4:
                                                                            return True
                                                                        else:
                                                                            if x9 <= 2:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    return True
                                                else:
                                                    if x12 <= 3:
                                                        return False
                                                    else:
                                                        if x4 <= 6:
                                                            if x10 <= 2:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                            else:
                                                if x3 <= 3:
                                                    return True
                                                else:
                                                    if x9 <= 4:
                                                        return True
                                                    else:
                                                        if x12 <= 5:
                                                            if x10 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return True
                                        else:
                                            if x1 <= 0:
                                                if x6 <= 2:
                                                    if x10 <= 6:
                                                        if x3 <= 4:
                                                            if x6 <= 1:
                                                                if x8 <= 3:
                                                                    if x3 <= 0:
                                                                        return False
                                                                    else:
                                                                        return True
                                                                else:
                                                                    return True
                                                            else:
                                                                if x4 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                        else:
                                                            if x8 <= 4:
                                                                return False
                                                            else:
                                                                if x4 <= 5:
                                                                    if x9 <= 2:
                                                                        return True
                                                                    else:
                                                                        if x6 <= 1:
                                                                            if x2 <= 1:
                                                                                return True
                                                                            else:
                                                                                if x8 <= 5:
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
                                                if x9 <= 2:
                                                    if x4 <= 0:
                                                        if x7 <= 1:
                                                            return False
                                                        else:
                                                            if x12 <= 3:
                                                                return True
                                                            else:
                                                                if x2 <= 1:
                                                                    return True
                                                                else:
                                                                    if x8 <= 4:
                                                                        return False
                                                                    else:
                                                                        return True
                                                    else:
                                                        return True
                                                else:
                                                    return True
                                    else:
                                        if x1 <= 2:
                                            return True
                                        else:
                                            if x4 <= 6:
                                                if x9 <= 2:
                                                    if x10 <= 6:
                                                        return True
                                                    else:
                                                        if x2 <= 1:
                                                            return True
                                                        else:
                                                            return False
                                                else:
                                                    return True
                                            else:
                                                return False
                                else:
                                    if x4 <= 5:
                                        if x1 <= 0:
                                            if x10 <= 6:
                                                if x6 <= 2:
                                                    if x8 <= 5:
                                                        return False
                                                    else:
                                                        if x2 <= 1:
                                                            if x6 <= 1:
                                                                return True
                                                            else:
                                                                if x4 <= 4:
                                                                    return True
                                                                else:
                                                                    return False
                                                        else:
                                                            if x4 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                else:
                                                    return False
                                            else:
                                                return False
                                        else:
                                            if x4 <= 1:
                                                if x7 <= 3:
                                                    return True
                                                else:
                                                    if x6 <= 6:
                                                        return False
                                                    else:
                                                        if x2 <= 1:
                                                            if x10 <= 6:
                                                                return True
                                                            else:
                                                                return False
                                                        else:
                                                            return False
                                            else:
                                                if x5 <= 6:
                                                    if x3 <= 6:
                                                        if x5 <= 2:
                                                            return True
                                                        else:
                                                            if x5 <= 5:
                                                                return False
                                                            else:
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
                                                    if x2 <= 1:
                                                        if x6 <= 1:
                                                            return True
                                                        else:
                                                            if x6 <= 5:
                                                                if x4 <= 4:
                                                                    if x4 <= 2:
                                                                        if x7 <= 5:
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
                                                        if x4 <= 2:
                                                            return False
                                                        else:
                                                            if x6 <= 6:
                                                                if x4 <= 4:
                                                                    if x9 <= 2:
                                                                        if x6 <= 1:
                                                                            return True
                                                                        else:
                                                                            if x6 <= 5:
                                                                                if x3 <= 6:
                                                                                    if x4 <= 3:
                                                                                        return False
                                                                                    else:
                                                                                        return True
                                                                                else:
                                                                                    if x4 <= 3:
                                                                                        return True
                                                                                    else:
                                                                                        return False
                                                                            else:
                                                                                return True
                                                                    else:
                                                                        if x3 <= 6:
                                                                            if x6 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                        else:
                                                                            if x4 <= 3:
                                                                                return True
                                                                            else:
                                                                                return False
                                                                else:
                                                                    if x3 <= 6:
                                                                        if x6 <= 1:
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
                            return True
                    else:
                        return True
            else:
                if x11 <= 4:
                    if x2 <= 4:
                        if x0 <= 0:
                            if x10 <= 5:
                                if x7 <= 3:
                                    if x10 <= 2:
                                        return True
                                    else:
                                        if x1 <= 0:
                                            if x6 <= 4:
                                                if x10 <= 4:
                                                    if x9 <= 2:
                                                        if x10 <= 3:
                                                            return True
                                                        else:
                                                            if x6 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                                    else:
                                                        if x12 <= 3:
                                                            return False
                                                        else:
                                                            if x6 <= 3:
                                                                return True
                                                            else:
                                                                if x10 <= 3:
                                                                    if x4 <= 5:
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
                                            if x3 <= 3:
                                                if x5 <= 5:
                                                    if x4 <= 5:
                                                        if x3 <= 2:
                                                            return True
                                                        else:
                                                            if x10 <= 4:
                                                                return True
                                                            else:
                                                                if x1 <= 1:
                                                                    return False
                                                                else:
                                                                    return True
                                                    else:
                                                        return False
                                                else:
                                                    return True
                                            else:
                                                if x10 <= 4:
                                                    if x7 <= 2:
                                                        return True
                                                    else:
                                                        if x6 <= 6:
                                                            if x6 <= 3:
                                                                if x4 <= 5:
                                                                    return True
                                                                else:
                                                                    if x12 <= 3:
                                                                        if x5 <= 2:
                                                                            return True
                                                                        else:
                                                                            return False
                                                                    else:
                                                                        return True
                                                            else:
                                                                if x9 <= 2:
                                                                    if x10 <= 3:
                                                                        if x4 <= 6:
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
                                                    if x1 <= 2:
                                                        return False
                                                    else:
                                                        if x3 <= 4:
                                                            return True
                                                        else:
                                                            if x12 <= 3:
                                                                return True
                                                            else:
                                                                return False
                                else:
                                    if x9 <= 2:
                                        if x10 <= 4:
                                            if x4 <= 4:
                                                return False
                                            else:
                                                if x4 <= 5:
                                                    if x12 <= 3:
                                                        return False
                                                    else:
                                                        if x3 <= 4:
                                                            if x6 <= 5:
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
                                return False
                        else:
                            return True
                    else:
                        return True
                else:
                    return True
