"""Real encodings: they decode back exactly, and the program code is the grammar code of the score."""

import random

import numpy as np
import pytest
from test_dsl import Gen

from chess_forces import baselines, codec, dsl, endgames, nets, score

KPK = endgames.KPK
FILES = sorted(KPK.programs.glob("*.dsl")) + sorted(KPK.trees.glob("*.dsl"))


@pytest.mark.parametrize("path", FILES, ids=lambda p: p.name)
def test_program_code_decodes_to_the_same_tree_and_matches_the_score(path):
    prog = dsl.parse(path.read_text())
    blob = codec.encode_program(prog)
    assert codec.decode_program(blob) == prog
    bits = dsl.size_bits(prog)
    assert codec.program_bits(prog) == pytest.approx(bits, abs=1e-6)
    assert len(blob) <= bits / 8 + 1


def test_random_programs_round_trip():
    rng = random.Random(7)
    for _ in range(300):
        prog = dsl.parse(dsl.canonical(Gen(rng).program()))  # slots numbered as the parser does
        assert codec.decode_program(codec.encode_program(prog)) == prog


@pytest.mark.parametrize("k", [0, 1, 5, 300, 2_000, 9_000])
def test_exception_lists_decode_and_answer_every_position(k):
    n = 20_000
    wrong = sorted(random.Random(k).sample(range(n), k))
    blob = codec.encode_exceptions(n, wrong)
    assert codec.decode_exceptions(blob) == (n, wrong)
    listed = set(wrong)
    assert all(codec.contains(blob, x) == (x in listed) for x in range(n))
    if k:
        assert len(blob) < score.exception_bits(n, k) / 8 * 1.35 + 16


def test_dense_exceptions_fall_back_to_a_bitmap():
    n = 1_000
    wrong = list(range(0, n, 2))
    blob = codec.encode_exceptions(n, wrong)
    assert len(blob) == 5 + n // 8
    assert codec.decode_exceptions(blob) == (n, wrong)


def test_net_weights_decode():
    net = nets.load(min(KPK.nets.glob("relative3-h14-*.npz")))
    shape = (list(nets.FAMILIES).index(net.family), net.hidden, net.bits)
    blob = codec.encode_net(net.E, net.w, net.bias, shape)
    body = codec.decode_net_body(blob, 3 + 4)
    want = net.E.astype(np.int8).tobytes() + net.w.astype(np.int8).tobytes()
    assert body == want


def test_real_size_of_a_force_program_is_close_to_its_bound():
    text = (KPK.programs / "r1-trimmed-966.dsl").read_text()
    r = score.score(text, KPK.task())
    real = baselines.real_program_bytes(text, r)
    assert r.bytes_total < real < r.bytes_total * 1.15
