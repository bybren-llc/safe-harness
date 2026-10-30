---
name: stack-and-model-check
description: Research-only tool, model, and price fit check with a ranked recommendation and sources. Use when Scout is asked what to use. No vendor model versions in the output body.
---

# Stack and model check

**Source:** generalize
**Used by:** Scout · Story Media

## Authority

- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — Scout is research-only; not a merge seat
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — pricing as O2

See the cited section; this skill grants no authority.

## When to use

Someone asked "what tool / model / stack should we use?" Research only.

## Steps

1. Restate the job, constraints, and budget. Mark gaps `UNKNOWN`.
2. Fit-band research: capability vs the job, not a brand preference.
3. Rank options. Use **tier names** (Orchestrator, Heavy, Light) for models. Do not put vendor model versions in the skill output. Concrete versions belong only in an adapter example config after the GM accepts the recommendation.
4. Cite sources. No invented links. Public, official sources only. If a source is not on the current URL allowlist, describe it by name and mark the URL `UNKNOWN` until it is allowlisted.
5. Hand the brief to Studio or the GM. Do not implement.

## Stop rules

- Research-only by default. See the cited section; this skill grants no authority.
- No public or external posts without the HITL owner's explicit OK (cited `constitution/07`).
- Scanner, not fixer (cited `constitution/07`).
- Price calls are informational. Product pricing changes follow the cited O2 section.
