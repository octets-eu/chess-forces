import os
import subprocess
import sys
import threading

import pytest

from chess_forces import budget
from chess_forces.budget import BudgetExceeded, Guard, NotBilled, cost, worst_case

HAIKU, OPUS, SONNET = "claude-haiku-5-5", "claude-opus-5-5", "claude-sonnet-5-5"
DAY = 86_400.0


class Clock:
    def __init__(self, t=1_800_000_000.0):
        self.t = t

    def __call__(self):
        return self.t


@pytest.fixture
def clock():
    return Clock()


@pytest.fixture
def guard(tmp_path, clock):
    g = Guard(tmp_path / "b.sqlite", clock)
    g.init(100, 20)
    return g


def usage(inp=0, out=0, **kw):
    return {"input_tokens": inp, "output_tokens": out, **kw}


# --- prices, checked against the published table (nano-dollars per token) ---


def test_prices_per_million_tokens():
    m = 10**6
    assert cost(HAIKU, usage(50_000, 0)) == 50_000 * 100
    assert cost(OPUS, usage(m, 0)) == 4 * budget.NUSD
    assert cost(OPUS, usage(0, m)) == 20 * budget.NUSD
    assert cost(SONNET, usage(0, m)) == 10 * budget.NUSD
    assert cost(SONNET, usage(m, 0), batch=True) == 1 * budget.NUSD


def test_haiku_is_dearer_beyond_100k_including_cached_tokens():
    assert cost(HAIKU, usage(100_000, 1000)) == 100_000 * 100 + 1000 * 500
    assert cost(HAIKU, usage(100_001, 1000)) == 100_001 * 500 + 1000 * 2500
    big = usage(1000, 0, cache_read_input_tokens=100_000)
    assert cost(HAIKU, big) == 1000 * 500 + 100_000 * 50


def test_cache_reads_and_writes():
    assert cost(OPUS, usage(0, 0, cache_read_input_tokens=10**6)) == budget.NUSD // 5  # $0.20
    split = {"ephemeral_5m_input_tokens": 600, "ephemeral_1h_input_tokens": 400}
    u = usage(0, 0, cache_creation_input_tokens=1000, cache_creation=split)
    assert cost(SONNET, u) == 600 * 2500 + 400 * 4000
    unsplit = usage(0, 0, cache_creation_input_tokens=1000)
    assert cost(SONNET, unsplit) == 1000 * 4000  # unknown split counts as the dearer kind


def test_unpriced_usage_and_unknown_model_fail():
    with pytest.raises(budget.UnpricedUsage):
        cost(OPUS, usage(1, 1, server_tool_use={"web_search_requests": 1}))
    with pytest.raises(budget.UnpricedUsage):
        cost(OPUS, usage(1, 1, speed="fast"))
    with pytest.raises(budget.UnknownModel):
        cost("claude-nonsense-1", usage(1, 1))


def test_worst_case_covers_the_real_cost():
    for model in (HAIKU, OPUS, SONNET):
        for n in (10, 5000, 99_000, 250_000):
            for batch in (False, True):
                for cached in (False, True):
                    w = worst_case(model, n, 4000, batch, cached)
                    real = cost(model, usage(n, 4000), batch)
                    assert w >= real


# --- stopping and resuming ---


def ok(value="done", inp=1000, out=100, calls=None, key=None):
    def call(handle):
        if calls is not None:
            calls.append(key)
        return value, usage(inp, out)

    return call


def test_stops_before_the_daily_limit_and_never_crosses_it(guard):
    # worst case of one Opus call with 100k output: 100k * $20/M + small input = about $2
    n = 0
    with pytest.raises(BudgetExceeded):
        for n in range(1000):
            guard.run(f"u{n}", OPUS, 1000, 100_000, ok(inp=1000, out=100_000))
    assert n >= 8
    s = guard.status()
    assert s["day_spent"] <= s["day_limit"] == 20 * budget.NUSD


def test_resume_after_confirm_does_not_repeat_finished_work(guard, clock):
    calls = []
    work = [f"u{i}" for i in range(30)]

    def go():
        for k in work:
            guard.run(k, OPUS, 1000, 100_000, ok(out=100_000, calls=calls, key=k))

    with pytest.raises(BudgetExceeded):
        go()
    done = list(calls)
    assert 0 < len(done) < 30
    with pytest.raises(BudgetExceeded):
        go()  # still no money: no new call is made
    assert calls == done
    guard.grant(10, "day")  # what the terminal command does
    with pytest.raises(BudgetExceeded):
        go()
    assert calls[: len(done)] == done and len(calls) > len(done)
    assert len(set(calls)) == len(calls)  # no unit was paid twice


def test_a_new_day_gets_a_fresh_daily_budget_but_the_total_stays(guard, clock):
    spent = 0
    for day in range(10):
        try:
            for i in range(1000):
                guard.run(f"d{day}-{i}", OPUS, 1000, 100_000, ok(out=100_000))
        except BudgetExceeded:
            pass
        spent = guard.status()["total_spent"]
        clock.t += DAY
    assert spent <= 100 * budget.NUSD
    assert guard.status()["total_limit"] - spent < 3 * budget.NUSD  # the total is what stopped it
    with pytest.raises(BudgetExceeded, match="total"):
        guard.run("late", OPUS, 1000, 100_000, ok())


