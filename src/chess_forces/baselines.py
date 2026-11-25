"""Baselines for the KPK task, in the same units as DSL programs: bytes and word operations.

Table lookups and decoders count their operations by hand or by a rough estimate; that is said in
each point's note. Learned models are written so that the interpreter (the tree) or an explicit
formula (the net) gives their operation counts. Everything learned is trained on all positions: the
exceptions charge every mistake, so there is nothing to overfit to.
"""

import lzma
import math
import os
import time
from dataclasses import asdict, dataclass
from pathlib import Path

import numpy as np

from . import kpk, nets, score
from .dsl import TIERS, Position

SYZYGY_DIR = Path(os.environ.get("SYZYGY_PATH", Path(__file__).resolve().parents[3] / "syzygy"))


@dataclass
class Point:
    name: str
    kind: str  # table, learned or force
    bytes_model: float
    bytes_exceptions: float
    errors: int
    ops_mean: float | None
    ops_max: float | None
    estimated_ops: bool
    exact: bool
    note: str = ""
    detail: str = ""  # program text or architecture
    state_bytes: int | None = None  # decoded size held in memory, where it matters

    @property
    def bytes_total(self) -> float:
        return self.bytes_model + self.bytes_exceptions

    def row(self) -> dict:
        return {**asdict(self), "bytes_total": self.bytes_total}


def _from_report(name: str, kind: str, r: score.Report, note: str, detail: str) -> Point:
    return Point(
        name,
        kind,
        r.bits_program / 8,
        r.bits_exceptions / 8,
        r.errors,
        r.ops_mean,
        r.ops_max,
        False,
        False,
        note,
        detail,
    )


# --- tables --------------------------------------------------------------------------------------


def table_points(win: dict | None = None) -> list[Point]:
    """Bitbase, Syzygy and lzma of the bitbase."""
    win = win or kpk.generate()
    slots = np.zeros(2 * 24 * 64 * 64, dtype=np.uint8)
    for (stm, p, wk, bk), v in win.items():
        pi = (p & 7) * 6 + (p >> 3) - 1
        slots[((stm * 24 + pi) * 64 + wk) * 64 + bk] = v
    packed = np.packbits(slots).tobytes()
    out = [
        Point(
            "bitbase (all slots)",
            "table",
            len(packed),
            0.0,
            0,
            20,
            20,
            False,
            True,
            "hand-counted: 5 operations to find the pawn index, 4 loads, 6 to combine, 5 for the read",
            f"{len(packed)} bytes",
            len(packed),
        )
    ]
    syzygy = SYZYGY_DIR / "KPvK.rtbw"
    if syzygy.exists():
        out.append(
            Point(
                "Syzygy KPvK.rtbw",
                "table",
                syzygy.stat().st_size,
                0.0,
                0,
                None,
                None,
                False,
                True,
                "size is the file on disk; operations were not measured",
            )
        )
    filters = [
        {"id": lzma.FILTER_LZMA2, "preset": 9 | lzma.PRESET_EXTREME, "lc": 0, "lp": 0, "pb": 0}
    ]
    blob = lzma.compress(packed, format=lzma.FORMAT_RAW, filters=filters)
    best = min(
        _time(lambda: lzma.decompress(blob, lzma.FORMAT_RAW, filters=filters)) for _ in range(5)
    )
    ops = (
        best * 3e9
    )  # order of magnitude only: cold decompression time at 3 GHz, one operation a cycle
    out.append(
        Point(
            "lzma of the bitbase",
            "table",
            len(blob),
            0.0,
            0,
            ops,
            ops,
            True,
            True,
            "one lzma setting, not tuned; operations are a rough estimate from decompression time "
            "(everything must be unpacked for a single position)",
        )
    )
    return out


def _time(f) -> float:
    t = time.perf_counter()
    f()
    return time.perf_counter() - t


# --- decision tree as a DSL program --------------------------------------------------------------

FEATURES: dict[str, str] = {
    "tempo": "tempo",
    "file(P)": "file(P)",
    "rank(P)": "rank(P)",
    "file(K)": "file(K)",
    "rank(K)": "rank(K)",
    "file(k)": "file(k)",
    "rank(k)": "rank(k)",
    "dist(K, P)": "dist(K, P)",
    "dist(k, P)": "dist(k, P)",
    "dist(K, k)": "dist(K, k)",
    "dist(K, sq(file(P), 7))": "dist(K, sq(file(P), 7))",
    "dist(k, sq(file(P), 7))": "dist(k, sq(file(P), 7))",
    "dist(k, sq(file(P), rank(P) + 1))": "dist(k, sq(file(P), rank(P) + 1))",
}


