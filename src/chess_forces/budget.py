"""Spend guard for API calls.

Rules, in order of importance:
1. A call is reserved at its worst-case price BEFORE it is made. If that would pass today's limit or
   the account total, nothing is sent and BudgetExceeded is raised. The script therefore stops a
   little early. The limit holds as long as PRICES is current and the token estimate (plus 5%) is
   an upper bound; a higher real price is recorded and stops the next call.
2. After the call the reservation is settled at the real price and the result is stored in the same
   transaction. A rerun returns the stored result and makes no call.
3. If a process dies between reserving and settling, the money may have been spent: the reservation
   stays counted. A reservation that carries a batch id (attach) is picked up again instead of being
   submitted twice.
4. Nothing can raise a limit without a person at a terminal (cli.py: budget confirm / topup).
5. The key must identify the content (model, prompt version, work unit): a stored result is returned
   for the same key even if the prompt has changed since.
6. Clients must be created with max_retries=0. A retried request can be billed twice under one
   reservation; retries belong to this layer, each with its own reservation.
7. The ledger only knows calls made through it. Other uses of the same API key (for example Claude
   Code) lower the real account balance without being counted, so a dedicated key is best.

Amounts are integer nano-dollars. The ledger is one SQLite file shared by all scripts; the file
itself is local and not committed.
"""

import json
import os
import sqlite3
import sys
import threading
import time
from collections.abc import Callable
from contextlib import contextmanager
from dataclasses import dataclass
from datetime import datetime
from decimal import Decimal
from pathlib import Path

NUSD = 10**9
DEFAULT_DAILY_USD = Decimal(20)
EXIT_BUDGET = 75  # EX_TEMPFAIL: stopped by budget, safe to rerun


class BudgetExceeded(Exception):
    """The next call could pass a limit. Nothing was sent."""


class NotInitialised(BudgetExceeded):
    """No ledger yet, so no budget is known. Fails closed."""


class UnknownModel(Exception):
    """No price for this model, so no call is allowed."""


class UnpricedUsage(Exception):
    """The response reports spend this table cannot price."""


class NotBilled(Exception):
    """Raised by a call that is certain nothing was charged (for example a rejected request)."""


class KeyBusy(Exception):
    """Another live process is working on the same key."""


@dataclass(frozen=True)
class Rate:
    """Nano-dollars per token. 1000 n$ per token = $1 per million tokens."""

    inp: int
    write_5m: int
    write_1h: int
    read: int
    out: int


# Source: https://platform.claude.com/docs/en/about-claude/pricing (read 2026-11-25). Per model:
# (prompt limit in tokens, rate); the first tier whose limit fits the prompt applies, None = no limit.
PRICES_AS_OF = "2026-11-25"
PRICES: dict[str, tuple[tuple[int | None, Rate], ...]] = {
    "claude-haiku-5-5": (
        (100_000, Rate(100, 125, 200, 10, 500)),
        (None, Rate(500, 625, 1000, 50, 2500)),
    ),
    "claude-sonnet-5-5": ((None, Rate(2000, 2500, 4000, 100, 10_000)),),
    "claude-opus-5-5": ((None, Rate(4000, 5000, 8000, 200, 20_000)),),
}


def rate(model: str, prompt_tokens: int) -> Rate:
    tiers = PRICES.get(model)
    if tiers is None:
        raise UnknownModel(f"no price for {model!r} (prices as of {PRICES_AS_OF})")
    for limit, r in tiers:
        if limit is None or prompt_tokens <= limit:
            return r
    raise UnknownModel(f"prompt of {prompt_tokens} tokens exceeds every tier of {model!r}")


def _halve_up(n: int) -> int:
    return (n + 1) // 2


def cost(model: str, usage: dict, batch: bool = False) -> int:
    """Price of a finished call in nano-dollars, from the API usage block. Raises UnpricedUsage."""
    if any((usage.get("server_tool_use") or {}).values()) or len(usage.get("iterations") or []) > 1:
        raise UnpricedUsage("server tools or fallback attempts are not priced here")
    if usage.get("speed") == "fast" or usage.get("inference_geo") == "us":
        raise UnpricedUsage("fast mode and US-only inference cost more and are not priced here")
    if (usage.get("service_tier") or "standard") not in ("standard", "batch"):
        raise UnpricedUsage(f"service tier {usage['service_tier']!r} is not priced here")
    inp = usage.get("input_tokens") or 0
    writes = usage.get("cache_creation_input_tokens") or 0
    read = usage.get("cache_read_input_tokens") or 0
    out = usage.get("output_tokens") or 0
    r = rate(model, inp + writes + read)
    split = usage.get("cache_creation") or {}
    w5 = split.get("ephemeral_5m_input_tokens", 0) if split else 0
    w1 = writes - w5  # unsplit writes count as 1-hour, the dearer kind
    total = inp * r.inp + w5 * r.write_5m + w1 * r.write_1h + read * r.read + out * r.out
    return _halve_up(total) if batch else total


