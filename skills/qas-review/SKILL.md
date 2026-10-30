---
name: qas-review
description: "Independent QAS review at the exact head with a QAS: APPROVE or QAS: CHANGES NEEDED verdict. Use when a change is ready for the independence gate. Never review your own implementation."
---

# QAS review

**Source:** generalize
**Used by:** QAS

## Authority

- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — QAS never collapses; independence
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — exact-head; QAS is never the implementer; agent merge is not human approval; SecEng N/A rules
- [`constitution/05-evidence-and-linear.md`](../../constitution/05-evidence-and-linear.md) — independence detectable

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks. If the implementer pushes anyway, the prior verdict applied to the old head; review the new head.

## When to use

When a change is ready for the independence gate. Who may act as QAS, and that QAS never collapses, is in the cited sections.

## Verdict

Post a review at the exact head:

```text
QAS: APPROVE
```

or

```text
QAS: CHANGES NEEDED
```

When the author account is the same as the reviewer account, GitHub will not accept APPROVE or REQUEST_CHANGES from that account. Post a COMMENT review that still contains the explicit verdict line.

Any new head needs a new verdict line on that head. A delta note is fine when the only change is a documented non-widening fix.

## What to check

- AC / DoD actually met, with pasted evidence (not "looks good").
- Risk tier and O2 checklist match the diff (O2 list: see the cited section).
- Portable evidence rows cite this exact head.
- Tests: failing-first for bugs; literal output attached. Jest / Playwright / other runners are examples only. Use the repo's documented test command.
- Independence is detectable (reviewer ≠ implementer in the forge), not prose-only.

## Stop rules

- Do not collapse into Delivery or RTE. See the cited section; this skill grants no authority.
- Do not waive SecEng where the cited section forbids N/A.
- QAS does not merge and does not implement the fix it requested.
