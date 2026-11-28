# Status and handover (2026-11-26, end of session)

Read this first; new to the project? Start with the [beginner's guide](00-beginners-guide.md). Details: [01 DSL concept and results](01-dsl-concept.md), [02 agent loop](02-agent-loop.md), [03 concept loop](03-concept-loop.md), [04 KQvKP](04-kqkp.md) (approved, not built), [endgames/kpk/report.md](../endgames/kpk/report.md). Working rules for this machine are kept in a local, unpublished `CLAUDE.md`.

## What this is

Find short programs in a small language of "forces on 64 squares" that answer an endgame exactly and are smaller than its Syzygy file, with at most 4,096 operations per position. Size counts the program (grammar code) plus the list of its mistakes; operations are 64-bit word operations, worst case.

## Goal (2026-11-26)

The target is the Syzygy file of each endgame. KPK is too small to show much: its file is 7.8 KB. The real test is endgames of 5 pieces and more, where Syzygy files are megabytes, for example KRPvKP 4.4 MB, KRPvKR 16.4 MB, KQPvKQ 20.4 MB (`ls -l ../syzygy`). Nets, decision trees and lzma stay on the plot as references, not targets: they show how much of a win comes from the concepts and how much from Syzygy's general file format, and how far a force program might still go. Passing Syzygy is not the end: the search keeps pushing the force-program frontier (bytes against operations) as long as that pays off. Tokens cost money, so with more pieces the spend per endgame needs a rule, for example closing an island when the bytes saved per dollar fall below a set value (concept note 04).

## Where things stand

- **KPK: three passes done** (2026-11-26), written up in [endgames/kpk/analysis.md](../endgames/kpk/analysis.md). Best force programs, all built by trees over concepts without a model call: `pool-r1-256`, 1,857 B real with 158 errors, and the exact `pool-r1-exact`, 2,201 B real (−72% against Syzygy's 7,824 B), smaller than every net. Their cost is operations: up to 2,856 per position, above Syzygy's estimated worst case (2,122); `pool-exact` (2,789 B, at most 1,896) is smaller and cheaper than Syzygy. The model's own programs from run r1 stay at 4,886 B.
- What KPK taught: r1's 3.2% errors were a limit of the search, not of the language; the force quantities given to the trees matter most (30 to 45 atoms took the exact program from 5,327 to 2,789 B); trees combine concepts better than the model did; and in a first test (8 paid calls) the model's concepts did no better than random enumerated comparisons. Everything found is known chess.
- Every exact method is kept and shown in the report in its own colour (29 nets, 9 programs, the tables).
- Language 0.3 (2026-11-26): programs are limited by grammar code (128 KiB), not by characters; every score is unchanged.
- Nothing beyond KPK has been started. The next endgame is KQvKP ([concept note 04](04-kqkp.md), approved, not built): about 11.4 million positions, Syzygy 58 KB, break-even error rate about 0.4%. Scoring one program would take about 2 minutes (11 µs per position, measured on KPK), and trees over 10 million positions and hundreds of features do not fit in 24 GB as they are built now.
- Phase 1 is done and a single-user search loop exists (one run, r1; 1,075 calls, 1.97 USD). 217 tests pass. API spend so far: 1.98 USD of the account (r1 and the concept smoke test c0; `chess-forces budget status`).

## Git

- `main` is published on GitHub (first push 2026-11-25). Feature branches stay local. Commit as `operator`, no attribution lines, only when asked; never push without asking.
- `main` holds everything up to the concept loop and is pushed (2026-11-26); the work branches `close-kpk`, `kpk-pass2` and `concept-loop` were merged into it and deleted.

## Where things are

- `src/chess_forces/`: `dsl.py` language, interpreter and costs; `score.py` scorer; `codec.py` real encodings (program, exceptions, nets); `concepts.py` concept pool, trees and the concept loop; `kpk.py`, `board.py` rules and table; `endgames.py` the endgame folders; `baselines.py`, `nets.py`, `report.py` other methods and the plot; `promote.py` moving programs into a folder; `search.py` loop; `budget.py` spend guard; `cli.py` commands. `scripts/`: experiments and tools outside the package: `syzygy_ops.py` (uses python-chess, so not in `src/`), `force_trees.py`, `enumerate_concepts.py`, `concept_calibration.py`, `rejected.py`, `trim.py`, `review.py` (paid, OpenRouter).
- `endgames/kpk/`: everything about KPK; the folder decides the endgame (`src/chess_forces/endgames.py`). `programs/*.dsl`: hand-written and found programs (text, never run as Python). `trees/`: the decision-tree baselines as DSL programs; the report reads them, only `chess-forces trees` retrains them, and a test checks that retraining gives the same text. `nets/`: trained nets (integers) and the sweep record. `syzygy.json`: Syzygy's operations, an estimate. `report.md`, `report.json`, `report.png`: table, plot, JSON. `analysis.md`: the written result.
- Local only, gitignored: `state/` with the spend ledger `budget.sqlite`, `search-r1.sqlite` (all 1,076 proposals with their texts and scores) and `run-r1/`. Deleting them loses the run archive, not the results in the repository.
- Syzygy 3-4-5 tables live next to the repository in `../syzygy`. They are read only by tests and by one-off scripts through python-chess, which `src/` must not import.

## Commands

```text
uv run chess-forces kpk | spec | score FILE | report | trees | promote FILE... | concepts ... | train-nets | evolve ... | budget status
uv run pytest            # about 9 minutes
uv run chess-forces report        # rebuilds endgames/kpk/report.* (about 3 minutes)
uv run chess-forces trees         # retrains the decision trees into endgames/kpk/trees (a few seconds)
uv run chess-forces train-nets    # retrains the nets (about 25 minutes, all cores)
uv run chess-forces promote FILE --name NAME   # copies a program into endgames/kpk/programs if it beats its tier
uv run python scripts/syzygy_ops.py            # rewrites endgames/kpk/syzygy.json (about 5 s)
uv run python scripts/force_trees.py           # trees over the concepts of one program, as DSL
uv run python scripts/enumerate_concepts.py    # concepts by enumeration against the model's (about 3 minutes)
uv run python scripts/rejected.py --run r1     # programs a run rejected for too many operations
uv run python scripts/trim.py --rejected state/run-r1/rejected.json   # mechanical trimming
uv run chess-forces concepts baseline          # the concept pool and its trees (about 3 minutes)
uv run python scripts/concept_calibration.py --run c0   # a run's concepts against random enumerated ones, from the ledger
uv run chess-forces concepts run --run c1 --usd 3       # paid: a model proposes concepts (held back, see 03)
uv run chess-forces evolve --run r2 --usd 3   # needs the API key and the owner's budget confirmation
```

## Decisions taken

D1–D5 of the concept note; own rules code; licence MIT; python-chess only as a dev dependency; grammar code for size; log2 C(N, k) for exceptions; operation tiers 64, 256, 1,024, 4,096; default budget 20 per day, scripts stop and resume, only the owner raises limits; funsearch is not copied, its island and cluster idea may be adapted later (Apache-2.0). On 2026-11-26: keep every promising approach and block nothing that might help beyond the current endgame; a finished endgame is reviewed and may be run again. Also on 2026-11-26: the next endgame is KQvKP, built as concept note 04 proposes (L1 language 0.4 with `man(side, kind)`, S1 scale plan, B1 paid run only after a saturated pool, cap 3 USD; approved); tables come from our own enumeration of positions with results read from Syzygy, KPK's own generator as the check (T1); the 50-move rule is ignored from KQvKP on as a listed exception (E1). Also on 2026-11-26: the target is the Syzygy file of each endgame within the 4,096-operation cap; nets, trees and lzma are references; no paid search on KPK; KPK closes with a written analysis; endgames of 5 pieces and more are the real test. On 2026-11-28, added to note 04 and agreed: Syzygy measured with the tables its probe reads and its capture search (F1), our own tree builder pruned by bytes (S2), quantities computed where the tree needs them (O1), KQvKP tests on a sample (Q1), prompts aimed at Syzygy (L1), the smoke test with and without themes and the free soft cap before a paid program search (B1).

## Open exceptions to the rules of chess

- **E1, the 50-move rule** (decided 2026-11-26): from KQvKP on, the targets ignore it; Syzygy's cursed wins count as wins, blessed losses as losses. Every report must show how many positions this affects. It must be resolved later by a target under the 50-move rule, as Syzygy's values are ([04](04-kqkp.md)). Do not drop this item.

## Waiting for the owner

1. The paid part of the soft-cap design below (reviewer, grants) needs its own short concept and a cost cap. Its free part (keep everything, check every tier, tolerant frontier, local trimming) is agreed as a step before any paid program search (note 04, B1, 2026-11-28).

## Approaches, all kept

| Approach | Cost | What it gave on KPK | Where |
| --- | --- | --- | --- |
| Search loop: a model proposes whole programs | tokens | textbook concepts, best 4,426 B (bound) | `search.py`, run r1 |
| Mechanical trimming, no model | free | r1 program 966 from 4,476 to 4,430 B | `scripts/trim.py`, input from `scripts/rejected.py` |
| Reviewer models on rejected programs | tokens | one useful variant (4,472 B at 388 operations) | `scripts/review.py` (OpenRouter, own ledger) |
| Trees over force concepts, written as DSL | free | 3,577 B real at 256 leaves; exact 7,110 B | `scripts/force_trees.py` |
| Decision trees over simple features | free | reference; exact at 10,672 B | `chess-forces trees`, `scripts/force_trees.py` |
| Table nets | free (CPU) | reference; 29 exact, smallest 4,018 B real | `nets.py`, `chess-forces train-nets` |
| Concepts by enumeration (comparisons of 30 force quantities), combined by trees | free | 3,014 B real at 256 leaves; exact 5,270 B | `scripts/enumerate_concepts.py` |
| Concept pool: 45 atoms, stronger enumeration, r1's concepts | free | 1,857 B real at 256 leaves; exact 2,201 B | `chess-forces concepts baseline` |
| Concept loop: a model proposes concepts, trees judge them | tokens for concepts only | smoke test (8 calls, 0.013 USD): no better than random enumerated comparisons; 3 USD run held back | `chess-forces concepts run`, `scripts/concept_calibration.py`, [03](03-concept-loop.md) |
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

1. The search prompt shows the best force program of the tier (to improve) and the endgame's Syzygy size (to pass); the best reference of the tier may be shown as a hint of what is possible, not as the bar (today the nets are the bar: `search.Bars`, [02](02-agent-loop.md)). Part of L1 in note 04 since 2026-11-28.
2. Concept note 04 for KQvKP is written ([04](04-kqkp.md)); its scale plan and test plan carry the earlier points (scoring speed, trees in 24 GB, a saturated pool, the token spend per endgame). Still open for later endgames: the brief's scaling test (operations per position against the number of pieces).

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
- `uv run pytest` takes about 9 minutes (most of it scores the promoted KPK programs). The concept pool caches its quantities in `state/cache`; the smoke run's answers (run c0) stay in the ledger and replay for free.
- Prompts contain FEN strings; they run near 1.75 characters a token, so bound token counts with 1.6.
- Model output is thinking-heavy (about 2,500 of 3,000 tokens), and answers cut off by the output limit are rejected; the default limit is 9,000 tokens.

## Next steps in order

Start of the next session: build [concept note 04](04-kqkp.md) (all decisions taken), one commit per step on a branch, tests green after each:

1. **T1, positions:** a general enumeration of legal positions for a set of men in `src/` (symmetries, legality, both sides to move); it must reproduce KPK's 165,676 positions.
2. **T1, results:** a script outside `src/` that probes Syzygy in parallel and writes the table locally with its sha256 (the local pilot `state/scripts/kqkp_gen.py` shows the probing); cross-check: the extracted KPK table equals our own generator's. It records cursed wins and blessed losses separately (**E1**: counted as wins and losses, the count shown in every report).
3. **L1, language 0.4:** `man(side, kind)`, a KQvKP task, prompts per endgame that show Syzygy's size and the best force program, no KPK numbers in the code; fingerprint pinned anew, every score unchanged.
4. **The KQvKP folder and report:** `endgames/kqkp/`, references (lzma; Syzygy as **F1**, the file and the tables its probe reads, `scripts/syzygy_ops.py` generalised with the capture search; decision trees; nets), the E1 count.
5. **S1, scale, and Q1:** parallel scoring and quantities; KQvKP programs tested on a fixed sample, full scores in the report.
6. **S2 and O1, trees:** our own tree builder (one byte per atom, one bit per comparison, pruned by bytes) and quantities computed where a path needs them; both checked on KPK first.
7. **Concept pool on KQvKP** (queen quantities), then saturation until extra comparisons stop helping.
8. **B1:** a smoke test of model concepts against the saturated pool, half with KQvKP themes and half without; the paid run (cap 3 USD) only if they clearly beat enumerated ones; a paid program search only after the free part of the soft cap.
9. Later: E1 resolved (a target under the 50-move rule), an evaluator that scores all positions at once (numpy arrays of 64-bit boards, operations counted per position, the same values and counts as the interpreter on KPK; its own concept note, before 5-piece endgames), 5-piece endgames, the brief's scaling test, reflector, migration between islands, Batch API, a 7x7 board or an invented piece.
