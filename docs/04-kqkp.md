# Concept note 04: the next endgame, KQvKP

Status: approved 2026-11-26 (T1, E1, L1, S1, B1). Nothing of it is built; the order of work is in STATUS, Next steps.

## Why KQvKP

White has king and queen, Black king and pawn. It is the classic queen-against-pawn ending: the queen wins, except against a rook or bishop pawn on the seventh rank when the strong king is far away, where stalemate saves Black; the pawn can also promote and occasionally win. Its quantities are lines, checks, pins and stalemate rather than KPK's distances, which is where enumerated comparisons may stop being enough and a model's chess knowledge may start to pay off: the test KPK could not decide (note 03).

| | KPK | KQvKP |
| --- | ---: | ---: |
| Syzygy file | 7,824 B | 58,064 B |
| positions in Syzygy's index | 187,488 | 11,436,768 |
| Syzygy's bits per position | 0.33 | 0.041 |
| break-even error rate (rough, see STATUS) | 6.2% | 0.44% |

A program must be close to exact to beat Syzygy here; the exact programs KPK produced are the starting point.

## The table (T1, decided)

1. **Positions from our own code.** A general enumeration of the legal positions of a set of men, in `src/`: symmetries (pawns mirrored to files a–d, the eight symmetries of the board without pawns), legality (the side not to move is not in check, no pawn on the first or last rank), both sides to move. It replaces the KPK-only enumeration and must give KPK's 165,676 positions unchanged.
2. **Results from Syzygy.** A script outside `src/` probes every position through python-chess (a dev dependency, decision D6), in parallel, and writes the table locally next to `../syzygy` with its sha256; the hash goes into the repository. Estimate from KPK's probes (about 30 µs each): about 6 minutes for KQvKP on one core, under one on 14.
3. **Cross-check.** For KPK the extracted table must equal our own generator's, position by position; the generator stays as that check.
4. **Target.** `wins()` stays "White wins with best play". Black wins (the pawn promotes and wins) count as not a White win, like draws; the table records the three results, so a three-class target can come later.

## The 50-move rule (E1, decided: an exception that must not be forgotten)

Syzygy distinguishes wins that the 50-move rule turns into draws ("cursed wins") and losses it saves ("blessed losses"). From KQvKP on we start without the rule: a cursed win counts as a win, a blessed loss as a loss, the pure game result. This is an exception to the rules of chess as played, not a detail:

- the extraction counts the positions it affects, and every report and analysis of an endgame shows that count next to the result;
- STATUS lists it under open exceptions until it is resolved;
- resolving it means a target under the 50-move rule, as Syzygy's own WDL values are, so a program is judged against the same rules as the file it is compared with. That is planned, not optional.

## The language (L1, proposed)

`P` is "the strong side's only pawn", which KQvKP does not have. Proposed for version 0.4: a general accessor `man(side, kind)`, the square of that side's only man of that kind, or none; `K`, `k` and `P` stay as they are. The queen's lines are then `hits(strong, queen, man(strong, queen), occ)`, the weak pawn is `man(weak, pawn)`. The prompts get a description per endgame instead of KPK's.

## Scale (S1, proposed)

About 70 times KPK's positions. Measured on KPK and scaled, so estimates:

- **Scoring a program:** about 2 minutes on one core with today's interpreter (11 µs per position); in parallel over 14 processes about 10 to 15 seconds.
- **Quantities (atoms):** about 35 seconds each on one core, a few seconds in parallel; cached.
- **Trees:** scikit-learn copies the features as 32-bit floats: 10 million positions and 200 features take about 8 GB, 600 features about 24 GB, more than this machine has. The plan: at most about 200 features per tree (the atoms plus the comparisons that matter), trees on all positions, so exact programs stay exact.
- **Syzygy's operations:** `scripts/syzygy_ops.py` generalised to any table.

## Test plan

1. The table, the language additions and the report for KQvKP, with the references: lzma of the table, Syzygy (size and estimated operations), decision trees and nets.
2. The concept pool, free: atoms for the queen (its lines to the pawn and the promotion square, checks, the squares it controls around the weak king, the kings' distances to the pawn and to the promotion square, the pawn's rank and file), enumerated comparisons, and trees at 256 leaves and grown until exact.
3. A saturated pool, free: add enumerated comparisons by their bytes saved until more stop helping; the level where a random comparison saves nothing is the noise floor (KPK's lesson: the 1 B rule measured noise).
4. The model's concepts against it: first the KPK smoke test's form, a few calls; a paid concept run (cap proposed: 3 USD) only if the model's concepts clearly beat enumerated ones against the saturated pool (criterion C5 of note 03).

## Decisions

| # | Question | State |
| --- | --- | --- |
| T1 | Table source | decided 2026-11-26: positions from our own code, results from Syzygy; KPK's own generator as the check |
| E1 | 50-move rule | decided 2026-11-26: KQvKP starts without it, counted and shown in every report; to be resolved later, listed as an open exception |
| L1 | Language 0.4 | approved 2026-11-26: `man(side, kind)`, prompts per endgame |
| S1 | Scale | approved 2026-11-26: parallel scoring and atoms, at most about 200 features per tree, all positions |
| B1 | Paid run on KQvKP | approved 2026-11-26: only after a saturated pool and a smoke test, cap 3 USD |
