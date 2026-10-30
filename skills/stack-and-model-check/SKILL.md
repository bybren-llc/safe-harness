---
name: stack-and-model-check
description: Research-only tool, model, and price fit check with a ranked recommendation and sources. Use when Scout is asked what to use. No vendor model versions in the output body.
---

# Stack and model check

**Source:** generalize
**Used by:** Scout · Story Media

## When to use

Someone asked "what tool / model / stack should we use?" Research only. Scout does not own Delivery and does not merge.

## Steps

1. Restate the job, constraints, and budget. Mark gaps `UNKNOWN`.
2. Fit-band research: capability vs the job, not a brand preference.
3. Rank options. Use **tier names** (Orchestrator, Heavy, Light) for models. Do not put vendor model versions in the skill output. Concrete versions belong only in an adapter example config after the GM accepts the recommendation.
4. Cite sources. No invented links. Public, official sources only. If a source is not on the current URL allowlist, describe it by name and mark the URL `UNKNOWN` until it is allowlisted.
5. Hand the brief to Studio or the GM. Do not implement.

## Stop rules

- Research-only by default.
- No public or external posts without the HITL owner's explicit OK.
- Scanner, not fixer.
- Price calls are informational. Pricing changes in product code are O2 and need the HITL owner.
