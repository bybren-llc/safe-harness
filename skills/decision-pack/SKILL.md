---
name: decision-pack
description: Assemble the constitution/03 decision-pack minimum for a Med or High change. Use when a bolt needs human approve / change-request / escalate at an exact head.
---

# Decision pack

**Source:** new
**Used by:** Delivery, GM

## When to use

Med and High (including O2) changes need a human decision pack. Low may skip the pack when tests and evidence types are met, but a pack is still valid if the ask is unclear.

`constitution/03` is the rule. This skill only lists the minimum fields.

## Minimum fields

| Field | Rule |
| --- | --- |
| GitHub Issue | Link the SoR issue. Do not open a tracker row in an optional external tracker as a substitute. |
| Exact-head SHA / PR | The head under review. Later commits void prior QAS/SecEng until delta-confirmed. |
| Evidence IDs | Portable rows. See [`portable-evidence`](../portable-evidence/SKILL.md). |
| Requirements | `REQ-<CMP>-NNN` list, or an explicit "none in spec yet" line. |
| QAS status | pass / change-request / N/A. N/A is Low only and needs a rationale. |
| SecEng status | Same. High/O2: never N/A and cannot be waived. |
| Risk tier + O2 checklist | Tick each O2 item. Record any GM downgrade in writing. |
| Ask | approve / change-request / escalate |

## How to ask

State the ask in one sentence. If the HITL owner must concur, ask them to write the concur in their own words at the exact head.

A consequential action needs the human's own words verified. An agent relaying approval is never approval. See [`hitl-concur-check`](../hitl-concur-check/SKILL.md).

## Stop rules

- Never quote private chat. Quote the HITL owner's own words only with a timestamp and their OK.
- Do not put secret values, vault paths, or personal-store facts in the pack.
- Do not resolve open constitution questions in the pack. Leave them open.
- Delivery never merges on the back of a pack. Merge execution follows `constitution/03`.
