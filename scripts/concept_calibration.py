"""Calibration of the concept loop (docs/03-concept-loop.md), free: no new paid call.

1. Replays the answers of a paid run from the spend ledger (they are cached by key), refits the trees
   for every candidate and prints what the quick filter said next to the bytes actually saved.
2. Draws random enumerated comparisons from below the pool's cut and measures them the same way, each
   against the same base: what an arbitrary concept "saves" is the noise floor of the acceptance rule.

    uv run python scripts/concept_calibration.py --run c0 --units 8 --random 30
"""

import argparse
import random
import statistics

from chess_forces import concepts, endgames, search
from chess_forces.budget import Guard


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--run", default="c0")
    ap.add_argument("--units", type=int, default=8)
    ap.add_argument("--random", type=int, default=30)
    args = ap.parse_args()
    kpk = endgames.KPK
    task = kpk.task()
    r1 = {"r1": (kpk.programs / "r1-unit-831.dsl").read_text()}
    out_dir = endgames.ROOT / "state" / f"concepts-{args.run}-calibration"

    def fresh():
        pool, rest = concepts.build_pool(task, 500, r1)
        s = concepts.LoopSettings(run=args.run, filter_bits=-1.0, exact_bits=-1.0)
        return concepts.ConceptLoop(
            s, Guard(run=args.run), None, pool, out_dir, log=print
        ), rest

    def cached(_handle):
        raise RuntimeError("not in the ledger: this script never calls the API")

    loop, rest = fresh()
    model = []
    print(
        "| Unit | Concept | Filter, 256 leaves (bits) | Saved at 256 leaves | Saved, exact | Status |"
    )
    print("| ---: | --- | ---: | ---: | ---: | --- |")
    for u in range(args.units):
        ans = loop.guard.run(f"{args.run}/{u}", "claude-haiku-5-5", 1, 1, cached)
        for c in concepts.named_concepts(
            search.extract(ans["text"]), f"u{u}_", task, f"{args.run}/{u}"
        ):
            if not loop.pool.is_new(c):
                continue
            bits = concepts.gain_in_leaves(c.values, loop.pool.y, loop.state.leaf)
            n = len(loop.pool.concepts)
            o = loop.consider(u, c)
            if o.status == "accepted":  # measure every candidate against the same base
                loop.pool.concepts = loop.pool.concepts[:n]
                loop.accepted.pop()
            model.append(o.saved_exact)
            print(
                f"| {u} | {c.name} | {bits:,.0f} | {o.saved_256:,.1f} | {o.saved_exact:,.1f} | {o.status} |"
            )
    rng = random.Random(1)
    enum = []
    for c in rng.sample(rest[:3000], args.random):
        n = len(loop.pool.concepts)
        o = loop.consider(-1, c)
        if o.status == "accepted":
            loop.pool.concepts = loop.pool.concepts[:n]
            loop.accepted.pop()
        enum.append(o.saved_exact)

    def summary(xs):
        return (
            f"{len(xs)} concepts, saved on the exact tree: median {statistics.median(xs):,.1f} B, "
            f"{sum(x >= 1 for x in xs) / len(xs):.0%} at least 1 B"
        )

    print(f"\nmodel ({args.run}): {summary(model)}")
    print(f"random enumerated comparisons: {summary(enum)}")


if __name__ == "__main__":
    main()
