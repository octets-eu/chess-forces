"""Table nets for the KPK task: the strongest learned baseline that is cheap to run (NNUE style).

A net looks up one row per index (a square, a relative square, a pair), adds the rows, applies ReLU and
a small output layer: wins if sum(w_j * max(0, sum_t E[index_t, j])) + bias > 0. Without a hidden layer
the rows are single numbers and their sum is compared with the bias. Weights are small integers, trained
with quantisation, so evaluation is exact integer arithmetic and the same on every machine.

Size: adaptive (KT) code length of the integer weights, 16 bits for the bias, 32 bits for the shape.
Operations: loads, index arithmetic, one load and one add per table and hidden unit, ReLU 1, output 2.
Like a DSL program, the model is held decoded; the decoded size is reported as state_bytes.
"""

import hashlib
import json
import math
import os
from concurrent.futures import ProcessPoolExecutor, as_completed
from dataclasses import asdict, dataclass
from pathlib import Path

import numpy as np

from . import endgames, score
from .dsl import EXCEPTION_LOOKUP_OPS, TIERS

NETS_DIR = endgames.KPK.nets


@dataclass(frozen=True)
class Table:
    size: int
    ops: int  # index arithmetic beyond what the family shares


@dataclass(frozen=True)
class Family:
    tables: tuple[str, ...]
    loads: int  # position fields read
    shared_ops: int  # files, ranks, pawn index


# ops: pawn index file*6+rank 4 (file, rank, multiply, add; constants fold into the base pointer);
# relative square: two subtractions, multiply, add; pair: multiply, add
TABLES = {
    "K": Table(64, 0),
    "k": Table(64, 0),
    "P": Table(24, 0),
    "t": Table(2, 0),
    "relK": Table(143, 4),
    "relk": Table(143, 4),
    "relKk": Table(225, 4),
    "KP": Table(64 * 24, 2),
    "kP": Table(64 * 24, 2),
    "Kk": Table(64 * 64, 2),
    "kPt": Table(64 * 24 * 2, 4),
    "KPt": Table(64 * 24 * 2, 4),
}
FAMILIES = {
    "squares": Family(("K", "k", "P", "t"), 4, 4),
    "relative": Family(("relK", "relk", "P", "t"), 4, 8),
    "relative3": Family(("relK", "relk", "relKk", "P", "t"), 4, 8),
    "pairs": Family(("KP", "kP", "t"), 4, 4),
    "pairs3": Family(("KP", "kP", "Kk", "t"), 4, 4),
    "pairs3t": Family(("KPt", "kPt", "Kk"), 4, 4),
}


def indices(task: score.Task) -> dict[str, np.ndarray]:
    """Row index of every position in every table (KPK)."""
    K, k, P, t = np.array([[p.K, p.k, p.P, p.tempo] for p in task.positions]).T
    f, r = (lambda s: s & 7), (lambda s: s >> 3)
    p24 = f(P) * 6 + r(P) - 1
    rel = lambda s: (f(s) - f(P) + 3) * 13 + (r(s) - r(P) + 6)
    return {
        "K": K,
        "k": k,
        "P": p24,
        "t": t,
        "relK": rel(K),
        "relk": rel(k),
        "relKk": (f(K) - f(k) + 7) * 15 + (r(K) - r(k) + 7),
        "KP": K * 24 + p24,
        "kP": k * 24 + p24,
        "Kk": K * 64 + k,
        "kPt": (k * 24 + p24) * 2 + t,
        "KPt": (K * 24 + p24) * 2 + t,
    }


def rows(task: score.Task, family: str) -> tuple[np.ndarray, int]:
    """Global row numbers (positions x tables) and the total number of rows."""
    ix = indices(task)
    base, cols = 0, []
    for name in FAMILIES[family].tables:
        cols.append(ix[name] + base)
        base += TABLES[name].size
    return np.stack(cols, axis=1).astype(np.int32), base


