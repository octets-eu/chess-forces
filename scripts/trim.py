"""Mechanical trimming, no model: remove or replace single parts of a program, keep what gets smaller.

Each step tries every single simplification of wins(): an and/or/not replaced by one of its
arguments, an if replaced by one branch, min/max/add/sub replaced by an Int argument. Every variant is
scored exactly; the next program is the one with the smallest total, where each operation over the
limit costs 0.5 B. It stops after --steps steps, when nothing improves and a fitting variant exists,
or after --seconds. The best variant within the limit is written next to the others in --out.

First result (2026-11-25): r1 program 966 from 4,476 B (4 operations over its limit) to 4,430 B at
1,019 operations; three other items were cut to far worse programs (the greedy steps cut too much).

    uv run python scripts/trim.py FILE... --limit 1024
    uv run python scripts/trim.py --rejected state/run-r1/rejected.json --top 10
"""

import argparse
import dataclasses
import json
import multiprocessing as mp
import time
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

from chess_forces import dsl, endgames, score, search

NODES = (dsl.Lit, dsl.Var, dsl.App, dsl.Call, dsl.Logic, dsl.If, dsl.Let, dsl.Loop)
OVER_COST = 0.5  # bytes charged per operation over the limit while searching


def edits(e) -> list:
    """All single-node simplifications of an expression tree, as new trees."""
    out = []

    def rec(e, rebuild):
        match e:
            case dsl.Logic():
                out.extend(rebuild(a) for a in e.args)
            case dsl.If():
                out.extend([rebuild(e.a), rebuild(e.b)])
            case dsl.App() if e.t == "Int" and e.prim in ("min", "max", "add", "sub"):
                out.extend(rebuild(a) for a in e.args if a.t == "Int")
        for f in dataclasses.fields(e):
            v = getattr(e, f.name)
            if isinstance(v, NODES) and not isinstance(v, dsl.Lit):
                rec(v, lambda nv, f=f.name, e=e, rb=rebuild: rb(dataclasses.replace(e, **{f: nv})))
            elif isinstance(v, tuple):
                for i, x in enumerate(v):
                    if isinstance(x, NODES) and not isinstance(x, dsl.Lit):
                        rec(
                            x,
                            lambda nv, f=f.name, i=i, e=e, v=v, rb=rebuild: rb(
                                dataclasses.replace(e, **{f: v[:i] + (nv,) + v[i + 1 :]})
                            ),
                        )

    rec(e, lambda n: n)
    return out


def variants(text: str) -> list[str]:
    prog = dsl.parse(text)
    d = prog.defs[-1]
    seen, res = set(), []
    for b in edits(d.body):
        if b.t != "Bool":
            continue
        p2 = dataclasses.replace(prog, defs=(*prog.defs[:-1], dataclasses.replace(d, body=b)))
        try:
            t = dsl.canonical(p2)
            dsl.parse(t)
        except dsl.DslError:
            continue
        if t not in seen:
            seen.add(t)
            res.append(t)
    return res


def _init(name: str) -> None:
    global EV
    EV = search.Evaluator(endgames.ALL[name].task())


def _work(t: str):
    try:
        s = EV.evaluate(t)
        return t, s.total, s.ops_max
    except (dsl.DslError, score.OverBudget):
        return t, 1e9, 10**9


def trim(pool, text: str, total: float, ops: int, limit: int, steps: int, deadline: float):
    cur, best = (text, total, ops), None
    penalty = lambda r: r[1] + OVER_COST * max(0, r[2] - limit)
    for _ in range(steps):
        if time.time() > deadline:
            break
        cand = [r for r in pool.map(_work, variants(cur[0])) if r[2] <= dsl.CAP]
        if not cand:
            break
        for r in cand:
            if r[2] <= limit and (best is None or r[1] < best[1]):
                best = r
        nxt = min(cand, key=penalty)
        if penalty(nxt) >= penalty(cur) and best:
            break
        cur = nxt
    return best


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="*")
    ap.add_argument("--rejected", help="rejected.json from scripts/rejected.py")
    ap.add_argument("--top", type=int, default=10, help="with --rejected: the smallest N")
    ap.add_argument("--limit", type=int, help="operation limit for FILEs")
    ap.add_argument("--endgame", default="kpk", choices=sorted(endgames.ALL))
    ap.add_argument("--steps", type=int, default=5)
    ap.add_argument("--seconds", type=int, default=500)
    ap.add_argument("--out", default=str(endgames.ROOT / "state" / "trim"))
    args = ap.parse_args()
    task = endgames.ALL[args.endgame].task()
    jobs = []
    if args.rejected:
        items = json.loads(Path(args.rejected).read_text())
        for i in sorted(items, key=lambda i: i["total"])[: args.top]:
            jobs.append((f"unit-{i['unit']}", i["text"], i["total"], i["ops"], i["limit"]))
    for f in args.files:
        if args.limit is None:
            ap.error("--limit is needed for FILEs")
        text = Path(f).read_text()
        r = score.score(text, task)
        jobs.append((Path(f).stem, text, r.bytes_total, r.ops_max, args.limit))
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    deadline = time.time() + args.seconds
    with ProcessPoolExecutor(
        max(1, mp.cpu_count() - 1),
        mp_context=mp.get_context("spawn"),
        initializer=_init,
        initargs=(args.endgame,),
    ) as pool:
        for name, text, total, ops, limit in jobs:
            best = trim(pool, text, total, ops, limit, args.steps, deadline)
            row = {"name": name, "limit": limit, "total": round(total, 1), "ops": ops}
            if best:
                path = out / f"{name}-trimmed.dsl"
                path.write_text(best[0])
                row.update(trimmed=round(best[1], 1), trimmed_ops=best[2], file=str(path))
            print(json.dumps(row), flush=True)


if __name__ == "__main__":
    main()
