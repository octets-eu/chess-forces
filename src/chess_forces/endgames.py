"""One folder per endgame (endgames/<name>/): its programs, learned references and report.

The folder decides the endgame. Force programs live in programs/, decision trees in trees/, nets in
nets/, Syzygy measurements in syzygy.json; report.md, report.json, report.png and analysis.md sit in
the folder's root.
"""

from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
ENDGAMES = ROOT / "endgames"


@dataclass(frozen=True)
class Endgame:
    name: str  # folder name and task name in score.TASKS
    syzygy: str  # Syzygy table name, e.g. KPvK

    @property
    def folder(self) -> Path:
        return ENDGAMES / self.name

    @property
    def programs(self) -> Path:
        return self.folder / "programs"

    @property
    def trees(self) -> Path:
        return self.folder / "trees"

    @property
    def nets(self) -> Path:
        return self.folder / "nets"

    @property
    def syzygy_ops(self) -> Path:
        return self.folder / "syzygy.json"

    def report(self, suffix: str) -> Path:
        return self.folder / f"report.{suffix}"

    def task(self):
        from . import score

        return score.TASKS[self.name]()


KPK = Endgame("kpk", "KPvK")
ALL = {e.name: e for e in (KPK,)}


def of_path(path: str | Path) -> Endgame | None:
    """The endgame whose folder holds this file, or None for a file elsewhere."""
    try:
        rel = Path(path).resolve().relative_to(ENDGAMES)
    except ValueError:
        return None
    return ALL.get(rel.parts[0]) if rel.parts else None
