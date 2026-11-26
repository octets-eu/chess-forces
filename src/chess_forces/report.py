"""KPK baseline report: table, plot and JSON from the points in baselines.py."""

import json
from dataclasses import dataclass
from pathlib import Path

from . import baselines, codec, dsl, endgames, score
from .baselines import Point

ENDGAME = endgames.KPK
PROGRAMS = ENDGAME.programs

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


def build() -> Report:
    task = score.kpk_task()
    points = list(baselines.table_points())
    points += baselines.tree_points(task)
    points += baselines.net_points(task)
    for path in sorted(PROGRAMS.glob("*.dsl")):
        points.append(
            baselines.program_point(
                path.stem, path.read_text(), task, f"DSL program, programs/{path.name}"
            )
        )
    return Report(
        points,
        pareto(points),
        f"dsl {dsl.DSL_VERSION} {dsl.fingerprint()}",
        score.kpk_task().sha256,
    )


def write(report: Report, endgame: endgames.Endgame = ENDGAME) -> list[Path]:
    endgame.folder.mkdir(parents=True, exist_ok=True)
    paths = [endgame.report("json"), endgame.report("md"), endgame.report("png")]
    paths[0].write_text(
        json.dumps({"dsl": report.dsl, "table": report.table, "points": report.rows()}, indent=1)
    )
    paths[1].write_text(_markdown(report))
    _plot(report, paths[2])
    return paths


