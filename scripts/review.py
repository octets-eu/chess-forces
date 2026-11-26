"""Reviewer models on rejected programs: paid, through OpenRouter and the spend guard.

Each model gets the language, up to ten programs that were rejected for using too many operations
(from scripts/rejected.py), and is asked to pick three, predict their total and write versions that
fit. Every answer is scored exactly. Prices come from OpenRouter's live model list and are entered
into the guard before any call; every call goes through Guard.run with a hard limit for this run.

The OpenRouter ledger is separate from the Anthropic one and only a person sets its limits:

    uv run chess-forces budget --ledger state/openrouter.sqlite init --total 1
    uv run python scripts/review.py --items state/run-r1/rejected.json --usd 0.30 --run review2

Needs OPENROUTER_API_KEY. First try (2026-11-25, five models, ten items): one useful variant
(GPT-5.4 mini, 4,472 B at 388 operations), no improvement over the best force program.
"""

import argparse
import json
import os
import re
import time
import urllib.error
import urllib.request
from pathlib import Path

from chess_forces import budget, dsl, endgames, search
from chess_forces.budget import BudgetExceeded, Guard, NotBilled, Rate, exit_on_budget
from chess_forces.score import OverBudget

API = "https://openrouter.ai/api/v1"
MODELS = [
    "anthropic/claude-haiku-5.5",
    "deepseek/deepseek-v4-pro-0813",
    "google/gemini-3.8-flash",
    "openai/gpt-5.4-mini",
    "anthropic/claude-sonnet-5.5",
]
PICK = re.compile(
    r"PICK\s+(\d+)\s*\n+PREDICTED_TOTAL\s+([\d.,]+)[^\n]*\n+REASON\s+([^\n]*)\n+\x60\x60\x60[a-z]*\n(.*?)\x60\x60\x60",
    re.DOTALL | re.IGNORECASE,
)


def register_prices(models: list[str]) -> None:
    live = {
        m["id"]: m for m in json.load(urllib.request.urlopen(f"{API}/models", timeout=30))["data"]
    }
    for m in models:
        p = live[m]["pricing"]
        i, o = float(p["prompt"]) * 1e9, float(p["completion"]) * 1e9
        budget.PRICES["or:" + m] = (
            (None, Rate(round(i), round(i * 1.25), round(i * 2), round(i), round(o))),
        )


def choose(items: list[dict]) -> list[dict]:
    near = sorted([i for i in items if i["ops"] <= 1.1 * i["limit"]], key=lambda i: i["total"])[:6]
    wide = sorted([i for i in items if i["ops"] > 1.1 * i["limit"]], key=lambda i: i["total"])[:4]
    return (near + wide)[:10]


def prompt(items: list[dict]) -> str:
    out = [
        (
            "You are reviewing programs that were rejected ONLY because they need too many operations. Each has a "
            "limit; its worst-case operations (counting 32 for exception lookup) must be at or below the limit. "
            "Programs are judged by total bytes (program size plus exceptions); smaller is better."
        ),
        "",
    ]
    for n, i in enumerate(items, 1):
        out += [
            (
                f"### Item {n}: limit {i['limit']}, uses {i['ops']} operations, total {i['total']:,.0f} bytes "
                f"({i['prog']:.0f} program), {i['errors']:,} errors"
            ),
            "\x60\x60\x60python",
            i["text"].strip(),
            "\x60\x60\x60",
            "Largest error groups: " + "; ".join(f"{lbl} {c:,}" for lbl, c, _ in i["clusters"]),
            "",
        ]
    out += [
        (
            "Choose the THREE items whose idea can be kept while fitting the limit and that promise the lowest "
            "total. For each, write an edited program that fits its limit, and predict the total bytes it will "
            "reach (be realistic; most edits gain little). Answer exactly in this format, three times, nothing else:"
        ),
        "PICK <item number>",
        "PREDICTED_TOTAL <bytes>",
        "REASON <one sentence>",
        "\x60\x60\x60python",
        "<program>",
        "\x60\x60\x60",
    ]
    return "\n".join(out)


