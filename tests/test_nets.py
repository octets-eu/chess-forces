"""Table nets: exact integer evaluation, code length, bias search, operation counts."""

import json
import math

import numpy as np
import pytest

from chess_forces import nets, score


@pytest.fixture(scope="module")
def task():
    return score.kpk_task()


def test_code_length_matches_the_sequential_estimator():
    rng = np.random.default_rng(0)
    values = rng.choice([-2, 0, 0, 0, 1, 3], 60)
    alphabet, counts, bits = 7, {}, 0.0
    for i, v in enumerate(values):  # Krichevsky-Trofimov, one symbol at a time
        bits -= math.log2((counts.get(v, 0) + 0.5) / (i + alphabet / 2))
        counts[v] = counts.get(v, 0) + 1
    assert nets.code_bits(values, alphabet) == pytest.approx(bits)
    assert nets.code_bits(np.zeros(1000, dtype=int), 7) < 40  # a constant costs almost nothing


def test_best_bias_is_optimal():
    rng = np.random.default_rng(1)
    for _ in range(50):
        z, y = rng.integers(-6, 7, 40), rng.random(40) < 0.5
        bias, errors = nets._best_bias(z, y)
        assert errors == int(((z + bias > 0) != y).sum())
        assert errors == min(int(((z + b > 0) != y).sum()) for b in range(-20, 21))


def test_rows_cover_the_tables_without_overlap(task):
    for family, spec in nets.FAMILIES.items():
        J, total = nets.rows(task, family)
        assert total == sum(nets.TABLES[n].size for n in spec.tables)
        base = 0
        for c, name in enumerate(spec.tables):
            assert J[:, c].min() >= base and J[:, c].max() < base + nets.TABLES[name].size
            base += nets.TABLES[name].size


def test_logits_match_a_plain_python_evaluation(task):
    rng = np.random.default_rng(2)
    J, D = nets.rows(task, "relative")
    net = nets.Net(
        "relative",
        3,
        4,
        rng.integers(-7, 8, (D, 3)).astype(np.int8),
        rng.integers(-15, 16, 3).astype(np.int8),
        5,
    )
    z = net.logits(J)
    for i in rng.integers(0, task.n, 200):
        total = net.bias
        for j in range(3):
            h = sum(int(net.E[row, j]) for row in J[i])
            total += int(net.w[j]) * max(0, h)
        assert z[i] == total


def test_operation_counts_by_hand():
    E, w = np.zeros((154, 2), dtype=np.int8), np.zeros(2, dtype=np.int8)
    # 4 loads, 4 for the pawn index, 4 tables x 2 for the row address,
    # 2 hidden x (4 loads + 3 adds + ReLU + multiply + add), one comparison
    assert nets.Net("squares", 2, 4, E, w, 0).ops() == 4 + 4 + 8 + 2 * 10 + 1
    # additive: 4 loads, 4 index, 4 address adds, 4 loads, 3 adds, one comparison
    assert nets.Net("squares", 0, 4, E[:, :1], w[:0], 0).ops() == 4 + 4 + 4 + 4 + 3 + 1


def test_training_is_exact_and_beats_the_constant_answer(task):
    net, errors = nets.train("squares", 4, 4, seed=0, epochs=6, task=task)
    r = nets.evaluate(net, task)
    assert r.errors == errors < 54_394
    assert np.abs(net.E).max() <= 7 and net.E.dtype == np.int8


def test_saved_nets_reproduce_their_recorded_scores(task):
    recorded = nets.NETS_DIR / "sweep.json"
    if not recorded.exists():
        pytest.skip("nets not trained yet")
    by_digest = {r["digest"]: r for r in json.loads(recorded.read_text())}
    paths = list(nets.NETS_DIR.glob("*.npz"))
    assert paths
    for path in paths:
        r = nets.evaluate(nets.load(path), task)
        old = by_digest[r.digest]
        assert (r.errors, r.ops) == (old["errors"], old["ops"])
        assert r.model_bytes == pytest.approx(old["model_bytes"])
