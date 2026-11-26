# Status and handover (2026-11-26)

Read this first; new to the project? Start with the [beginner's guide](00-beginners-guide.md). Details: [01 DSL concept and results](01-dsl-concept.md), [02 agent loop](02-agent-loop.md), [endgames/kpk/report.md](../endgames/kpk/report.md). Working rules for this machine are kept in a local, unpublished `CLAUDE.md`.

## What this is

Find short programs in a small language of "forces on 64 squares" that answer an endgame exactly and are smaller than its Syzygy file, with at most 4,096 operations per position. Size counts the program (grammar code) plus the list of its mistakes; operations are 64-bit word operations, worst case.

## Goal (2026-11-26)

The target is the Syzygy file of each endgame. KPK is too small to show much: its file is 7.8 KB. The real test is endgames of 5 pieces and more, where Syzygy files are megabytes, for example KRPvKP 4.4 MB, KRPvKR 16.4 MB, KQPvKQ 20.4 MB (`ls -l ../syzygy`). Nets, decision trees and lzma stay on the plot as references, not targets: they show how much of a win comes from the concepts and how much from Syzygy's general file format, and how far a force program might still go. Passing Syzygy is not the end: the search keeps pushing the force-program frontier (bytes against operations) as long as that pays off. Tokens cost money, so with more pieces the spend per endgame needs a rule, for example closing an island when the bytes saved per dollar fall below a set value (concept note 03).

## Where things stand

- **KPK: first pass finished and reviewed** (2026-11-26): [endgames/kpk/analysis.md](../endgames/kpk/analysis.md). The review reopened it (below). Five force programs from the first pass are smaller than Syzygy's `KPvK.rtbw` (7,824 B) in real bytes: the best, `r1-unit-831`, is 4,886 B (−38%) at 1,259 operations at most, 403 on average; Syzygy needs an estimated 2,122 at most, 983 on average. Real bytes are an actual encoding (`codec.py`), about 10% above the score's bound.
- References are smaller still: a table net 2,351 B real at 235 operations, lzma of the bitbase 3,341 B at an estimated 282,600. 29 nets are exact (no exceptions); the smallest is 4,018 B real at 611 operations. Every exact method is kept and shown in the report in its own colour. No force program is exact. At KPK, beating Syzygy says more about Syzygy's general format than about the concepts; the real test is 5 pieces and more.
- What the search found is known chess (square, key squares, opposition, rook-pawn corner, blockade, captures), not new concepts. Programs are small (about 150 B); almost all their cost is exceptions, most of them with a central pawn on ranks 2 to 4.
- Review of KPK (`scripts/force_trees.py`, no model): a greedy tree over the 10 concepts of r1's best program is an exact DSL program of 7,110 B, smaller than Syzygy; with 256 leaves it is 3,577 B real, 27% below r1's best. The 3.2% errors were a limit of the search, not of the language. Both programs are over the language's 40,000-character limit, a limit on text rather than information; the 64-leaf tree fits and is promoted (`forcetree-0064`, 4,480 B real).
- Phase 1 is done and a single-user search loop exists (one run, r1). 182 tests pass.
- Nothing beyond KPK has been started. Scoring one program takes about 11 µs per position (1.8 s for KPK's 165,676 positions, `chess-forces score endgames/kpk/programs/evolved-1024.dsl`, 2026-11-26). A 5-piece table has a few hundred million positions, so one program would take 1–2 hours on one core (estimate). Transfer (whether KPK ideas help in other endgames) is a second question, not tested.

## Git

- `main` is published on GitHub (first push 2026-11-25). Feature branches stay local. Commit as `operator`, no attribution lines, only when asked; never push without asking.
- `main` holds Phase 1, the search loop with run r1, the table nets and the Syzygy goal. Branch `close-kpk` (local, not merged) holds the KPK closing: endgame folder, `promote`, real sizes, Syzygy's operations, the analysis.

## Where things are

- `src/chess_forces/`: `dsl.py` language, interpreter and costs; `score.py` scorer; `codec.py` real encodings (program, exceptions, nets); `kpk.py`, `board.py` rules and table; `endgames.py` the endgame folders; `baselines.py`, `nets.py`, `report.py` other methods and the plot; `promote.py` moving programs into a folder; `search.py` loop; `budget.py` spend guard; `cli.py` commands. `scripts/syzygy_ops.py`: Syzygy's operations (uses python-chess, so not in `src/`).
- `endgames/kpk/`: everything about KPK; the folder decides the endgame (`src/chess_forces/endgames.py`). `programs/*.dsl`: hand-written and found programs (text, never run as Python). `trees/`: the decision-tree baselines as DSL programs; the report reads them, only `chess-forces trees` retrains them, and a test checks that retraining gives the same text. `nets/`: trained nets (integers) and the sweep record. `syzygy.json`: Syzygy's operations, an estimate. `report.md`, `report.json`, `report.png`: table, plot, JSON. `analysis.md`: the written result.
- Local only, gitignored: `state/` with the spend ledger `budget.sqlite`, `search-r1.sqlite` (all 1,076 proposals with their texts and scores) and `run-r1/`. Deleting them loses the run archive, not the results in the repository.
- Syzygy 3-4-5 tables live next to the repository in `../syzygy`. They are read only by tests and by one-off scripts through python-chess, which `src/` must not import.

## Commands

```text
uv run chess-forces kpk | spec | score FILE | report | trees | promote FILE... | train-nets | evolve ... | budget status
uv run pytest            # about 70 s
uv run chess-forces report        # rebuilds endgames/kpk/report.* (about 15 s)
uv run chess-forces trees         # retrains the decision trees into endgames/kpk/trees (a few seconds)
uv run chess-forces train-nets    # retrains the nets (about 25 minutes, all cores)
uv run chess-forces promote FILE --name NAME   # copies a program into endgames/kpk/programs if it beats its tier
uv run python scripts/syzygy_ops.py            # rewrites endgames/kpk/syzygy.json (about 5 s)
uv run chess-forces evolve --run r2 --usd 3   # needs the API key and the owner's budget confirmation
```

## Decisions taken

D1–D5 of the concept note; own rules code; licence MIT; python-chess only as a dev dependency; grammar code for size; log2 C(N, k) for exceptions; operation tiers 64, 256, 1,024, 4,096; default budget 20 per day, scripts stop and resume, only the owner raises limits; funsearch is not copied, its island and cluster idea may be adapted later (Apache-2.0). On 2026-11-26: keep every promising approach and block nothing that might help beyond the current endgame; a finished endgame is reviewed and may be run again. Also on 2026-11-26: the target is the Syzygy file of each endgame within the 4,096-operation cap; nets, trees and lzma are references; no paid search on KPK; KPK closes with a written analysis; endgames of 5 pieces and more are the real test.

## Waiting for the owner

1. Merge `close-kpk` into `main`, and push?
2. Build the free part of the soft-cap design below (keep everything, check every tier, tolerant frontier, local trimming)? A first trial of trimming and review is described there. The paid part (reviewer, grants) needs its own short concept and a cost cap first.
3. After KPK: one 4-piece endgame first (KRvKP, Syzygy 179 KB, about 12 million positions, about 2 minutes per program; estimate) to test the setup at a real size, or straight to a concept for 5 pieces?
4. For 5 pieces, where do the tables come from: own rules code (the rule so far, a large job) or read from Syzygy by a tool outside `src/`?
5. KPK second pass, all free: (a) language limits counted in bits of grammar code instead of characters, so the 256-leaf and exact trees fit (a language change: `DSL_VERSION` bump, every score redone); (b) concepts by enumeration of small DSL expressions, combined by trees, against r1's concepts at equal size; (c) the trimmer and the reviewer script moved from `state/scripts` into `scripts/`, so no approach lives only on one machine.

## Approaches, all kept

| Approach | Cost | What it gave on KPK | Where |
| --- | --- | --- | --- |
| Search loop: a model proposes whole programs | tokens | textbook concepts, best 4,426 B (bound) | `search.py`, run r1 |
| Mechanical trimming, no model | free | r1 program 966 from 4,476 to 4,430 B | `state/scripts/trim.py` (local) |
| Reviewer models on rejected programs | tokens | one useful variant (4,472 B at 388 operations) | `state/scripts/review.py` (local) |
| Trees over force concepts, written as DSL | free | exact program 7,110 B; 3,577 B real at 256 leaves | `scripts/force_trees.py` |
| Decision trees over simple features | free | reference; exact at 10,672 B | `chess-forces trees`, `scripts/force_trees.py` |
| Table nets | free (CPU) | reference; 29 exact, smallest 4,018 B real | `nets.py`, `chess-forces train-nets` |
| Concepts found by enumeration of small DSL expressions | free | not built | proposed 2026-11-26 |
| Concepts by a model, combined by a tree | tokens for concepts only | not built | proposed 2026-11-26 |
| Keep every program, check every tier (soft cap) | free | not built; would have kept program 831 | agreed ideas below |

## KPK first pass (2026-11-26)

Done on branch `close-kpk`, one commit per step: one folder per endgame (`endgames/kpk/`, the folder decides the endgame); the report plots every program in `programs/`, named by file; `chess-forces promote`, which the search also calls at the end of a run, promoted the trimmed r1 program (4,430 B) and r1 proposal 831 (4,426 B, recovered from the run's ledger); real sizes next to the bounds (`codec.py`, decoded back in the tests); Syzygy's operations estimated (`scripts/syzygy_ops.py`); lzma's operations pinned to one timing, so two report runs give identical files; [analysis.md](../endgames/kpk/analysis.md).

## Agreed ideas, not built

**Three numbers instead of one cap.** Every method gets bytes stored (the score so far), steps (worst case) and bytes held (what must be unpacked into memory before the first answer; see the beginner's guide). The earlier 8 KB cap on held bytes was fitted to the nets and is withdrawn. Which limit is used decides who leads: in the nets already trained, programs lead at 1 KB of held bytes and nets from 2 KB up, but the nets were not tuned for little memory.

**No hard cap as a filter.** Limits are views, not rejections. Reason, measured in run r1: 86 programs were rejected only for too many steps and were not stored; 22 of them were within 10% of the limit and 5 within 1% (smallest overshoot 0.4%).

1. Keep every valid program with its three numbers, however far over a limit. Nothing is deleted for missing by a byte.
2. Tolerant frontier: a method drops off only if another is at least 5% better in one number and not more than 5% worse in the others. The 5% is a judgment; it changes which points are listed as ties, not which data exists.
3. Report the headline at several limits for held bytes (1/40, 1/20, 1/10 and 1/5 of the raw table) and for steps, each with a near-miss list up to 10% over. The human rules (273 steps) are a near miss of the 256 tier, not outside it.
4. Local trimming, no model: for near misses, try removing or merging parts and keep changes that cost little accuracy but save steps or bytes.

**Soft cap on spending, not on memory of results.** Tokens are rationed separately from what is kept:

1. Parking lot: what trimming cannot fix is parked with its numbers, error groups and a reason. Only items within 10% of the frontier in all three numbers may be parked, so a program that buys a small gain with many more steps gets no tokens.
2. Review: at intervals a stronger model (Opus) reads the best parked items (numbers and examples only) and must predict a concrete gain, such as "300 B less at 1,024 steps". The prediction is compared with what happened. Rough cost per review (estimate): a fraction of a cent with Haiku 5.5, a few cents with Sonnet 5.5 or Opus 5.5. No reviewer is adopted only because it is stronger: it must make better picks per dollar.
3. Grants: approved paths may spend a small grant of 10 proposals and close after 5 without progress; parked paths together stay under about 15% of a run's budget. Grants shrink when the reviewer's picks do not pay off.
4. Absolute limits remain where cheating is possible: 4,096 steps, and no more held bytes than the raw table.

Open point: whether the review beats the simpler steering in loop v2 is unknown and needs a comparison at equal budget.

**No result stays local.** Built 2026-11-26 except point 1: one folder per endgame, the report reads every program in it, `promote`, and the rule in `CLAUDE.md` that a program's number goes into the docs only after the program is in its folder and in the report.

1. `chess-forces report` scans `state/**/*.dsl` and lists local programs that would beat the frontier but are not promoted. This only works on the owner's machine, because `state/` is not in git.

**A search aimed at Syzygy.** Agreed 2026-11-26. Real sizes, Syzygy's operations and a pinned lzma timing are built (above); open:

1. The search prompt shows the best force program of the tier (to improve) and the endgame's Syzygy size (to pass); the best reference of the tier may be shown as a hint of what is possible, not as the bar (today the nets are the bar: `search.Bars`, [02](02-agent-loop.md)).
2. A concept note 03 for 5 pieces: scoring speed (compile programs to numpy over the whole table or to C, or estimate exceptions from a sample during the search and count exactly only for the best programs), the table source (question 4 above), the brief's scaling test (operations per position against the number of pieces), and the token spend per endgame: when a paid search stops, measured in bytes saved per dollar rather than a fixed number of proposals.

### First try of trimming and review (2026-11-25, 10 rejected programs of run r1)

Ten programs that run r1 had rejected only for too many steps (six within 10% of their limit, four further over) were given to five models in one call each: pick three, predict the total bytes, write a version that fits. Every answer was scored exactly, and the useful ones were checked against Syzygy. A mechanical trimmer (remove or replace single parts, greedy) ran on the same items without any model. Test scripts and result files are in `state/scripts` and `state/run-r1` (local, not in the repository).

| Reviewer | Result |
| --- | --- |
| Haiku 5.5 (cheap) | 2 of 3 fit, no improvement over the best force program |
| Sonnet 5.5 | 3 of 3 fit, 4,473 to 4,530 B, predictions off by 3 to 6 B; no improvement |
| GPT-5.4 mini | one new program: 4,472 B at 388 steps (from 1,259), errors 5,447, verified against Syzygy; predictions off by 2 to 52 B |
| DeepSeek v4 pro, Gemini 3.8 Flash | no answer: the whole 10,000-token output went into thinking |
| Mechanical trimmer | program 966 (4,476 B, 4 steps over) trimmed to 4,430 B at 1,019 steps, errors 5,398, verified against Syzygy: better than run r1's best at that tier (4,459 B) |

Findings:

- Trimming one program by 29 B without any model was the best result. The run was stopped after 500 seconds: five items were worked through fully (one improved, one fell to 4,526 B and fits, three were trimmed to far worse programs of about 7,600 B, because the greedy steps cut too much); four were not reached. So this is one good case, not a rate.
- Program 831 (4,426 B at 1,259 steps) was rejected because it was over the limit of its own island. It fits the 4,096 tier, where the best was 4,459 B, so a record was thrown away. Keeping every program and checking all tiers would have caught it.
- Accurate predictions (Sonnet) did not bring an improvement; a model with optimistic predictions (GPT-5.4 mini) found the useful variant. Predictions should be compared with outcomes before trusting them.
- Settings matter: reviewers need a low thinking effort or a larger output limit.
- Ten items and one answer per model cannot rank models. At OpenRouter, Claude models cost the same as at Anthropic; other models are much cheaper, and the key used here must have its own price table in the budget guard.

Order suggested by this: first the free steps (keep everything, check all tiers, trim with a gentler search), then a small reviewer comparison with Sonnet 5.5 and GPT-5.4 mini.

## Gotchas

- The language fingerprint is pinned in a test. Any change of names, costs or limits needs a `DSL_VERSION` bump and a new pin, and all scores are redone.
- Every score includes 32 operations for an exception lookup when there are errors (an assumption, also after real sizes: the Elias–Fano lookup was not counted).
- The plot shows the score (a bound); the comparison with Syzygy in the report uses real bytes.
- The API key is only visible to interactive shells (`.zshrc`), so a script started from Claude Code needs `zsh -ic '...'`. Never print it.
- A run's islands are fixed when it starts. Run r1 has the old islands (256, 1,024, 1,024, 4,096); continuing it needs those.
- Learned baselines use all positions (there is no hold-out), because exceptions are charged. Net training is seeded, but another BLAS may shift it; the saved nets are exact integers.
- Prompts contain FEN strings; they run near 1.75 characters a token, so bound token counts with 1.6.
- Model output is thinking-heavy (about 2,500 of 3,000 tokens), and answers cut off by the output limit are rejected; the default limit is 9,000 tokens.

## Next steps in order

1. Owner's answers above.
2. KPK second pass (question 5), then a new review.
3. Concept note 03 for 5 pieces (above).
4. The next endgame, as the owner decides. Re-scoring the KPK programs on it gives a first transfer result for free.
5. Paid, only on the new endgame and only after a budget: effort A/B (low against medium, 120 proposals each), then a run.
6. Later: reflector, migration between islands, Batch API, a 7x7 board or an invented piece.
