# KPK report

Task: KPK, 165,676 positions, table sha256 03e8133653f26b75f2924bc5b66cb37e6702c88c9d7bdbdf7b61c76c666293c0. Language: dsl 0.2 acd01c74a7d2eb2c. Total bytes is the score: program or model size plus exceptions. For programs and learned models both parts are information bounds (grammar code or an adaptive code over the weights, and log2 C(N, k)); tables are real files. See docs/01-dsl-concept.md. Operations are 64-bit word operations, maximum over all positions, with 32 added for an exception lookup whenever there are errors. Marked with a dash: operations not measured. Marked (est): a rough estimate.

## Against the target: Syzygy

The target is the Syzygy file of the endgame, with at most 4,096 operations per position: Syzygy KPvK.rtbw, 7,824 B on disk, about 983 operations on average and 2,122 at most (an estimate: decoder steps counted over every position, costs per step by hand, syzygy.json and scripts/syzygy_ops.py). The comparison uses real sizes: the program as one mixed-radix integer over its grammar choices (the tests decode it back) with a 2-byte length, and the exceptions as Elias-Fano with a select sample every 256 zeros, or a bitmap where that is smaller, so one position can be looked up without unpacking the rest (src/chess_forces/codec.py). The bound is the score: grammar code plus log2 C(N, k).

| Force program | Real bytes | Bound | Max ops | Against Syzygy |
| --- | ---: | ---: | ---: | ---: |
| r1-unit-831 | 4,886 | 4,426 | 1,259 | -2,938 B (-38%) |
| r1-trimmed-966 | 4,890 | 4,430 | 1,019 | -2,934 B (-38%) |
| evolved-1024 | 4,920 | 4,459 | 959 | -2,904 B (-37%) |
| evolved-256 | 5,893 | 5,367 | 232 | -1,931 B (-25%) |
| human | 6,207 | 5,639 | 273 | -1,617 B (-21%) |
| square | 16,801 | 14,151 | 70 | +8,977 B (+115%) |
| always_win | 20,718 | 18,914 | 32 | +12,894 B (+165%) |

## All methods

Total bytes is the bound used for ranking and the plot; real bytes is an actual encoding.

