"""Real encodings next to the information bounds of the score (docs/01-dsl-concept.md, scoring item 3).

The score counts a program by its grammar code and the exceptions by log2 C(N, k). Those are bounds.
This module writes actual bytes that a decoder can turn back into the same thing:

- a program as one mixed-radix integer over the same choices the grammar code counts, so it needs at
  most one byte more than the bound (decode() rebuilds the identical tree);
- the exceptions as Elias-Fano with a sampled select index, so a single position can be looked up
  without unpacking the rest, or as a plain bitmap where that is smaller;
- a net as its integer weights packed with lzma.
"""

import lzma
import math
import struct
from collections.abc import Iterable

import numpy as np

from .dsl import (
    ENUMS,
    INT_MAX,
    INT_MIN,
    PRIMS,
    PRODUCTIONS,
    VALUE_TYPES,
    App,
    Call,
    Def,
    If,
    Let,
    Lit,
    Logic,
    Loop,
    Program,
    Var,
    size_bits,
)

INTS = INT_MAX - INT_MIN + 1

# --- programs: one mixed-radix integer -----------------------------------------------------------


def choices(program: Program) -> list[tuple[int, int]]:
    """The (digit, radix) sequence the grammar code counts, in decoding order."""
    out: list[tuple[int, int]] = []
    last = len(program.defs) - 1
    for i, d in enumerate(program.defs):
        if i < last:
            out.append((1, 2))  # another def before wins()
            for t in d.params:
                out += [(1, 2), (VALUE_TYPES.index(t), len(VALUE_TYPES))]
            out += [(0, 2), (VALUE_TYPES.index(d.ret), len(VALUE_TYPES))]
        else:
            out.append((0, 2))  # wins() follows
        earlier = [(j, e.ret) for j, e in enumerate(program.defs[:i])]
        _choices(d.body, list(enumerate(d.params)), earlier, out)
    return out


def _choices(e, scope: list, earlier: list, out: list) -> None:
    t = e.t
    if t in ENUMS:
        out.append((ENUMS[t].index(e.v), len(ENUMS[t])))
        return
    prods = PRODUCTIONS[t]
    vars_t = [slot for slot, vt in scope if vt == t]
    defs_t = [j for j, ret in earlier if ret == t]
    n = len(prods) + len(vars_t) + len(defs_t)
    match e:
        case Var():
            out.append((len(prods) + vars_t.index(e.slot), n))
        case Call():
            out.append((len(prods) + len(vars_t) + defs_t.index(e.fn), n))
            for a in e.args:
                _choices(a, scope, earlier, out)
        case App():
            out.append((prods.index(e.prim), n))
            for a in e.args:
                _choices(a, scope, earlier, out)
        case Lit():
            out.append((prods.index("lit"), n))
            out.append((int(e.v), 2) if t == "Bool" else (e.v - INT_MIN, INTS))
        case Logic():
            out.append((prods.index(e.op), n))
            for a in e.args:
                _choices(a, scope, earlier, out)
        case If():
            out.append((prods.index("if"), n))
            for x in (e.c, e.a, e.b):
                _choices(x, scope, earlier, out)
        case Let():
            out.append((prods.index("let"), n))
            out.append((VALUE_TYPES.index(e.rhs.t), len(VALUE_TYPES)))
            _choices(e.rhs, scope, earlier, out)
            _choices(e.body, [*scope, (e.slot, e.rhs.t)], earlier, out)
        case Loop():
            out.append((prods.index(e.op), n))
            _choices(e.over, scope, earlier, out)
            _choices(e.body, [*scope, (e.slot, "Sq")], earlier, out)
        case _:
            raise AssertionError(e)


