def wins() -> Bool:
    """Decision tree, 8 leaves: scikit-learn DecisionTreeClassifier(max_leaf_nodes=8, criterion="entropy", random_state=0) on all positions, written by chess-forces trees. Learned, not a force program."""
    x0 = tempo
    x2 = rank(P)
    x6 = rank(k)
    x11 = dist(k, sq(file(P), 7))
    x12 = dist(k, sq(file(P), rank(P) + 1))
    if x12 <= 2:
        if x0 <= 0:
            return False
        else:
            if x6 <= 1:
                return True
            else:
                return False
    else:
        if x11 <= 3:
            if x2 <= 5:
                return False
            else:
                return True
        else:
            if x2 <= 3:
                if x11 <= 5:
                    return True
                else:
                    return True
            else:
                return True
