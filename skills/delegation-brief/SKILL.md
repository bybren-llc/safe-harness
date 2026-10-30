---
name: delegation-brief
description: Write a cloud or sub-agent brief with scope, files, tier, stop rules, and evidence to return. Use when handing a bolt to an implementer or a nested agent.
---

# Delegation brief

**Source:** generalize
**Used by:** Delivery · Lead

## When to use

Before launching a cloud agent, a subagent, or an on-demand Implementer. The brief is the contract. Start from `templates/delivery-bolt-brief.md` and strip anything the delegate must not see (secrets, personal-store facts).

Model and provider defaults are not hardcoded here. Name **tiers** only (Orchestrator, Heavy, Light). Concrete models belong on the adapter's role→model card.

## Brief minimum

| Field | Content |
| --- | --- |
| Scope | In / out. One bolt. |
| Files | Paths the delegate may touch. Say what is forbidden (`constitution/`, `trace/`, `intent.md`, `spec.md`, workflow files, and anything the current PR forbids). |
| Tier + O2 | Low / Med / High and the O2 checklist. |
| Stop rules | No merge. Scanner not fixer. Freeze after QAS APPROVE. Own-words check. |
| Evidence to return | Portable rows, literal check output, PR URL, exact head. |

## Stop rules to copy into every brief

- Delivery and cloud agents never merge. Nobody merges their own authored change. An agent merge never counts as human approval.
- After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.
- A consequential action needs the human's own words verified. An agent relaying approval is never approval.
- Scanner, not fixer: file findings; no fix PRs without the HITL owner's explicit go.
- No public or external posts without the HITL owner's explicit OK.

## Stop rules for the author

- Do not put secret values or vault paths in the brief.
- Do not assign out-of-lane work. See [`lane-routing`](../lane-routing/SKILL.md).
- Escalate via Ops or the GM, not around them.
