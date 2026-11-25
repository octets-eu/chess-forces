"""KPK baseline report: table, plot and JSON from the points in baselines.py."""

import json
from dataclasses import dataclass
from pathlib import Path

from . import baselines, dsl, score
from .baselines import Point

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "reports"
PROGRAMS = ROOT / "programs"
TREE_LEAVES = (2, 4, 8, 16, 32, 64, 96, 128)
NETS = ((8,), (16,), (32,), (64,), (128,), (16, 16))
PROGRAM_NAMES = {
    "always_win": "always win",
    "square": "rule of the square",
    "human": "human rules",
    "evolved-256": "evolved, 256 ops",
    "evolved-1024": "evolved, 1,024 ops",
}

# categorical slots 1-3 of the reference palette (validated for scatter use, all pairs), chart inks
BLUE, ORANGE, AQUA = "#257de0", "#f47230", "#00b894"
INK, INK_2, GRID, SURFACE = "#191919", "#666666", "#e6e6e6", "#ffffff"


@dataclass
class Report:
    points: list[Point]
    frontier: list[Point]
    dsl: str
    table: str

    def rows(self) -> list[dict]:
        return [{**p.row(), "frontier": p in self.frontier} for p in self.points]


def pareto(points: list[Point]) -> list[Point]:
    """Smallest total bytes at or below each operation count. Only points with counted operations."""
    known = sorted(
        (p for p in points if p.ops_max is not None and not p.estimated_ops),
        key=lambda p: (p.ops_max, p.bytes_total),
    )
    front: list[Point] = []
    for p in known:
        if not front or p.bytes_total < front[-1].bytes_total:
            front.append(p)
    return front


def build(nets=NETS, leaves=TREE_LEAVES) -> Report:
    task = score.kpk_task()
    points = list(baselines.table_points())
    points += baselines.tree_points(task, leaves)
    points += baselines.mlp_points(task, nets)
    for path, label in PROGRAM_NAMES.items():
        points.append(
            baselines.program_point(
                label, (PROGRAMS / f"{path}.dsl").read_text(), task, "DSL program, " + label
            )
        )
    return Report(
        points,
        pareto(points),
        f"dsl {dsl.DSL_VERSION} {dsl.fingerprint()}",
        score.kpk_task().sha256,
    )


def write(report: Report, out: Path = OUT) -> list[Path]:
    out.mkdir(exist_ok=True)
    paths = [out / "kpk.json", out / "kpk.md", out / "kpk.png"]
    paths[0].write_text(
        json.dumps({"dsl": report.dsl, "table": report.table, "points": report.rows()}, indent=1)
    )
    paths[1].write_text(_markdown(report))
    _plot(report, paths[2])
    return paths


def _markdown(report: Report) -> str:
    lines = [
        "# KPK baselines",
        "",
        (
            f"Task: KPK, 165,676 positions, table sha256 {report.table}. Language: {report.dsl}. "
            "Every number is total bytes: program or model size plus exceptions (log2 C(N, k), see "
            "docs/01-dsl-concept.md). Operations are 64-bit word operations, maximum over all positions, "
            "with 32 added for an exception lookup whenever there are errors. "
            "Marked with a dash: operations not measured. Marked (est): a rough estimate."
        ),
        "",
        "| | Total bytes | Model | Exceptions | Errors | Max ops |",
        "| --- | ---: | ---: | ---: | ---: | ---: |",
    ]
    for p in sorted(report.points, key=lambda p: (p.kind, p.bytes_total)):
        ops = (
            "–"
            if p.ops_max is None
            else f"{p.ops_max:,.0f}" + (" (est)" if p.estimated_ops else "")
        )
        star = " ★" if p in report.frontier else ""
        lines.append(
            f"| {p.name}{star} | {p.bytes_total:,.0f} | {p.bytes_model:,.1f} | {p.bytes_exceptions:,.1f} | {p.errors:,} | {ops} |"
        )
    lines += [
        "",
        "## What a force program has to beat",
        "",
        "Per operation tier: the smallest total among tables and learned models with counted operations, and the best force program at the same budget.",
        "",
        "| Tier | Best other method | Best force program | Difference |",
        "| ---: | --- | --- | ---: |",
    ]
    for tier in dsl.TIERS:
        others = [
            p
            for p in report.points
            if p.kind != "force"
            and p.ops_max is not None
            and not p.estimated_ops
            and p.ops_max <= tier
        ]
        force = [p for p in report.points if p.kind == "force" and p.ops_max <= tier]
        best_o = min(others, key=lambda p: p.bytes_total)
        best_f = min(force, key=lambda p: p.bytes_total)
        lines.append(
            f"| {tier:,} | {best_o.bytes_total:,.0f} B ({best_o.name}) | {best_f.bytes_total:,.0f} B ({best_f.name}) | "
            f"{best_f.bytes_total - best_o.bytes_total:+,.0f} B |"
        )
    lines += [
        "",
        (
            "★ on the frontier of counted points (smallest total bytes at or below that operation count). "
            "Tables: Syzygy's operations were not measured; lzma is one setting, and its operations come "
            "from decompression time (rough), because a single position needs the whole file unpacked. "
            "Learned baselines are trained on all positions and their exceptions are charged. The decision "
            "trees are written as DSL programs; the nets use 8-bit weights and count operations from their "
            "layer sizes. Seeds are fixed; results may change slightly with another scikit-learn build."
        ),
        "",
        (
            "Hand-written programs: programs/*.dsl. The human rules were written from chess theory and "
            "tuned by looking at groups of mistakes over about 20 quick runs."
        ),
    ]
    return "\n".join(lines) + "\n"


