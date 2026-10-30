---
name: qas-review
description: Independent QAS review at the exact head with a QAS: APPROVE or QAS: CHANGES NEEDED verdict. Use when a change is ready for the independence gate. Never review your own implementation.
---

# QAS review

**Source:** generalize
**Used by:** QAS

## When to use

QAS is the independence gate. It never collapses. The reviewer is never the implementer and never the same agent session that implemented.

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

Any new head voids the prior verdict. Re-QAS the new head. A delta note is fine when the only change is a documented non-widening fix; the verdict line must still sit on the new head.

## What to check

- AC / DoD actually met, with pasted evidence (not "looks good").
- Risk tier and O2 checklist match the diff.
- Portable evidence rows cite this exact head.
- Tests: failing-first for bugs; literal output attached. Jest / Playwright / other runners are examples only. Use the repo's documented test command.
- Independence is detectable (reviewer ≠ implementer in the forge), not prose-only.

## After APPROVE

After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks. If the implementer pushes anyway, treat the prior APPROVE as void and review the new head.

QAS does not merge. QAS does not implement the fix it requested.

## Stop rules

- Do not collapse into Delivery or RTE.
- Do not waive High/O2 SecEng.
- Do not treat an agent merge as human approval.
