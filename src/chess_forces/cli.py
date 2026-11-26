"""chess-forces command line: KPK table and API budget."""

import argparse
import json
import sys
import time
from pathlib import Path

from . import budget, endgames, kpk


def _kpk(_args) -> int:
    win = kpk.generate()
    got = kpk.digest(win)
    wins = sum(win.values())
    ok = got == kpk.SHA256 and len(win) == kpk.N_POSITIONS and wins == kpk.N_WINS
    print(f"KPK positions {len(win)}, White wins {wins}\nsha256 {got} {'OK' if ok else 'MISMATCH'}")
    if not ok:
        return 1
    out = Path(__file__).resolve().parents[2] / "build" / "kpk.bin"
    out.parent.mkdir(exist_ok=True)
    out.write_bytes(kpk.pack(win))
    print(f"wrote {out} ({out.stat().st_size} bytes)")
    return 0


def _score(args) -> int:
    from . import score as scoring

    try:
        text = sys.stdin.read() if args.file == "-" else Path(args.file).read_text()
        folder = None if args.file == "-" else endgames.of_path(args.file)
        if folder and args.task and args.task != folder.name:
            print(
                f"rejected: {args.file} is in the {folder.name} folder, not {args.task}",
                file=sys.stderr,
            )
            return 1
        name = folder.name if folder else (args.task or "kpk")
        t0 = time.perf_counter()
        task = scoring.TASKS[name]()
        t1 = time.perf_counter()
        report = scoring.score(text, task)
    except (scoring.DslError, scoring.OverBudget, OSError) as e:
        print(f"rejected: {e}", file=sys.stderr)
        return 1
    print(report.to_json() if args.json else report.text())
    if not args.json:
        print(f"(table {t1 - t0:.1f} s, scoring {time.perf_counter() - t1:.1f} s)")
    return 0


def _spec(_args) -> int:
    from .dsl import spec

    print(spec())
    return 0


def _train_nets(_args) -> int:
    from . import nets

    t = time.perf_counter()
    results = nets.sweep(progress=lambda m: print(m, flush=True))
    print(f"{len(results)} nets in {time.perf_counter() - t:.0f} s, kept in {nets.NETS_DIR}")
    return 0


def _trees(_args) -> int:
    from . import baselines, score

    for path in baselines.write_trees(score.kpk_task()):
        print(f"wrote {path}")
    return 0


def _promote(args) -> int:
    from . import promote
    from . import report as rep

    endgame = endgames.ALL[args.endgame]
    if args.name and len(args.name) != len(args.files):
        print("give one --name per file, or none", file=sys.stderr)
        return 1
    outcomes = promote.promote(
        [Path(f) for f in args.files], endgame, prefix=args.prefix, names=args.name
    )
    for o in outcomes:
        where = f"promoted to {o.promoted.relative_to(endgames.ROOT)}" if o.promoted else "kept out"
        print(f"{o.source}: {where} ({o.reason})")
    if any(o.promoted for o in outcomes) and not args.no_report:
        for path in rep.write(rep.build()):
            print(f"wrote {path}")
    return 0


