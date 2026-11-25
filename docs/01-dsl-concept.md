# Concept note 01: a DSL of forces on a fixed field

Status: D1–D6 decided (D1–D5 approved 2026-11-25). Built and tested: the KPK truth table, the interpreter with operation counter, and the scorer (`chess-forces score`, `chess-forces spec`). Baselines, plot and the human rule set exist (reports/kpk.md); next is the single-user agent loop. Figures marked *measured* come from throwaway scripts run on 2026-11-25 against the local Syzygy tables; they will be redone as tested code after approval. Everything else is design or, where marked, speculation.

## The idea in one paragraph

The board is a fixed graph of 64 squares. A piece does not "do" anything on it; it emits fields: squares it attacks, squares it can ever reach while everything else stands still, and how many moves each takes. A concept is a short statement about how fields overlap, block each other, or race. "The pawn cannot be caught" becomes "the pawn needs n moves to promote and the weak king needs more than n to reach that square". No primitive plays a move, and there is no recursion. Nested looks can imitate a shallow look-ahead, but they pay for it in operations.

## What the measurements say first

| Fact (*measured*) | Value | Consequence |
| --- | --- | --- |
| KPK positions, pawn on files a–d, both sides to move | 196,608 slots, **165,676 legal** (32.8% draws) | N for the scorer |
| Raw bitbase | 24,576 B over slots, 20,710 B over legal positions | the 24 KB in the brief |
| Syzygy `KPvK.rtbw` | **7,824 B** | the fast, small baseline on disk |
| lzma of the slot bitbase (illegal = 0; one setting, not tuned) | **3.3–3.4 KB** depending on slot order | the size to beat if compute is ignored |
| Best constant answer ("always win") | 54,394 errors, 18,911 B of exceptions | floor for "no idea" |
| Rule of the square, one line (below) | 30,006 errors, about 14,133 B of exceptions, 99.3% precise, finds 73.5% of wins | one concept is worth about 4.8 KB by log2 C |
| Errors allowed to beat Syzygy, before paying for the program | about 12,131 (92.7% accuracy) | the first real target |
| Errors allowed to beat lzma, before paying for the program | about 4,064 (97.5% accuracy) | the second real target |

So the brief's "beating the 24 KB bitbase is likely" is true but too easy. The first baselines (reports/kpk.md, 2026-11-25) raise the bar further: small learned models already beat Syzygy's size, so a force program has to beat the best point at each operation tier:

| Tier | Best total so far | Method |
| ---: | ---: | --- |
| 64 | 15,028 B | decision tree, 2 leaves |
| 256 | 5,670 B | neural net, 8 hidden units, 8-bit weights |
| 1,024 | 3,105 B | neural net, 32 hidden units |
| 4,096 | 2,837 B | neural net, 64 hidden units |

The hand-written rule set (`programs/human.dsl`: rule of the square, key squares, rook-pawn corner, loose pawn; 80 B of program, 7,590 errors, 5,639 B) was the first force program on the frontier. The search run r1 (2026-11-25, 1,076 proposals by Haiku 5.5) then produced `programs/evolved-256.dsl`: 5,367 B at 232 operations, below the best other method at that tier (the 8-unit net, 5,670 B), and `programs/evolved-1024.dsl`: 4,459 B at 959 operations. At 1,024 and 4,096 operations the nets still lead (3,105 B and 2,837 B). Verified against Syzygy position by position. What the winning programs use is mostly known chess: opposition, the rook-pawn corner, pawn support, blockade and captures; the new structure is the search finding compact combinations of them, not new concepts yet.

## Types

| Type | Meaning |
| --- | --- |
| `Int` | small integer, saturating; `inf` for unreachable |
| `Bool` | truth value; the program returns one ("strong side wins") |
| `Sq` | a square, or `none`; operations on `none` give `none`, `false` or `inf`, never an error |
| `Field` | a set of squares, one 64-bit word |

The strong side is always White and moves up the board, files are mirrored so the pawn stands on a–d. There are no field literals, strings or tables in the language, so a data blob cannot be written, only computed.

## Grammar

