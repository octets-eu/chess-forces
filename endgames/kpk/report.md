# KPK report

Task: KPK, 165,676 positions, table sha256 03e8133653f26b75f2924bc5b66cb37e6702c88c9d7bdbdf7b61c76c666293c0. Language: dsl 0.3 0b9fbe14c26f9ea3. Total bytes is the score: program or model size plus exceptions. For programs and learned models both parts are information bounds (grammar code or an adaptive code over the weights, and log2 C(N, k)); tables are real files. See docs/01-dsl-concept.md. Operations are 64-bit word operations, maximum over all positions, with 32 added for an exception lookup whenever there are errors. Marked with a dash: operations not measured. Marked (est): a rough estimate.

## Against the target: Syzygy

The target is the Syzygy file of the endgame, with at most 4,096 operations per position: Syzygy KPvK.rtbw, 7,824 B on disk, about 983 operations on average and 2,122 at most (an estimate: decoder steps counted over every position, costs per step by hand, syzygy.json and scripts/syzygy_ops.py). The comparison uses real sizes: the program as one mixed-radix integer over its grammar choices (the tests decode it back) with a 2-byte length, and the exceptions as Elias-Fano with a select sample every 256 zeros, or a bitmap where that is smaller, so one position can be looked up without unpacking the rest (src/chess_forces/codec.py). The bound is the score: grammar code plus log2 C(N, k).

| Force program | Real bytes | Bound | Max ops | Against Syzygy |
| --- | ---: | ---: | ---: | ---: |
| forcetree-0256 | 3,577 | 3,390 | 1,357 | -4,247 B (-54%) |
| forcetree-0064 | 4,480 | 4,137 | 1,355 | -3,344 B (-43%) |
| r1-unit-831 | 4,886 | 4,426 | 1,259 | -2,938 B (-38%) |
| r1-trimmed-966 | 4,890 | 4,430 | 1,019 | -2,934 B (-38%) |
| evolved-1024 | 4,920 | 4,459 | 959 | -2,904 B (-37%) |
| evolved-256 | 5,893 | 5,367 | 232 | -1,931 B (-25%) |
| human | 6,207 | 5,639 | 273 | -1,617 B (-21%) |
| forcetree-1800 | 7,110 | 7,103 | 1,325 | -714 B (-9%) |
| square | 16,801 | 14,151 | 70 | +8,977 B (+115%) |
| always_win | 20,718 | 18,914 | 32 | +12,894 B (+165%) |

## Exact methods (no exceptions)

Every method that answers all positions without a list of exceptions is kept and shown, smallest first.