def code_bits(values: np.ndarray, alphabet: int) -> float:
    """Adaptive code length (Krichevsky-Trofimov) of integers from an alphabet, in bits."""
    if values.size == 0:
        return 0.0
    _, counts = np.unique(values, return_counts=True)
    a = alphabet / 2
    nats = math.lgamma(values.size + a) - math.lgamma(a)
    nats -= sum(math.lgamma(c + 0.5) - math.lgamma(0.5) for c in counts)
    return nats / math.log(2)


@dataclass
class Net:
    family: str
    hidden: int  # 0: additive
    bits: int
    E: np.ndarray  # integer rows x max(hidden, 1)
    w: np.ndarray  # integer output weights (empty when additive)
    bias: int
    seed: int = 0

    def logits(self, J: np.ndarray) -> np.ndarray:
        H = self.E.astype(np.int64)[J].sum(axis=1)
        if self.hidden == 0:
            return H[:, 0] + self.bias
        return np.maximum(H, 0) @ self.w.astype(np.int64) + self.bias

    def size_bits(self) -> float:
        levels = 2**self.bits - 1
        total = 32.0 + 16.0
        base = 0
        for name in FAMILIES[self.family].tables:
            n = TABLES[name].size
            total += code_bits(self.E[base : base + n].ravel(), levels)
            base += n
        return total + (code_bits(self.w, 31) if self.hidden else 0.0)

    def ops(self) -> int:
        fam = FAMILIES[self.family]
        T = len(fam.tables)
        index = fam.loads + fam.shared_ops + sum(TABLES[n].ops for n in fam.tables)
        if self.hidden == 0:
            return index + T + T + (T - 1) + 1  # base adds, loads, adds, compare
        return index + 2 * T + self.hidden * (T + (T - 1) + 1 + 2) + 1

    def state_bytes(self) -> int:
        return int(self.E.size + self.w.size + 2)

    def digest(self) -> str:
        h = hashlib.sha256()
        for part in (
            self.E.astype(np.int8).tobytes(),
            self.w.astype(np.int8).tobytes(),
            str(self.bias).encode(),
        ):
            h.update(part)
        return h.hexdigest()[:16]


def _best_bias(z: np.ndarray, y: np.ndarray) -> tuple[int, int]:
    """Integer bias b minimising the errors of (z + b > 0), and that number of errors."""
    values, inverse = np.unique(z, return_inverse=True)
    wins = np.bincount(inverse, weights=y.astype(float), minlength=values.size)
    total = np.bincount(inverse, minlength=values.size)
    draws = total - wins
    # predict win for z > c: cut after position i means values[0..i] are called draws
    lost = np.concatenate([[0], np.cumsum(wins)])
    false = np.concatenate([[draws.sum()], draws.sum() - np.cumsum(draws)])
    i = int(np.argmin(lost + false))
    cut = int(values[i - 1]) if i > 0 else int(values[0]) - 1
    return -cut, int((lost + false)[i])