def _concepts(args) -> int:
    from . import concepts, score
    from .budget import Guard, api_key, default_path, exit_on_budget, usd

    kpk = endgames.KPK
    task = kpk.task()
    r1 = {"r1": (kpk.programs / "r1-unit-831.dsl").read_text()}
    state = default_path().parent
    if args.cmd == "baseline":
        out = state / "concepts-baseline"
        out.mkdir(parents=True, exist_ok=True)
        rows = (
            ("30 atoms + enumerated comparisons", "base", False, None),
            ("45 atoms + stronger enumeration", "stronger", True, None),
            ("45 atoms + stronger enumeration + concepts of r1-unit-831", "stronger-r1", True, r1),
        )
        print("| Pool | Leaves | Errors | Bytes (score) | Real bytes | Max ops |")
        print("| --- | ---: | ---: | ---: | ---: | ---: |")
        for label, slug, stronger, programs in rows:
            pool, _ = concepts.build_pool(task, args.keep, programs, stronger=stronger)
            for size, leaves in (("256", 256), ("exact", None)):
                g = pool.grow(leaves)
                r = score.score(g.text, task)
                if r.errors != g.errors:
                    raise AssertionError(f"{label}: the program and its tree disagree")
                (out / f"{slug}-{size}.dsl").write_text(g.text)
                n = g.tree.get_n_leaves()
                print(
                    f"| {label} | {n:,} | {g.errors:,} | {g.bytes_total:,.0f} | {g.real_bytes:,} | {r.ops_max:,} |",
                    flush=True,
                )
        print(f"programs written to {out}")
        return 0
    pool, rest = concepts.build_pool(task, args.keep, r1)
    out = state / f"concepts-{args.run}"
    if args.cmd == "compare":
        data = json.loads((out / "outcomes.json").read_text())
        model = [concepts.concept_from_record(r, task) for r in data["accepted"]]
        concepts.compare(pool, rest, model, out)
        return 0
    import anthropic

    settings = concepts.LoopSettings(
        run=args.run,
        model=args.model,
        effort=args.effort,
        max_tokens=args.max_tokens,
        workers=args.workers,
        plateau=args.plateau,
        min_bytes_per_usd=args.min_bytes_per_usd,
    )
    guard = Guard(run=args.run, run_limit_usd=args.usd)
    client = anthropic.Anthropic(api_key=api_key(), max_retries=0, timeout=180)
    loop = concepts.ConceptLoop(
        settings, guard, client, pool, out, log=lambda m: print(m, flush=True)
    )
    why = "stopped"
    with exit_on_budget():
        try:
            why = loop.run(args.units)
        finally:
            loop.save(out / "outcomes.json")
            acc = [o for o in loop.outcomes if o.status == "accepted"]
            print(
                f"stop: {why}; {len(loop.outcomes)} candidates, {len(acc)} accepted; "
                f"run spend {usd(guard.run_spent())} USD"
            )
            _promote(
                argparse.Namespace(
                    files=[str(out / "best-256.dsl"), str(out / "best-exact.dsl")],
                    endgame="kpk",
                    prefix="",
                    name=[f"{args.run}-best-256", f"{args.run}-best-exact"],
                    no_report=False,
                )
            )
    return 0


def _report(_args) -> int:
    from . import report as rep

    t = time.perf_counter()
    result = rep.build()
    for path in rep.write(result):
        print(f"wrote {path}")
    print(
        f"{len(result.points)} points, {len(result.frontier)} on the frontier, {time.perf_counter() - t:.0f} s"
    )
    return 0