def caller(model: str, system: str, user: str, key: str):
    def call(_handle):
        body = {
            "model": model,
            "max_tokens": 10000,
            "messages": [{"role": "system", "content": system}, {"role": "user", "content": user}],
            "usage": {"include": True},
            "provider": {"data_collection": "deny"},
            "reasoning": {"effort": "medium"},
        }
        req = urllib.request.Request(
            f"{API}/chat/completions",
            data=json.dumps(body).encode(),
            headers={"Authorization": "Bearer " + key, "Content-Type": "application/json"},
        )
        try:
            d = json.load(urllib.request.urlopen(req, timeout=300))
        except urllib.error.HTTPError as e:
            raise NotBilled(f"HTTP {e.code}: {e.read()[:200]}") from None
        if "choices" not in d:
            raise NotBilled(str(d)[:200])
        c, u = d["choices"][0], d.get("usage", {})
        usage = {
            "input_tokens": u.get("prompt_tokens", 0),
            "output_tokens": u.get("completion_tokens", 0),
        }
        value = {
            "text": c["message"].get("content") or "",
            "stop": c.get("finish_reason"),
            "cost": u.get("cost"),
            "reasoning_tokens": (u.get("completion_tokens_details") or {}).get("reasoning_tokens"),
            "served_by": d.get("provider"),
        }
        return value, usage

    return call


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--items", required=True, help="rejected.json from scripts/rejected.py")
    ap.add_argument("--usd", required=True, help="hard limit for this run in USD")
    ap.add_argument("--run", default="review2", help="name of this review; resumes when it exists")
    ap.add_argument("--models", default=",".join(MODELS))
    ap.add_argument("--ledger", default=str(budget.default_path().parent / "openrouter.sqlite"))
    args = ap.parse_args()
    key = os.environ.get("OPENROUTER_API_KEY", "").strip()
    if not key:
        raise SystemExit("OPENROUTER_API_KEY is not set")
    models = args.models.split(",")
    register_prices(models)
    guard = Guard(Path(args.ledger), run=args.run, run_limit_usd=args.usd)
    items = choose(json.loads(Path(args.items).read_text()))
    system, user = search.system_text(), prompt(items)
    ev = search.Evaluator(endgames.KPK.task())
    report = []
    with exit_on_budget():
        for m in models:
            t = time.time()
            try:
                ans = guard.run(
                    f"{args.run}/{m}",
                    "or:" + m,
                    len(system + user) // 3,
                    10000,
                    caller(m, system, user, key),
                )
            except (NotBilled, BudgetExceeded) as e:
                print(m, "failed:", str(e)[:200])
                continue
            picks = []
            for n, pred, _why, code in PICK.findall(ans["text"]):
                item = items[int(n) - 1] if 0 < int(n) <= len(items) else None
                if item is None:
                    picks.append({"item": n, "error": "no such item"})
                    continue
                try:
                    s = ev.evaluate(code.strip() + "\n")
                except (dsl.DslError, OverBudget) as e:
                    picks.append({"item": int(n), "error": f"{type(e).__name__}: {str(e)[:60]}"})
                    continue
                picks.append(
                    {
                        "item": int(n),
                        "unit": item["unit"],
                        "limit": item["limit"],
                        "orig_total": item["total"],
                        "predicted": float(pred.replace(",", "")),
                        "total": round(s.total, 1),
                        "ops": s.ops_max,
                        "fits": s.ops_max <= item["limit"],
                        "text": code.strip() + "\n",
                    }
                )
            report.append(
                {
                    "model": m,
                    "seconds": round(time.time() - t),
                    "cost": ans["cost"],
                    "stop": ans["stop"],
                    "picks": picks,
                }
            )
            print(json.dumps({k: v for k, v in report[-1].items() if k != "picks"}), flush=True)
    out = budget.default_path().parent / f"{args.run}.json"
    out.write_text(json.dumps({"items": [i["unit"] for i in items], "report": report}, indent=1))
    print(f"wrote {out}")


if __name__ == "__main__":
    main()
