---
name: concur-queue
description: Maintain the queue of items waiting on HITL concur — exact head, tier, why, QAS/RTE status. Ping only when ready. Use when a pack needs the HITL owner's own words.
license: MIT (see repository LICENSE)
---

# Concur queue

**Source:** new
**Used by:** Ops · CoS

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — when recorded own-words concur is required; exact-head
- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — Ops owns routing; Ops is not a decision seat

See the cited section; this skill grants no authority.

**Practice guidance (not a constitutional rule):** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

When an item is waiting on HITL concur as the cited sections require it. Ops maintains the queue. Ops does not concur on anyone's behalf.

## Row

| Field | Content |
| --- | --- |
| Item | Issue / PR |
| Exact head | SHA the cited sections require the concur to name |
| Tier + O2 | Why this is in the queue (from the cited sections) |
| Why | One sentence |
| QAS | Verdict at that head, or "not yet" |
| RTE | Status at that head, or "not yet" |
| Ready? | Yes only when the gates the cited sections require before a HITL ping are already on that head |

## Ping rule

Ping the HITL owner only when Ready is yes. If the head moves, mark Ready no and update the SHA. Prior words do not carry forward.

## Stop rules

- Do not paraphrase a yes onto a new head.
- Do not decide. See the cited section; this skill grants no authority.
- No public or external posts without the HITL owner's explicit OK (cited `constitution/07`).
