def wins() -> Bool:
    """Textbook KPK by hand: rule of the square, key squares two ranks ahead (also one ahead from
    rank 5), the rook-pawn corner, and a loose pawn the weak king reaches first."""
    f = file(P)
    r = rank(P)
    q = sq(f, 7)
    n = min(5, 7 - r)
    runs = n + 1 - tempo < dist(k, q) and K not in path(strong, P)
    ks = inter(union(rank_f(r + 2), rank_f(r + 1 if r > 3 else 8)), union(file_f(f), union(file_f(f - 1), file_f(f + 1))))
    reach = any(dist(K, s) < dist(k, s) + tempo for s in ks) if f > 0 else dist(K, sq(1, 6)) < min(dist(k, sq(2, 7)), dist(k, sq(1, 7)), dist(k, sq(2, 6)), dist(k, sq(0, 7))) + tempo
    loose = dist(k, P) + tempo < dist(K, P)
    return runs or (reach and not loose)
