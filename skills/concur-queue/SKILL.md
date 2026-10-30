---
name: concur-queue
description: Maintain the queue of items waiting on HITL concur — exact head, tier, why, QAS/RTE status. Ping only when ready. Use when a pack needs the HITL owner's own words.
---

# Concur queue

**Source:** new
**Used by:** Ops · CoS

## When to use

An item needs the HITL owner's recorded own-words concur (`constitution/`, High, O2, prod-risk, or a named ask). Ops maintains the queue. Ops does not concur on their behalf.

## Row

| Field | Rule |
| --- | --- |
| Item | Issue / PR |
| Exact head | SHA the concur must name |
| Tier + O2 | Why this is in the queue |
| Why | One sentence |
| QAS | Verdict at that head, or "not yet" |
| RTE | PASS / HOLD / checklist / "not yet" |
| Ready? | Yes only when QAS (and RTE, when required) are already on that head |

## Ping rule

Ping the HITL owner only when Ready is yes. A half-ready pack wastes the human gate.

If the head moves, mark Ready no and update the SHA. Prior words do not carry forward.

## Stop rules

- Do not paraphrase a yes onto a new head.
- A consequential action needs the human's own words verified. An agent relaying approval is never approval.
- No public or external posts without the HITL owner's explicit OK.
