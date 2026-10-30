---
name: delegation-brief
description: Write a cloud or sub-agent brief with scope, files, tier, stop rules, and evidence to return. Use when handing a bolt to an implementer or a nested agent.
license: MIT (see repository LICENSE)
---

# Delegation brief

**Source:** generalize
**Used by:** Delivery · Lead

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — merge execution; Delivery and cloud agents; exact-head
- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — lane owners; scanner, not fixer
- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — QAS / SecEng independence

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

Before launching a cloud agent, a subagent, or an on-demand Implementer. The brief is the contract. Start from `templates/delivery-bolt-brief.md` and strip anything the delegate must not see (secrets, personal-store facts).

Model and provider defaults are not hardcoded here. Name **tiers** only (Orchestrator, Heavy, Light). Concrete models belong on the adapter's role→model card.

## Brief minimum

| Field | Content |
| --- | --- |
| Scope | In / out. One bolt. |
| Files | Paths the delegate may touch. Say what the current PR and the cited sections forbid (`constitution/`, `trace/`, `intent.md`, `spec.md`, workflow files, as applicable). |
| Tier + O2 | Low / Med / High and the O2 checklist from the cited section. |
| Stop rules | Point at the cited sections plus the two working-practice lines above. |
| Evidence to return | Portable rows, literal check output, PR URL, exact head. |

## Stop rules to copy into every brief

Copy the Authority block (cited sections + the two working-practice lines). Do not invent extra merge or concur rights. See the cited section; this skill grants no authority.

Also: no public or external posts without the HITL owner's explicit OK (cited `constitution/07`).

## Stop rules for the author

- Do not put secret values or vault paths in the brief.
- Do not assign out-of-lane work. See [`lane-routing`](../lane-routing/SKILL.md).
- Escalate via Ops or the GM, not around them.
