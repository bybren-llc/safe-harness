# 06 — Empiricism

Techniques that win in controlled comparison replace prior defaults. Dogma retires with evidence.

## Comparison protocol

1. **Name the claim** — e.g. “ultracode default beats role→model cards on M5.”
2. **Define control vs candidate** — same Bolt shape, same risk tier, same seat map.
3. **Lock metrics** — primary from M1–M6; secondary latency/cost/error if useful.
4. **Run N≥2 comparable Units of Work** (or one Bolt with paired tasks).
5. **Publish decision pack** — winner, loser, keep/adapt/drop, next default.
6. **Update constitution / adapters** only after HITL concur on the pack.

## What we measure to retire dogma

| Dogma at risk | Measure |
| --- | --- |
| Ultracode-as-default | Task success + time-to-exit vs O4 role→model cards |
| tmux/Dark Factory required | M2 happy path without tmux |
| Freeze-the-train as safety | M6 release health + incident rate under decision packs |
| Always-on 11 bots | Idle cost vs on-demand specialist latency (M5) |
| Claude-only evidence IDs | Portability failures across Cursor/Codex/Grok |
| Linear Agents | Explicitly out of Wave 0; revisit only with comparison after Wave 0 prove |

## Keep / adapt / drop

Every empiricism pack ends with a three-column matrix. Defaults change only when **adapt** or **drop** is concurred.

## Stop rules

- Do not A/B production secrets or privacy-boundary crossings.
- High-tier O2 work is not an empiricism playground without Scott's recorded concur. Two distinct humans is recommended guidance, not a gate.
- SAW `dev` remains reference until a comparison says otherwise — still no silent rewrite.