```text
program := def*                      the last function is wins() -> Bool
def     := def name(p: Type, ...) -> Type:  stmt*  return expr    no recursion, earlier defs only
stmt    := name = expr               assigned once
expr    := int | name | name(expr, ...) | not expr | expr if expr else expr
         | expr (+ - and or < <= == in) expr
         | any(expr for name in Field) | count(name for name in Field if expr)
int     := -8 .. 63
```

This is a subset of Python, read with `ast` and checked against the table below. It is never executed as Python, and anything outside the grammar is rejected. Size is computed on the syntax tree, so the spelling costs nothing. I chose Python because language models write it most fluently (educated guess), and it makes FunSearch-style prompts (`wins_v0`, `wins_v1`, ...) directly usable.

## Primitives (v0) and their op cost

Unit: one 64-bit word operation in the reference implementation, no lookup tables. Costs are a published table with a version number.

The full list with exact costs is printed by `uv run chess-forces spec`; that output is the definition, this table is only an overview.

| Group | Primitives | Ops |
| --- | --- | --- |
| Position | `K` `k` kings, `P` the only strong pawn (none if not exactly one), `men(side, kind)`, `occ`, `tempo` | 1 |
| Scalar | `+ - min max abs`, `< <= > >= == !=`, `odd` | 1 |
| Square | `file rank` 1, `sq(f, r)` 4, `shift(s, df, dr)` 8, `dist` and `mdist` 9, `shade` 3 | 1–9 |
| Field algebra | `union inter minus compl one count empty` 1, `s in F` 2, `rank_f file_f` 3 | 1–3 |
| Forces | `king_f` 11, `hits(side, piece, s, occ)` and `ray` by the squares they cross, `guard(side)`, `guard_x(side, s)`, `path(side, s)` 8 | 8 to about 100 |
| Motion, all else frozen | `within(s, k, F)`, `flood(s, F)`, `steps(s, t, F)` | 12 (steps 14) per wave run |
| Bounded look | `any(... for s in F)`, `count(s for s in F if ...)` | 2 (counting 3) per square visited, plus the body |

Two things changed from the first proposal. The costs are counted from the reference implementation, so `dist` is 9 operations, not 1–3. And `hits` and `path` take a side, because weak pawns move the other way (needed for KRKP and KPKP).

`any(... for s in king_f(k))` can ask about a square, but it costs 2 operations per square plus the body, but no primitive produces a position after a move. That answers the brief's "no search, or 1–2 plies?": plies are not a setting. Op budget is the only limit.

Example, the rule of the square (`programs/square.dsl`; scored on all 165,676 positions it costs 15.6 B plus 14,135 B of exceptions, 544 false alarms and 29,462 missed wins, matching the earlier measurement exactly):

```python
def wins() -> Bool:
    n = min(5, 7 - rank(P))
    return K not in path(strong, P) and n + 1 - tempo < dist(k, sq(file(P), 7))
```

## How a candidate is scored

1. **Size of the program, |Y|.** Fixed code over the typed grammar: every node costs log2(number of choices legal at that type), variables cost log2(variables in scope), integers log2(72). Each `def` is paid for once. This is smooth in fractions of a bit and has no version drift. General compressors work in whole bytes on text: the first version of this example (105 bytes) becomes 89 B with zstd, 95 B with raw lzma and 148 B with xz (*measured*), while the grammar code should need roughly 20 B (estimate). They are reported as a side check only.
2. **Size of the exceptions, |E|.** log2 C(N, k) plus the cost of k itself, as in the brief. This is an information bound, so the operations to look an exception up are charged separately (a fixed constant when k > 0, value to be set with the interpreter). Elias–Fano, a structure that can be read at random, is shown as a practical check: computed from k(2 + ⌈log2(N/k)⌉) bits without its select index it is 8–14% larger at 100 to 3,000 errors and 28% larger at 10,000. It should not be the official number, because it gets poor when errors are dense (18,754 B against 14,133 B for the rule of the square). WDL targets with three classes add the class bits.
3. **Operations.** Mean and maximum word ops per position, plus the exception lookup. Tiers of 64, 256, 1,024 and 4,096 (max) instead of one budget, so the frontier is a curve.
4. **Cold start.** Every position is scored from nothing, with no state kept between positions. Without this rule, retrograde analysis or unpacking the lzma file once would be shared by all positions and cost little per answer (argument, not measured). The brief's budget rule does not close this hole; this one does.
5. **As built:** the operation cap is 4,096, a listed exception costs 32 operations to look up (an assumption, not a measurement), and every report carries the language fingerprint, the table hash and a hash of the program's canonical text.
6. **Fair for all.** Interpreter size is excluded for every method and reported separately. Baselines (bitbase, Syzygy, lzma, decision tree, MLP, human rules) are measured in the same word ops, and the MLP pays for its quantised weights.
7. **New primitives are not free.** If it can be written as a `def`, its bytes are charged. If it needs native code, it raises the DSL version and every baseline is rescored. Otherwise the reflector could move bytes from the program into the interpreter.

