# Concept note 03: concepts by a model, combined by trees

Status: approved 2026-11-26 (C1–C5 as proposed) and built: `src/chess_forces/concepts.py`, `chess-forces concepts baseline | run | compare`. The baseline is measured (below); the paid run follows. Current results are in [STATUS.md](STATUS.md) and [endgames/kpk/analysis.md](../endgames/kpk/analysis.md).

## Why

KPK showed where a model helps and where it does not. Run r1 let Claude Haiku 5.5 write whole programs: 1,075 paid calls, 1.97 USD (`chess-forces budget status`), best program 4,886 B real. Greedy trees then combined concepts without any model (`scripts/force_trees.py`, `scripts/enumerate_concepts.py`):

| Concepts given to the tree | 256 leaves, real bytes | Exact program, real bytes |
| --- | ---: | ---: |
| 30 force quantities (atoms) only | 3,818 | 6,013 |
| atoms + 500 enumerated comparisons | 3,014 | 5,270 |
| atoms + the 10 concepts of r1's best program | 2,939 | 4,258 |
| atoms + both | 2,640 | 4,136 |

So the model's value was in its concepts, not in how it combined them, and its 10 concepts were worth about 1 KB on top of the enumeration for an exact program. Those 10 came from the best of 1,075 whole programs, a roundabout way to get concepts. The question this note proposes to answer on KPK, where scoring takes seconds and a call costs about 0.2 cents: does a model asked directly for concepts add enough beyond a strong enumeration to be worth its tokens? The answer decides how tokens are spent at 5 pieces (concept note 04).

## The loop

1. **Pool.** Every concept is a named Bool expression of the language, with its value on every position (a bit vector), its text, its origin (enumeration, a program, a model call) and the call's cost. The pool starts with the atoms, the enumerated comparisons and r1's concepts. Identical bit vectors are one concept.
2. **Current best.** Greedy trees over the pool at 256 leaves and grown until exact, written as programs and scored like any other (as in `scripts/enumerate_concepts.py`). Their largest error groups are what the model is shown.
3. **Prompt.** A cached prefix with the language and the answer format; then the current numbers against the target (Syzygy's file, and the best force program), the largest error groups of the 256-leaf tree with a few example positions and their true result, and the definitions of the concepts the trees use most, so the model does not repeat them.
4. **Answer.** A small program, `def wins() -> Bool:` with statements; every Bool name it defines is a candidate concept (the same reading as `scripts/force_trees.py`). The parser, the operation cap and the scorer apply unchanged, and the program itself is scored too.
5. **Scoring a candidate, free.** Invalid or over the operation cap: rejected, with the reason kept. Same bit vector as a pool concept: a duplicate. Otherwise a quick filter, the information it adds inside the leaves of the current 256-leaf tree; above a threshold, the trees are grown again with it and the bytes it saves at 256 leaves and for the exact program are its gain.
6. **Accepting.** A candidate that saves at least 1 B at either size joins the pool; trees and the current best are rebuilt, and better programs go through `chess-forces promote` (every exact one is kept). Nothing is deleted: rejected and duplicate candidates stay in the run's archive with their numbers.

## A fair baseline first (free)

The model must beat a strong enumeration, not a weak one. Before any paid call the enumeration gets more quantities: walks of both kings to more squares, file and rank differences of the kings (opposition), counts of squares in fields (for example the weak king's squares guarded by the strong side), and sums of two quantities compared with a third, limited to the most informative ones. Its numbers are recorded first. The fair comparison in the run: the bytes saved by the model's accepted concepts against the bytes saved by as many concepts taken from further down the enumeration's ranking.

## Baseline, measured (C3)

`uv run chess-forces concepts baseline`, 2026-11-26. The stronger enumeration has 45 atoms (the 30 before, three walks of the weak king around the strong side's guarded squares, file and rank differences of the kings and the pawn, the kings' file and rank distance, counts of the weak king's free and guarded squares, of the squares both kings attack, and of the pawn's path) and, among the 500 kept comparisons, sums of two of the 12 most informative atoms compared with a third.

| Pool | 256 leaves: errors | real bytes | Exact: leaves | real bytes | Max ops (exact) |
| --- | ---: | ---: | ---: | ---: | ---: |
| 30 atoms + enumerated comparisons | 1,502 | 3,012 | 1,139 | 5,327 | 1,235 |
| 45 atoms + stronger enumeration | 756 | 2,347 | 545 | 2,789 | 1,896 |
| the same + the 10 concepts of `r1-unit-831` | 158 | 1,857 | 365 | 2,201 | 2,841 |

The stronger enumeration alone gives an exact program of 2,789 B, smaller than the smallest exact net (4,018 B); with r1's concepts the exact program is 2,201 B, smaller than the best net with errors (2,351 B, 530 errors). The last row is the pool the paid run starts from; its programs are promoted (`pool-r1-256`, `pool-r1-exact`, `pool-exact`, `pool30-exact`). The cost is operations: every atom is computed first, up to 2,856 operations per position.

## What is measured

Per call: tokens, cost, valid candidates, new candidates, accepted candidates, bytes saved at 256 leaves and for the exact program. Per run: bytes saved per dollar, and the same for the enumeration (free, so per concept). Operations of the written programs are reported too: today's tree programs compute every quantity first and need about 1,200 operations on average, 2,350 at most.

**Success criterion, set before the run:** the model's accepted concepts save at least twice the bytes of as many enumerated concepts, at 256 leaves and for the exact program. If they do not, concept note 04 plans 5 pieces on enumeration and spends tokens only on naming and explaining concepts.

## Budget and stopping

Claude Haiku 5.5 at medium effort, as in r1, through `chess_forces.budget` with a hard limit of 3 USD for the run, confirmed by the owner in a terminal. The run stops at the limit, after 200 calls without an accepted concept, or when the last 100 calls saved less than a set number of bytes per dollar (a first trial of the spend rule for larger endgames; the number is fixed before the run).

## Where it lives

A module `src/chess_forces/concepts.py` (pool, scoring, trees) and a command `chess-forces concepts --run c1 --usd 3`, reusing the paid-call, repair and archive parts of `search.py`. The pool of accepted concepts is KPK's and lives in `endgames/kpk/concepts.json`; the run's archive stays in `state/`. The stronger enumeration extends `scripts/enumerate_concepts.py`.

## What it will not show

New chess. KPK is textbook, and so far both the model and the enumeration produced known ideas. A novelty test belongs to the unexplained exceptions of a 5-piece endgame or to a board without human theory (the brief's invented piece).

## Decisions for the owner

| # | Question | Proposal |
| --- | --- | --- |
| C1 | Answer format | a small program whose Bool statements are candidate concepts |
| C2 | Accepting a concept | bytes saved when the trees are grown again, at 256 leaves and exact; a quick filter first |
| C3 | Baseline | a stronger enumeration, built and measured before any paid call |
| C4 | Budget | Haiku 5.5, medium effort, hard limit 3 USD, the stop rules above |
| C5 | Success | twice the bytes saved of as many enumerated concepts, at both sizes |
