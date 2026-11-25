"""Score a program: size, exceptions and operations against a truth table (D2, D3, D4)."""

import hashlib
import json
import math
from collections.abc import Callable
from dataclasses import dataclass, field
from functools import cache

import zstandard

from . import kpk
from .dsl import (
    CAP,
    DSL_VERSION,
    EXCEPTION_LOOKUP_OPS,
    TIERS,
    Ctx,
    DslError,
    OpLimit,
    Position,
    canonical,
    compile_program,
    fingerprint,
    parse,
    size_bits,
)


@dataclass(frozen=True)
class Task:
    """A finite set of positions with the true answer 'the strong side wins'."""

    name: str
    positions: tuple[Position, ...]
    truth: tuple[bool, ...]
    sha256: str
    describe: Callable[[Position], tuple[str, ...]]  # features used to group errors

    @property
    def n(self) -> int:
        return len(self.truth)


class OverBudget(Exception):
    """The program exceeds the operation cap on a position."""


@dataclass
class Report:
    task: str
    n: int
    bits_program: float
    errors: int
    false_wins: int
    missed_wins: int
    bits_exceptions: float
    ops_mean: float
    ops_max: int
    tier: int | None
    zstd_bytes: int
    lzma_bytes: int
    program_hash: str
    dsl: str
    table_sha256: str
    clusters: list[tuple[str, int, str]] = field(default_factory=list)  # (label, count, sample FEN)
    samples: list[str] = field(default_factory=list)
    samples_truth: list[bool] = field(default_factory=list)  # true result of each sample

    @property
    def bits_total(self) -> float:
        return self.bits_program + self.bits_exceptions

    @property
    def bytes_total(self) -> float:
        return self.bits_total / 8

    def to_json(self) -> str:
        d = {k: v for k, v in self.__dict__.items()}
        d["bytes_program"] = self.bits_program / 8
        d["bytes_exceptions"] = self.bits_exceptions / 8
        d["bytes_total"] = self.bytes_total
        return json.dumps(d, indent=1, ensure_ascii=False)

    def text(self) -> str:
        lines = [
            f"task {self.task}, {self.n:,} positions (table {self.table_sha256[:12]}), {self.dsl}, program {self.program_hash}",
            f"program     {self.bits_program:10.1f} bits {self.bits_program / 8:10.1f} B   (zstd text {self.zstd_bytes} B, lzma {self.lzma_bytes} B, side check)",
            f"exceptions  {self.bits_exceptions:10.1f} bits {self.bits_exceptions / 8:10.1f} B   {self.errors:,} errors: {self.false_wins:,} false wins, {self.missed_wins:,} missed wins ({100 * self.errors / self.n:.2f}%)",
            f"total       {self.bits_total:10.1f} bits {self.bytes_total:10.1f} B",
            f"operations  mean {self.ops_mean:.1f}, max {self.ops_max}"
            + (f", tier {self.tier}" if self.tier else ", no tier"),
        ]
        if self.clusters:
            lines.append(
                "largest error groups (who moves, kind of mistake, pawn rank; example FEN):"
            )
            lines += [f"  {n:>6,}  {label:<34} {fen}" for label, n, fen in self.clusters]
        return "\n".join(lines)


def tier_for(ops: int) -> int | None:
    """Smallest tier that admits a program with this worst operation count."""
    return next((t for t in TIERS if ops <= t), None)


def log2_choose(n: int, k: int) -> float:
    if k in (0, n):
        return 0.0
    return (math.lgamma(n + 1) - math.lgamma(k + 1) - math.lgamma(n - k + 1)) / math.log(2)


def exception_bits(n: int, k: int) -> float:
    """log2 C(n, k) for which positions, plus the cost of k itself."""
    return log2_choose(n, k) + math.log2(n + 1)


def _fen(p: Position) -> str:
    board = {
        s: ("K" if side == "strong" else "k")
        if kind == "king"
        else (kind[0].upper() if side == "strong" else kind[0])
        for side, kind, s in p.men
    }
    rows = []
    for r in range(7, -1, -1):
        row, gap = "", 0
        for f in range(8):
            ch = board.get(r * 8 + f)
            if ch is None:
                gap += 1
            else:
                row += (str(gap) if gap else "") + ch
                gap = 0
        rows.append(row + (str(gap) if gap else ""))
    return "/".join(rows) + (" w - - 0 1" if p.tempo else " b - - 0 1")


