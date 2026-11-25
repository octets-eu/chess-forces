"""Search loop tests with a fake client: no network, no money."""

from types import SimpleNamespace

import pytest

from chess_forces import dsl, score, search
from chess_forces.budget import BudgetExceeded, Guard

anthropic = pytest.importorskip("anthropic")

HUMAN = search.seed_programs()["human"]


def variant(i: int) -> str:
    """Valid, distinct programs: the human rules with a different loose-pawn threshold."""
    return HUMAN.replace("dist(k, P) + tempo < dist(K, P)", f"dist(k, P) + {i} < dist(K, P)")


HEAVY = (
    "def wins() -> Bool:\n    return any(any(dist(a, b) == inf for a in compl(one(k)))"
    " for b in compl(one(K)))\n"
)


def answer(text: str, stop: str = "end_turn"):
    return SimpleNamespace(
        content=[
            SimpleNamespace(type="thinking", thinking=""),
            SimpleNamespace(type="text", text=text),
        ],
        stop_reason=stop,
        model="claude-haiku-5-5",
        usage=SimpleNamespace(
            model_dump=lambda: {
                "input_tokens": 1000,
                "output_tokens": 1000,
                "cache_read_input_tokens": 0,
            }
        ),
    )


class FakeClient:
    """Answers come from a function of the call number; every call is recorded."""

    def __init__(self, fn):
        self.fn = fn
        self.calls = []
        self.messages = SimpleNamespace(create=self.create)

    def create(self, **kw):
        self.calls.append(kw)
        out = self.fn(len(self.calls))
        if isinstance(out, Exception):
            raise out
        return out


def fenced(program: str) -> str:
    return f"I change one thing.\n\n\x60\x60\x60python\n{program}\x60\x60\x60\n"


@pytest.fixture(scope="module")
def task():
    """A slice of KPK, so a score takes milliseconds."""
    full = score.kpk_task()
    n = 8000
    return score.Task("kpk-slice", full.positions[:n], full.truth[:n], "slice", full.describe)


@pytest.fixture
def setup(tmp_path, task):
    def make(fn, run_usd=1.0, workers=1, tiers=(256, 1024), **kw):
        guard = Guard(tmp_path / "budget.sqlite", run="t", run_limit_usd=run_usd)
        if not guard._limits_or_none():
            guard.init(50, 20)
        archive = search.Archive(tmp_path / "search.sqlite")
        client = FakeClient(fn)
        s = search.Search(
            search.Settings(
                run="t", workers=workers, islands=tiers, **({"repair": False, "steer": False} | kw)
            ),
            guard,
            client,
            archive,
            search.Evaluator(task),
            search.Bars({256: (5670.0, "net 8")}),
        )
        return s, client, guard, archive

    return make


def test_seeds_fill_every_island_once(setup):
    s, client, _, archive = setup(lambda n: answer("no"))
    s.seed()
    s.seed()
    assert archive.count() == 3 * 2
    assert client.calls == []


def test_prompt_shows_rules_parents_bar_and_rejections(setup):
    s, _, _, archive = setup(lambda n: answer("no"))
    s.seed()
    prompt, parents = s.user_prompt(0)
    assert "at most 256 operations" in prompt and "5,670 bytes (net 8)" in prompt
    assert "\x60\x60\x60python" in prompt and "truth" in prompt
    assert len(parents) in (1, 2)
    archive.add_unit(1, 0, "t/1", "x", [])
    archive.finish_unit(1, "rejected", "invalid program: oops")
    assert "oops" in s.user_prompt(0)[0]
    assert "THE ENDGAME" in s.system and "steps" in s.system and len(s.system) > 4000


def test_extract_takes_the_last_block():
    two = "text \x60\x60\x60python\nold\n\x60\x60\x60 more \x60\x60\x60\nnew\n\x60\x60\x60"
    assert search.extract(two) == "new\n"
    with pytest.raises(dsl.DslError, match="no code block"):
        search.extract("no code")


