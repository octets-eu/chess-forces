"""Single-user evolutionary search over DSL programs (docs/02-agent-loop.md).

One SQLite archive holds programs and work units; the spend ledger (budget.py) holds money and the
raw answers. Everything needed to resume is on disk before the API is called.
"""

import json
import multiprocessing
import random
import re
import signal
import sqlite3
import threading
import time
from collections.abc import Callable
from concurrent.futures import FIRST_COMPLETED, ProcessPoolExecutor, ThreadPoolExecutor, wait
from dataclasses import dataclass, field
from pathlib import Path

from . import dsl, endgames, score
from .budget import BudgetExceeded, Guard, NotBilled
from .score import DslError, OverBudget


class SearchStopped(Exception):
    """The API rejected the request in a way that would repeat for every unit."""


DEFAULT_MODEL = "claude-haiku-5-5"
ISLAND_TIERS = (64, 256, 1024, 4096)
LEGACY_ISLANDS = (256, 1024, 1024, 4096)  # run r1, before islands were stored
MAX_TOKENS = 6000
SEEDS = ("always_win", "square", "human")
CODE = re.compile(r"\x60\x60\x60[a-zA-Z]*\n(.*?)\x60\x60\x60", re.DOTALL)
PROGRAMS = endgames.KPK.programs


SYSTEM = """You improve small programs that decide whether the strong side wins a chess endgame.
Programs are written in the language below and judged exactly: every position of the endgame is
checked against the true result from a solved table. Nothing is sampled and there is no partial credit.

THE ENDGAME
KPK: the strong side (White) has king K and one pawn P, the weak side (Black) has king k. The pawn
stands on files 0 to 3 (a-d; the board is mirrored otherwise). wins() must return True exactly when
White wins with best play by both sides, and False when it is a draw. Both sides may be to move:
tempo is 1 when White moves and 0 when Black moves. Squares are sq(file, rank), file 0..7 (a..h) and
rank 0..7, where rank 0 is White's back rank and rank 7 is the promotion rank. The pawn is on rank 1..6.
There are no other pieces. A program sees the position only through the primitives; it cannot play moves.

THE LANGUAGE
{SPEC}

Semantics that matter
- none (a missing square, for example sq off the board, or P if there is not exactly one pawn): every
  operation on none gives inf (99), False, an empty Field or none; it never fails.
- Int saturates at +-99. Literals are integers from -8 to 63. abs, min, max, + and - work on Int.
- Field is a set of squares. men(side, kind) gives the squares of a side's men; king_f(s), ray, hits,
  guard, path, within, flood and steps give Fields or distances. guard(side) is every square that side
  attacks now; guard_x(side, s) is the same with the man on s removed.
- dist is king moves on an empty board (Chebyshev); steps(s, t, F) is the number of king moves from s
  to t moving only through squares in F (t must be in F), or inf; flood(s, F) is all squares reachable.
- any(condition for s in Field) is a loop over the squares of a Field, and count(s for s in Field if
  condition) counts them. Conditions may use the loop square. These are the only loops.
- A program is def statements; the last is wins() -> Bool. Every value that is used twice should be
  named once (x = ...). Functions may take parameters annotated with Int, Bool, Sq or Field.
- No imports, strings, floats, lists, while or for statements, chained comparisons, attributes, lambda.

THE SCORE
total bytes = program bytes + exception bytes. A program's size is the number of bits needed to choose
each of its parts among everything that could stand there (an Int literal costs about 10 bits, a
primitive about 5, a variable in scope about 5). Exceptions: the k positions the program gets wrong must
be listed; that costs log2(choose(165676, k)) bits, roughly 17 bits per error when errors are few,
about 8 bits per error around a thousand, and 5 to 6 around ten thousand.
Smaller total is better. Remove errors, but only with conditions that are worth their own bits.
Operations: each program step costs operations (shown in the language table); the limit is the
worst case over all positions. Exceeding it is a rejection.

OUTPUT
Write at most three sentences saying what you change and why. Then the complete program in one
python code block (three backticks) and nothing after it. Do not write comments inside the block."""