def score(
    program_source: str, task: Task, cap: int = CAP, samples: int = 12, clusters: int = 12
) -> Report:
    """Parse, run over every position and score. Raises DslError or OverBudget."""
    prog = parse(program_source)
    run = compile_program(prog)
    ctx = Ctx(task.positions[0], cap)
    total_ops = 0
    max_ops = 0
    wrong: list[int] = []
    false_win = missed = 0
    for i, pos in enumerate(task.positions):
        ctx.pos, ctx.ops = pos, 0
        try:
            got = run(ctx)
        except OpLimit:
            raise OverBudget(f"over {cap} operations on {_fen(pos)}") from None
        total_ops += ctx.ops
        max_ops = max(max_ops, ctx.ops)
        if got != task.truth[i]:
            wrong.append(i)
            if got:
                false_win += 1
            else:
                missed += 1
    k = len(wrong)
    extra = EXCEPTION_LOOKUP_OPS if k else 0
    text = canonical(prog)
    top = max_ops + extra
    report = Report(
        task=task.name,
        n=task.n,
        bits_program=size_bits(prog),
        errors=k,
        false_wins=false_win,
        missed_wins=missed,
        bits_exceptions=exception_bits(task.n, k) if k else 0.0,
        ops_mean=total_ops / task.n + extra,
        ops_max=top,
        tier=tier_for(top),
        zstd_bytes=len(zstandard.ZstdCompressor(level=19).compress(text.encode())),
        lzma_bytes=_lzma_bytes(text.encode()),
        program_hash=hashlib.sha256(text.encode()).hexdigest()[:16],
        dsl=f"dsl {DSL_VERSION} {fingerprint()}",
        table_sha256=task.sha256,
    )
    _explain(report, task, wrong, clusters, samples)
    return report


def _lzma_bytes(data: bytes) -> int:
    import lzma

    return len(
        lzma.compress(
            data, format=lzma.FORMAT_RAW, filters=[{"id": lzma.FILTER_LZMA2, "preset": 9}]
        )
    )


def _explain(report: Report, task: Task, wrong: list[int], clusters: int, samples: int) -> None:
    groups: dict[str, list[int]] = {}
    for i in wrong:
        label = ", ".join(task.describe(task.positions[i]))
        label += " | " + ("false win" if not task.truth[i] else "missed win")
        groups.setdefault(label, []).append(i)
    ranked = sorted(groups.items(), key=lambda kv: (-len(kv[1]), kv[0]))
    report.clusters = [
        (label, len(ix), _fen(task.positions[ix[0]])) for label, ix in ranked[:clusters]
    ]
    if wrong:
        step = max(1, len(wrong) // samples)
        chosen = wrong[::step][:samples]
        report.samples = [_fen(task.positions[i]) for i in chosen]
        report.samples_truth = [task.truth[i] for i in chosen]


# --- tasks ---------------------------------------------------------------------------------------


def _kpk_features(p: Position) -> tuple[str, ...]:
    pawn = next(s for side, kind, s in p.men if kind == "pawn")
    return ("White moves" if p.tempo else "Black moves", f"pawn rank {(pawn >> 3) + 1}")


@cache
def kpk_task() -> Task:
    win = kpk.generate()
    if kpk.digest(win) != kpk.SHA256:
        raise AssertionError("KPK table hash mismatch")
    positions, truth = [], []
    for stm, p, wk, bk in kpk.iter_slots():
        positions.append(
            Position(
                [("strong", "king", wk), ("weak", "king", bk), ("strong", "pawn", p)],
                int(stm == kpk.WHITE),
            )
        )
        truth.append(win[stm, p, wk, bk])
    return Task("kpk", tuple(positions), tuple(truth), kpk.SHA256, _kpk_features)


TASKS = {"kpk": kpk_task}

__all__ = ["DslError", "OverBudget", "Report", "Task", "kpk_task", "score"]