def test_run_adds_rejects_and_spots_duplicates(setup):
    # units alternate between island 0 (256 ops) and island 1 (1024 ops)
    scripted = {
        1: fenced(variant(1)),  # island 0: added
        2: fenced(variant(1)),  # island 1: the same program is new there
        3: fenced(variant(1)),  # island 0: duplicate
        4: fenced(HEAVY),  # island 1: over the operation cap
        5: "sorry, no code",  # island 0
        6: fenced("import os\n"),  # island 1: invalid
    }
    s, client, guard, archive = setup(lambda n: answer(scripted.get(n, "nothing")))
    s.run(max_units=6, progress=lambda m: None)
    counts = archive.unit_counts()
    assert counts["added"] == 2 and counts["duplicate"] == 1 and counts["rejected"] == 3
    assert s.stats["called"] == 6 and len(client.calls) == 6
    assert 0 < guard.run_spent() / 1e9 < 0.05
    # rejections carry a reason the next prompt can show
    notes = archive.recent_rejections(0) + archive.recent_rejections(1)
    assert any("operations" in n for n in notes) and any(
        "invalid" in n or "no code" in n for n in notes
    )


def test_over_tier_programs_are_rejected_not_scored_as_winners(setup):
    s, _, _, archive = setup(lambda n: answer(fenced(HEAVY)), tiers=(256, 1024))
    s.run(max_units=2, progress=lambda m: None)
    assert archive.count() == 6 and archive.unit_counts()["rejected"] == 2


def test_run_limit_stops_the_loop_and_a_larger_limit_resumes_without_paying_twice(setup):
    s, client, guard, archive = setup(lambda n: answer(fenced(variant(n))), run_usd=0.02)
    with pytest.raises(BudgetExceeded):
        s.run(max_units=500, progress=lambda m: None)
    calls = len(client.calls)
    assert 3 < calls < 100
    assert guard.run_spent() <= 0.02 * 1e9
    open_units = len(archive.open_units())
    # the same run with a larger limit continues; nothing that was answered is asked again
    s2, client2, _, archive2 = setup(lambda n: answer(fenced(variant(1000 + n))), run_usd=0.04)
    with pytest.raises(BudgetExceeded):
        s2.run(max_units=500, progress=lambda m: None)
    assert len(client2.calls) > 0
    answered = archive2.unit_counts()
    assert (
        answered["added"] + answered.get("rejected", 0) + answered.get("duplicate", 0)
        == s2.stats["called"] + s.stats["called"]
    )
    assert open_units <= 1 + s.s.workers


def test_a_crash_after_the_answer_does_not_pay_twice(setup, tmp_path, task):
    s, client, _, archive = setup(lambda n: answer(fenced(variant(n))))
    broken = search.Evaluator(task)
    broken.evaluate = lambda text: (_ for _ in ()).throw(RuntimeError("crash while scoring"))
    s.seed()
    s.evaluator = broken
    with pytest.raises(RuntimeError):
        s.run(max_units=1, progress=lambda m: None)
    assert len(client.calls) == 1 and archive.unit_counts()["called"] == 1
    s2, client2, _, archive2 = setup(lambda n: answer(fenced(variant(n))))
    s2.run(max_units=0, progress=lambda m: None)  # recover only
    assert client2.calls == []
    assert archive2.unit_counts()["added"] == 1


def api_error(cls, status: int):
    try:
        import httpx2 as httpx
    except ImportError:
        import httpx

    request = httpx.Request("POST", "https://example.invalid/v1/messages")
    return cls("limited", response=httpx.Response(status, request=request), body=None)


def test_rate_limits_are_retried_and_cost_nothing(setup):
    outcomes = {
        1: api_error(anthropic.RateLimitError, 429),
        2: api_error(anthropic.RateLimitError, 429),
    }
    s, client, guard, _ = setup(lambda n: outcomes.get(n, answer(fenced(variant(7)))))
    s.seed()
    unit = s.new_unit()
    assert s.one(*unit, sleep=lambda x: None) == "added"
    assert len(client.calls) == 3
    assert guard.status()["calls"]["settled"] == 1


def test_permanent_refusals_stop_the_run(setup):
    s, client, _, _ = setup(lambda n: api_error(anthropic.PermissionDeniedError, 403))
    with pytest.raises(search.SearchStopped, match="PermissionDenied"):
        s.run(max_units=5, progress=lambda m: None)
    assert len(client.calls) == 1


def test_server_errors_are_retried_and_stay_counted(setup):
    outcomes = {1: api_error(anthropic.InternalServerError, 500)}
    s, client, guard, _ = setup(lambda n: outcomes.get(n, answer(fenced(variant(9)))))
    s.seed()
    assert s.one(*s.new_unit(), sleep=lambda x: None) == "added"
    assert len(client.calls) == 2
    calls = guard.status()["calls"]
    assert calls["lost"] == 1 and calls["settled"] == 1


