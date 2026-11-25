# KPK baselines

Task: KPK, 165,676 positions, table sha256 03e8133653f26b75f2924bc5b66cb37e6702c88c9d7bdbdf7b61c76c666293c0. Language: dsl 0.2 acd01c74a7d2eb2c. Every number is total bytes: program or model size plus exceptions (log2 C(N, k), see docs/01-dsl-concept.md). Operations are 64-bit word operations, maximum over all positions, with 32 added for an exception lookup whenever there are errors. Marked with a dash: operations not measured. Marked (est): a rough estimate.

| | Total bytes | Model | Exceptions | Errors | Max ops |
| --- | ---: | ---: | ---: | ---: | ---: |
| evolved, 1,024 ops | 4,459 | 150.3 | 4,308.9 | 5,426 | 959 |
| evolved, 256 ops | 5,367 | 149.5 | 5,217.8 | 6,977 | 232 |
| human rules | 5,639 | 80.4 | 5,558.3 | 7,590 | 273 |
| rule of the square | 14,151 | 15.6 | 14,135.4 | 30,006 | 70 |
| always win ★ | 18,914 | 0.8 | 18,912.9 | 54,394 | 32 |
| net relative3 14 hidden, 4 bit ★ | 2,178 | 1,531.8 | 646.0 | 530 | 235 |
| net relative3 12 hidden, 4 bit ★ | 2,213 | 1,464.0 | 748.9 | 631 | 211 |
| net relative3 10 hidden, 4 bit ★ | 2,390 | 1,262.6 | 1,127.5 | 1,027 | 187 |
| net relative3 8 hidden, 4 bit ★ | 2,628 | 1,303.8 | 1,324.0 | 1,246 | 163 |
| net relative3 6 hidden, 4 bit ★ | 2,994 | 1,008.4 | 1,985.4 | 2,041 | 139 |
| net relative3 5 hidden, 4 bit ★ | 3,458 | 854.0 | 2,604.0 | 2,857 | 127 |
| net relative3 4 hidden, 4 bit ★ | 4,144 | 696.3 | 3,447.8 | 4,072 | 115 |
| net relative3 3 hidden, 4 bit ★ | 4,880 | 584.2 | 4,295.5 | 5,404 | 103 |
| net relative 4 hidden, 4 bit ★ | 5,612 | 433.3 | 5,178.9 | 6,908 | 101 |
| net pairs3 additive, 5 bit ★ | 5,681 | 2,878.2 | 2,802.8 | 3,133 | 58 |
| decision tree, 128 leaves | 5,682 | 494.4 | 5,187.4 | 6,923 | 155 |
| decision tree, 96 leaves | 6,258 | 378.1 | 5,880.3 | 8,186 | 153 |
| net pairs additive, 5 bit ★ | 6,619 | 1,190.9 | 5,427.8 | 7,353 | 53 |
| decision tree, 64 leaves | 7,313 | 259.0 | 7,053.6 | 10,493 | 136 |
| decision tree, 32 leaves | 9,083 | 140.9 | 8,942.3 | 14,677 | 132 |
| decision tree, 16 leaves | 11,032 | 81.2 | 10,950.9 | 19,845 | 126 |
| net squares additive, 5 bit ★ | 12,002 | 79.7 | 11,922.8 | 22,656 | 52 |
| decision tree, 8 leaves | 13,288 | 39.9 | 13,248.3 | 26,881 | 80 |
| decision tree, 2 leaves | 15,028 | 9.7 | 15,017.8 | 33,400 | 53 |
| decision tree, 4 leaves | 15,040 | 22.6 | 15,017.8 | 33,400 | 75 |
| lzma of the bitbase | 3,341 | 3,341.0 | 0.0 | 0 | 297,876 (est) |
| Syzygy KPvK.rtbw | 7,824 | 7,824.0 | 0.0 | 0 | – |
| bitbase (all slots) ★ | 24,576 | 24,576.0 | 0.0 | 0 | 20 |

## What a force program has to beat

Per operation tier: the smallest total among tables and learned models with counted operations, and the best force program at the same budget.

| Tier | Best other method | Best force program | Difference |
| ---: | --- | --- | ---: |
| 64 | 5,681 B (net pairs3 additive, 5 bit) | 18,914 B (always win) | +13,233 B |
| 256 | 2,178 B (net relative3 14 hidden, 4 bit) | 5,367 B (evolved, 256 ops) | +3,190 B |
| 1,024 | 2,178 B (net relative3 14 hidden, 4 bit) | 4,459 B (evolved, 1,024 ops) | +2,281 B |
| 4,096 | 2,178 B (net relative3 14 hidden, 4 bit) | 4,459 B (evolved, 1,024 ops) | +2,281 B |

★ on the frontier of counted points (smallest total bytes at or below that operation count). Tables: Syzygy's operations were not measured; lzma is one setting, and its operations come from decompression time (rough), because a single position needs the whole file unpacked. Learned baselines are trained on all positions and their exceptions are charged. The decision trees are written as DSL programs. The nets (src/chess_forces/nets.py) look up one row per square or square pair, add the rows and apply a small output layer; weights are integers, stored in baselines/nets and evaluated exactly, so the numbers do not depend on the machine. Net sizes use an adaptive code over the integer weights. A model may be held decoded (a DSL program and a net are); tables must be read at random. That rule is a choice: unpacked once, the lzma bitbase would need 20 operations too, but 24,576 bytes of memory, against at most a few KB for the nets.

Hand-written programs: programs/*.dsl. The human rules were written from chess theory and tuned by looking at groups of mistakes over about 20 quick runs.