def _plot(report: Report, path: Path) -> None:
    import matplotlib as mpl

    mpl.use("Agg")
    import matplotlib.pyplot as plt

    plt.rcParams.update(
        {
            "font.family": ["Helvetica", "Arial", "sans-serif"][0],
            "font.size": 10,
            "axes.edgecolor": INK_2,
            "axes.labelcolor": INK,
            "xtick.color": INK_2,
            "ytick.color": INK_2,
        }
    )
    fig, ax = plt.subplots(figsize=(10.5, 6.6), dpi=150, facecolor=SURFACE)
    ax.set_facecolor(SURFACE)
    style = {
        "table": (AQUA, "s", "Tables and decoders"),
        "learned": (ORANGE, "^", "Learned (tree, net)"),
        "force": (BLUE, "o", "Force-language programs"),
    }
    for kind, (color, marker, label) in style.items():
        pts = [p for p in report.points if p.kind == kind and p.ops_max is not None]
        solid = [p for p in pts if not p.estimated_ops]
        hollow = [p for p in pts if p.estimated_ops]
        ax.scatter(
            [p.ops_max for p in solid],
            [p.bytes_total for p in solid],
            s=70,
            marker=marker,
            color=color,
            edgecolors=SURFACE,
            linewidths=1.2,
            zorder=3,
            label=label,
        )
        if hollow:
            ax.scatter(
                [p.ops_max for p in hollow],
                [p.bytes_total for p in hollow],
                s=70,
                marker=marker,
                facecolors=SURFACE,
                edgecolors=color,
                linewidths=1.8,
                zorder=3,
            )
    front = report.frontier
    ax.plot(
        [p.ops_max for p in front],
        [p.bytes_total for p in front],
        color=INK_2,
        lw=1.2,
        zorder=2,
        drawstyle="steps-post",
        label="Frontier of counted points",
    )
    syz = next((p for p in report.points if p.ops_max is None), None)
    if syz:
        ax.axhline(syz.bytes_total, color=AQUA, lw=1.2, ls=(0, (5, 4)), zorder=1)
        ax.text(
            0.985,
            syz.bytes_total * 1.07,
            f"{syz.name}: {syz.bytes_total:,.0f} B, operations not measured",
            color=INK_2,
            fontsize=9,
            ha="right",
            transform=ax.get_yaxis_transform(),
        )
    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.yaxis.set_major_locator(mpl.ticker.LogLocator(base=10, subs=(1.0, 2.0, 3.0, 5.0)))
    ax.yaxis.set_major_formatter(mpl.ticker.FuncFormatter(lambda v, _: f"{v:,.0f}"))
    ax.yaxis.set_minor_formatter(mpl.ticker.NullFormatter())
    ax.xaxis.set_major_formatter(mpl.ticker.FuncFormatter(lambda v, _: f"{v:,.0f}"))
    ax.set_xlim(14, 900_000)
    ax.set_ylim(2_300, 32_000)
    ax.grid(True, which="major", color=GRID, lw=0.8, zorder=0)
    ax.set_xlabel("Operations per position, worst case (64-bit word operations)")
    ax.set_ylabel("Total bytes (program or model, plus exceptions)")
    ax.set_title(
        "KPK: size against compute (smaller is better)", loc="left", fontsize=13, color=INK, pad=12
    )
    ax.spines[["top", "right"]].set_visible(False)
    ax.legend(frameon=False, loc="upper right", fontsize=9)
    labels = {
        "bitbase (all slots)": (9, 4, "left"),
        "always win": (9, 4, "left"),
        "rule of the square": (9, 4, "left"),
        "decision tree, 64 leaves": (-9, -4, "right"),
        "decision tree, 128 leaves": (-9, -14, "right"),
        "net 8": (-8, -14, "right"),
        "human rules": (9, 8, "left"),
        "evolved, 256 ops": (9, -14, "left"),
        "evolved, 1,024 ops": (9, 6, "left"),
        "net 16": (9, 4, "left"),
        "net 32": (9, 4, "left"),
        "net 64": (9, -14, "left"),
        "net 128": (9, 4, "left"),
        "lzma of the bitbase": (9, 6, "left"),
    }
    for p in report.points:
        if p.name in labels and p.ops_max is not None:
            dx, dy, ha = labels[p.name]
            text = p.name + (" (operations estimated)" if p.estimated_ops else "")
            ax.annotate(
                text,
                (p.ops_max, p.bytes_total),
                xytext=(dx, dy),
                textcoords="offset points",
                fontsize=8.5,
                color=INK,
                ha=ha,
            )
    fig.tight_layout()
    fig.savefig(path, facecolor=SURFACE)
    plt.close(fig)


__all__ = ["OUT", "Report", "build", "pareto", "write"]
