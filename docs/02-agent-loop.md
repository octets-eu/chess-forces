# Concept note 02: single-user agent loop (Phase 2)

Status: built; first run (r1) done on 2026-11-25 within a small, capped budget. A FunSearch-style loop: a model proposes a DSL program, the local scorer judges it exactly, good programs go into the next prompt.

## One unit of work

1. Pick an island. Each island aims at one operation tier (256, 1,024, 1,024 and 4,096), so diversity comes from different compute budgets, not only from random restarts. Islands do not mix in v1.
2. Build a prompt: the language and scoring rules (cached prefix), two parents from the island (the stronger one more often) with their scores, their largest error groups and a dozen wrong positions with the true result, the bar to beat at that tier (reports/kpk.md), and the last rejected proposals with the reason.
3. Claude (Haiku 5.5, medium effort) answers with one program. Anything that is not a single valid DSL program, or that needs more operations than the tier allows, is rejected locally and costs nothing beyond the call.
4. Score it on all 165,676 positions, store it (program, score, error groups), skip duplicates by canonical hash.

## Parameters

- Parent selection: rank-based, the best of the island three times as likely as the next, then random. The second parent is drawn from the top quarter.
- Seeds: always win, rule of the square, human rules. Learned trees and nets are not seeded; they only set the bar.
- Stop: the run's spend limit (hard, on top of the daily and total limits of chess_forces.budget), a maximum number of units, or Ctrl-C. Resuming continues: prompts and answers are stored before and after each call, an answer that was paid for but not yet scored is scored on the next start.
- Retries: rate limits are not billed and are retried; server errors are ambiguous, so their reservation stays counted and the unit is retried under a new one.
- Cost model: every call is reserved at its worst case first (prompt bound from its length, plus 6,000 output tokens), settled afterwards from the API's usage numbers. Prompt caching is used for the fixed prefix.

## Not in v1

Reflector (a stronger model proposing new primitives), migration between islands, island resets, Batch API (half price but minutes of latency per generation), and any primitive beyond the fixed language. They come after the first run shows what a Haiku proposal is worth.

## Result of run r1

1,076 proposals by Claude Haiku 5.5, 8 workers, about an hour in three sessions. 895 were added to the archive, 111 were rejected (no valid program, operations over the island's limit) and 69 were duplicates; 10 answers ran out of output tokens while thinking in the first 120 calls, after which the output limit was raised.

| Tier | Start (human rules or square) | Best after r1 | Best other method | Verdict |
| ---: | ---: | ---: | ---: | --- |
| 256 | 14,151 B | 5,367 B | 5,670 B (net, 8 units) | below it |
| 1,024 | 5,639 B | 4,459 B | 3,105 B (net, 32 units) | above it |
| 4,096 | 5,639 B | 4,459 B | 2,837 B (net, 64 units) | above it |

What changed the pace: after about 340 proposals, prompts began to show the strongest programs of the whole archive (even over the island's limit) and a rotating theme (opposition, flood, captures, rook-pawn corner, shortening, ...). Before that, the 256 island sat at 6,420 B; it dropped to 5,921 B within 100 proposals and to 5,367 B by the end.

Limits: one seed, one model, no reflector, no migration. The winning programs are readable and use familiar chess ideas; nothing new was found yet.