## Where I would deviate from the brief

- **Transfer targets.** KRK is not a useful WDL test: 94.5% of random legal positions are wins and Syzygy needs 208 B (*measured*, 20,000 samples). KBNK is 90% wins. I suggest KPK → KQKP → KRKP → KPKP: entropies 0.91, 0.66, 0.99 and 1.59 bits per position, Syzygy 7.8, 58, 179 and 245 KB. KQKP and KRKP have many structural exceptions (chess knowledge, not measured), which is what a vocabulary should compress.
- **Hold-out.** With every position scored, exceptions already punish overfitting. Hold-out is still useful to judge transfer, so I would hold out whole endgames rather than positions.
- **Language variants.** A 7×7 board should be easy to add (field size as a parameter; not tried). An invented piece is a cleaner test of "no human theory", and I would do it second.

## FunSearch: the method yes, the clone's code mostly no

The method is the core of Phase 2. FunSearch pairs a language model with an evaluator, keeps the best programs in islands, feeds them back into the prompt, and evolves only a small critical function inside a fixed skeleton. Its paper says that, loosely, it searches for solutions of low Kolmogorov complexity, which is this project's aim. Here the skeleton is the fixed harness (board, primitives, scorer) and the evolved part is `wins()`.

The clone at `../repos/funsearch` implements that method for other problems. Reading it (2026-11-25), five things do not fit:

1. It runs model-written Python with `exec` and cloudpickle. The safety check is an import allow-list plus a string blacklist. The brief allows DSL programs only.
2. Its score is one number per input, summed. This project needs bytes and operations together.
3. Its Claude call sends `temperature` and `top_p`, which the current 5.5 models reject, and reads `content[0].text`, which fails when a reply starts with a thinking block.
4. It caps tokens rather than dollars, resumes from pickled databases, and I found no prompt caching or batch calls, where most of the savings are.
5. It depends on four LLM SDKs and Weights & Biases.

Worth reusing: the island and cluster database in `programs_database.py` (score-signature clusters, softmax sampling with a temperature schedule, shorter programs preferred, reset of the weaker half of the islands). It is Apache-2.0, so Phase 2 can adapt it with the notice kept. Nothing has been built yet, so this choice is open until then. No container is needed either, because the interpreter never runs foreign code.

## Decisions I need from you

| # | Question | Recommendation |
| --- | --- | --- |
| D1 | Language: types, grammar and primitives as above, spelled as a Python subset? | yes, as v0; change later by version bump |
| D2 | Op budget | tiers 64 / 256 / 1,024 / 4,096, no ply rule |
| D3 | Size measure | grammar code; zstd as side check |
| D4 | Exceptions | log2 C as in the brief, lookup ops charged; Elias–Fano shown as a check |
| D5 | Transfer order | KPK, KQKP, KRKP, KPKP instead of KRK, KBNK, KRKP |
| D6 | Licence of the public repo | decided 2026-11-25: own rules code, python-chess (GPL-3.0+) only as a dev dependency for tests and the PGN. Licence: MIT |

After approval the order stays as in the brief: KPK table with hash, interpreter with op counter, scorer, baselines and plot, then the human rule set.e
