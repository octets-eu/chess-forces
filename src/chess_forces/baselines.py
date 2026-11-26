"""Baselines for the KPK task, in the same units as DSL programs: bytes and word operations.

Table lookups and decoders count their operations by hand or by a rough estimate; that is said in
each point's note. Learned models are written so that the interpreter (the tree) or an explicit
formula (the net) gives their operation counts. Everything learned is trained on all positions: the
exceptions charge every mistake, so there is nothing to overfit to.
"""

import json
import lzma
import math
import os
from dataclasses import asdict, dataclass
from pathlib import Path

import numpy as np

from . import codec, dsl, endgames, kpk, nets, score
from .dsl import TIERS, Position

ROOT = Path(__file__).resolve().parents[2]
SYZYGY_DIR = Path(os.environ.get("SYZYGY_PATH", ROOT.parent / "syzygy"))
TREES_DIR = endgames.KPK.trees
TREE_LEAVES = (2, 4, 8, 16, 32, 64, 96, 128)
SYZYGY_NAME = "Syzygy KPvK.rtbw"
# Decompressing the lzma bitbase (3,341 B to 24,576 B) with Python's lzma: median of 200 runs on an
# Apple M4 Pro, 2026-11-26. Pinned so the report does not change from run to run; an estimate.
LZMA_DECODE_SECONDS = 94.2e-6


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
    real_bytes: float | None = None  # an actual encoding (codec.py), next to the bound above

    @property
    def bytes_total(self) -> float:
        return self.bytes_model + self.bytes_exceptions

    def row(self) -> dict:
        return {**asdict(self), "bytes_total": self.bytes_total}


PROGRAM_LENGTH_BYTES = 2  # a real file says where the program ends and the exceptions begin


def real_program_bytes(text: str, r: score.Report) -> int:
    """Program as a mixed-radix integer plus its length, exceptions as Elias-Fano or a bitmap."""
    program = len(codec.encode_program(dsl.parse(text))) + PROGRAM_LENGTH_BYTES
    return program + len(codec.encode_exceptions(r.n, r.wrong))


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
        real_bytes=real_program_bytes(detail, r),
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
            real_bytes=len(packed),
        )
    ]
    syzygy = SYZYGY_DIR / "KPvK.rtbw"
    if syzygy.exists():
        counted = endgames.KPK.syzygy_ops
        est = json.loads(counted.read_text()) if counted.exists() else None
        out.append(
            Point(
                SYZYGY_NAME,
                "table",
                syzygy.stat().st_size,
                0.0,
                0,
                est["ops_mean"] if est else None,
                est["ops_max"] if est else None,
                est is not None,
                True,
                "size is the file on disk; operations estimated by scripts/syzygy_ops.py "
                "(counted decoder steps, costs per step by hand)"
                if est
                else "size is the file on disk; operations were not measured",
                real_bytes=syzygy.stat().st_size,
            )
        )
    filters = [
        {"id": lzma.FILTER_LZMA2, "preset": 9 | lzma.PRESET_EXTREME, "lc": 0, "lp": 0, "pb": 0}
    ]
    blob = lzma.compress(packed, format=lzma.FORMAT_RAW, filters=filters)
    ops = LZMA_DECODE_SECONDS * 3e9  # order of magnitude only: one operation a cycle at 3 GHz
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
            "one lzma setting, not tuned; operations are a rough estimate from one pinned decompression "
            "time (everything must be unpacked for a single position)",
            real_bytes=len(blob),
        )
    )
    return out


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


def tree_program(tree, names: list[str], doc: str = "") -> str:
    """sklearn tree to DSL text. Features used are named once at the top; doc becomes the docstring."""
    t = tree.tree_
    used = sorted({int(i) for i in t.feature if i >= 0})
    lines = [f'    """{doc}"""'] if doc else []
    lines += [f"    x{i} = {FEATURES[names[i]]}" for i in used]

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