def feature_matrix(task: score.Task) -> np.ndarray:
    """The FEATURES evaluated in numpy; checked against the interpreter by tree_program."""
    men = np.array([[p.K, p.k, p.P, p.tempo] for p in task.positions])
    K, k, P, tempo = men.T
    f, r = lambda s: s & 7, lambda s: s >> 3
    cheb = lambda a, b: np.maximum(abs(f(a) - f(b)), abs(r(a) - r(b)))
    board = lambda ff, rr: rr * 8 + ff
    q = board(f(P), np.full_like(P, 7))
    ahead = board(f(P), r(P) + 1)
    cols = [
        tempo,
        f(P),
        r(P),
        f(K),
        r(K),
        f(k),
        r(k),
        cheb(K, P),
        cheb(k, P),
        cheb(K, k),
        cheb(K, q),
        cheb(k, q),
    ]
    ahead_ok = (r(P) + 1) < 8
    cols.append(np.where(ahead_ok, cheb(k, np.where(ahead_ok, ahead, 0)), 99))
    return np.stack(cols, axis=1)


def tree_program(tree, names: list[str]) -> str:
    """sklearn tree to DSL text. Features used are named once at the top."""
    t = tree.tree_
    used = sorted({int(i) for i in t.feature if i >= 0})
    lines = [f"    x{i} = {FEATURES[names[i]]}" for i in used]

    def emit(node: int, depth: int) -> None:
        pad = "    " * depth
        if t.children_left[node] == -1:
            lines.append(f"{pad}return {bool(np.argmax(t.value[node]))}")
            return
        limit = math.floor(t.threshold[node])
        lines.append(f"{pad}if x{int(t.feature[node])} <= {limit}:")
        emit(t.children_left[node], depth + 1)
        lines.append(f"{pad}else:")
        emit(t.children_right[node], depth + 1)

    emit(0, 1)
    body = ["def wins() -> Bool:", *lines]
    return "\n".join(body) + "\n"


def tree_points(
    task: score.Task, leaves=(2, 4, 6, 8, 12, 16, 24, 32, 48, 64), seed: int = 0
) -> list[Point]:
    from sklearn.tree import DecisionTreeClassifier

    names = list(FEATURES)
    x = feature_matrix(task)
    y = np.array(task.truth)
    out = []
    for n in leaves:
        tree = DecisionTreeClassifier(max_leaf_nodes=n, criterion="entropy", random_state=seed).fit(
            x, y
        )
        text = tree_program(tree, names)
        r = score.score(text, task)
        got = y != tree.predict(x)
        if int(got.sum()) != r.errors:
            raise AssertionError("tree program disagrees with the tree it was made from")
        out.append(
            _from_report(
                f"decision tree, {n} leaves",
                "learned",
                r,
                "greedy entropy tree as a DSL program",
                text,
            )
        )
    return out


# --- table nets (trained by nets.py, saved as integers) --------------------------------------------


def net_points(task: score.Task) -> list[Point]:
    """Saved nets, evaluated exactly on all positions: those on their own frontier and the best per tier."""
    results = [nets.evaluate(nets.load(p), task) for p in sorted(nets.NETS_DIR.glob("*.npz"))]
    keep = {r.digest for r in nets.frontier(results)}
    for tier in TIERS:
        fits = [r for r in results if r.ops <= tier]
        if fits:
            keep.add(min(fits, key=lambda r: r.total).digest)
    out = []
    for r in sorted(results, key=lambda r: r.ops):
        if r.digest not in keep:
            continue
        shape = f"{r.hidden} hidden" if r.hidden else "additive"
        out.append(
            Point(
                f"net {r.family} {shape}, {r.bits} bit",
                "learned",
                r.model_bytes,
                r.exception_bytes,
                r.errors,
                r.ops,
                r.ops,
                False,
                False,
                "table lookups plus a small output layer, integer weights, quantisation-aware training",
                f"digest {r.digest}",
                r.state_bytes,
            )
        )
    return out


# --- putting it together -------------------------------------------------------------------------


def program_point(name: str, text: str, task: score.Task, note: str) -> Point:
    r = score.score(text, task)
    p = _from_report(name, "force", r, note, text)
    return p


def positions_count(task: score.Task) -> int:
    return len(task.positions)


__all__ = [
    "FEATURES",
    "Point",
    "Position",
    "net_points",
    "program_point",
    "table_points",
    "tree_points",
]