| Method | Kind | Bytes (score) | Real bytes | Operations, mean / max |
| --- | --- | ---: | ---: | ---: |
| lzma of the bitbase | table | 3,341 | 3,341 | 282,600 / 282,600 (est) |
| net relative3 48 hidden, 4 bit (relative3-h48-b4-s1-l3e-06) | learned | 3,795 | 4,018 | 611 / 611 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s1-l3e-06) | learned | 4,202 | 4,404 | 803 / 803 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s0-l3e-06) | learned | 4,412 | 4,625 | 803 / 803 |
| net relative3 24 hidden, 4 bit (relative3-h24-b4-s0-l0) | learned | 4,583 | 4,783 | 323 / 323 |
| net relative3 24 hidden, 4 bit (relative3-h24-b4-s1-l0) | learned | 4,587 | 4,825 | 323 / 323 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s0-l3e-06) | learned | 4,857 | 5,027 | 1,187 / 1,187 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s1-l3e-06) | learned | 5,129 | 5,355 | 1,187 / 1,187 |
| net relative 48 hidden, 4 bit (relative-h48-b4-s1-l0) | learned | 5,345 | 5,283 | 509 / 509 |
| net relative 48 hidden, 4 bit (relative-h48-b4-s0-l0) | learned | 5,371 | 5,309 | 509 / 509 |
| net relative3 32 hidden, 4 bit (relative3-h32-b4-s1-l0) | learned | 6,081 | 6,283 | 419 / 419 |
| net relative3 32 hidden, 4 bit (relative3-h32-b4-s0-l0) | learned | 6,090 | 6,417 | 419 / 419 |
| forcetree-1800 | force | 7,103 | 7,110 | 469 / 1,325 |
| net relative 64 hidden, 4 bit (relative-h64-b4-s0-l0) | learned | 7,121 | 7,267 | 669 / 669 |
| net relative3 48 hidden, 3 bit (relative3-h48-b3-s0-l0) | learned | 7,123 | 7,978 | 611 / 611 |
| net relative 64 hidden, 4 bit (relative-h64-b4-s1-l0) | learned | 7,130 | 7,165 | 669 / 669 |
| net relative3 48 hidden, 3 bit (relative3-h48-b3-s1-l0) | learned | 7,137 | 8,077 | 611 / 611 |
| Syzygy KPvK.rtbw | table | 7,824 | 7,824 | 983 / 2,122 (est) |
| net relative 96 hidden, 3 bit (relative-h96-b3-s1-l0) | learned | 8,399 | 8,998 | 989 / 989 |
| net relative 96 hidden, 3 bit (relative-h96-b3-s0-l0) | learned | 8,401 | 9,080 | 989 / 989 |
| net relative3 48 hidden, 4 bit (relative3-h48-b4-s0-l0) | learned | 9,079 | 9,734 | 611 / 611 |
| net relative3 48 hidden, 4 bit (relative3-h48-b4-s1-l0) | learned | 9,148 | 9,824 | 611 / 611 |
| net relative3 64 hidden, 3 bit (relative3-h64-b3-s0-l0) | learned | 9,488 | 10,767 | 803 / 803 |
| net relative3 64 hidden, 3 bit (relative3-h64-b3-s1-l0) | learned | 9,505 | 10,720 | 803 / 803 |
| decision tree, 2926 leaves | learned | 10,665 | 10,672 | 111 / 157 |
| net relative 96 hidden, 4 bit (relative-h96-b4-s0-l0) | learned | 10,668 | 11,139 | 989 / 989 |
| net relative 96 hidden, 4 bit (relative-h96-b4-s1-l0) | learned | 10,705 | 11,167 | 989 / 989 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s0-l0) | learned | 12,188 | 12,720 | 803 / 803 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s1-l0) | learned | 12,198 | 12,717 | 803 / 803 |
| net relative3 96 hidden, 3 bit (relative3-h96-b3-s1-l0) | learned | 14,214 | 16,040 | 1,187 / 1,187 |
| net relative3 96 hidden, 3 bit (relative3-h96-b3-s0-l0) | learned | 14,224 | 16,147 | 1,187 / 1,187 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s1-l0) | learned | 18,214 | 19,280 | 1,187 / 1,187 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s0-l0) | learned | 18,214 | 19,420 | 1,187 / 1,187 |
| bitbase (all slots) | table | 24,576 | 24,576 | 20 / 20 |

## All methods

Total bytes is the bound used for ranking and the plot; real bytes is an actual encoding.