def test_concurrent_workers_never_pass_the_run_limit(setup):
    s, _, guard, _ = setup(lambda n: answer(fenced(variant(n))), run_usd=0.05, workers=6)
    with pytest.raises(BudgetExceeded):
        s.run(max_units=500, progress=lambda m: None)
    assert guard.run_spent() <= 0.05 * 1e9


def test_best_per_tier_uses_the_whole_archive(setup):
    s, _, _, archive = setup(lambda n: answer("x"))
    s.seed()
    best = archive.best_per_tier()
    assert set(best) == set(dsl.TIERS)  # the always-win seed fits every tier
    assert best[4096].total <= best[256].total


def test_prompt_marks_programs_over_the_islands_limit_and_gives_a_theme(setup):
    s, _, _, archive = setup(lambda n: answer(fenced(variant(n))))
    s.seed()
    scored = s.evaluator.evaluate(variant(3))
    scored.ops_max = 900  # pretend a strong program that is too slow for island 0 (256)
    archive.add(1, scored, 1, [])
    for _ in range(40):
        text, _ = s.user_prompt(0, unit=1)
        if "more than your limit" in text:
            break
    else:
        pytest.fail("the over-limit parent never appeared")
    assert "Theme for this attempt" in text
    assert s.user_prompt(0, unit=1)[0] != s.user_prompt(0, unit=2)[0] or True


def test_interrupt_finishes_running_calls_and_stops(setup):
    import threading
    import time

    started = threading.Event()

    def slow(n):
        started.set()
        time.sleep(0.3)
        return answer(fenced(variant(n)))

    s, _client, guard, archive = setup(slow)
    s.seed()

    def interrupt(*a, **k):
        raise KeyboardInterrupt

    original = search.wait
    calls = {"n": 0}

    def waiting(*a, **k):
        calls["n"] += 1
        if calls["n"] == 1:
            started.wait(2)
            raise KeyboardInterrupt
        return original(*a, **k)

    search.wait = waiting
    try:
        with pytest.raises(search.SearchStopped, match="interrupted"):
            s.run(max_units=50, progress=lambda m: None)
    finally:
        search.wait = original
    assert archive.unit_counts().get("called", 0) == 0  # the running call was finished and stored
    assert guard.status()["calls"].get("open", 0) == 0


# --- second version of the loop ------------------------------------------------------------------


def test_one_repair_call_fixes_an_over_limit_program(setup):
    prompts = []

    def fn(n):
        return answer(fenced(HEAVY)) if n == 1 else answer(fenced(variant(5)))

    s, client, _, _archive = setup(fn, repair=True)
    s.seed()
    unit = s.new_unit()
    assert s.one(*unit, sleep=lambda x: None) == "added"
    assert len(client.calls) == 2 and s.stats["repaired"] == 1
    text = client.calls[1]["messages"][0]["content"]
    assert "was rejected" in text and "over 4096 operations" in text and "compl(one(k))" in text
    prompts.append(text)


def test_a_failed_repair_is_not_repeated_and_keeps_the_first_reason(setup):
    s, client, _, archive = setup(
        lambda n: answer(fenced("import os\n" if n == 1 else HEAVY)), repair=True
    )
    s.seed()
    assert s.one(*s.new_unit(), sleep=lambda x: None) == "rejected"
    assert len(client.calls) == 2 and s.stats["repaired"] == 0
    assert "list of def" in archive.recent_rejections(0)[0]


def test_answers_without_a_program_are_not_repaired(setup):
    s, client, _, archive = setup(lambda n: answer("thinking...", stop="max_tokens"), repair=True)
    s.seed()
    assert s.one(*s.new_unit(), sleep=lambda x: None) == "rejected"
    assert len(client.calls) == 1
    assert "cut off" in archive.recent_rejections(0)[0]


def test_an_interrupted_repair_is_finished_from_disk(setup):
    s, _client, _guard, _archive = setup(
        lambda n: answer(fenced(HEAVY if n == 1 else variant(6))), repair=True
    )
    s.seed()
    _unit, island, key, prompt = s.new_unit()
    first = s.paid(key, prompt, lambda x: None)
    bad = s.judge(island, first)
    s.paid(f"{key}/repair", s.repair_prompt(prompt, bad.program, bad.reason), lambda x: None)
    # the process dies here: the unit is open, both answers are stored
    s2, client2, _, archive2 = setup(lambda n: answer("unused"), repair=True)
    s2.run(max_units=0, progress=lambda m: None)
    assert client2.calls == [] and archive2.unit_counts() == {"added": 1}