def train_trees(task: score.Task, leaves=TREE_LEAVES, seed: int = 0) -> dict[int, str]:
    """Greedy entropy trees as DSL text, by leaf count. Raises if a program and its tree disagree."""
    from sklearn.tree import DecisionTreeClassifier

    names = list(FEATURES)
    x = feature_matrix(task)
    y = np.array(task.truth)
    out = {}
    for n in leaves:
        tree = DecisionTreeClassifier(max_leaf_nodes=n, criterion="entropy", random_state=seed).fit(
            x, y
        )
        doc = (
            f"Decision tree, {n} leaves: scikit-learn DecisionTreeClassifier(max_leaf_nodes={n}, "
            f'criterion="entropy", random_state={seed}) on all positions, written by '
            "chess-forces trees. Learned, not a force program."
        )
        text = tree_program(tree, names, doc)
        r = score.score(text, task)
        if int((y != tree.predict(x)).sum()) != r.errors:
            raise AssertionError("tree program disagrees with the tree it was made from")
        out[n] = text
    return out


def tree_path(n: int, directory: Path = TREES_DIR) -> Path:
    return directory / f"tree-{n:03d}.dsl"


def write_trees(task: score.Task, leaves=TREE_LEAVES, directory: Path = TREES_DIR) -> list[Path]:
    """Retrain the trees and save them as programs; the report reads these files, it does not train."""
    directory.mkdir(parents=True, exist_ok=True)
    paths = []
    for n, text in train_trees(task, leaves).items():
        paths.append(tree_path(n, directory))
        paths[-1].write_text(text)
    return paths


def tree_points(task: score.Task, directory: Path = TREES_DIR) -> list[Point]:
    """The saved trees (endgames/kpk/trees/tree-NNN.dsl), scored like any program."""
    out = []
    for path in sorted(directory.glob("tree-*.dsl")):
        n = int(path.stem.split("-")[1])
        r = score.score(path.read_text(), task)
        out.append(
            _from_report(
                f"decision tree, {n} leaves",
                "learned",
                r,
                f"greedy entropy tree as a DSL program, {path.relative_to(ROOT)}",
                path.read_text(),
            )
        )
    return out


# --- table nets (trained by nets.py, saved as integers) --------------------------------------------


def real_net_bytes(net: nets.Net, task: score.Task) -> int:
    """Weights as int8 with lzma plus a small header, exceptions as Elias-Fano or a bitmap."""
    J, _ = nets.rows(task, net.family)
    wrong = np.nonzero((net.logits(J) > 0) != np.array(task.truth))[0]
    shape = (list(nets.FAMILIES).index(net.family), net.hidden, net.bits)
    model = codec.encode_net(net.E, net.w, net.bias, shape)
    return len(model) + PROGRAM_LENGTH_BYTES + len(codec.encode_exceptions(task.n, wrong))


def net_points(task: score.Task) -> list[Point]:
    """Saved nets, evaluated exactly on all positions: those on their own frontier, the best per tier and
    every net without errors."""
    by_digest, stems = {}, {}
    for p in sorted(nets.NETS_DIR.glob("*.npz")):
        net = nets.load(p)
        if net.digest() not in by_digest:
            by_digest[net.digest()], stems[net.digest()] = net, p.stem
    results = [nets.evaluate(net, task) for net in by_digest.values()]
    keep = {r.digest for r in nets.frontier(results)}
    keep |= {r.digest for r in results if r.errors == 0}  # every exact net is shown
    for tier in TIERS:
        fits = [r for r in results if r.ops <= tier]
        if fits:
            keep.add(min(fits, key=lambda r: r.total).digest)
    kept = [r for r in sorted(results, key=lambda r: r.ops) if r.digest in keep]

    def plain(r):
        return f"net {r.family} {f'{r.hidden} hidden' if r.hidden else 'additive'}, {r.bits} bit"

    seen = [plain(r) for r in kept]
    out = []
    for r in kept:
        name = plain(r)
        if seen.count(name) > 1:  # same shape, other seed or sparsity: the file tells them apart
            name += f" ({stems[r.digest]})"
        out.append(
            Point(
                name,
                "learned",
                r.model_bytes,
                r.exception_bytes,
                r.errors,
                r.ops,
                r.ops,
                False,
                False,
                "table lookups plus a small output layer, integer weights, quantisation-aware training",
                f"digest {r.digest}, nets/{stems[r.digest]}.npz",
                r.state_bytes,
                real_bytes=real_net_bytes(by_digest[r.digest], task),
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
    "train_trees",
    "tree_points",
    "write_trees",
]