HINTS = (
    "make the program shorter without losing accuracy: remove anything that does not earn its bits",
    "the largest error group: what single distance, tempo or square relation separates those positions?",
    (
        "confrontation of the kings: opposition (kings two apart on a file or rank with one square between), "
        "and which side has to move"
    ),
    "flood or steps: whether the weak king can reach the squares it needs before the strong king cuts it off",
    "captures: when the weak king attacks the pawn, when the strong king defends it, and who moves first",
    "the rook pawn and the corner: which squares the weak king must reach to draw",
    "pawn on the 6th and 7th rank: support squares around the promotion square",
    "replace a hand-tuned set of squares with a force: hits, guard or king_f of one of the kings",
    "an idea that uses few operations: what can a single comparison decide?",
)


def system_text() -> str:
    return SYSTEM.replace("{SPEC}", dsl.spec())


def extract(text: str) -> str:
    blocks = CODE.findall(text)
    if not blocks:
        raise DslError("no code block in the answer")
    return blocks[-1].strip() + "\n"


@dataclass
class Scored:
    """A program in an island's population."""

    id: int
    text: str
    total: float
    prog_bytes: float
    exc_bytes: float
    errors: int
    false_wins: int
    missed: int
    ops_max: int
    tier: int | None
    feedback: dict = field(default_factory=dict)


SCHEMA = """
create table if not exists programs (
    id integer primary key, island integer not null, text text not null, hash text not null,
    total real not null, prog_bytes real not null, exc_bytes real not null, errors integer not null,
    false_wins integer not null, missed integer not null, ops_max integer not null, tier integer,
    feedback text not null, parents text not null, unit integer, unique (island, hash));
create table if not exists meta (k text primary key, v text not null);
create table if not exists units (
    unit integer primary key, island integer not null, key text not null, prompt text not null,
    status text not null, note text not null default '', parents text not null default '[]');
"""


class Archive:
    """Programs and units of one run. One connection guarded by a lock."""

    def __init__(self, path: Path):
        path.parent.mkdir(parents=True, exist_ok=True)
        self._db = sqlite3.connect(path, check_same_thread=False, isolation_level=None)
        self._lock = threading.Lock()
        self._db.executescript(SCHEMA)

    def close(self) -> None:
        self._db.close()

    def _rows(self, q: str, args=()) -> list[tuple]:
        with self._lock:
            return self._db.execute(q, args).fetchall()

    def population(self, island: int, max_ops: int) -> list[Scored]:
        rows = self._rows(
            "select id, text, total, prog_bytes, exc_bytes, errors, false_wins, missed, ops_max, tier, feedback "
            "from programs where island = ? and ops_max <= ? order by total, id",
            (island, max_ops),
        )
        return [Scored(*r[:-1], json.loads(r[-1])) for r in rows]

    def add(self, island: int, s: Scored, unit: int | None, parents: list[int]) -> bool:
        with self._lock:
            cur = self._db.execute(
                "insert or ignore into programs (island, text, hash, total, prog_bytes, exc_bytes, errors, "
                "false_wins, missed, ops_max, tier, feedback, parents, unit) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                (
                    island,
                    s.text,
                    hash_of(s.text),
                    s.total,
                    s.prog_bytes,
                    s.exc_bytes,
                    s.errors,
                    s.false_wins,
                    s.missed,
                    s.ops_max,
                    s.tier,
                    json.dumps(s.feedback),
                    json.dumps(parents),
                    unit,
                ),
            )
            return cur.rowcount > 0

    def count(self) -> int:
        return self._rows("select count(*) from programs")[0][0]

    def next_unit(self) -> int:
        return (self._rows("select max(unit) from units")[0][0] or 0) + 1

    def add_unit(self, unit: int, island: int, key: str, prompt: str, parents: list[int]) -> None:
        with self._lock:
            self._db.execute(
                "insert into units (unit, island, key, prompt, status, parents) values (?,?,?,?,'called',?)",
                (unit, island, key, prompt, json.dumps(parents)),
            )

    def unit_parents(self, unit: int) -> list[int]:
        rows = self._rows("select parents from units where unit = ?", (unit,))
        return json.loads(rows[0][0]) if rows else []

    def finish_unit(self, unit: int, status: str, note: str = "") -> None:
        with self._lock:
            self._db.execute(
                "update units set status = ?, note = ? where unit = ?", (status, note, unit)
            )

    def open_units(self) -> list[tuple[int, int, str, str]]:
        return self._rows(
            "select unit, island, key, prompt from units where status = 'called' order by unit"
        )

    def staleness(self, island: int, max_ops: int) -> int:
        """Finished units on an island since the one that produced its current best program."""
        rows = self._rows(
            "select coalesce(unit, 0) from programs where island = ? and ops_max <= ? order by total, id limit 1",
            (island, max_ops),
        )
        best_unit = rows[0][0] if rows else 0
        return self._rows(
            "select count(*) from units where island = ? and unit > ? and status != 'called'",
            (island, best_unit),
        )[0][0]

    def meta(self, key: str) -> str | None:
        rows = self._rows("select v from meta where k = ?", (key,))
        return rows[0][0] if rows else None

    def set_meta(self, key: str, value: str) -> None:
        with self._lock:
            self._db.execute("insert or replace into meta values (?, ?)", (key, value))

    def unit_counts(self) -> dict[str, int]:
        return dict(self._rows("select status, count(*) from units group by status"))

    def best_overall(self, n: int) -> list[Scored]:
        """Best programs of the archive, any island and operation count, without repeats."""
        rows = self._rows(
            "select min(id), text, total, prog_bytes, exc_bytes, errors, false_wins, missed, ops_max, tier, feedback "
            "from programs where unit is not null group by hash order by total limit ?",
            (n,),
        )
        return [Scored(*r[:-1], json.loads(r[-1])) for r in rows]

    def recent_rejections(self, island: int, n: int = 4) -> list[str]:
        rows = self._rows(
            "select note from units where island = ? and status = 'rejected' order by unit desc limit ?",
            (island, n),
        )
        return [r[0] for r in rows]

    def best_per_tier(self) -> dict[int, Scored]:
        out: dict[int, Scored] = {}
        for t in dsl.TIERS:
            rows = self._rows(
                "select id, text, total, prog_bytes, exc_bytes, errors, false_wins, missed, ops_max, tier, feedback "
                "from programs where ops_max <= ? order by total, id limit 1",
                (t,),
            )
            if rows:
                r = rows[0]
                out[t] = Scored(*r[:-1], json.loads(r[-1]))
        return out