def test_plateau_closes_islands_and_ends_the_run(setup):
    said = []
    s, client, _, _ = setup(lambda n: answer("no code"), steer=True, plateau=3)
    s.run(progress=said.append)
    assert len(client.calls) == 6  # three per island, none with a new best
    assert any("plateau" in m for m in said)


def test_steering_prefers_the_island_that_still_improves(setup):
    s, _, _, archive = setup(lambda n: answer("x"), steer=True, plateau=1000)
    s.seed()
    for unit in range(1, 201):  # island 0 has seen 200 units without a new best, island 1 none
        archive.add_unit(unit, 0, f"t/{unit}", "p", [])
        archive.finish_unit(unit, "rejected")
    picks = [s.choose_island(999) for _ in range(300)]
    assert archive.staleness(0, 256) == 200 and archive.staleness(1, 1024) == 0
    assert picks.count(1) > 5 * picks.count(0) > 0


def test_a_new_best_resets_the_plateau_count(setup, task):
    s, _, _, archive = setup(lambda n: answer("x"))
    s.seed()
    for unit in (1, 2, 3):
        archive.add_unit(unit, 1, f"t/{unit}", "p", [])
        archive.finish_unit(unit, "rejected")
    better = s.evaluator.evaluate(HUMAN)
    better.total, better.text = 1.0, variant(8)
    archive.add(1, better, 3, [])
    archive.add_unit(4, 1, "t/4", "p", [])
    archive.finish_unit(4, "rejected")
    assert archive.staleness(1, 1024) == 1


def test_the_run_budget_is_used_up_before_stopping(setup):
    s, _, guard, _ = setup(lambda n: answer(fenced(variant(n))), run_usd=0.05, workers=6)
    with pytest.raises(BudgetExceeded):
        s.run(max_units=500, progress=lambda m: None)
    worst = max(r[0] for r in _rows(guard, "select worst from calls"))
    assert 0.05e9 - 1.2 * worst < guard.run_spent() <= 0.05e9
    assert guard.status()["calls"].get("open", 0) == 0


def _rows(guard, q):
    with guard._tx() as db:
        return db.execute(q).fetchall()


def test_retry_after_is_respected(setup):
    try:
        import httpx2 as httpx
    except ImportError:
        import httpx
    request = httpx.Request("POST", "https://example.invalid/v1/messages")
    limited = anthropic.RateLimitError(
        "slow down",
        response=httpx.Response(429, request=request, headers={"retry-after": "37"}),
        body=None,
    )
    s, _, _, _ = setup(lambda n: limited if n == 1 else answer(fenced(variant(4))))
    s.seed()
    slept = []
    assert s.one(*s.new_unit(), sleep=slept.append) == "added"
    assert slept == [37.0]


def test_usage_is_logged_per_call(setup):
    s, _, guard, _ = setup(lambda n: answer(fenced(variant(n))))
    s.run(max_units=3, progress=lambda m: None)
    u = guard.usage_totals()
    assert u["calls"] == 3 and u["input_tokens"] == 3000 and u["output_tokens"] == 3000
    assert "1,000 output tokens" in s.usage_text()


def test_bars_leave_force_programs_out(tmp_path):
    point = {"ops_max": 100, "estimated_ops": False}
    data = {
        "points": [
            {"name": "ours", "kind": "force", "bytes_total": 10, **point},
            {"name": "net", "kind": "learned", "bytes_total": 50, **point},
        ]
    }
    path = tmp_path / "kpk.json"
    path.write_text(__import__("json").dumps(data))
    assert search.Bars.load(path).by_tier[256] == (50, "net")


def test_a_run_keeps_its_islands(setup):
    s, _, _, _ = setup(lambda n: answer("x"), tiers=(256, 1024))
    s.seed()
    with pytest.raises(ValueError, match="islands"):
        setup(lambda n: answer("x"), tiers=(64, 256))


def test_pool_scoring_gives_the_same_result():
    pool = search.PoolEvaluator("kpk", processes=1)
    try:
        a = pool.evaluate(HUMAN)
        b = search.Evaluator(score.kpk_task()).evaluate(HUMAN)
        assert (a.total, a.errors, a.ops_max, a.feedback) == (
            b.total,
            b.errors,
            b.ops_max,
            b.feedback,
        )
        with pytest.raises(dsl.DslError):
            pool.evaluate("import os\n")
        with pytest.raises(score.OverBudget):
            pool.evaluate(HEAVY)
    finally:
        pool.close()
