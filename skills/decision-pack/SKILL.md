---
name: decision-pack
description: Assemble the constitution/03 decision-pack minimum for a Med or High change. Use when a bolt needs human approve / change-request / escalate at an exact head.
license: MIT (see repository LICENSE)
---

# Decision pack

**Source:** new
**Used by:** Delivery, GM

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — decision-pack minimum; tiers; O2; when QAS / SecEng may be N/A
- [`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md) — portable evidence fields

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

When a change needs a human decision pack. Whether a tier requires a pack, and what "minimum" means, is in the cited section. This skill is an assembly checklist, not a new gate.

## Fields to assemble

Copy the field list from the cited "Decision pack minimum" section. Typical contents (pointer only):

- GitHub Issue (SoR)
- Exact-head SHA / PR
- Evidence IDs ([`portable-evidence`](../portable-evidence/SKILL.md))
- Requirements (`REQ-<CMP>-NNN` list, or an explicit "none in spec yet" line)
- QAS + SecEng status as the cited section allows
- SecEng: <review-id> PASS at <sha>
- Risk tier + O2 checklist
- Ask: approve / change-request / escalate

## How to ask

State the ask in one sentence. If the cited section requires the HITL owner's concur, ask them to write it in their own words at the exact head. See [`hitl-concur-check`](../hitl-concur-check/SKILL.md).

## Stop rules

- Never quote private chat. Quote the HITL owner's own words only with a timestamp and their OK.
- Do not put secret values, vault paths, or personal-store facts in the pack.
- Do not resolve open constitution questions in the pack. Leave them open.
- Do not merge from a pack. See the cited section; this skill grants no authority.
