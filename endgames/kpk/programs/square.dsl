def wins() -> Bool:
    """Rule of the square: the weak king is too far to catch the pawn. Ignores obstruction."""
    n = min(5, 7 - rank(P))
    return K not in path(strong, P) and n + 1 - tempo < dist(k, sq(file(P), 7))