def encode_program(program: Program) -> bytes:
    value, scale = 0, 1
    for digit, radix in choices(program):
        value += digit * scale
        scale *= radix
    return value.to_bytes(max(1, ((scale - 1).bit_length() + 7) // 8), "little")


def program_bits(program: Program) -> float:
    """log2 of the product of the radices; equals dsl.size_bits (checked in the tests)."""
    return sum(math.log2(r) for _, r in choices(program))


class _Digits:
    def __init__(self, data: bytes):
        self.value = int.from_bytes(data, "little")

    def take(self, radix: int) -> int:
        self.value, d = divmod(self.value, radix)
        return d


def decode_program(data: bytes) -> Program:
    r = _Digits(data)
    defs: list[Def] = []
    while True:
        another = r.take(2)
        params: list[str] = []
        if another:
            while r.take(2):
                params.append(VALUE_TYPES[r.take(len(VALUE_TYPES))])
            ret = VALUE_TYPES[r.take(len(VALUE_TYPES))]
        else:
            ret = "Bool"
        counter = [len(params)]
        body = _read(ret, list(enumerate(params)), defs, counter, r)
        defs.append(Def(tuple(params), ret, body, counter[0]))
        if not another:
            return Program(tuple(defs))


def _read(t: str, scope: list, defs: list[Def], counter: list[int], r: _Digits):
    if t in ENUMS:
        return Lit(t, ENUMS[t][r.take(len(ENUMS[t]))])
    prods = PRODUCTIONS[t]
    vars_t = [slot for slot, vt in scope if vt == t]
    defs_t = [j for j, d in enumerate(defs) if d.ret == t]
    c = r.take(len(prods) + len(vars_t) + len(defs_t))
    if c >= len(prods) + len(vars_t):
        fn = defs_t[c - len(prods) - len(vars_t)]
        args = tuple(_read(pt, scope, defs, counter, r) for pt in defs[fn].params)
        return Call(t, fn, args)
    if c >= len(prods):
        return Var(t, vars_t[c - len(prods)])
    name = prods[c]
    if name == "if":
        cond = _read("Bool", scope, defs, counter, r)
        a = _read(t, scope, defs, counter, r)
        return If(t, cond, a, _read(t, scope, defs, counter, r))
    if name == "let":
        rt = VALUE_TYPES[r.take(len(VALUE_TYPES))]
        rhs = _read(rt, scope, defs, counter, r)
        slot = counter[0]
        counter[0] += 1
        return Let(t, slot, rhs, _read(t, [*scope, (slot, rt)], defs, counter, r))
    if name == "lit":
        return Lit("Bool", bool(r.take(2))) if t == "Bool" else Lit("Int", r.take(INTS) + INT_MIN)
    if name in ("and", "or"):
        a = _read("Bool", scope, defs, counter, r)
        return Logic("Bool", name, (a, _read("Bool", scope, defs, counter, r)))
    if name == "not":
        return Logic("Bool", "not", (_read("Bool", scope, defs, counter, r),))
    if name in ("any", "count_if"):
        over = _read("Field", scope, defs, counter, r)
        slot = counter[0]
        counter[0] += 1
        return Loop(t, name, slot, over, _read("Bool", [*scope, (slot, "Sq")], defs, counter, r))
    p = PRIMS[name]
    return App(t, name, tuple(_read(a, scope, defs, counter, r) for a in p.args))


# --- exceptions: Elias-Fano with a sampled select index, or a bitmap ----------------------------

SELECT_STRIDE = 256  # one sample per this many zeros of the upper bits
_EMPTY, _EF, _BITMAP = 0, 1, 2


class _Bits:
    """Little-endian bit string in a Python int."""

    def __init__(self) -> None:
        self.value, self.n = 0, 0

    def put(self, x: int, width: int) -> None:
        if width:
            self.value |= (x & ((1 << width) - 1)) << self.n
            self.n += width

    def bytes(self) -> bytes:
        return self.value.to_bytes((self.n + 7) // 8, "little")


def _ef_layout(n: int, k: int) -> tuple[int, int, int, int]:
    """low bits per entry, length of the upper bits, number of select samples, sample width."""
    low = max(0, math.floor(math.log2(n / k)))
    upper = k + (n >> low) + 1
    zeros = upper - k
    samples = (zeros + SELECT_STRIDE - 1) // SELECT_STRIDE
    return low, upper, samples, max(1, upper.bit_length())


def encode_exceptions(n: int, wrong: Iterable[int]) -> bytes:
    xs = sorted({int(x) for x in wrong})
    k = len(xs)
    if k == 0:
        return struct.pack("<BI", _EMPTY, n)
    if xs[0] < 0 or xs[-1] >= n:
        raise ValueError("exception outside 0..n-1")
    low, upper, samples, width = _ef_layout(n, k)
    bits = _Bits()
    for x in xs:
        bits.put(x, low)
    up = 0
    for i, x in enumerate(xs):
        up |= 1 << ((x >> low) + i)
    zero_positions = [p for p in range(upper) if not (up >> p) & 1]
    bits.put(up, upper)
    for j in range(samples):
        bits.put(zero_positions[j * SELECT_STRIDE], width)
    ef = struct.pack("<BII", _EF, n, k) + bits.bytes()
    bitmap = struct.pack("<BI", _BITMAP, n) + _bitmap(n, xs)
    return ef if len(ef) <= len(bitmap) else bitmap


def _bitmap(n: int, xs: list[int]) -> bytes:
    v = 0
    for x in xs:
        v |= 1 << x
    return v.to_bytes((n + 7) // 8, "little")


def _ef_parts(blob: bytes):
    _, n, k = struct.unpack_from("<BII", blob)
    low, upper, samples, width = _ef_layout(n, k)
    v = int.from_bytes(blob[9:], "little")
    lows = v & ((1 << (k * low)) - 1)
    up = (v >> (k * low)) & ((1 << upper) - 1)
    sv = v >> (k * low + upper)
    sample = [(sv >> (j * width)) & ((1 << width) - 1) for j in range(samples)]
    return n, k, low, lows, up, upper, sample


def decode_exceptions(blob: bytes) -> tuple[int, list[int]]:
    kind = blob[0]
    if kind == _EMPTY:
        return struct.unpack_from("<I", blob, 1)[0], []
    if kind == _BITMAP:
        n = struct.unpack_from("<I", blob, 1)[0]
        v = int.from_bytes(blob[5:], "little")
        return n, [x for x in range(n) if (v >> x) & 1]
    n, _, low, lows, up, upper, _ = _ef_parts(blob)
    out, zeros, i = [], 0, 0
    for p in range(upper):
        if (up >> p) & 1:
            out.append((zeros << low) | ((lows >> (i * low)) & ((1 << low) - 1)))
            i += 1
        else:
            zeros += 1
    return n, out


def contains(blob: bytes, x: int) -> bool:
    """Random access: is position x listed? Reads one sample and a short stretch of the upper bits."""
    kind = blob[0]
    if kind == _EMPTY:
        return False
    if kind == _BITMAP:
        return bool((blob[5 + (x >> 3)] >> (x & 7)) & 1)
    _, _, low, lows, up, upper, sample = _ef_parts(blob)
    h = x >> low
    # bucket h holds the ones between zero number h-1 and zero number h
    if h == 0:
        p = 0
    else:
        z = h - 1
        p = sample[z // SELECT_STRIDE]
        seen = (z // SELECT_STRIDE) * SELECT_STRIDE
        while seen < z:
            p += 1
            if not (up >> p) & 1:
                seen += 1
        p += 1
    mask = (1 << low) - 1
    while p < upper and (up >> p) & 1:
        i = p - h  # ones before p
        if ((lows >> (i * low)) & mask) == (x & mask):
            return True
        p += 1
    return False


# --- nets: integer weights with lzma -------------------------------------------------------------

_LZMA = [{"id": lzma.FILTER_LZMA2, "preset": 9 | lzma.PRESET_EXTREME, "lc": 0, "lp": 0, "pb": 0}]


def encode_net(E: np.ndarray, w: np.ndarray, bias: int, shape: tuple[int, ...]) -> bytes:
    """Shape (family, hidden, bits as small integers), bias, then E and w as int8, lzma-packed."""
    head = struct.pack("<" + "B" * len(shape) + "i", *shape, int(bias))
    body = E.astype(np.int8).tobytes() + w.astype(np.int8).tobytes()
    return head + lzma.compress(body, format=lzma.FORMAT_RAW, filters=_LZMA)


def decode_net_body(blob: bytes, head_len: int) -> bytes:
    return lzma.decompress(blob[head_len:], format=lzma.FORMAT_RAW, filters=_LZMA)


__all__ = [
    "choices",
    "contains",
    "decode_exceptions",
    "decode_net_body",
    "decode_program",
    "encode_exceptions",
    "encode_net",
    "encode_program",
    "program_bits",
    "size_bits",
]