| | Total bytes | Real bytes | Model | Exceptions | Errors | Max ops |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| r1-unit-831 | 4,426 | 4,886 | 156.1 | 4,270.4 | 5,363 | 1,259 |
| r1-trimmed-966 | 4,430 | 4,890 | 138.3 | 4,291.8 | 5,398 | 1,019 |
| evolved-1024 | 4,459 | 4,920 | 150.3 | 4,308.9 | 5,426 | 959 |
| evolved-256 | 5,367 | 5,893 | 149.5 | 5,217.8 | 6,977 | 232 |
| human | 5,639 | 6,207 | 80.4 | 5,558.3 | 7,590 | 273 |
| square | 14,151 | 16,801 | 15.6 | 14,135.4 | 30,006 | 70 |
| always_win ★ | 18,914 | 20,718 | 0.8 | 18,912.9 | 54,394 | 32 |
| net relative3 14 hidden, 4 bit ★ | 2,178 | 2,351 | 1,531.8 | 646.0 | 530 | 235 |
| net relative3 12 hidden, 4 bit ★ | 2,213 | 2,383 | 1,464.0 | 748.9 | 631 | 211 |
| net relative3 10 hidden, 4 bit ★ | 2,390 | 2,576 | 1,262.6 | 1,127.5 | 1,027 | 187 |
| net relative3 8 hidden, 4 bit ★ | 2,628 | 2,783 | 1,303.8 | 1,324.0 | 1,246 | 163 |
| net relative3 6 hidden, 4 bit ★ | 2,994 | 3,224 | 1,008.4 | 1,985.4 | 2,041 | 139 |
| net relative3 5 hidden, 4 bit ★ | 3,458 | 3,771 | 854.0 | 2,604.0 | 2,857 | 127 |
| net relative3 4 hidden, 4 bit ★ | 4,144 | 4,471 | 696.3 | 3,447.8 | 4,072 | 115 |
| net relative3 3 hidden, 4 bit ★ | 4,880 | 5,410 | 584.2 | 4,295.5 | 5,404 | 103 |
| net relative 4 hidden, 4 bit ★ | 5,612 | 6,123 | 433.3 | 5,178.9 | 6,908 | 101 |
| net pairs3 additive, 5 bit ★ | 5,681 | 5,579 | 2,878.2 | 2,802.8 | 3,133 | 58 |
| decision tree, 128 leaves | 5,682 | 6,205 | 494.4 | 5,187.4 | 6,923 | 155 |
| decision tree, 96 leaves | 6,258 | 6,878 | 378.1 | 5,880.3 | 8,186 | 153 |
| net pairs additive, 5 bit ★ | 6,619 | 6,964 | 1,190.9 | 5,427.8 | 7,353 | 53 |
| decision tree, 64 leaves | 7,313 | 8,258 | 259.0 | 7,053.6 | 10,493 | 136 |
| decision tree, 32 leaves | 9,083 | 10,242 | 140.9 | 8,942.3 | 14,677 | 132 |
| decision tree, 16 leaves | 11,032 | 12,767 | 81.2 | 10,950.9 | 19,845 | 126 |
| net squares additive, 5 bit ★ | 12,002 | 14,121 | 79.7 | 11,922.8 | 22,656 | 52 |
| decision tree, 8 leaves | 13,288 | 15,654 | 39.9 | 13,248.3 | 26,881 | 80 |
| decision tree, 2 leaves | 15,028 | 18,068 | 9.7 | 15,017.8 | 33,400 | 53 |
| decision tree, 4 leaves | 15,040 | 18,081 | 22.6 | 15,017.8 | 33,400 | 75 |
| lzma of the bitbase | 3,341 | 3,341 | 3,341.0 | 0.0 | 0 | 282,600 (est) |
| Syzygy KPvK.rtbw | 7,824 | 7,824 | 7,824.0 | 0.0 | 0 | 2,122 (est) |
| bitbase (all slots) ★ | 24,576 | 24,576 | 24,576.0 | 0.0 | 0 | 20 |

## References per tier

Tables and learned models are references, not targets: they show how much of a win over Syzygy comes from the concepts and how much from Syzygy's general file format. Per operation tier: the smallest reference with counted operations, and the best force program at the same budget.

| Tier | Best reference | Best force program | Difference |
| ---: | --- | --- | ---: |
| 64 | 5,681 B (net pairs3 additive, 5 bit) | 18,914 B (always_win) | +13,233 B |
| 256 | 2,178 B (net relative3 14 hidden, 4 bit) | 5,367 B (evolved-256) | +3,190 B |
| 1,024 | 2,178 B (net relative3 14 hidden, 4 bit) | 4,430 B (r1-trimmed-966) | +2,252 B |
| 4,096 | 2,178 B (net relative3 14 hidden, 4 bit) | 4,426 B (r1-unit-831) | +2,249 B |

★ on the frontier of counted points (smallest total bytes at or below that operation count). Tables: Syzygy's operations are an estimate (see above); lzma is one setting, and its operations come from decompression time (rough, and different on every run), because a single position needs the whole file unpacked. Learned baselines are trained on all positions and their exceptions are charged. The decision trees are DSL programs in trees/, retrained only by chess-forces trees. The nets (src/chess_forces/nets.py) look up one row per square or square pair, add the rows and apply a small output layer; weights are integers, stored in nets/ and evaluated exactly, so the numbers do not depend on the machine. Net sizes use an adaptive code over the integer weights. A model may be held decoded (a DSL program and a net are); tables must be read at random. That rule is a choice: unpacked once, the lzma bitbase would need 20 operations too, but 24,576 bytes of memory, against at most a few KB for the nets.

Force programs: programs/*.dsl, hand-written or found by search. Paths are relative to this folder. The human rules were written from chess theory and tuned by looking at groups of mistakes over about 20 quick runs.