def _evolve(args) -> int:
    from . import score, search
    from .budget import Guard, api_key, default_path, exit_on_budget, usd

    state = default_path().parent
    archive = search.Archive(state / f"search-{args.run}.sqlite")
    settings = search.Settings(
        run=args.run,
        workers=args.workers,
        effort=args.effort,
        model=args.model,
        max_tokens=args.max_tokens,
        islands=tuple(int(x) for x in args.islands.split(",")),
        seed=args.seed,
        repair=not args.no_repair,
        plateau=args.plateau,
    )
    bars = search.Bars.load(endgames.KPK.report("json"))
    if args.show_prompt:
        s = search.Search(
            settings, Guard(), None, archive, search.Evaluator(score.kpk_task()), bars
        )
        s.seed()
        print(s.system + "\n\n=== user prompt, island 0 ===\n\n" + s.user_prompt(0)[0])
        return 0
    import anthropic

    client = anthropic.Anthropic(api_key=api_key(), max_retries=0, timeout=180)
    guard = Guard(run=args.run, run_limit_usd=args.usd)
    evaluator = search.PoolEvaluator("kpk", args.scorers)
    try:
        s = search.Search(settings, guard, client, archive, evaluator, bars)
    except ValueError as e:
        evaluator.close()
        print(e, file=sys.stderr)
        return 1
    with exit_on_budget():
        try:
            s.run(args.units, progress=lambda m: print(m, flush=True))
        except search.SearchStopped as e:
            print(f"stopped: {e}", file=sys.stderr)
        finally:
            evaluator.close()
            print(s.summary())
            print(s.usage_text())
            out = state / f"run-{args.run}"
            out.mkdir(exist_ok=True)
            saved = []
            for tier, best in archive.best_per_tier().items():
                saved.append(out / f"best-{tier}.dsl")
                saved[-1].write_text(best.text)
            for i, s in enumerate(archive.exact()):
                saved.append(out / f"exact-{i}.dsl")
                saved[-1].write_text(s.text)
                bar = bars.by_tier.get(tier)
                bar_text = f"; bar {bar[0]:,.0f} B ({bar[1]})" if bar else ""
                print(
                    f"tier {tier:>5}: best {best.total:,.0f} B, {best.errors:,} errors, "
                    f"ops {best.ops_max}{bar_text}"
                )
            print(f"programs saved in {out}; run spend so far {usd(guard.run_spent())} USD")
            _promote(
                argparse.Namespace(
                    files=[str(p) for p in saved],
                    endgame="kpk",
                    prefix=f"{args.run}-",
                    name=None,
                    no_report=False,
                )
            )
    return 0


def _confirm_tty(amount: str, what: str) -> None:
    if not sys.stdin.isatty():
        sys.exit("Refused: this needs a person at a terminal. Run it yourself, not from a script.")
    want = budget.to_nusd(amount)
    answer = input(f"{what}\nType the amount again to confirm {budget.usd(want)} USD: ").strip()
    try:
        ok = budget.to_nusd(answer) == want
    except (ValueError, ArithmeticError):
        ok = False
    if not ok:
        sys.exit("Not confirmed, nothing changed.")


