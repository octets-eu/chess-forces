"""Move a program into its endgame's programs/ folder when it beats the best one of its tier.

A program is promoted if its total is smaller than that of every force program already in the folder
whose worst case fits the same tier, or if it has no errors at all: every exact program is kept. It is copied with a comment on where it came from (comments are
free: size is computed on the syntax tree), scored again, and older programs stay. The report then
plots it, because it reads every file in programs/.
"""

import datetime
import math
import re
from dataclasses import dataclass
from pathlib import Path

from . import endgames, score
from .score import DslError, OverBudget


@dataclass
class Outcome:
    source: str
    promoted: Path | None
    reason: str


def _shown(path: Path) -> str:
    """Path relative to the repository, else the bare file name (no home directories in the repo)."""
    try:
        return str(path.resolve().relative_to(endgames.ROOT))
    except ValueError:
        return path.name


def _name(stem: str) -> str:
    return re.sub(r"[^A-Za-z0-9_-]+", "-", stem).strip("-") or "program"


def promote(
    paths: list[Path],
    endgame: endgames.Endgame = endgames.KPK,
    prefix: str = "",
    today: datetime.date | None = None,
    names: list[str] | None = None,
) -> list[Outcome]:
    """Score each file in order and copy the ones that beat their tier; later files see earlier ones."""
    task = endgame.task()
    day = (today or datetime.date.today()).isoformat()
    known: dict[Path, tuple[float, int]] = {}
    hashes: set[str] = set()
    for p in sorted(endgame.programs.glob("*.dsl")):
        r = score.score(p.read_text(), task)
        known[p] = (r.bytes_total, r.ops_max)
        hashes.add(r.program_hash)
    out = []
    for i, path in enumerate(map(Path, paths)):
        source = _shown(path)
        stem = names[i] if names else path.stem
        text = path.read_text()
        try:
            r = score.score(text, task)
        except (DslError, OverBudget) as e:
            out.append(Outcome(source, None, f"rejected: {e}"))
            continue
        tier = r.tier
        best = min((b for b, ops in known.values() if ops <= tier), default=math.inf)
        if r.program_hash in hashes:
            out.append(Outcome(source, None, "the same program is there already"))
            continue
        exact = r.errors == 0
        if r.bytes_total >= best and not exact:
            out.append(
                Outcome(
                    source,
                    None,
                    f"{r.bytes_total:,.1f} B is not smaller than {best:,.1f} B in tier {tier:,}",
                )
            )
            continue
        dest = endgame.programs / f"{_name(prefix + stem)}.dsl"
        if dest.exists():
            out.append(Outcome(source, None, f"{dest.name} exists already"))
            continue
        header = (
            f"# Promoted {day} from {source}: {r.bytes_total:,.1f} B "
            f"({r.bits_program / 8:,.1f} B program, {r.bits_exceptions / 8:,.1f} B exceptions), "
            f"{r.errors:,} errors, at most {r.ops_max:,} operations, tier {tier:,}.\n"
        )
        endgame.programs.mkdir(parents=True, exist_ok=True)
        dest.write_text(header + text)
        again = score.score(dest.read_text(), task)
        if (again.bits_total, again.errors, again.ops_max) != (r.bits_total, r.errors, r.ops_max):
            dest.unlink()
            raise AssertionError(f"{dest.name} scores differently after copying")
        known[dest] = (r.bytes_total, r.ops_max)
        hashes.add(r.program_hash)
        was = "" if best == math.inf else f", best so far {best:,.1f} B"
        why = (
            "exact, kept"
            if exact and r.bytes_total >= best
            else f"{r.bytes_total:,.1f} B in tier {tier:,}{was}"
        )
        out.append(Outcome(source, dest, why))
    return out


__all__ = ["Outcome", "promote"]