| | Total bytes | Real bytes | Model | Exceptions | Errors | Max ops |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| forcetree-0256 | 3,390 | 3,577 | 1,142.7 | 2,247.0 | 2,378 | 1,357 |
| forcetree-0064 | 4,137 | 4,480 | 405.5 | 3,731.2 | 4,505 | 1,355 |
| r1-unit-831 | 4,426 | 4,886 | 156.1 | 4,270.4 | 5,363 | 1,259 |
| r1-trimmed-966 | 4,430 | 4,890 | 138.3 | 4,291.8 | 5,398 | 1,019 |
| evolved-1024 | 4,459 | 4,920 | 150.3 | 4,308.9 | 5,426 | 959 |
| evolved-256 | 5,367 | 5,893 | 149.5 | 5,217.8 | 6,977 | 232 |
| human | 5,639 | 6,207 | 80.4 | 5,558.3 | 7,590 | 273 |
| forcetree-1800 | 7,103 | 7,110 | 7,102.7 | 0.0 | 0 | 1,325 |
| square | 14,151 | 16,801 | 15.6 | 14,135.4 | 30,006 | 70 |
| always_win ★ | 18,914 | 20,718 | 0.8 | 18,912.9 | 54,394 | 32 |
| net relative3 14 hidden, 4 bit ★ | 2,178 | 2,351 | 1,531.8 | 646.0 | 530 | 235 |
| net relative3 12 hidden, 4 bit ★ | 2,213 | 2,383 | 1,464.0 | 748.9 | 631 | 211 |
| net relative3 10 hidden, 4 bit ★ | 2,390 | 2,576 | 1,262.6 | 1,127.5 | 1,027 | 187 |
| net relative3 8 hidden, 4 bit ★ | 2,628 | 2,783 | 1,303.8 | 1,324.0 | 1,246 | 163 |
| net relative3 6 hidden, 4 bit ★ | 2,994 | 3,224 | 1,008.4 | 1,985.4 | 2,041 | 139 |
| net relative3 5 hidden, 4 bit ★ | 3,458 | 3,771 | 854.0 | 2,604.0 | 2,857 | 127 |
| net relative3 48 hidden, 4 bit (relative3-h48-b4-s1-l3e-06) | 3,795 | 4,018 | 3,795.1 | 0.0 | 0 | 611 |
| net relative3 4 hidden, 4 bit ★ | 4,144 | 4,471 | 696.3 | 3,447.8 | 4,072 | 115 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s1-l3e-06) | 4,202 | 4,404 | 4,201.6 | 0.0 | 0 | 803 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s0-l3e-06) | 4,412 | 4,625 | 4,412.1 | 0.0 | 0 | 803 |
| net relative3 24 hidden, 4 bit (relative3-h24-b4-s0-l0) | 4,583 | 4,783 | 4,583.4 | 0.0 | 0 | 323 |
| net relative3 24 hidden, 4 bit (relative3-h24-b4-s1-l0) | 4,587 | 4,825 | 4,586.9 | 0.0 | 0 | 323 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s0-l3e-06) | 4,857 | 5,027 | 4,857.4 | 0.0 | 0 | 1,187 |
| net relative3 3 hidden, 4 bit ★ | 4,880 | 5,410 | 584.2 | 4,295.5 | 5,404 | 103 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s1-l3e-06) | 5,129 | 5,355 | 5,128.6 | 0.0 | 0 | 1,187 |
| net relative 48 hidden, 4 bit (relative-h48-b4-s1-l0) | 5,345 | 5,283 | 5,344.9 | 0.0 | 0 | 509 |
| net relative 48 hidden, 4 bit (relative-h48-b4-s0-l0) | 5,371 | 5,309 | 5,370.6 | 0.0 | 0 | 509 |
| net relative 4 hidden, 4 bit ★ | 5,612 | 6,123 | 433.3 | 5,178.9 | 6,908 | 101 |
| net pairs3 additive, 5 bit ★ | 5,681 | 5,579 | 2,878.2 | 2,802.8 | 3,133 | 58 |
| decision tree, 128 leaves | 5,682 | 6,205 | 494.4 | 5,187.4 | 6,923 | 155 |
| net relative3 32 hidden, 4 bit (relative3-h32-b4-s1-l0) | 6,081 | 6,283 | 6,081.0 | 0.0 | 0 | 419 |
| net relative3 32 hidden, 4 bit (relative3-h32-b4-s0-l0) | 6,090 | 6,417 | 6,089.6 | 0.0 | 0 | 419 |
| decision tree, 96 leaves | 6,258 | 6,878 | 378.1 | 5,880.3 | 8,186 | 153 |
| net pairs additive, 5 bit ★ | 6,619 | 6,964 | 1,190.9 | 5,427.8 | 7,353 | 53 |
| net relative 64 hidden, 4 bit (relative-h64-b4-s0-l0) | 7,121 | 7,267 | 7,121.3 | 0.0 | 0 | 669 |
| net relative3 48 hidden, 3 bit (relative3-h48-b3-s0-l0) | 7,123 | 7,978 | 7,123.5 | 0.0 | 0 | 611 |
| net relative 64 hidden, 4 bit (relative-h64-b4-s1-l0) | 7,130 | 7,165 | 7,129.6 | 0.0 | 0 | 669 |
| net relative3 48 hidden, 3 bit (relative3-h48-b3-s1-l0) | 7,137 | 8,077 | 7,137.0 | 0.0 | 0 | 611 |
| decision tree, 64 leaves | 7,313 | 8,258 | 259.0 | 7,053.6 | 10,493 | 136 |
| net relative 96 hidden, 3 bit (relative-h96-b3-s1-l0) | 8,399 | 8,998 | 8,399.2 | 0.0 | 0 | 989 |
| net relative 96 hidden, 3 bit (relative-h96-b3-s0-l0) | 8,401 | 9,080 | 8,401.1 | 0.0 | 0 | 989 |
| net relative3 48 hidden, 4 bit (relative3-h48-b4-s0-l0) | 9,079 | 9,734 | 9,078.6 | 0.0 | 0 | 611 |
| decision tree, 32 leaves | 9,083 | 10,242 | 140.9 | 8,942.3 | 14,677 | 132 |
| net relative3 48 hidden, 4 bit (relative3-h48-b4-s1-l0) | 9,148 | 9,824 | 9,148.2 | 0.0 | 0 | 611 |
| net relative3 64 hidden, 3 bit (relative3-h64-b3-s0-l0) | 9,488 | 10,767 | 9,487.7 | 0.0 | 0 | 803 |
| net relative3 64 hidden, 3 bit (relative3-h64-b3-s1-l0) | 9,505 | 10,720 | 9,504.7 | 0.0 | 0 | 803 |
| decision tree, 2926 leaves | 10,665 | 10,672 | 10,664.6 | 0.0 | 0 | 157 |
| net relative 96 hidden, 4 bit (relative-h96-b4-s0-l0) | 10,668 | 11,139 | 10,668.2 | 0.0 | 0 | 989 |
| net relative 96 hidden, 4 bit (relative-h96-b4-s1-l0) | 10,705 | 11,167 | 10,704.5 | 0.0 | 0 | 989 |
| decision tree, 16 leaves | 11,032 | 12,767 | 81.2 | 10,950.9 | 19,845 | 126 |
| net squares additive, 5 bit ★ | 12,002 | 14,121 | 79.7 | 11,922.8 | 22,656 | 52 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s0-l0) | 12,188 | 12,720 | 12,187.5 | 0.0 | 0 | 803 |
| net relative3 64 hidden, 4 bit (relative3-h64-b4-s1-l0) | 12,198 | 12,717 | 12,197.8 | 0.0 | 0 | 803 |
| decision tree, 8 leaves | 13,288 | 15,654 | 39.9 | 13,248.3 | 26,881 | 80 |
| net relative3 96 hidden, 3 bit (relative3-h96-b3-s1-l0) | 14,214 | 16,040 | 14,214.4 | 0.0 | 0 | 1,187 |
| net relative3 96 hidden, 3 bit (relative3-h96-b3-s0-l0) | 14,224 | 16,147 | 14,223.7 | 0.0 | 0 | 1,187 |
| decision tree, 2 leaves | 15,028 | 18,068 | 9.7 | 15,017.8 | 33,400 | 53 |
| decision tree, 4 leaves | 15,040 | 18,081 | 22.6 | 15,017.8 | 33,400 | 75 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s1-l0) | 18,214 | 19,280 | 18,213.9 | 0.0 | 0 | 1,187 |
| net relative3 96 hidden, 4 bit (relative3-h96-b4-s0-l0) | 18,214 | 19,420 | 18,213.9 | 0.0 | 0 | 1,187 |
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
| 4,096 | 2,178 B (net relative3 14 hidden, 4 bit) | 3,390 B (forcetree-0256) | +1,212 B |

★ on the frontier of counted points (smallest total bytes at or below that operation count). Tables: Syzygy's operations are an estimate (see above); lzma is one setting, and its operations come from decompression time (rough, and different on every run), because a single position needs the whole file unpacked. Learned baselines are trained on all positions and their exceptions are charged. The decision trees are DSL programs in trees/, retrained only by chess-forces trees. The nets (src/chess_forces/nets.py) look up one row per square or square pair, add the rows and apply a small output layer; weights are integers, stored in nets/ and evaluated exactly, so the numbers do not depend on the machine. Net sizes use an adaptive code over the integer weights. A model may be held decoded (a DSL program and a net are); tables must be read at random. That rule is a choice: unpacked once, the lzma bitbase would need 20 operations too, but 24,576 bytes of memory, against at most a few KB for the nets.

Force programs: programs/*.dsl, hand-written or found by search. Paths are relative to this folder. The human rules were written from chess theory and tuned by looking at groups of mistakes over about 20 quick runs.
