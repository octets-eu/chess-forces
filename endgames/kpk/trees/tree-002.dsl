def wins() -> Bool:
    """Decision tree, 2 leaves: scikit-learn DecisionTreeClassifier(max_leaf_nodes=2, criterion="entropy", random_state=0) on all positions, written by chess-forces trees. Learned, not a force program."""
    x12 = dist(k, sq(file(P), rank(P) + 1))
    if x12 <= 2:
        return False
    else:
        return True
