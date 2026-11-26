# Status and handover (2026-11-26)

Read this first; new to the project? Start with the [beginner's guide](00-beginners-guide.md). Details: [01 DSL concept and results](01-dsl-concept.md), [02 agent loop](02-agent-loop.md), [reports/kpk.md](../reports/kpk.md). Working rules for this machine are kept in a local, unpublished `CLAUDE.md`.

## What this is

Find short programs in a small language of "forces on 64 squares" that answer an endgame exactly and are smaller than its Syzygy file, with at most 4,096 operations per position. Size counts the program (grammar code) plus the list of its mistakes; operations are 64-bit word operations, worst case.

## Goal (2026-11-26)

The target is the Syzygy file of each endgame. KPK is too small to show much: its file is 7.8 KB. The real test is endgames of 5 pieces and more, where Syzygy files are megabytes, for example KRPvKP 4.4 MB, KRPvKR 16.4 MB, KQPvKQ 20.4 MB (`ls -l ../syzygy`). Nets, decision trees and lzma stay on the plot as references, not targets: they show how much of a win comes from the concepts and how much from Syzygy's general file format, and how far a force program might still go. Passing Syzygy is not the end: the search keeps pushing the force-program frontier (bytes against operations) as long as that pays off. Tokens cost money, so with more pieces the spend per endgame needs a rule, for example closing an island when the bytes saved per dollar fall below a set value (concept note 03).

## Where things stand

- Phase 1 is done: KPK table (own rules code, verified against Syzygy position by position), the language and its interpreter, the scorer, baselines, a hand-written rule set, a plot. A single-user search loop (Phase 2) exists and has run once (r1). 134 tests pass.
- KPK against Syzygy (7,824 B): three force programs are smaller: run r1 4,459 B (959 operations) and 5,367 B (232 operations), human rules 5,639 B (273 operations). A trimmed r1 program, 4,430 B at 1,019 operations, exists only in `state/` (see the first try of trimming below). Current numbers: [reports/kpk.md](../reports/kpk.md).
- Two caveats on that win. The program sizes are information bounds (grammar code, log2 C(N, k)), while Syzygy's is a real file; a real exception list is larger (Elias–Fano without its select index: 8–14% at 100 to 3,000 errors, 28% at 10,000, see 01; the force programs have about 5,400), and real sizes are not in the report yet. Syzygy's operations were not measured, so "smaller at the same compute" is not shown either.
- References: a table net (2,178 B, 235 operations) and lzma of the bitbase (3,341 B, operations a rough estimate) are smaller than every force program. At KPK, being smaller than Syzygy is therefore a weak result.
- What the search found is known chess (opposition, corner, support, blockade), not new concepts. Force programs are small (about 150 B); almost all their cost is exceptions.
- Nothing beyond KPK has been started. Scoring one program takes about 11 µs per position (1.8 s for KPK's 165,676 positions, `chess-forces score programs/evolved-1024.dsl`, 2026-11-26). A 5-piece table has a few hundred million positions, so one program would take 1–2 hours on one core (estimate). Transfer (whether KPK ideas help in other endgames) is a second question, not tested.

## Git

- `main` is published on GitHub (first push 2026-11-25). Feature branches stay local. Commit as `operator`, no attribution lines, only when asked; never push without asking.
- `main` holds everything: Phase 1 core, baselines and human rules, the search loop with run r1, the faster loop with table nets. The feature branches point into it.

## Where things are

- `src/chess_forces/`: `dsl.py` language, interpreter and costs; `score.py` scorer; `kpk.py`, `board.py` rules and table; `baselines.py`, `nets.py`, `report.py` other methods and the plot; `search.py` loop; `budget.py` spend guard; `cli.py` commands.
- `programs/*.dsl`: hand-written and found programs (text, never run as Python). `programs/trees/`: the decision-tree baselines as DSL programs; the report reads them, only `chess-forces trees` retrains them, and a test checks that retraining gives the same text. `baselines/nets/`: trained nets (integers) and the sweep record. `reports/`: table, plot, JSON.
- Local only, gitignored: `state/` with the spend ledger `budget.sqlite`, `search-r1.sqlite` (all 1,076 proposals with their texts and scores) and `run-r1/`. Deleting them loses the run archive, not the results in the repository.
- Syzygy 3-4-5 tables live next to the repository in `../syzygy`. They are read only by tests and by one-off scripts through python-chess, which `src/` must not import.

## Commands

```text
uv run chess-forces kpk | spec | score FILE | report | trees | train-nets | evolve ... | budget status
uv run pytest            # about 30 s
uv run chess-forces report        # rebuilds reports/ (about 15 s)
uv run chess-forces trees         # retrains the decision trees into programs/trees (a few seconds)
uv run chess-forces train-nets    # retrains the nets (about 25 minutes, all cores)
uv run chess-forces evolve --run r2 --usd 3   # needs the API key and the owner's budget confirmation
```

## Decisions taken

D1–D5 of the concept note; own rules code; licence MIT; python-chess only as a dev dependency; grammar code for size; log2 C(N, k) for exceptions; operation tiers 64, 256, 1,024, 4,096; default budget 20 per day, scripts stop and resume, only the owner raises limits; funsearch is not copied, its island and cluster idea may be adapted later (Apache-2.0). On 2026-11-26: the target is the Syzygy file of each endgame within the 4,096-operation cap; nets, trees and lzma are references; no paid search on KPK; KPK closes with a written analysis; endgames of 5 pieces and more are the real test.

## Waiting for the owner

1. Build the free part of the soft-cap design below (keep everything, check every tier, tolerant frontier, local trimming)? A first trial of trimming and review is described there. The paid part (reviewer, grants) needs its own short concept and a cost cap first.
2. After KPK: one 4-piece endgame first (KRvKP, Syzygy 179 KB, about 12 million positions, about 2 minutes per program; estimate) to test the setup at a real size, or straight to a concept for 5 pieces?
3. For 5 pieces, where do the tables come from: own rules code (the rule so far, a large job) or read from Syzygy by a tool outside `src/`?

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

**One folder per endgame, and no result stays local.** Found 2026-11-26: a program file does not say which endgame it is for (K, k and P would appear in KQKP too), and a better program (the trimmed 4,430 B one below) exists only in `state/` and is missing from the report.

1. One folder per endgame holds everything about it, for example `endgames/kpk/` with `programs/`, `trees/` and `nets/` inside (the folder name is a suggestion). The folder decides the task: report and search read only that folder, and `chess-forces score` takes the task from the path (`--task` only for files elsewhere). A test scores every program in `endgames/kpk/` on KPK. The task is not put only in a docstring, because nothing checks a docstring.
2. The report (png, md, json) is written to the root of that folder. When a set such as KPvK is done, a written analysis (`analysis.md`) joins it there: the result against Syzygy, the references per tier, the best force programs and the chess ideas they use, what did not work, and every number with the command that produced it. A set counts as done only when its root has the plot and the analysis.
3. The report plots every program in its folder, not the fixed list `PROGRAM_NAMES` in `report.py`, so a file dropped in is enough.
4. `chess-forces promote FILE...` scores each program, copies those that beat the best force program of a tier into the endgame's `programs/` with a docstring saying where it came from, and rebuilds the report. The search loop calls it at the end of every run, and one-off scripts call it too. First candidate: `state/run-r1/trimmed-966-4430B-1019ops.dsl` (1,024 tier, 29 B better than run r1's best).
5. `chess-forces report` scans `state/**/*.dsl` and lists local programs that would beat the frontier but are not promoted. This only works on the owner's machine, because `state/` is not in git.
6. A rule for the repository's `CLAUDE.md`: a program's number goes into the docs only after the program is in its endgame folder and in the report.

**Honest numbers against Syzygy, and a search aimed at it.** Agreed 2026-11-26, not built.

1. Real sizes in the report next to the information bounds: the exceptions in a structure that can be read at random (Elias–Fano), the program as stored. A win over Syzygy is claimed on real sizes.
2. Syzygy's operations: a rough count of one probe (index, finding the block, decoding, capture check), marked as such.
3. lzma's operations from a count, not from decompression time × 3 GHz, which depends on the machine and changes on every run (297,876 and 267,750 on the same machine, 2026-11-26).
4. The search prompt shows the best force program of the tier (to improve) and the endgame's Syzygy size (to pass); the best reference of the tier may be shown as a hint of what is possible, not as the bar (today the nets are the bar: `search.Bars`, [02](02-agent-loop.md)).
5. A concept note 03 for 5 pieces: scoring speed (compile programs to numpy over the whole table or to C, or estimate exceptions from a sample during the search and count exactly only for the best programs), the table source (question 3 above), the brief's scaling test (operations per position against the number of pieces), and the token spend per endgame: when a paid search stops, measured in bytes saved per dollar rather than a fixed number of proposals.

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
- Every score includes 32 operations for an exception lookup when there are errors (an assumption).
- The API key is only visible to interactive shells (`.zshrc`), so a script started from Claude Code needs `zsh -ic '...'`. Never print it.
- A run's islands are fixed when it starts. Run r1 has the old islands (256, 1,024, 1,024, 4,096); continuing it needs those.
- Learned baselines use all positions (there is no hold-out), because exceptions are charged. Net training is seeded, but another BLAS may shift it; the saved nets are exact integers.
- Prompts contain FEN strings; they run near 1.75 characters a token, so bound token counts with 1.6.
- Model output is thinking-heavy (about 2,500 of 3,000 tokens), and answers cut off by the output limit are rejected; the default limit is 9,000 tokens.

## Next steps in order

1. Owner's answers above.
2. Close KPK, all free: the endgame folder and `promote` (above), promote the trimmed program, real sizes in the report, then `analysis.md`.
3. Concept note 03 for 5 pieces (above).
4. The next endgame, as the owner decides. Re-scoring the KPK programs on it gives a first transfer result for free.
5. Paid, only on the new endgame and only after a budget: effort A/B (low against medium, 120 proposals each), then a run.
6. Later: reflector, migration between islands, Batch API, a 7x7 board or an invented piece.