def hash_of(text: str) -> str:
    import hashlib

    return hashlib.sha256(dsl.canonical(dsl.parse(text)).encode()).hexdigest()[:16]


class Evaluator:
    """Scores program text against a task; keeps what prompts need to show about its errors."""

    def __init__(self, task: score.Task):
        self.task = task

    def evaluate(self, text: str) -> Scored:
        r = score.score(text, self.task, samples=12, clusters=6)
        return Scored(
            id=0,
            text=text,
            total=r.bytes_total,
            prog_bytes=r.bits_program / 8,
            exc_bytes=r.bits_exceptions / 8,
            errors=r.errors,
            false_wins=r.false_wins,
            missed=r.missed_wins,
            ops_max=r.ops_max,
            tier=r.tier,
            feedback={
                "clusters": [[label, n, fen] for label, n, fen in r.clusters],
                "samples": [
                    [fen, bool(t)] for fen, t in zip(r.samples, r.samples_truth, strict=True)
                ],
            },
        )

    def close(self) -> None:
        pass


_WORKER: Evaluator | None = None


def _init_worker(task_name: str) -> None:
    global _WORKER
    signal.signal(signal.SIGINT, signal.SIG_IGN)  # Ctrl-C is handled by the parent
    _WORKER = Evaluator(score.TASKS[task_name]())


def _work(text: str) -> Scored:
    assert _WORKER is not None
    return _WORKER.evaluate(text)


class PoolEvaluator:
    """Evaluator in worker processes, so threads that wait for answers do not queue on one core."""

    def __init__(self, task_name: str = "kpk", processes: int = 10):
        self._pool = ProcessPoolExecutor(
            processes,
            mp_context=multiprocessing.get_context("spawn"),
            initializer=_init_worker,
            initargs=(task_name,),
        )

    def evaluate(self, text: str) -> Scored:
        return self._pool.submit(_work, text).result()

    def close(self) -> None:
        self._pool.shutdown(cancel_futures=True)


def seed_programs() -> dict[str, str]:
    return {name: (PROGRAMS / f"{name}.dsl").read_text() for name in SEEDS}


