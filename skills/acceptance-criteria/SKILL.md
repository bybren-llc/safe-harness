---
name: acceptance-criteria
description: Shape acceptance criteria, definition of done, and a demo script when a bolt lacks clarity. Use before construction when AC is missing or untestable. Defer O2 scope to the HITL owner.
---

# Acceptance criteria

**Source:** generalize
**Used by:** BSA-like, Studio

## Authority

- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — human validate; QAS is not BSA-like
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — O2 list; defer O2 scope

See the cited section; this skill grants no authority.

## When to use

A bolt or handoff lacks testable AC or DoD. BSA-like shapes them. BSA-like does not replace QAS and does not invent source pins.

## Required shape

- User-visible outcome (who, what, done-when)
- Testable AC checklist (pass/fail, not "should be nice")
- DoD (checks, evidence types, demo script)
- Success command: the repo's documented check or test command
- O2 scan: if the AC implies an item on the cited O2 list, stop and defer scope. See the cited section; this skill grants no authority.

## Steps

1. Read the handoff or issue. If AC is already testable, do not rewrite it.
2. Check the adopter's pattern library and nearby specs. See [`pattern-discovery`](../pattern-discovery/SKILL.md).
3. Draft AC / DoD / demo. Mark unknowns `UNKNOWN`.
4. Hand back to Studio or Delivery. Construction waits for the human-validate step when the cited sections require it.

## Stop rules

- Do not invent vault or store paths.
- Do not expand O2 scope. See the cited section; this skill grants no authority.
- Do not collapse into QAS. See the cited `constitution/02` section.
