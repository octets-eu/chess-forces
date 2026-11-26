"""Programs a search run rejected only for using too many operations, scored again.

Reads the run's archive (state/search-<run>.sqlite) and the paid answers in the spend ledger, keeps
each distinct program whose rejection note says it was over its island's operation limit, and writes
them with their scores to state/run-<run>/rejected.json, the input of scripts/trim.py and
scripts/review.py. Read-only on both databases.

    uv run python scripts/rejected.py --run r1
"""

import argparse
import json
import re
import sqlite3

from chess_forces import budget, dsl, endgames, search


def read_only(path) -> sqlite3.Connection:
    return sqlite3.connect(f"file:{path}?mode=ro", uri=True)


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--run", default="r1")
    args = ap.parse_args()
    state = budget.default_path().parent
    answers = {
        k: json.loads(v)
        for k, v in read_only(budget.default_path()).execute("select key, value from results")
    }
    archive = read_only(state / f"search-{args.run}.sqlite")
    ev = search.Evaluator(endgames.KPK.task())  # run r1 searched KPK
    items, seen = [], set()
    for unit, note in archive.execute("select unit, note from units where status = 'rejected'"):
        m = re.match(r"uses ([\d,]+) operations, limit ([\d,]+)", note)
        answer = answers.get(f"{args.run}/{unit}")
        if not m or not answer:
            continue
        try:
            text = search.extract(answer["text"])
            h = search.hash_of(text)
        except dsl.DslError:  # no program in the answer, or not a valid one
            continue
        if h in seen:
            continue
        seen.add(h)
        s = ev.evaluate(text)
        items.append(
            {
                "unit": unit,
                "limit": int(m.group(2).replace(",", "")),
                "text": text,
                "total": round(s.total, 1),
                "ops": s.ops_max,
                "errors": s.errors,
                "prog": round(s.prog_bytes, 1),
                "clusters": s.feedback["clusters"][:4],
            }
        )
    out = state / f"run-{args.run}" / "rejected.json"
    out.parent.mkdir(exist_ok=True)
    out.write_text(json.dumps(items, indent=1))
    near = sum(i["ops"] <= 1.1 * i["limit"] for i in items)
    print(f"{len(items)} distinct programs over their limit, {near} within 10%; wrote {out}")
    for i in sorted(items, key=lambda x: x["total"])[:6]:
        print(
            i["unit"],
            "limit",
            i["limit"],
            "ops",
            i["ops"],
            "total",
            i["total"],
            "errors",
            i["errors"],
        )


if __name__ == "__main__":
    main()
