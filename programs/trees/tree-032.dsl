def wins() -> Bool:
    """Decision tree, 32 leaves: scikit-learn DecisionTreeClassifier(max_leaf_nodes=32, criterion="entropy", random_state=0) on all positions, written by chess-forces trees. Learned, not a force program."""
    x0 = tempo
    x1 = file(P)
    x2 = rank(P)
    x3 = file(K)
    x5 = file(k)
    x6 = rank(k)
    x7 = dist(K, P)
    x8 = dist(k, P)
    x10 = dist(K, sq(file(P), 7))
    x11 = dist(k, sq(file(P), 7))
    x12 = dist(k, sq(file(P), rank(P) + 1))
    if x12 <= 2:
        if x0 <= 0:
            if x7 <= 2:
                return False
            else:
                if x11 <= 6:
                    return False
                else:
                    if x8 <= 1:
                        return False
                    else:
                        return True
        else:
            if x6 <= 1:
                return True
            else:
                if x12 <= 1:
                    if x7 <= 2:
                        return False
                    else:
                        return False
                else:
                    if x8 <= 1:
                        return True
                    else:
                        if x2 <= 5:
                            if x7 <= 3:
                                if x10 <= 4:
                                    return True
                                else:
                                    return False
                            else:
                                return False
                        else:
                            return True
    else:
        if x11 <= 3:
            if x2 <= 5:
                if x10 <= 4:
                    if x7 <= 3:
                        if x1 <= 0:
                            return False
                        else:
                            return True
                    else:
                        return False
                else:
                    if x7 <= 2:
                        return False
                    else:
                        if x2 <= 4:
                            return False
                        else:
                            if x0 <= 0:
                                return False
                            else:
                                return True
            else:
                return True
        else:
            if x2 <= 3:
                if x11 <= 5:
                    if x3 <= 4:
                        if x5 <= 5:
                            return True
                        else:
                            return True
                    else:
                        if x7 <= 4:
                            return True
                        else:
                            return False
                else:
                    if x11 <= 6:
                        if x0 <= 0:
                            if x2 <= 2:
                                return True
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
                            return False
                        else:
                            return True
                    else:
                        return True
                else:
                    return True
