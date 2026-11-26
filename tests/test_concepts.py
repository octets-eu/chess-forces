"""Concept loop (docs/03-concept-loop.md) on a slice of KPK, with a fake client: no network, no money."""

import json

import numpy as np
import pytest
from test_search import FakeClient, answer, fenced

from chess_forces import concepts, dsl, score
from chess_forces.budget import Guard

CONCEPT = """def wins() -> Bool:
    n = min(5, 7 - rank(P))
    runs = n + 1 - tempo < dist(k, sq(file(P), 7))
    near = dist(K, P) <= 1
    both = runs and near
    return both
"""


@pytest.fixture(scope="module")
def task():
    full = score.kpk_task()
    n = 6000
    return score.Task("kpk-slice", full.positions[:n], full.truth[:n], "slice-6000", full.describe)


@pytest.fixture(scope="module")
def pool(task):
    p, _ = concepts.build_pool(task, keep=60)
    return p


def test_named_concepts_take_their_statements_and_agree_with_the_language(task):
    cs = concepts.named_concepts(CONCEPT, "u7_", task, "test")
    assert [c.name for c in cs] == ["u7_runs", "u7_near", "u7_both"]
    both = cs[2]
    assert both.lines[0].strip().startswith("u7_n = ")  # the Int statement it needs comes along
    run = dsl.compile_program(dsl.parse(CONCEPT))
    ctx = dsl.Ctx(task.positions[0], dsl.CAP)
    for i in range(0, task.n, 97):
        ctx.pos, ctx.ops = task.positions[i], 0
        assert bool(both.values[i]) == run(ctx)


def test_helper_functions_and_bad_programs_give_no_concepts(task):
    helper = "def f() -> Bool:\n    return True\n\ndef wins() -> Bool:\n    x = f()\n    return x\n"
    with pytest.raises(concepts.Rejected):
        concepts.named_concepts(helper, "p_", task, "test")
    with pytest.raises(dsl.DslError):
        concepts.named_concepts("def wins() -> Bool:\n    return nonsense\n", "p_", task, "test")


def test_trees_written_as_programs_score_as_the_tree_predicts(pool, task):
    for leaves in (64, None):
        g = pool.grow(leaves)
        r = score.score(g.text, task)
        assert r.errors == g.errors
        assert r.bits_program == pytest.approx(g.bits_program)
    assert pool.grow(None).errors == 0


def test_the_filter_sees_information_only_where_the_tree_is_wrong(pool):
    g = pool.grow(8)
    assert g.errors > 0
    leaf = g.tree.apply(pool.matrix())
    truth = concepts.gain_in_leaves(pool.y.copy(), pool.y, leaf)
    again = concepts.gain_in_leaves(g.tree.predict(pool.matrix()).astype(bool), pool.y, leaf)
    assert truth > 0 and again == pytest.approx(0.0, abs=1e-6)


def test_loop_judges_answers_and_keeps_every_outcome(tmp_path, task):
    p, _ = concepts.build_pool(task, keep=60)
    guard = Guard(tmp_path / "budget.sqlite", run="t", run_limit_usd=1.0)
    if not guard._limits_or_none():
        guard.init(50, 20)
    texts = {1: fenced(CONCEPT), 2: "no code here", 3: fenced(CONCEPT)}
    client = FakeClient(lambda n: answer(texts.get(n, "nothing")))
    s = concepts.LoopSettings(run="t", workers=1, plateau=50)
    loop = concepts.ConceptLoop(s, guard, client, p, tmp_path / "out", log=lambda m: None)
    loop.run(max_units=3)
    status = [(o.unit, o.status) for o in loop.outcomes]
    assert (1, "rejected") in status  # unit 1 got the answer without code
    assert any(st in ("accepted", "small") for u, st in status if u == 0)
    first = {o.name.split("_", 1)[1]: o.status for o in loop.outcomes if o.unit == 0}
    for o in (o for o in loop.outcomes if o.unit == 2):  # the same concepts again
        if first[o.name.split("_", 1)[1]] == "accepted":
            assert o.status == "duplicate"
    assert len(client.calls) == 3 and guard.run_spent() > 0
    loop.save(tmp_path / "outcomes.json")
    data = json.loads((tmp_path / "outcomes.json").read_text())
    for rec in data["accepted"]:
        c = concepts.concept_from_record(rec, task)
        assert np.array_equal(
            c.values, next(a for a in loop.accepted if a.name == rec["name"]).values
        )
    # a rerun replays the paid answers from the ledger: no new calls
    again = concepts.ConceptLoop(
        s,
        guard,
        client,
        concepts.build_pool(task, keep=60)[0],
        tmp_path / "out2",
        log=lambda m: None,
    )
    again.run(max_units=3)
    assert len(client.calls) == 3
