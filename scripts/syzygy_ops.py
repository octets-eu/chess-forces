"""Rough operation count for one Syzygy WDL probe of every KPK position (writes endgames/kpk/syzygy.json).

Outside src/ because it needs python-chess (a dev dependency). It probes all 165,676 positions through
python-chess with a counting copy of the table decoder (Table.decompress_pairs) and counts the steps
that depend on the position: the walk through the size table to the right block, the Huffman symbols
decoded in the block, the comparisons that find each code length, the refills of the 64-bit code, and
the steps that expand a pair symbol to the stored value. Each step is given a cost in 64-bit word
operations, read off the reference code line by line; the parts that do not depend on the data
(material key, the squares of the three men, the index of the position, the capture check) are counted
by hand. All of it is an estimate, not a measurement of a real engine.

    uv run python scripts/syzygy_ops.py [path/to/syzygy]
"""

import datetime
import json
import sys
from pathlib import Path

import chess
import chess.syzygy

from chess_forces import endgames, kpk

# Cost of one step in 64-bit word operations (loads, arithmetic, comparisons, branches folded in).
STEP_COST = {
    "setup": 11,  # main index and offset: shift, mask, two table reads, adds
    "size_step": 5,  # one entry of the size table: load, compare, add or subtract, move on
    "block_start": 7,  # block pointer, first 64-bit code (load and byte swap), counters
    "symbol": 12,  # one Huffman symbol: offset read, symbol arithmetic, length test, advance
    "length_step": 3,  # one comparison with the base table while finding a code length
    "refill": 6,  # 32 new bits: load, byte swap, shift, or, pointer
    "pair_step": 15,  # one level of a pair symbol: two reads of the pattern, unpack, compare
    "finish": 4,  # value of the final symbol, minus 2
}
# Parts that do not depend on the table data, counted by hand from the reference code.
FIXED = {
    "material key and colour mirror": 13,
    "squares of the three men": 11,
    "pawn file and index of the position": 25,
    "capture check (king takes pawn)": 8,
}

counts: dict[str, int] = {}


def counting_decompress_pairs(self, d, idx):
    """chess.syzygy.Table.decompress_pairs with step counters; same result."""
    c = counts
    if not d.idxbits:
        return d.min_len
    c["setup"] += 1
    mainidx = idx >> d.idxbits
    litidx = (idx & (1 << d.idxbits) - 1) - (1 << (d.idxbits - 1))
    block = self.read_uint32(d.indextable + 6 * mainidx)
    litidx += self.read_uint16(d.indextable + 6 * mainidx + 4)
    if litidx < 0:
        while litidx < 0:
            c["size_step"] += 1
            block -= 1
            litidx += self.read_uint16(d.sizetable + 2 * block) + 1
    else:
        while litidx > self.read_uint16(d.sizetable + 2 * block):
            c["size_step"] += 1
            litidx -= self.read_uint16(d.sizetable + 2 * block) + 1
            block += 1
    c["block_start"] += 1
    ptr = d.data + (block << d.blocksize)
    m = d.min_len
    base_idx = -m
    code = self.read_uint64_be(ptr)
    ptr += 2 * 4
    bitcnt = 0
    while True:
        c["symbol"] += 1
        length = m
        c["length_step"] += 1
        while code < d.base[base_idx + length]:
            length += 1
            c["length_step"] += 1
        sym = self.read_uint16(d.offset + length * 2)
        sym += (code - d.base[base_idx + length]) >> (64 - length)
        if litidx < d.symlen[sym] + 1:
            break
        litidx -= d.symlen[sym] + 1
        code <<= length
        bitcnt += length
        if bitcnt >= 32:
            c["refill"] += 1
            bitcnt -= 32
            code |= self.read_uint32_be(ptr) << bitcnt
            ptr += 4
        code &= 0xFFFFFFFFFFFFFFFF
    sympat = d.sympat
    while d.symlen[sym]:
        c["pair_step"] += 1
        w = sympat + 3 * sym
        s1 = ((self.data[w + 1] & 0xF) << 8) | self.data[w]
        if litidx < d.symlen[s1] + 1:
            sym = s1
        else:
            litidx -= d.symlen[s1] + 1
            sym = (self.data[w + 2] << 4) | (self.data[w + 1] >> 4)
    c["finish"] += 1
    return self.data[sympat + 3 * sym]


def main(tables: Path) -> dict:
    original = chess.syzygy.Table.decompress_pairs
    chess.syzygy.Table.decompress_pairs = counting_decompress_pairs
    fixed = sum(FIXED.values())
    per_position, worst_steps = [], {}
    try:
        with chess.syzygy.open_tablebase(str(tables)) as tb:
            win = kpk.generate()
            for stm, p, wk, bk in kpk.iter_slots():
                b = chess.Board(None)
                b.set_piece_at(p, chess.Piece(chess.PAWN, True))
                b.set_piece_at(wk, chess.Piece(chess.KING, True))
                b.set_piece_at(bk, chess.Piece(chess.KING, False))
                b.turn = bool(stm)  # as in tests/test_kpk.py
                counts.clear()
                counts.update(dict.fromkeys(STEP_COST, 0))
                wdl = tb.probe_wdl(b)
                wins = (wdl == 2) if b.turn else (wdl == -2)
                if wins != win[stm, p, wk, bk]:
                    raise AssertionError(f"probe disagrees with the KPK table at {b.fen()}")
                ops = fixed + sum(STEP_COST[k] * n for k, n in counts.items())
                per_position.append(ops)
                for k, n in counts.items():
                    worst_steps[k] = max(worst_steps.get(k, 0), n)
    finally:
        chess.syzygy.Table.decompress_pairs = original
    return {
        "table": endgames.KPK.syzygy,
        "positions": len(per_position),
        "ops_mean": sum(per_position) / len(per_position),
        "ops_max": max(per_position),
        "estimate": True,
        "method": "python-chess probe_wdl with a counting decoder; step costs and fixed parts counted by hand",
        "step_cost": STEP_COST,
        "fixed": FIXED,
        "worst_steps": worst_steps,
        "date": datetime.date.today().isoformat(),
        "python_chess": chess.__version__,
    }


if __name__ == "__main__":
    where = Path(sys.argv[1]) if len(sys.argv) > 1 else endgames.ROOT.parent / "syzygy"
    out = main(where)
    endgames.KPK.syzygy_ops.write_text(json.dumps(out, indent=1) + "\n")
    print(json.dumps({k: out[k] for k in ("positions", "ops_mean", "ops_max", "worst_steps")}))