def _budget(args) -> int:
    g = budget.Guard(args.ledger)
    try:
        if args.cmd == "init":
            g.init(args.total, args.daily)
            print(f"initialised: total {args.total} USD, daily {args.daily} USD ({g.path})")
        elif args.cmd == "confirm":
            _confirm_tty(args.amount, "This raises TODAY's limit only.")
            g.grant(args.amount, "day", "confirmed in terminal")
        elif args.cmd == "topup":
            _confirm_tty(
                args.amount, "This raises the account TOTAL (after topping up in the Console)."
            )
            g.grant(args.amount, "total", "topup confirmed in terminal")
        if args.cmd != "init":
            s = g.status()
            print(
                f"{s['day']}  today {budget.usd(s['day_spent'])} / {budget.usd(s['day_limit'])} USD"
                f"  total {budget.usd(s['total_spent'])} / {budget.usd(s['total_limit'])} USD"
                f"  left to spend now {budget.usd(max(0, s['left']))} USD"
                f"  calls {s['calls'] or 'none'}"
            )
    except (ValueError, budget.BudgetExceeded) as e:
        print(e, file=sys.stderr)
        return 1
    return 0


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="chess-forces")
    sub = ap.add_subparsers(dest="group", required=True)
    sub.add_parser("kpk", help="build the KPK truth table and check its hash").set_defaults(fn=_kpk)
    sc = sub.add_parser("score", help="score a program file against its endgame")
    sc.add_argument("file", help="program text, or - for stdin")
    sc.add_argument(
        "--task",
        default=None,
        choices=sorted(endgames.ALL),
        help="endgame for files outside endgames/<name>/ (default kpk); a file inside takes its folder's",
    )
    sc.add_argument("--json", action="store_true")
    sc.set_defaults(fn=_score)
    sub.add_parser("spec", help="print the language").set_defaults(fn=_spec)
    sub.add_parser(
        "report", help="baselines, frontier and plot for KPK (about a minute)"
    ).set_defaults(fn=_report)
    sub.add_parser(
        "trees", help="retrain the decision-tree baselines and write endgames/kpk/trees/*.dsl"
    ).set_defaults(fn=_trees)
    pr = sub.add_parser(
        "promote", help="copy programs that beat their tier into the endgame's programs/ folder"
    )
    pr.add_argument("files", nargs="+")
    pr.add_argument("--endgame", default="kpk", choices=sorted(endgames.ALL))
    pr.add_argument("--prefix", default="", help="put before each file name, e.g. r2-")
    pr.add_argument("--name", action="append", help="file name in programs/ (once per file)")
    pr.add_argument("--no-report", action="store_true", help="do not rebuild the report")
    pr.set_defaults(fn=_promote)
    co = sub.add_parser("concepts", help="concept loop, docs/03-concept-loop.md")
    cosub = co.add_subparsers(dest="cmd", required=True)
    for name, text in (
        ("baseline", "free: trees over atoms, enumerated comparisons and r1's concepts"),
        ("run", "paid: a model proposes concepts, trees judge them"),
        ("compare", "free: the run's concepts against as many enumerated ones"),
    ):
        p = cosub.add_parser(name, help=text)
        p.add_argument("--keep", type=int, default=500, help="enumerated comparisons in the pool")
        if name != "baseline":
            p.add_argument("--run", default="c1")
        if name == "run":
            p.add_argument("--usd", required=True, help="hard limit for this run in USD")
            p.add_argument("--units", type=int, default=None, help="stop after this many calls")
            p.add_argument("--workers", type=int, default=8)
            p.add_argument("--model", default="claude-haiku-5-5")
            p.add_argument("--effort", default="medium", choices=["low", "medium", "high"])
            p.add_argument("--max-tokens", type=int, default=9000)
            p.add_argument("--plateau", type=int, default=200)
            p.add_argument("--min-bytes-per-usd", type=float, default=100.0)
    co.set_defaults(fn=_concepts)
    ev = sub.add_parser("evolve", help="run the search loop (spends API money)")
    ev.add_argument("--run", default="r1", help="name of the run; resumes when it exists")
    ev.add_argument("--usd", required=True, help="hard limit for this run in USD")
    ev.add_argument("--units", type=int, default=None, help="stop after this many proposals")
    ev.add_argument("--workers", type=int, default=24, help="parallel API calls")
    ev.add_argument("--scorers", type=int, default=10, help="scoring processes")
    ev.add_argument("--islands", default="64,256,1024,4096", help="operation tier of each island")
    ev.add_argument(
        "--plateau",
        type=int,
        default=200,
        help="close an island after this many units without a new best",
    )
    ev.add_argument("--no-repair", action="store_true")
    ev.add_argument("--seed", type=int, default=0)
    ev.add_argument("--effort", default="medium", choices=["low", "medium", "high"])
    ev.add_argument(
        "--max-tokens", type=int, default=9000, help="output limit per call, thinking included"
    )
    ev.add_argument("--model", default="claude-haiku-5-5")
    ev.add_argument("--show-prompt", action="store_true", help="print a prompt and stop, no call")
    ev.set_defaults(fn=_evolve)
    bud = sub.add_parser("budget", help="API spend limits")
    bud.add_argument(
        "--ledger",
        default=None,
        help="another ledger file, e.g. state/openrouter.sqlite (default: budget.sqlite)",
    )
    bsub = bud.add_subparsers(dest="cmd", required=True)
    init = bsub.add_parser("init", help="set the limits once")
    init.add_argument("--total", required=True, help="USD available in the Console account")
    init.add_argument("--daily", default=str(budget.DEFAULT_DAILY_USD), help="USD per day")
    bsub.add_parser("status", help="show spend and limits")
    for name, text in (("confirm", "allow more today"), ("topup", "raise the account total")):
        p = bsub.add_parser(name, help=text + " (needs a terminal)")
        p.add_argument("amount", help="USD")
    bud.set_defaults(fn=_budget)
    args = ap.parse_args(argv)
    return args.fn(args)


if __name__ == "__main__":
    sys.exit(main())
