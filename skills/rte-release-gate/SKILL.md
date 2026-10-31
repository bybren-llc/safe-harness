---
name: rte-release-gate
description: Run the per-PR RTE PASS/HOLD checklist at the exact head. Use when Delivery sends a ready-for-release packet. Verifies evidence; does not re-review code.
license: MIT (see repository LICENSE)
---

# RTE release gate

**Source:** generalize
**Used by:** Release · RTE

## Authority

- [`roles/release-rte.md`](../../roles/release-rte.md) — gate mechanics, checklist, HOLD, notes, merge conditions
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — merge authority, RTE placement, HOLD override
- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — RTE non-collapse at Med+

See the cited section; this skill grants no authority.

**Practice guidance (not a constitutional rule):** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks. A new push is a new head; re-run the cited checklist there.

## When to use

When Delivery sends a ready-for-release packet. This skill is a pointer to the cited role card and constitution sections. It does not add a verdict, time box, or merge right.

## How to run

1. Open the cited role card and constitution sections.
2. Apply the checklist and verdict (PASS / HOLD, or the Low annotated checklist) as written there.
3. Verify evidence; do not re-review code.
4. Record the verdict on the exact head.

## Stop rules

- Do not author product changes from this seat.
- Do not invent HOLD-override or merge rules. See the cited section; this skill grants no authority.
- No public or external posts without the HITL owner's explicit OK ([`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md)).
