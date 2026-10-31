# 06 — Empiricism

Techniques that win in controlled comparison replace prior defaults. Dogma retires with evidence.

## Comparison protocol

1. **Name the claim** — e.g. “default model M beats role→model cards on primary metric.”
2. **Define control vs candidate** — same Bolt shape, same risk tier, same seat map.
3. **Lock metrics** — primary from your defined success metrics; secondary latency/cost/error if useful.
4. **Run N≥2 comparable Units of Work** (or one Bolt with paired tasks).
5. **Publish decision pack** — winner, loser, keep/adapt/drop, next default.
6. **Update constitution / adapters** only after HITL concur on the pack.

## What we measure to retire dogma

| Dogma at risk | Measure |
| --- | --- |
| Freeze-the-train as safety | Release health + incident rate under decision packs |
| Runtime-specific evidence IDs | Portability failures across runtimes |
| Issue-tracker agents | Revisit only with comparison after initial validation |

## Keep / adapt / drop

Every empiricism pack ends with a three-column matrix. Defaults change only when **adapt** or **drop** is concurred.

## Stop rules

- Do not A/B production secrets or privacy-boundary crossings.
- High-tier O2 work is not an empiricism playground without the owner's recorded concur. Two distinct humans is recommended guidance, not a gate.