def worst_case(
    model: str, input_tokens: int, max_tokens: int, batch: bool = False, cached: bool = False
) -> int:
    """Upper bound before the call. Token counts are estimates, so 5% and 100 tokens are added.
    Thinking counts toward max_tokens, so max_tokens times the output price covers it."""
    prompt = int(input_tokens * 1.05) + 100
    r = rate(model, prompt)
    total = prompt * (r.write_1h if cached else r.inp) + max_tokens * r.out
    return _halve_up(total) if batch else total


def usd(nusd: int) -> str:
    return f"{Decimal(nusd) / NUSD:.4f}".rstrip("0").rstrip(".") if nusd else "0"


def to_nusd(amount: str | Decimal | int) -> int:
    value = Decimal(str(amount))
    if not value.is_finite() or value <= 0 or value != value.quantize(Decimal("0.01")):
        raise ValueError("amount must be a positive dollar value with at most two decimals")
    return int(value * NUSD)


def _local_day(ts: float) -> str:
    return datetime.fromtimestamp(ts).strftime("%Y-%m-%d")


class Handle:
    """Passed to the call. attach() stores a batch id so a crash can be picked up again."""

    def __init__(self, guard: "Guard", call_id: int, ref: str | None):
        self._guard, self.call_id, self.ref = guard, call_id, ref

    def attach(self, ref: str) -> None:
        with self._guard._tx() as db:
            db.execute("update calls set ref = ? where id = ?", (ref, self.call_id))
        self.ref = ref