def _markdown(report: Report) -> str:
    lines = [
        "# KPK report",
        "",
        (
            f"Task: KPK, 165,676 positions, table sha256 {report.table}. Language: {report.dsl}. "
            "Every number is total bytes: program or model size plus exceptions. For programs and learned "
            "models both parts are information bounds (grammar code or an adaptive code over the weights, "
            "and log2 C(N, k)); tables are real files. See docs/01-dsl-concept.md. Operations are 64-bit word "
            "operations, maximum over all positions, with 32 added for an exception lookup whenever there "
            "are errors. Marked with a dash: operations not measured. Marked (est): a rough estimate."
        ),
    ]
    syz = next((p for p in report.points if p.kind == "table" and p.ops_max is None), None)
    force = sorted((p for p in report.points if p.kind == "force"), key=lambda p: p.bytes_total)
    if syz:
        lines += [
            "",
            "## Against the target: Syzygy",
            "",
            (
                f"The target is the Syzygy file of the endgame, with at most 4,096 operations per position: "
                f"{syz.name}, {syz.bytes_total:,.0f} B on disk, operations not measured. The comparison uses "
                "real sizes: the program as one mixed-radix integer over its grammar choices (the tests "
                f"decode it back) with a {baselines.PROGRAM_LENGTH_BYTES}-byte length, and the exceptions as "
                f"Elias-Fano with a select sample every {codec.SELECT_STRIDE} zeros, or a bitmap where that "
                "is smaller, so one position can be looked up without unpacking the rest (src/chess_forces/"
                "codec.py). The bound is the score: grammar code plus log2 C(N, k)."
            ),
            "",
            "| Force program | Real bytes | Bound | Max ops | Against Syzygy |",
            "| --- | ---: | ---: | ---: | ---: |",
        ]
        for p in sorted(force, key=lambda p: p.real_bytes):
            d = p.real_bytes - syz.bytes_total
            lines.append(
                f"| {p.name} | {p.real_bytes:,.0f} | {p.bytes_total:,.0f} | {p.ops_max:,.0f} | "
                f"{d:+,.0f} B ({d / syz.bytes_total:+.0%}) |"
            )
    lines += [
        "",
        "## All methods",
        "",
        "Total bytes is the bound used for ranking and the plot; real bytes is an actual encoding.",
        "",
        "| | Total bytes | Real bytes | Model | Exceptions | Errors | Max ops |",
        "| --- | ---: | ---: | ---: | ---: | ---: | ---: |",
    ]
    for p in sorted(report.points, key=lambda p: (p.kind, p.bytes_total)):
        ops = (
            "–"
            if p.ops_max is None
            else f"{p.ops_max:,.0f}" + (" (est)" if p.estimated_ops else "")
        )
        star = " ★" if p in report.frontier else ""
        real = "–" if p.real_bytes is None else f"{p.real_bytes:,.0f}"
        lines.append(
            f"| {p.name}{star} | {p.bytes_total:,.0f} | {real} | {p.bytes_model:,.1f} | {p.bytes_exceptions:,.1f} | {p.errors:,} | {ops} |"
        )
    lines += [
        "",
        "## References per tier",
        "",
        (
            "Tables and learned models are references, not targets: they show how much of a win over "
            "Syzygy comes from the concepts and how much from Syzygy's general file format. Per operation "
            "tier: the smallest reference with counted operations, and the best force program at the same budget."
        ),
        "",
        "| Tier | Best reference | Best force program | Difference |",
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
        fits = [p for p in force if p.ops_max <= tier]
        best_o = min(others, key=lambda p: p.bytes_total)
        best_f = min(fits, key=lambda p: p.bytes_total)
        lines.append(
            f"| {tier:,} | {best_o.bytes_total:,.0f} B ({best_o.name}) | {best_f.bytes_total:,.0f} B ({best_f.name}) | "
            f"{best_f.bytes_total - best_o.bytes_total:+,.0f} B |"
        )
    lines += [
        "",
        (
            "★ on the frontier of counted points (smallest total bytes at or below that operation count). "
            "Tables: Syzygy's operations were not measured; lzma is one setting, and its operations come "
            "from decompression time (rough, and different on every run), because a single position needs "
            "the whole file unpacked. "
            "Learned baselines are trained on all positions and their exceptions are charged. The decision "
            "trees are DSL programs in trees/, retrained only by chess-forces trees. The nets "
            "(src/chess_forces/nets.py) look up one row per square or "
            "square pair, add the rows and apply a small output layer; weights are integers, stored in "
            "nets/ and evaluated exactly, so the numbers do not depend on the machine. Net sizes use an "
            "adaptive code over the integer weights. A model may be held decoded (a DSL program and a net are); "
            "tables must be read at random. That rule is a choice: unpacked once, the lzma bitbase would need 20 "
            "operations too, but 24,576 bytes of memory, against at most a few KB for the nets."
        ),
        "",
        (
            "Force programs: programs/*.dsl, hand-written or found by search. Paths are relative to this "
            "folder. The human rules were written "
            "from chess theory and tuned by looking at groups of mistakes over about 20 quick runs."
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
        "table": (AQUA, "s", "Table references"),
        "learned": (ORANGE, "^", "Learned references (tree, net)"),
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
            f"Target: {syz.name}, {syz.bytes_total:,.0f} B (operations not measured)",
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
    ax.set_ylim(min(p.bytes_total for p in report.points) * 0.75, 32_000)
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
        "always_win": (9, 4, "left"),
        "square": (9, 4, "left"),
        "decision tree, 64 leaves": (9, -4, "left"),
        "human": (9, 6, "left"),
        "evolved-256": (9, -14, "left"),
        "evolved-1024": (-9, -18, "right"),
        "r1-trimmed-966": (9, -18, "left"),
        "r1-unit-831": (9, 8, "left"),
        "lzma of the bitbase": (9, 6, "left"),
        "net pairs3 additive, 5 bit": None,  # named in the report's table; no room on the plot
        "net relative3 14 hidden, 4 bit": (9, -4, "left"),
    }
    tier_best = {
        min(
            (q for q in report.points if q.kind == "learned" and q.ops_max <= t),
            key=lambda q: q.bytes_total,
        ).name
        for t in dsl.TIERS
    }
    # Labels: preferred offsets first, then the first free spot, so points added later
    # (promoted programs) do not write over each other.
    fig.canvas.draw()
    renderer = fig.canvas.get_renderer()
    placed = []
    spots = [(9, 4, "left"), (9, -14, "left"), (9, 16, "left"), (9, -26, "left"), (-9, 4, "right")]
    chosen = [
        p
        for p in report.points
        if p.ops_max is not None
        and (p.name in labels or p.name in tier_best or p.kind == "force")
        and labels.get(p.name, ()) is not None
    ]
    chosen.sort(key=lambda p: (p.name not in labels, p.ops_max))
    for p in chosen:
        text = p.name + (" (operations estimated)" if p.estimated_ops else "")
        tries = ([labels[p.name]] if p.name in labels else []) + spots
        for dx, dy, ha in tries:
            far = abs(dy) > 8  # a leader line shows which point a moved label belongs to
            ann = ax.annotate(
                text,
                (p.ops_max, p.bytes_total),
                xytext=(dx, dy),
                textcoords="offset points",
                fontsize=8.5,
                color=INK,
                ha=ha,
                arrowprops={
                    "arrowstyle": "-",
                    "color": INK_2,
                    "lw": 0.6,
                    "shrinkA": 1,
                    "shrinkB": 4,
                }
                if far
                else None,
            )
            box = ann.get_window_extent(renderer)
            if not any(box.overlaps(q) for q in placed):
                placed.append(box)
                break
            ann.remove()
        else:
            placed.append(box)
            ax.add_artist(ann)
    fig.tight_layout()
    fig.savefig(path, facecolor=SURFACE)
    plt.close(fig)


__all__ = ["ENDGAME", "PROGRAMS", "Report", "build", "pareto", "write"]