def train(
    family: str,
    hidden: int,
    bits: int,
    seed: int,
    epochs: int = 240,
    lr: float = 0.02,
    l1: float = 0.0,
    task: score.Task | None = None,
) -> tuple[Net, int]:
    """Quantisation-aware training with Adam on all positions. Returns the integer net and its errors."""
    from scipy.sparse import csr_matrix

    task = task or score.kpk_task()
    J, D = rows(task, family)
    y = np.array(task.truth, dtype=np.float64)
    rng = np.random.default_rng(seed)
    N, T = J.shape
    width = max(hidden, 1)
    E = rng.normal(0, 0.5 / math.sqrt(T), (D, width))
    used = np.zeros(D, dtype=bool)
    used[J.ravel()] = True
    E[~used] = 0  # rows no position touches stay zero and cost next to nothing
    w = rng.choice([-1.0, 1.0], hidden) * rng.uniform(0.6, 1.0, hidden) if hidden else np.zeros(0)
    c = 0.0
    L, Lw = 2 ** (bits - 1) - 1, 15
    state = [np.zeros_like(E), np.zeros_like(E), np.zeros_like(w), np.zeros_like(w), 0.0, 0.0]
    batch, step = 4096, 0
    total_steps = epochs * math.ceil(N / batch)
    qat_from, freeze_from = int(0.3 * epochs), int(0.8 * epochs)
    sE, sw = 1.0, 1.0
    for epoch in range(epochs):
        qat = epoch >= qat_from
        if qat and epoch < freeze_from:
            sE = max(2 * np.abs(E).mean() / math.sqrt(L), 1e-6)
            sw = max(np.abs(w).max() / Lw, 1e-6) if hidden else 1.0
        order = rng.permutation(N)
        for start in range(0, N, batch):
            b = order[start : start + batch]
            Jb, yb = J[b], y[b]
            Eq = np.clip(np.round(E / sE), -L, L) * sE if qat else E
            wq = np.clip(np.round(w / sw), -Lw, Lw) * sw if qat and hidden else w
            H = Eq[Jb].sum(axis=1)
            if hidden:
                A = np.maximum(H, 0)
                z = A @ wq + c
            else:
                z = H[:, 0] + c
            g = (1 / (1 + np.exp(-np.clip(z, -30, 30))) - yb) / len(b)
            if hidden:
                gw = A.T @ g
                gH = (g[:, None] * wq) * (H > 0)
            else:
                gw = np.zeros(0)
                gH = g[:, None]
            Xb = csr_matrix(
                (np.ones(Jb.size), Jb.ravel(), np.arange(0, Jb.size + 1, T)), shape=(len(b), D)
            )
            gE = Xb.T @ gH
            if l1:
                gE = gE + l1 * np.sign(E)
            step += 1
            rate = lr * 0.5 * (1 + math.cos(math.pi * step / total_steps)) + 1e-5
            c1, c2 = 1 - 0.9**step, 1 - 0.999**step
            for p, grad, i in ((E, gE, 0), (w, gw, 2)):
                if grad.size:
                    state[i] = 0.9 * state[i] + 0.1 * grad
                    state[i + 1] = 0.999 * state[i + 1] + 0.001 * grad * grad
                    p -= rate * (state[i] / c1) / (np.sqrt(state[i + 1] / c2) + 1e-8)
            gc = float(g.sum())
            state[4] = 0.9 * state[4] + 0.1 * gc
            state[5] = 0.999 * state[5] + 0.001 * gc * gc
            c -= rate * (state[4] / c1) / (math.sqrt(state[5] / c2) + 1e-8)
    net = Net(
        family,
        hidden,
        bits,
        np.clip(np.round(E / sE), -L, L).astype(np.int8),
        np.clip(np.round(w / sw), -Lw, Lw).astype(np.int8),
        0,
        seed,
    )
    net.bias, errors = _best_bias(net.logits(J), np.array(task.truth))
    return net, errors


@dataclass
class Result:
    family: str
    hidden: int
    bits: int
    seed: int
    l1: float
    errors: int
    model_bytes: float
    exception_bytes: float
    ops: int
    state_bytes: int
    digest: str

    @property
    def total(self) -> float:
        return self.model_bytes + self.exception_bytes


def evaluate(net: Net, task: score.Task, l1: float = 0.0) -> Result:
    """Exact integer evaluation over every position."""
    J, _ = rows(task, net.family)
    errors = int(((net.logits(J) > 0) != np.array(task.truth)).sum())
    exc = score.exception_bits(task.n, errors) / 8 if errors else 0.0
    ops = net.ops() + (EXCEPTION_LOOKUP_OPS if errors else 0)
    return Result(
        net.family,
        net.hidden,
        net.bits,
        net.seed,
        l1,
        errors,
        net.size_bits() / 8,
        exc,
        ops,
        net.state_bytes(),
        net.digest(),
    )


