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

1. Decoded-memory rule: programs and nets may be held decoded (nets up to 7.5 KB); an 8 KB cap would exclude unpacked tables. Adopt it?
2. Next step: KQKP and the transfer test (free, about a day of code), or the paid effort A/B first?

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
