def wins() -> Bool:
    """Decision tree, 4 leaves: scikit-learn DecisionTreeClassifier(max_leaf_nodes=4, criterion="entropy", random_state=0) on all positions, written by chess-forces trees. Learned, not a force program."""
    x2 = rank(P)
    x11 = dist(k, sq(file(P), 7))
    x12 = dist(k, sq(file(P), rank(P) + 1))
    if x12 <= 2:
        return False
    else:
        if x11 <= 3:
            return True
        else:
            if x2 <= 3:
                return True
            else:
                return True
