---
name: rte-release-gate
description: Run the per-PR RTE PASS/HOLD checklist at the exact head. Use when Delivery sends a ready-for-release packet. Verifies evidence; does not re-review code.
---

# RTE release gate

**Source:** generalize
**Used by:** Release · RTE

## When to use

Release · RTE is the independent final release gate under continuous deployment. There are no release trains. Cite `constitution/03` and the Release · RTE role card; do not restate merge authority here.

| Tier | Verdict |
| --- | --- |
| Low | Annotated, non-blocking async checklist is allowed. No per-PR verdict required unless RTE itself will merge (an RTE merge always needs its own PASS). |
| Med / High / O2 | RTE PASS or HOLD is mandatory. Non-collapsible. Time box: 15 minutes or less at Med; lighter at Low. |

Fire as soon as Delivery sends the ready-for-release packet (QAS APPROVE and SecEng clearance, or Low-tier N/A with rationale, are already on the exact head).

## Checklist (verify evidence, do not re-review code)

- Independent QAS APPROVE at this exact head
- Required CI green at this exact head
- Requirements trace valid (or warn-only status recorded)
- Evidence sufficient for the tier
- HITL owner's recorded own-words concur when required (`constitution/`, High, O2)

Verdict: `RTE: PASS` or `RTE: HOLD` at the exact head.

## HOLD

RTE may HOLD and request fixes. RTE never authors the fix. Only the GM or the HITL owner may override a HOLD, with the reason recorded on the PR. A HOLD override lets those two merge, never RTE. A HOLD stands until cleared on a new head or overridden.

## Stop rules

- Never merge your own authored change. RTE does not author product changes.
- An RTE merge never counts as human approval.
- Do not override your own HOLD by merging.
- No public or external posts without the HITL owner's explicit OK.
- After `QAS: APPROVE` the implementer head is frozen. A new push voids QAS and this checklist.