class Guard:
    def __init__(self, path: Path | str | None = None, clock: Callable[[], float] = time.time):
        self.path = Path(path) if path else default_path()
        self.clock = clock
        self._active: set[str] = set()
        self._lock = threading.Lock()
        self.path.parent.mkdir(parents=True, exist_ok=True)
        with self._tx() as db:
            db.executescript(
                """
                create table if not exists settings (k text primary key, v text not null);
                create table if not exists grants (
                    id integer primary key, day text not null, kind text not null,
                    nusd integer not null, note text not null, ts real not null);
                create table if not exists calls (
                    id integer primary key, key text not null, day text not null,
                    status text not null, nusd integer not null, worst integer not null,
                    model text not null, ref text, pid integer not null, ts real not null);
                create table if not exists results (
                    key text primary key, value text not null, call_id integer not null);
                create index if not exists calls_key on calls (key, status);
                """
            )

    @contextmanager
    def _tx(self):
        db = sqlite3.connect(self.path, timeout=30, isolation_level=None)
        try:
            db.execute("begin immediate")
            yield db
            if db.in_transaction:
                db.execute("commit")
        except BaseException:
            if db.in_transaction:
                db.execute("rollback")
            raise
        finally:
            db.close()

    # --- limits -------------------------------------------------------------------------------

    def init(self, total_usd, daily_usd=DEFAULT_DAILY_USD) -> None:
        """One time only. Later changes go through confirm() and topup()."""
        with self._tx() as db:
            if db.execute("select 1 from settings").fetchone():
                raise ValueError("ledger already initialised")
            db.execute("insert into settings values ('total', ?)", (str(to_nusd(total_usd)),))
            db.execute("insert into settings values ('daily', ?)", (str(to_nusd(daily_usd)),))

    def _limits(self, db, day: str) -> tuple[int, int]:
        s = dict(db.execute("select k, v from settings"))
        if "total" not in s:
            raise NotInitialised("no budget set yet: run 'chess-forces budget init'")
        q = "select coalesce(sum(nusd), 0) from grants where kind = ?"
        extra_day = db.execute(q + " and day = ?", ("day", day)).fetchone()[0]
        extra_total = db.execute(q, ("total",)).fetchone()[0]
        return int(s["daily"]) + extra_day, int(s["total"]) + extra_total

    def _spent(self, db, day: str | None = None) -> int:
        q = "select coalesce(sum(nusd), 0) from calls"
        row = db.execute(q + " where day = ?", (day,)) if day else db.execute(q)
        return row.fetchone()[0]

    def grant(self, amount_usd, kind: str = "day", note: str = "") -> None:
        """kind 'day' raises today's limit, 'total' raises the account total. CLI only, behind a TTY."""
        if kind not in ("day", "total"):
            raise ValueError(kind)
        now = self.clock()
        with self._tx() as db:
            self._limits(db, _local_day(now))  # must be initialised
            db.execute(
                "insert into grants (day, kind, nusd, note, ts) values (?, ?, ?, ?, ?)",
                (_local_day(now), kind, to_nusd(amount_usd), note, now),
            )

    def status(self) -> dict:
        day = _local_day(self.clock())
        with self._tx() as db:
            daily, total = self._limits(db, day)
            spent_day, spent_total = self._spent(db, day), self._spent(db)
            states = dict(db.execute("select status, count(*) from calls group by status"))
        return {
            "day": day,
            "day_limit": daily,
            "day_spent": spent_day,
            "total_limit": total,
            "total_spent": spent_total,
            "left": min(daily - spent_day, total - spent_total),
            "calls": states,
        }

    # --- calls --------------------------------------------------------------------------------

    def _reserve(self, key: str, model: str, worst: int) -> int:
        now = self.clock()
        day = _local_day(now)
        with self._tx() as db:
            day_limit, total_limit = self._limits(db, day)
            day_spent, total_spent = self._spent(db, day), self._spent(db)
            if day_spent + worst > day_limit:
                raise BudgetExceeded(
                    f"today {usd(day_spent)} of {usd(day_limit)} USD used; "
                    f"the next call may cost up to {usd(worst)} USD"
                )
            if total_spent + worst > total_limit:
                raise BudgetExceeded(
                    f"total {usd(total_spent)} of {usd(total_limit)} USD used; "
                    f"the next call may cost up to {usd(worst)} USD"
                )
            cur = db.execute(
                "insert into calls (key, day, status, nusd, worst, model, ref, pid, ts) "
                "values (?, ?, 'open', ?, ?, ?, null, ?, ?)",
                (key, day, worst, worst, model, os.getpid(), now),
            )
            return cur.lastrowid

    def _settle(self, call_id: int, nusd: int, key: str, value, status: str = "settled") -> None:
        with self._tx() as db:
            db.execute(
                "update calls set status = ?, nusd = ? where id = ?", (status, nusd, call_id)
            )
            if status == "settled":
                db.execute(
                    "insert or replace into results values (?, ?, ?)",
                    (key, json.dumps(value), call_id),
                )

    def _pick_up(self, key: str) -> tuple[int, str] | None:
        """An open reservation left by a dead process: reuse it if it has a batch id, else count it
        as spent and let the caller reserve again."""
        with self._tx() as db:
            rows = db.execute(
                "select id, ref, pid from calls where key = ? and status = 'open'", (key,)
            ).fetchall()
            for call_id, ref, pid in rows:
                if pid != os.getpid() and _alive(pid):
                    raise KeyBusy(f"{key!r} is being worked on by process {pid}")
                if ref:
                    db.execute("update calls set pid = ? where id = ?", (os.getpid(), call_id))
                    return call_id, ref
                db.execute("update calls set status = 'lost' where id = ?", (call_id,))
        return None

    def run(
        self,
        key: str,
        model: str,
        input_tokens: int,
        max_tokens: int,
        call: Callable[[Handle], tuple[object, dict]],
        batch: bool = False,
        cached: bool = False,
    ):
        """Do one unit of paid work at most once. call(handle) returns (json-able result, usage)."""
        with self._lock:
            if key in self._active:
                raise KeyBusy(key)
            self._active.add(key)
        try:
            with self._tx() as db:
                row = db.execute("select value from results where key = ?", (key,)).fetchone()
            if row:
                return json.loads(row[0])
            worst = worst_case(model, input_tokens, max_tokens, batch, cached)
            picked = self._pick_up(key)
            if picked:
                call_id, ref = picked
            else:
                call_id, ref = self._reserve(key, model, worst), None
            try:
                value, usage = call(Handle(self, call_id, ref))
            except NotBilled:
                self._settle(call_id, 0, key, None, status="released")
                raise
            # any other exception: the request may have been billed, so the reservation stays 'open'
            try:
                nusd = cost(model, usage, batch)
            except UnpricedUsage as e:
                print(f"budget: {e}; counted at the worst case", file=sys.stderr)
                nusd = worst
            self._settle(call_id, nusd, key, value)
            return value
        finally:
            with self._lock:
                self._active.discard(key)


def _alive(pid: int) -> bool:
    try:
        os.kill(pid, 0)
    except ProcessLookupError:
        return False
    except PermissionError:
        return True
    return True


class MissingKey(Exception):
    """The project's own API key is not in the environment."""


API_KEY_ENV = "CHESS_FORCES_API_KEY"


def api_key() -> str:
    """The project's own key, passed explicitly to the SDK client. ANTHROPIC_API_KEY is ignored on
    purpose, so this spend cannot mix with other tools that use that variable."""
    key = os.environ.get(API_KEY_ENV, "").strip()
    if not key:
        raise MissingKey(
            f"{API_KEY_ENV} is not set (export it, or put it in .env and use uv run --env-file .env)"
        )
    return key


def default_path() -> Path:
    root = os.environ.get("CHESS_FORCES_STATE")
    return (Path(root) if root else Path(__file__).resolve().parents[2] / "state") / "budget.sqlite"


@contextmanager
def exit_on_budget():
    """Wrap a script's main: a budget stop becomes exit code 75 with a resume hint, not a traceback."""
    try:
        yield
    except BudgetExceeded as e:
        print(
            f"Budget stop: {e}.\nFinished work is saved. To go on, confirm more budget in a terminal "
            "(uv run chess-forces budget confirm <USD>) and rerun the same command.",
            file=sys.stderr,
        )
        raise SystemExit(EXIT_BUDGET) from None