def save(net: Net, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    np.savez_compressed(
        path,
        E=net.E,
        w=net.w,
        bias=np.int64(net.bias),
        meta=json.dumps([net.family, net.hidden, net.bits, net.seed]),
    )


def load(path: Path) -> Net:
    d = np.load(path, allow_pickle=False)
    family, hidden, bits, seed = json.loads(str(d["meta"]))
    return Net(family, hidden, bits, d["E"], d["w"], int(d["bias"]), seed)


def _job(args) -> tuple[Result, Net]:
    family, hidden, bits, seed, l1, epochs = args
    task = score.kpk_task()
    net, _ = train(family, hidden, bits, seed, epochs=epochs, l1=l1, task=task)
    return evaluate(net, task, l1), net


def grid() -> list[tuple]:
    sizes = (1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 24, 32, 48, 64, 96)
    jobs = []
    for family in ("squares", "relative", "relative3"):
        for h in sizes:
            jobs += [
                (family, h, bits, seed, l1, 400)
                for bits in (2, 3, 4)
                for l1 in (0.0, 3e-6)
                for seed in (0, 1)
            ]
    for family in FAMILIES:
        jobs += [(family, 0, bits, 0, l1, 300) for bits in (2, 3, 4, 5) for l1 in (0.0, 3e-6, 3e-5)]
    for h in (1, 2, 3, 4, 8):
        jobs += [("pairs", h, bits, 0, l1, 300) for bits in (2, 3) for l1 in (3e-6, 3e-5)]
    return jobs


def refine_grid() -> list[tuple]:
    """Second pass: stronger sparsity and more seeds around the best of the first pass."""
    return [
        ("relative3", h, bits, seed, l1, 400)
        for h in (5, 6, 8, 10, 12, 14)
        for bits in (3, 4)
        for l1 in (1e-5, 3e-5, 1e-4)
        for seed in (0, 1, 2)
    ] + [
        ("pairs3", 0, bits, seed, l1, 400)
        for bits in (4, 5)
        for l1 in (1e-6, 1e-5, 3e-5)
        for seed in (0, 1)
    ]


def frontier(results: list[Result]) -> list[Result]:
    front: list[Result] = []
    for r in sorted(results, key=lambda r: (r.ops, r.total)):
        if not front or r.total < front[-1].total:
            front.append(r)
    return front


def sweep(
    jobs: list[tuple] | None = None, processes: int | None = None, progress=print
) -> list[Result]:
    """Train the grid in parallel, save the nets on the bytes/operations frontier and the best per tier."""
    for v in ("OMP_NUM_THREADS", "VECLIB_MAXIMUM_THREADS", "OPENBLAS_NUM_THREADS"):
        os.environ.setdefault(v, "1")
    jobs = jobs or grid()
    out: list[tuple[Result, Net]] = []
    with ProcessPoolExecutor(processes or max(1, (os.cpu_count() or 4) - 2)) as pool:
        futures = [pool.submit(_job, j) for j in sorted(jobs, key=lambda j: -j[1])]
        for i, f in enumerate(as_completed(futures), 1):
            out.append(f.result())
            if i % 20 == 0 or i == len(futures):
                best = min((r for r, _ in out), key=lambda r: r.total)
                progress(
                    f"{i}/{len(futures)} nets, best total {best.total:,.0f} B ({best.family} h{best.hidden} b{best.bits}, {best.ops} ops)"
                )
    results = [r for r, _ in out]
    previous = NETS_DIR / "sweep.json"
    if previous.exists():
        fields = Result.__dataclass_fields__
        old = [
            Result(**{k: v for k, v in d.items() if k in fields})
            for d in json.loads(previous.read_text())
        ]
        results = old + results
    keep = {r.digest for r in frontier(results)}
    for tier in TIERS:
        fits = [r for r in results if r.ops <= tier]
        if fits:
            keep.add(min(fits, key=lambda r: r.total).digest)
    NETS_DIR.mkdir(parents=True, exist_ok=True)
    for r, net in out:
        if r.digest in keep:
            save(net, NETS_DIR / f"{r.family}-h{r.hidden}-b{r.bits}-s{r.seed}.npz")
    (NETS_DIR / "sweep.json").write_text(
        json.dumps(
            [{**asdict(r), "total": r.total} for r in sorted(results, key=lambda r: r.total)],
            indent=0,
        )
    )
    return results
