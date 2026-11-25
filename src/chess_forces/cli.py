"""chess-forces command line: KPK table and API budget."""

import argparse
import sys
import time
from pathlib import Path

from . import budget, kpk


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
        t0 = time.perf_counter()
        task = scoring.TASKS[args.task]()
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
    from .search import SearchStopped

    state = default_path().parent
    archive = search.Archive(state / f"search-{args.run}.sqlite")
    settings = search.Settings(
        run=args.run,
        workers=args.workers,
        effort=args.effort,
        model=args.model,
        max_tokens=args.max_tokens,
    )
    evaluator = search.Evaluator(score.kpk_task())
    bars = search.Bars.load(Path(__file__).resolve().parents[2] / "reports" / "kpk.json")
    if args.show_prompt:
        s = search.Search(settings, Guard(), None, archive, evaluator, bars)
        s.seed()
        print(s.system + "\n\n=== user prompt, island 0 ===\n\n" + s.user_prompt(0)[0])
        return 0
    import anthropic

    client = anthropic.Anthropic(api_key=api_key(), max_retries=0, timeout=180)
    guard = Guard(run=args.run, run_limit_usd=args.usd)
    s = search.Search(settings, guard, client, archive, evaluator, bars)
    with exit_on_budget():
        try:
            s.run(args.units, progress=lambda m: print(m, flush=True))
        except SearchStopped as e:
            print(f"stopped: {e}", file=sys.stderr)
        finally:
            print(s.summary())
            out = state / f"run-{args.run}"
            out.mkdir(exist_ok=True)
            for tier, best in archive.best_per_tier().items():
                (out / f"best-{tier}.dsl").write_text(best.text)
                bar = bars.by_tier.get(tier)
                bar_text = f"; bar {bar[0]:,.0f} B ({bar[1]})" if bar else ""
                print(
                    f"tier {tier:>5}: best {best.total:,.0f} B, {best.errors:,} errors, "
                    f"ops {best.ops_max}{bar_text}"
                )
            print(f"programs saved in {out}; run spend so far {usd(guard.run_spent())} USD")
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
    g = budget.Guard()
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
    sc = sub.add_parser("score", help="score a program file against a task")
    sc.add_argument("file", help="program text, or - for stdin")
    sc.add_argument("--task", default="kpk", choices=["kpk"])
    sc.add_argument("--json", action="store_true")
    sc.set_defaults(fn=_score)
    sub.add_parser("spec", help="print the language").set_defaults(fn=_spec)
    sub.add_parser(
        "report", help="baselines, frontier and plot for KPK (about a minute)"
    ).set_defaults(fn=_report)
    ev = sub.add_parser("evolve", help="run the search loop (spends API money)")
    ev.add_argument("--run", default="r1", help="name of the run; resumes when it exists")
    ev.add_argument("--usd", required=True, help="hard limit for this run in USD")
    ev.add_argument("--units", type=int, default=None, help="stop after this many proposals")
    ev.add_argument("--workers", type=int, default=8)
    ev.add_argument("--effort", default="medium", choices=["low", "medium", "high"])
    ev.add_argument(
        "--max-tokens", type=int, default=9000, help="output limit per call, thinking included"
    )
    ev.add_argument("--model", default="claude-haiku-5-5")
    ev.add_argument("--show-prompt", action="store_true", help="print a prompt and stop, no call")
    ev.set_defaults(fn=_evolve)
    bud = sub.add_parser("budget", help="API spend limits")
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
