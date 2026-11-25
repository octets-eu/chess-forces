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