def _block(s: Scored, label: str) -> str:
    lines = [
        (
            f"### {label}: total {s.total:,.0f} bytes (program {s.prog_bytes:,.0f}, exceptions {s.exc_bytes:,.0f}), "
            f"{s.errors:,} errors ({s.false_wins:,} false wins, {s.missed:,} missed wins), operations max {s.ops_max}"
        ),
        "\x60\x60\x60python",
        s.text.strip(),
        "\x60\x60\x60",
        "Largest error groups (who moves, kind of mistake, pawn rank: count, example FEN):",
        *[f"- {label_}: {n:,}, e.g. {fen}" for label_, n, fen in s.feedback.get("clusters", [])],
    ]
    samples = s.feedback.get("samples", [])
    if samples:
        lines.append("Some wrong positions (FEN, true result, what this program says):")
        for fen, truth in samples:
            said = "draw" if truth else "White wins"
            lines.append(f"- {fen}: truth {'White wins' if truth else 'draw'}, program says {said}")
    return "\n".join(lines)


@dataclass
class Bars:
    """Best totals known at each tier from the endgame's report (endgames/kpk/report.json), force programs left out."""

    by_tier: dict[int, tuple[float, str]]

    @classmethod
    def load(cls, path: Path) -> "Bars":
        if not path.exists():
            return cls({})
        data = json.loads(path.read_text())
        out: dict[int, tuple[float, str]] = {}
        for tier in dsl.TIERS:
            fits = [
                (p["bytes_total"], p["name"])
                for p in data["points"]
                if p["kind"] != "force"
                and p["ops_max"] is not None
                and not p["estimated_ops"]
                and p["ops_max"] <= tier
            ]
            if fits:
                out[tier] = min(fits)
        return cls(out)


@dataclass
class Settings:
    run: str
    model: str = DEFAULT_MODEL
    effort: str = "medium"
    max_tokens: int = MAX_TOKENS
    islands: tuple[int, ...] = ISLAND_TIERS
    workers: int = 24
    seed: int = 0
    repair: bool = True  # one follow-up call for a program that is invalid or over its limit
    steer: bool = True  # more calls to islands that still improve; otherwise round-robin
    plateau: int = 200  # an island closes after this many finished units without a new best


class RateLimited(NotBilled):
    def __init__(self, message: str, after: float):
        super().__init__(message)
        self.after = after


@dataclass
class Verdict:
    """What became of one answer: a scored program, or the reason it was rejected."""

    scored: Scored | None
    reason: str = ""
    program: str | None = None  # text worth repairing, if any


