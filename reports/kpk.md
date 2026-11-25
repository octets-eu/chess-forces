# KPK baselines

Task: KPK, 165,676 positions, table sha256 03e8133653f26b75f2924bc5b66cb37e6702c88c9d7bdbdf7b61c76c666293c0. Language: dsl 0.2 acd01c74a7d2eb2c. Every number is total bytes: program or model size plus exceptions (log2 C(N, k), see docs/01-dsl-concept.md). Operations are 64-bit word operations, maximum over all positions, with 32 added for an exception lookup whenever there are errors. Marked with a dash: operations not measured. Marked (est): a rough estimate.

| | Total bytes | Model | Exceptions | Errors | Max ops |
| --- | ---: | ---: | ---: | ---: | ---: |
| evolved, 1,024 ops | 4,459 | 150.3 | 4,308.9 | 5,426 | 959 |
| evolved, 256 ops ★ | 5,367 | 149.5 | 5,217.8 | 6,977 | 232 |
| human rules | 5,639 | 80.4 | 5,558.3 | 7,590 | 273 |
| rule of the square ★ | 14,151 | 15.6 | 14,135.4 | 30,006 | 70 |
| always win ★ | 18,914 | 0.8 | 18,912.9 | 54,394 | 32 |
| net 64 ★ | 2,837 | 593.0 | 2,243.9 | 2,374 | 1,197 |
| net 128 | 3,095 | 1,169.0 | 1,925.8 | 1,966 | 2,349 |
| net 32 ★ | 3,105 | 305.0 | 2,800.0 | 3,129 | 621 |
| net 16 ★ | 3,795 | 161.0 | 3,633.9 | 4,355 | 333 |
| net 16x16 | 4,487 | 441.0 | 4,046.2 | 5,001 | 877 |
| net 8 ★ | 5,670 | 89.0 | 5,581.2 | 7,632 | 189 |
| decision tree, 128 leaves ★ | 5,682 | 494.4 | 5,187.4 | 6,923 | 155 |
| decision tree, 96 leaves ★ | 6,258 | 378.1 | 5,880.3 | 8,186 | 153 |
| decision tree, 64 leaves ★ | 7,313 | 259.0 | 7,053.6 | 10,493 | 136 |
| decision tree, 32 leaves ★ | 9,083 | 140.9 | 8,942.3 | 14,677 | 132 |
| decision tree, 16 leaves ★ | 11,032 | 81.2 | 10,950.9 | 19,845 | 126 |
| decision tree, 8 leaves ★ | 13,288 | 39.9 | 13,248.3 | 26,881 | 80 |
| decision tree, 2 leaves ★ | 15,028 | 9.7 | 15,017.8 | 33,400 | 53 |
| decision tree, 4 leaves | 15,040 | 22.6 | 15,017.8 | 33,400 | 75 |
| lzma of the bitbase | 3,341 | 3,341.0 | 0.0 | 0 | 266,001 (est) |
| Syzygy KPvK.rtbw | 7,824 | 7,824.0 | 0.0 | 0 | – |
| bitbase (all slots) ★ | 24,576 | 24,576.0 | 0.0 | 0 | 20 |

## What a force program has to beat

Per operation tier: the smallest total among tables and learned models with counted operations, and the best force program at the same budget.

| Tier | Best other method | Best force program | Difference |
| ---: | --- | --- | ---: |
| 64 | 15,028 B (decision tree, 2 leaves) | 18,914 B (always win) | +3,886 B |
| 256 | 5,670 B (net 8) | 5,367 B (evolved, 256 ops) | -303 B |
| 1,024 | 3,105 B (net 32) | 4,459 B (evolved, 1,024 ops) | +1,354 B |
| 4,096 | 2,837 B (net 64) | 4,459 B (evolved, 1,024 ops) | +1,622 B |

★ on the frontier of counted points (smallest total bytes at or below that operation count). Tables: Syzygy's operations were not measured; lzma is one setting, and its operations come from decompression time (rough), because a single position needs the whole file unpacked. Learned baselines are trained on all positions and their exceptions are charged. The decision trees are written as DSL programs; the nets use 8-bit weights and count operations from their layer sizes. Seeds are fixed; results may change slightly with another scikit-learn build.

Hand-written programs: programs/*.dsl. The human rules were written from chess theory and tuned by looking at groups of mistakes over about 20 quick runs.