def test_topup_raises_the_total(guard, clock):
    guard.grant(5, "total")
    assert guard.status()["total_limit"] == 105 * budget.NUSD


def test_refuses_to_work_without_an_initialised_ledger(tmp_path):
    g = Guard(tmp_path / "empty.sqlite")
    with pytest.raises(budget.NotInitialised):
        g.run("k", OPUS, 10, 10, ok())


def test_init_works_only_once(guard):
    with pytest.raises(ValueError):
        guard.init(1000)


def test_rejected_request_is_not_charged_and_a_crash_is(guard):
    def rejected(handle):
        raise NotBilled

    with pytest.raises(NotBilled):
        guard.run("r", OPUS, 1000, 1000, rejected)
    assert guard.status()["total_spent"] == 0

    def crash(handle):
        raise ConnectionError("unknown if the server billed it")

    with pytest.raises(ConnectionError):
        guard.run("c", OPUS, 1000, 1000, crash)
    assert guard.status()["total_spent"] > 0  # counted until proven otherwise
    assert guard.run("c", OPUS, 1000, 1000, ok("second")) == "second"
    with guard._tx() as db:
        states = [r[0] for r in db.execute("select status from calls where key='c' order by id")]
    assert states == ["lost", "settled"]


def test_batch_id_is_picked_up_instead_of_submitted_twice(guard, tmp_path):
    submitted = []

    def submit_then_die(handle):
        handle.attach("msgbatch_123")
        submitted.append(1)
        raise KeyboardInterrupt

    with pytest.raises(KeyboardInterrupt):
        guard.run("b", HAIKU, 1000, 1000, submit_then_die, batch=True)
    spent_once = guard.status()["total_spent"]

    def resume(handle):
        assert handle.ref == "msgbatch_123"
        return "fetched", usage(1000, 500)

    assert guard.run("b", HAIKU, 1000, 1000, resume, batch=True) == "fetched"
    assert len(submitted) == 1
    assert guard.status()["total_spent"] <= spent_once


def test_unpriced_usage_is_counted_at_the_worst_case(guard):
    def odd(handle):
        return "x", usage(1, 1, server_tool_use={"web_search_requests": 3})

    guard.run("odd", OPUS, 1000, 1000, odd)
    assert guard.status()["total_spent"] == worst_case(OPUS, 1000, 1000)


def test_many_threads_cannot_overspend(guard):
    # each call needs up to about 0.2 USD and the limit is 20 USD
    def worker(i):
        try:
            for j in range(100):
                guard.run(f"t{i}-{j}", OPUS, 1000, 10_000, ok(inp=1000, out=10_000))
        except BudgetExceeded:
            pass

    threads = [threading.Thread(target=worker, args=(i,)) for i in range(8)]
    for t in threads:
        t.start()
    for t in threads:
        t.join()
    s = guard.status()
    assert 15 * budget.NUSD < s["day_spent"] <= s["day_limit"]


def test_confirm_needs_a_terminal(tmp_path):
    env = dict(os.environ, CHESS_FORCES_STATE=str(tmp_path))
    run = lambda *a: subprocess.run(
        [sys.executable, "-m", "chess_forces.cli", "budget", *a],
        check=False,
        env=env,
        input="",
        capture_output=True,
        text=True,
    )
    assert run("init", "--total", "100").returncode == 0
    r = run("confirm", "10")
    assert r.returncode != 0 and "terminal" in r.stderr
    assert "today 0 / 20 USD" in run("status").stdout


def test_money_amounts_are_exact():
    assert budget.to_nusd("0.10") == 100_000_000
    with pytest.raises(ValueError):
        budget.to_nusd("0.001")
    with pytest.raises(ValueError):
        budget.to_nusd("-5")


def test_exit_code_on_stop(capsys):
    with pytest.raises(SystemExit) as e, budget.exit_on_budget():
        raise BudgetExceeded("x")
    assert e.value.code == budget.EXIT_BUDGET
    assert "confirm" in capsys.readouterr().err


def test_api_key_is_the_projects_own_and_never_falls_back(monkeypatch):
    monkeypatch.setenv("ANTHROPIC_API_KEY", "other-tool-key")
    monkeypatch.delenv("CHESS_FORCES_API_KEY", raising=False)
    with pytest.raises(budget.MissingKey):
        budget.api_key()
    monkeypatch.setenv("CHESS_FORCES_API_KEY", "  project-key\n")
    assert budget.api_key() == "project-key"


def test_run_limit_is_a_third_cap_on_top_of_the_day(guard, tmp_path, clock):
    g = Guard(guard.path, clock, run="r1", run_limit_usd=0.05)
    n = 0
    with pytest.raises(BudgetExceeded, match="run r1"):
        for n in range(1000):
            g.run(f"r{n}", OPUS, 1000, 1000, ok(inp=1000, out=1000))
    assert 1 < n < 10
    assert g.run_spent() <= 0.05 * budget.NUSD
    other = Guard(guard.path, clock, run="r2", run_limit_usd=0.05)
    assert other.run("other-run", OPUS, 1000, 1000, ok()) == "done"
    assert next(k for k, _ in g.results("r")) == "r0"
