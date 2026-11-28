# Concept note 04: the next endgame, KQvKP

Status: T1, E1, L1, S1 and B1 approved 2026-11-26; F1, S2, O1, Q1 and additions to L1, S1 and B1 agreed 2026-11-28. Nothing of it is built; the order of work is in STATUS, Next steps.

## Why KQvKP

White has king and queen, Black king and pawn. It is the classic queen-against-pawn ending: the queen wins, except against a rook or bishop pawn on the seventh rank when the strong king is far away, where stalemate saves Black; the pawn can also promote and occasionally win. Its quantities are lines, checks, pins and stalemate rather than KPK's distances, which is where enumerated comparisons may stop being enough and a model's chess knowledge may start to pay off: the test KPK could not decide (note 03).

| | KPK | KQvKP |
| --- | ---: | ---: |
| Syzygy file | 7,824 B | 58,064 B |
| the same with the tables its probe reads (F1) | 7,824 B | 66,160 B |
| positions in Syzygy's index | 187,488 | 11,436,768 |
| Syzygy's bits per position | 0.33 | 0.041 |
| break-even error rate (rough, see STATUS) | 6.2% | 0.44% |

A program must be close to exact to beat Syzygy here; the exact programs KPK produced are the starting point.

## The table (T1, decided)

1. **Positions from our own code.** A general enumeration of the legal positions of a set of men, in `src/`: symmetries (pawns mirrored to files a–d, the eight symmetries of the board without pawns), legality (the side not to move is not in check, no pawn on the first or last rank), both sides to move. It replaces the KPK-only enumeration and must give KPK's 165,676 positions unchanged.
2. **Results from Syzygy.** A script outside `src/` probes every position through python-chess (a dev dependency, decision D6), in parallel, and writes the table locally next to `../syzygy` with its sha256; the hash goes into the repository. Estimate from KPK's probes (about 30 µs each): about 6 minutes for KQvKP on one core, under one on 14.
3. **Cross-check.** For KPK the extracted table must equal our own generator's, position by position; the generator stays as that check.
4. **Target.** `wins()` stays "White wins with best play". Black wins (the pawn promotes and wins) count as not a White win, like draws; the table records the three results, so a three-class target can come later.

## Syzygy as the target (F1, agreed 2026-11-28)

`KQvKP.rtbw` cannot answer alone: the probe first tries every capture (python-chess `probe_ab`) and reads the table of the position after it. Checked 2026-11-28 with files removed: `8/8/8/8/8/k7/1p1Q4/7K w` (queen takes pawn) needs `KQvK.rtbw` (272 B), `8/8/8/p7/3Q4/2k5/8/7K b` (king takes queen) needs `KPvK.rtbw` (7,824 B); KPK's probe needs no other file. So the pass line stays the file alone (58,064 B, the stricter number), the report shows the 66,160 B with those tables next to it, and Syzygy's operations count the capture search (generating the captures, probing each table they lead to), which `scripts/syzygy_ops.py` priced as a flat 8 for KPK. Syzygy also tells Black wins from draws and `wins()` does not (T1, point 4); the report says so.

## The 50-move rule (E1, decided: an exception that must not be forgotten)

Syzygy distinguishes wins that the 50-move rule turns into draws ("cursed wins") and losses it saves ("blessed losses"). From KQvKP on we start without the rule: a cursed win counts as a win, a blessed loss as a loss, the pure game result. This is an exception to the rules of chess as played, not a detail:

- the extraction counts the positions it affects, and every report and analysis of an endgame shows that count next to the result;
- STATUS lists it under open exceptions until it is resolved;
- resolving it means a target under the 50-move rule, as Syzygy's own WDL values are, so a program is judged against the same rules as the file it is compared with. That is planned, not optional.

## The language and the prompts (L1)

`P` is "the strong side's only pawn", which KQvKP does not have. Version 0.4 adds a general accessor `man(side, kind)`, the square of that side's only man of that kind, or none; `K`, `k` and `P` stay as they are. The queen's lines are then `hits(strong, queen, man(strong, queen), occ)`, the weak pawn is `man(weak, pawn)`.

Each endgame gets its own prompt (description, themes, numbers); no KPK numbers stay in the code, as `concepts.py`'s 7,824 B and the KPK themes in `search.HINTS` do today. Prompts show the endgame's Syzygy size (to pass) and the best force program of the tier (to improve), the best reference only as a hint of what is possible (STATUS, a search aimed at Syzygy).

## Scale (S1)

About 70 times KPK's positions. Measured on KPK and scaled, so estimates:

