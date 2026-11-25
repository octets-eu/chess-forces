# Status and handover (2026-11-25)

Read this first; new to the project? Start with the [beginner's guide](00-beginners-guide.md). Details: [01 DSL concept and results](01-dsl-concept.md), [02 agent loop](02-agent-loop.md), [reports/kpk.md](../reports/kpk.md). Working rules for this machine are kept in a local, unpublished `CLAUDE.md`.

## What this is

Find short programs in a small language of "forces on 64 squares" that answer KPK and later endgames exactly, with fewer bytes than other methods at the same operations per position. Size counts the program (grammar code) plus the list of its mistakes; operations are 64-bit word operations, worst case.

## Where things stand

- Phase 1 is done: KPK table (own rules code, verified against Syzygy position by position), the language and its interpreter, the scorer, baselines, a hand-written rule set, a plot. A single-user search loop (Phase 2) exists and has run once (r1). 134 tests pass.
- Bars (best other method, total bytes): tier 64: 5,681 B (additive pair tables); tiers 256, 1,024 and 4,096: **2,178 B** (a table net, 235 operations, 530 errors). Best force programs: human rules 5,639 B (273 operations), run r1 5,367 B (232 operations) and 4,459 B (959 operations). None beats the bar.
- A first claim that r1 beat the best method at 256 operations compared it with a weak net; it is wrong and corrected in the docs.
- What the search found is known chess (opposition, corner, support, blockade), not new concepts. Force programs are small (about 150 B); almost all their cost is exceptions.
- Transfer (the real prize) is not tested. KQKP has not been started: a pilot script was stopped before it produced anything.

## Git

- `main` is published on GitHub (first push 2026-11-25). Feature branches stay local. Commit as `operator`, no attribution lines, only when asked; never push without asking.
- `main` holds everything: Phase 1 core, baselines and human rules, the search loop with run r1, the faster loop with table nets. The feature branches point into it.

## Where things are

- `src/chess_forces/`: `dsl.py` language, interpreter and costs; `score.py` scorer; `kpk.py`, `board.py` rules and table; `baselines.py`, `nets.py`, `report.py` other methods and the plot; `search.py` loop; `budget.py` spend guard; `cli.py` commands.
- `programs/*.dsl`: hand-written and found programs (text, never run as Python). `baselines/nets/`: trained nets (integers) and the sweep record. `reports/`: table, plot, JSON.
- Local only, gitignored: `state/` with the spend ledger `budget.sqlite`, `search-r1.sqlite` (all 1,076 proposals with their texts and scores) and `run-r1/`. Deleting them loses the run archive, not the results in the repository.
- Syzygy 3-4-5 tables live next to the repository in `../syzygy`. They are read only by tests and by one-off scripts through python-chess, which `src/` must not import.

## Commands

```text
uv run chess-forces kpk | spec | score FILE | report | train-nets | evolve ... | budget status
uv run pytest            # about 30 s
uv run chess-forces report        # rebuilds reports/ (about 15 s)
uv run chess-forces train-nets    # retrains the nets (about 25 minutes, all cores)
uv run chess-forces evolve --run r2 --usd 3   # needs the API key and the owner's budget confirmation
```

## Decisions taken

D1–D5 of the concept note; own rules code; licence MIT; python-chess only as a dev dependency; grammar code for size; log2 C(N, k) for exceptions; operation tiers 64, 256, 1,024, 4,096; default budget 20 per day, scripts stop and resume, only the owner raises limits; funsearch is not copied, its island and cluster idea may be adapted later (Apache-2.0).

## Waiting for the owner

1. Build the free part of the soft-cap design below (keep everything, check every tier, tolerant frontier, local trimming)? A first trial of trimming and review is described there. The paid part (reviewer, grants) needs its own short concept and a cost cap first.
2. Next step: KQKP and the transfer test (free, about a day of code), or the paid effort A/B first?

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
2. KQKP: own generator (queen moves, both sides promoting, stalemate and draws), table and hash verified against Syzygy with python-chess in the tests, then re-score the KPK program library on it and compare with a net trained from scratch. That is the transfer test.
3. Paid, only after a budget: effort A/B (low against medium, 120 proposals each), then run r2 with the islands above.
4. Later: reflector, migration between islands, Batch API, a 7x7 board or an invented piece.