class Search:
    """Runs the loop. client has .messages.create; a test client can stand in."""

    def __init__(
        self,
        settings: Settings,
        guard: Guard,
        client,
        archive: Archive,
        evaluator,
        bars: Bars,
    ):
        self.s = settings
        self.guard = guard
        self.client = client
        self.archive = archive
        self.evaluator = evaluator
        self.bars = bars
        self.rng = random.Random(settings.seed)
        self.system = system_text()
        self._lock = threading.Lock()
        self._pending: list[tuple[int, int, str, str]] = []
        self._work_of: dict = {}
        self._budget_wait: BudgetExceeded | None = None
        self._reported = 0
        self.stopped: Exception | None = None
        self.stats = dict.fromkeys(
            ("called", "added", "rejected", "duplicate", "errors", "repaired"), 0
        )
        self._check_islands()

    def _check_islands(self) -> None:
        """A run keeps the islands it was started with."""
        stored = self.archive.meta("islands")
        if stored is None:
            islands = LEGACY_ISLANDS if self.archive.count() else self.s.islands
            self.archive.set_meta("islands", json.dumps(list(islands)))
            stored = json.dumps(list(islands))
        if json.loads(stored) != list(self.s.islands):
            raise ValueError(f"run {self.s.run!r} was started with islands {stored}")

    # --- seeds and prompts ----------------------------------------------------------------------

    def seed(self) -> None:
        """Every island starts with the same three programs (idempotent)."""
        seeds: list[Scored] = []
        for island in range(len(self.s.islands)):
            if self.archive.population(island, 10**9):
                continue
            seeds = seeds or [self.evaluator.evaluate(t) for t in seed_programs().values()]
            for s in seeds:
                self.archive.add(island, s, None, [])

    def tier_ops(self, island: int) -> int:
        """Largest worst-case count a program may have, its exception lookup included."""
        return self.s.islands[island]

    def choose_island(self, unit: int) -> int | None:
        """The island for the next unit, or None when every island is on its plateau."""
        n = len(self.s.islands)
        if not self.s.steer:
            return (unit - 1) % n
        stale = [self.archive.staleness(i, self.tier_ops(i)) for i in range(n)]
        still = [i for i in range(n) if stale[i] < self.s.plateau]
        if not still:
            return None
        return self.rng.choices(still, weights=[1 / (1 + stale[i] / 25) for i in still])[0]

    def parents(self, island: int) -> list[Scored]:
        """One parent from the island (rank-weighted); half the time a second from the best programs
        of the whole archive, even if it needs more operations than this island allows."""
        pop = self.archive.population(island, self.tier_ops(island))
        if not pop:
            return []
        weights = [3.0**-i for i in range(len(pop))]
        first = self.rng.choices(pop, weights=weights)[0]
        if self.rng.random() < 0.5:
            pool = [p for p in self.archive.best_overall(6) if p.id != first.id]
        else:
            pool = [p for p in pop[: max(1, len(pop) // 4)] if p.id != first.id]
        second = self.rng.choice(pool) if pool else None
        picks = [first] if second is None else [first, second]
        return sorted(picks, key=lambda p: -p.total)  # weaker first, stronger last

    def user_prompt(self, island: int, unit: int = 0) -> tuple[str, list[int]]:
        tier = self.s.islands[island]
        pops = self.parents(island)
        best = self.archive.population(island, self.tier_ops(island))
        lines = [
            (
                f"Target: at most {tier:,} operations per position (worst case), counting 32 for looking up listed "
                f"exceptions, so the program itself may use at most {self.tier_ops(island) - dsl.EXCEPTION_LOOKUP_OPS:,} while it has errors."
            ),
        ]
        if best:
            lines.append(f"Best total so far in this population: {best[0].total:,.0f} bytes.")
        if tier in self.bars.by_tier:
            b, name = self.bars.by_tier[tier]
            lines.append(
                f"The best total at this tier by other methods (not written in this language) is {b:,.0f} bytes ({name}). Beat the population's best first."
            )
        for i, p in enumerate(pops):
            over = p.ops_max > self.tier_ops(island)
            lines.append("")
            lines.append(
                _block(
                    p,
                    f"Program {chr(65 + i)}"
                    + (" (the stronger one)" if i == len(pops) - 1 and len(pops) > 1 else "")
                    + (
                        f" - uses {p.ops_max:,} operations, more than your limit: take its idea, not its cost"
                        if over
                        else ""
                    ),
                )
            )
        notes = self.archive.recent_rejections(island)
        if notes:
            lines.append("")
            lines.append("Recent proposals that were rejected:")
            lines += [f"- {n}" for n in notes]
        lines.append("")
        lines.append(f"Theme for this attempt: {HINTS[unit % len(HINTS)]}")
        lines.append("")
        lines.append(
            "Write one program that improves on the stronger parent (program or exceptions). Prefer a different structural idea over small constant changes when an error group is large."
        )
        return "\n".join(lines), [p.id for p in pops]

    def repair_prompt(self, prompt: str, program: str, reason: str) -> str:
        return (
            f"{prompt}\n\nYour previous answer to exactly this request was rejected.\n"
            f"\x60\x60\x60python\n{program.strip()}\n\x60\x60\x60\nReason: {reason}\n"
            "Keep the idea and fix only that. Reply in the same format: at most three sentences, then the program."
        )

    # --- one unit -------------------------------------------------------------------------------

    def new_unit(self) -> tuple[int, int, str, str] | None:
        with self._lock:
            unit = self.archive.next_unit()
            island = self.choose_island(unit)
            if island is None:
                return None
            prompt, parents = self.user_prompt(island, unit)
            key = f"{self.s.run}/{unit}"
            self.archive.add_unit(unit, island, key, prompt, parents)
        return unit, island, key, prompt

    def request(self, prompt: str) -> dict:
        return {
            "model": self.s.model,
            "max_tokens": self.s.max_tokens,
            "system": [
                {"type": "text", "text": self.system, "cache_control": {"type": "ephemeral"}}
            ],
            "messages": [{"role": "user", "content": prompt}],
            "output_config": {"effort": self.s.effort},
        }

    def call(self, prompt: str) -> Callable[..., tuple[dict, dict]]:
        import anthropic

        def do(_handle) -> tuple[dict, dict]:
            try:
                r = self.client.messages.create(**self.request(prompt))
            except anthropic.APIConnectionError:
                raise  # unknown whether it was billed: the reservation stays counted
            except anthropic.APIStatusError as e:
                text = f"{type(e).__name__}: {e.message}"
                if type(e) is anthropic.RateLimitError:
                    raise RateLimited(text, _retry_after(e)) from e
                if 400 <= e.status_code < 500 and e.status_code not in (408, 409):
                    raise NotBilled(text) from e
                raise
            text = "".join(b.text for b in r.content if b.type == "text")
            return {"text": text, "stop": r.stop_reason, "model": r.model}, r.usage.model_dump()

        return do

    def tokens_in(self, prompt: str) -> int:
        """Upper estimate of input tokens from characters. Measured on run r1: 1.75 characters a token
        in user prompts (FEN strings), 2.9 in the system prompt; 1.6 stays below both."""
        return int((len(self.system) + len(prompt)) / 1.6) + 200

    def paid(self, key: str, prompt: str, sleep: Callable[[float], None]) -> dict | Exception:
        """One paid answer, with retries for rate limits and server errors. Returns the last error
        when they do not help; raises BudgetExceeded and SearchStopped."""
        import anthropic

        last: Exception = RuntimeError("no attempt")
        for attempt in range(8):
            wait_s = min(60.0, 4.0 * 2**attempt)
            try:
                return self.guard.run(
                    key,
                    self.s.model,
                    self.tokens_in(prompt),
                    self.s.max_tokens,
                    self.call(prompt),
                    cached=True,
                )
            except RateLimited as e:
                last, wait_s = e, max(e.after, wait_s)
            except NotBilled as e:
                raise SearchStopped(str(e)) from e  # would fail the same way for every unit
            except (anthropic.APIError, OSError) as e:
                last = e  # 5xx, timeouts, connection loss: ambiguous, the reservation stays counted
                if attempt >= 4:
                    break
            sleep(wait_s)
        return last

    def judge(self, island: int, answer: dict) -> Verdict:
        if answer.get("stop") == "refusal":
            return Verdict(None, "the model refused")
        try:
            program = extract(answer.get("text", ""))
        except DslError as e:
            cut = " (the answer was cut off)" if answer.get("stop") == "max_tokens" else ""
            return Verdict(None, f"invalid program: {e}{cut}")
        try:
            scored = self.evaluator.evaluate(program)
        except DslError as e:
            return Verdict(None, f"invalid program: {str(e)[:160]}", program)
        except OverBudget as e:
            return Verdict(None, str(e)[:160], program)
        except RecursionError:
            return Verdict(None, "program too deeply nested", program)
        limit = self.tier_ops(island)
        if scored.ops_max > limit:
            return Verdict(None, f"uses {scored.ops_max:,} operations, limit {limit:,}", program)
        return Verdict(scored)

    def store(self, unit: int, island: int, verdict: Verdict) -> str:
        if verdict.scored is None:
            status = "rejected"
            self.archive.finish_unit(unit, status, verdict.reason)
        else:
            new = self.archive.add(island, verdict.scored, unit, self.archive.unit_parents(unit))
            status = "added" if new else "duplicate"
            self.archive.finish_unit(unit, status)
        with self._lock:
            self.stats[status] += 1
        return status

    def one(
        self,
        unit: int,
        island: int,
        key: str,
        prompt: str,
        sleep: Callable[[float], None] = time.sleep,
    ) -> str:
        """One unit: an answer, at most one repair, and the result on disk."""
        answer = self.paid(key, prompt, sleep)
        if isinstance(answer, Exception):
            self.archive.finish_unit(unit, "error", str(answer)[:200])
            with self._lock:
                self.stats["errors"] += 1
            return "error"
        with self._lock:
            self.stats["called"] += 1
        verdict = self.judge(island, answer)
        if self.s.repair and verdict.scored is None and verdict.program is not None:
            try:
                fixed = self.paid(
                    f"{key}/repair",
                    self.repair_prompt(prompt, verdict.program, verdict.reason),
                    sleep,
                )
            except BudgetExceeded:
                self.store(unit, island, verdict)
                raise
            if not isinstance(fixed, Exception):
                second = self.judge(island, fixed)
                if second.scored is not None:
                    verdict = second
                    with self._lock:
                        self.stats["repaired"] += 1
        return self.store(unit, island, verdict)

    # --- running --------------------------------------------------------------------------------

    def recover(self) -> int:
        """Finish work that an earlier run paid for, then queue units whose call was interrupted."""
        done = 0
        stored = dict(self.guard.results(f"{self.s.run}/"))
        for unit, island, key, prompt in self.archive.open_units():
            if key not in stored:
                self._pending.append((unit, island, key, prompt))
                continue
            verdict = self.judge(island, stored[key])
            if verdict.scored is None and f"{key}/repair" in stored:
                second = self.judge(island, stored[f"{key}/repair"])
                verdict = second if second.scored is not None else verdict
            self.store(unit, island, verdict)
            done += 1
        return done

    def _next(self):
        return self._pending.pop(0) if self._pending else self.new_unit()

    def run(self, max_units: int | None = None, progress: Callable[[str], None] = print) -> None:
        """Work until a limit, a plateau on every island, the budget or Ctrl-C. Raises BudgetExceeded at
        a budget stop; the money left is used up first, one call at a time."""
        self.seed()
        recovered = self.recover()
        if recovered:
            progress(f"recovered {recovered} paid answers from an earlier run")
        started = 0
        with ThreadPoolExecutor(self.s.workers) as pool:
            running: set = set()
            try:
                while True:
                    while (
                        self.stopped is None
                        and self._budget_wait is None
                        and len(running) < self.s.workers
                        and (max_units is None or started < max_units)
                    ):
                        work = self._next()
                        if work is None:
                            break
                        f = pool.submit(self.one, *work)
                        self._work_of[f] = work
                        running.add(f)
                        started += 1
                    if not running:
                        break
                    running = self._collect(wait(running, return_when=FIRST_COMPLETED))
                    if sum(self.stats.values()) >= self._reported + 25:
                        self._reported = sum(self.stats.values())
                        progress(self.summary())
            except KeyboardInterrupt:
                progress("interrupted: waiting for the calls already running, then stopping")
                self._collect(wait(running))
                self.stopped = SearchStopped("interrupted by the user")
        if self.stopped:
            raise self.stopped
        if max_units is None or started < max_units:
            progress(f"every island is on its plateau ({self.s.plateau} units without a new best)")

    def _collect(self, outcome) -> set:
        """Keep what finished. Out of budget: put the unit back and wait for running calls to settle, since
        each returns the part of its reservation it did not need; stop when nothing is running."""
        finished, running = outcome
        freed = False
        for f in finished:
            work = self._work_of.pop(f, None)
            try:
                f.result()
                freed = True
            except BudgetExceeded as e:
                if work is not None and any(u[0] == work[0] for u in self.archive.open_units()):
                    self._pending.insert(0, work)
                self._budget_wait = e
            except Exception as e:  # noqa: BLE001 - unexpected: stop cleanly, work is on disk
                self.stopped = self.stopped or e
        if self._budget_wait is not None:
            if not running:
                self.stopped = self.stopped or self._budget_wait
            elif freed:
                self._budget_wait = None  # money came back: try again
        return running

    def summary(self) -> str:
        best = self.archive.best_per_tier()
        parts = [f"{t}: {p.total:,.0f} B" for t, p in best.items()]
        st = self.stats
        return (
            f"{st['called']} answers, {st['added']} added, {st['rejected']} rejected, {st['repaired']} repaired, "
            f"{st['duplicate']} duplicates, {st['errors']} errors | best {', '.join(parts)} | "
            f"run spend {self.guard.run_spent() / 1e9:.3f} USD"
        )

    def usage_text(self) -> str:
        u = self.guard.usage_totals()
        if not u["calls"]:
            return "no usage logged yet"
        n = u["calls"]
        prefix = u["cache_read_input_tokens"] + u["cache_creation_input_tokens"]
        hit = 100 * u["cache_read_input_tokens"] / prefix if prefix else 0
        return (
            f"per call over {n} calls: {u['input_tokens'] / n:,.0f} plain input, {u['cache_read_input_tokens'] / n:,.0f} cached, "
            f"{u['output_tokens'] / n:,.0f} output tokens ({u['thinking_tokens'] / n:,.0f} thinking), cache hits {hit:.0f}%, "
            f"{u['nusd'] / n / 1e9:.5f} USD"
        )


def _retry_after(e) -> float:
    try:
        return float(e.response.headers.get("retry-after", 0))
    except (TypeError, ValueError):
        return 0.0