- **Scoring a program:** about 2 minutes on one core with today's interpreter (11 µs per position); in parallel over 14 processes about 10 to 15 seconds.
- **Quantities (atoms):** about 35 seconds each on one core, a few seconds in parallel; cached.
- **Trees:** on all positions, so exact programs stay exact; built as S2 describes.
- **Syzygy's operations:** `scripts/syzygy_ops.py` generalised to any table, with the capture search (F1).
- **Tests (Q1, agreed 2026-11-28):** scoring KQvKP programs in full in `uv run pytest` (9 minutes on KPK already) would take hours, so the tests pin the table's sha256 and check programs on a fixed sample of positions; full scores come from `chess-forces report`.

## Trees (S2, agreed 2026-11-28)

scikit-learn copies the features as 32-bit floats: 10 million positions and 200 features take about 8 GB, 600 about 24 GB, more than this machine has. Capping the features would cut the strongest lever (KPK: 30 to 45 atoms took the exact program from 5,327 to 2,789 B). Our own greedy builder instead:

- stores an atom in one byte (atoms are small integers) and a comparison in one bit: 600 atoms take about 6 GB, a comparison about 1.25 MB;
- grows each tree until exact, then prunes it from the leaves up wherever a split costs more program bytes than it saves in exceptions, and writes both trees as programs (today: 256 leaves or exact, `concepts.py`); at a break-even error rate of 0.44% the smallest total probably lies in between;
- matches the scikit-learn trees' sizes and errors on KPK, or explains each difference.

## Operations of tree programs (O1, agreed 2026-11-28)

The KPK trees compute every quantity before the first branch, so `pool-r1-exact` needs up to 2,841 operations; with hundreds of quantities and a queen's lines at 6 to about 100 operations each, KQvKP trees would probably exceed 4,096 (an estimate). A branch can already name a value that only it sees (`dsl.py`), so only the writer of concept trees (`concepts.py`) changes, not the baseline trees in `trees/`: each quantity is computed on every path that needs it (fewest operations) or once at the node above all its uses (fewest bytes), a curve of bytes against operations from one tree. Measured on KPK first; the earlier KPK programs stay, the new ones are promoted next to them.

## Test plan

1. The table, the language additions and the report for KQvKP, with the references: lzma of the table, Syzygy (F1), decision trees and nets.
2. The concept pool, free: atoms for the queen (its lines to the pawn and the promotion square, checks, the squares it controls around the weak king, the kings' distances to the pawn and to the promotion square, the pawn's rank and file), enumerated comparisons, and trees pruned by bytes and grown until exact (S2), written as O1 describes.
3. A saturated pool, free: add enumerated comparisons by their bytes saved until more stop helping; the level where a random comparison saves nothing is the noise floor (KPK's lesson: the 1 B rule measured noise).
4. The model's concepts against it: first the KPK smoke test's form, a few calls, in two halves, with KQvKP themes (stalemate with a rook or bishop pawn on the seventh, the queen's approach by checks, where the strong king must stand) and without, to see whether themes lead the model or narrow it. A paid concept run (cap 3 USD) only if the model's concepts clearly beat enumerated ones against the saturated pool (criterion C5 of note 03).
5. Every model call on KQvKP, the smoke test included, uses the prompts of L1. A paid program search waits for the free part of the soft cap (STATUS, agreed ideas: keep every valid program, check every tier, tolerant frontier, local trimming); in KPK a tier rejection lost program 831.

## Decisions

| # | Question | State |
| --- | --- | --- |
| T1 | Table source | decided 2026-11-26: positions from our own code, results from Syzygy; KPK's own generator as the check |
| E1 | 50-move rule | decided 2026-11-26: KQvKP starts without it, counted and shown in every report; to be resolved later, listed as an open exception |
| F1 | Syzygy as the target | agreed 2026-11-28: pass line the file alone (58,064 B), shown with its probe's tables (66,160 B); the capture search counted in its operations |
| L1 | Language 0.4 and prompts | approved 2026-11-26: `man(side, kind)`, prompts per endgame; 2026-11-28: prompts show Syzygy and the best force program |
| S1 | Scale | approved 2026-11-26: parallel scoring and atoms, trees on all positions; 2026-11-28: the limit of about 200 features gives way to S2 |
| S2 | Trees | agreed 2026-11-28: own builder, a byte per atom and a bit per comparison, pruned by bytes |
| O1 | Operations of tree programs | agreed 2026-11-28: quantities computed where a path needs them |
| Q1 | Tests | agreed 2026-11-28: the table's hash pinned, KQvKP programs tested on a fixed sample |
| B1 | Paid run on KQvKP | approved 2026-11-26: only after a saturated pool and a smoke test, cap 3 USD; 2026-11-28: smoke test with and without themes, prompts of L1, a program search only after the free soft cap |
