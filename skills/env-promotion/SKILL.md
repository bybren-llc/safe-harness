---
name: env-promotion
description: Apply the template default for environments — trunk merge rules, staging auto-promote, prod human gate for prod-risk, deploy freeze during demos. Use when promoting a change across environments.
---

# Environment promotion

**Source:** generalize
**Used by:** RTE, Delivery (adopters)

## When to use

The adopting repo has more than trunk. `constitution/03` is the template default. Adopters declare their own environment names.

This template repo itself is trunk-only. Use this skill when helping an adopter, or when documenting promotion.

## Template default

| Environment | Who may merge / promote | Gate |
| --- | --- | --- |
| Dev or trunk | Authorized merge seats under `constitution/03` | Checks green + independent QAS APPROVE at exact head; RTE PASS at Med/High/O2 (and whenever RTE merges); HITL own-words concur for constitution / High / O2 |
| Staging | Automatic promotion | Tests pass |
| Prod | Human gate: HITL owner's recorded own-words concur | Prod-risk items only |

## Prod-risk (prod-promotion gate, not a second trunk gate)

Migrations, money / pricing / refunds, auth / permissions, deploy CI / workflows, prod secrets, privacy-boundary (O2). Deploy freeze during demos.

Migrations stay a prod-risk item here. This skill does not teach a vendor migration runner.

## Stop rules

- No machine-specific deploy steps, hostnames, or registries.
- Delivery and cloud agents never merge.
- A consequential action needs the human's own words verified. An agent relaying approval is never approval.
- Rollback is first-class. See [`rollback-rehearsal`](../rollback-rehearsal/SKILL.md).
