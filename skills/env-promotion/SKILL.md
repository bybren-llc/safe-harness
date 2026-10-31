---
name: env-promotion
description: Apply the template default for environments — trunk merge rules, staging auto-promote, prod human gate for prod-risk, deploy freeze during demos. Use when promoting a change across environments.
license: MIT (see repository LICENSE)
---

# Environment promotion

**Source:** generalize
**Used by:** RTE, Delivery (adopters)

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — template default by environment; prod-risk list; deploy freeze during demos; rollback
- [`roles/release-rte.md`](../../roles/release-rte.md) — RTE on trunk vs promotion

See the cited section; this skill grants no authority.

**Practice guidance (not a constitutional rule):** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

The adopting repo has more than trunk. This template repo itself is trunk-only. Use this skill when helping an adopter, or when documenting promotion. Who may merge or promote, and what the prod-risk list is, lives only in the cited section.

## How to promote

1. Name the environment the adopter declared.
2. Open the cited "Template default by environment" and "Prod-risk" text.
3. Apply that row. Do not invent a seat or skip a gate this skill does not name.
4. Rehearse rollback first on high-risk deploys ([`rollback-rehearsal`](../rollback-rehearsal/SKILL.md)).

Migrations stay a prod-risk item in the cited section. This skill does not teach a vendor migration runner.

## Stop rules

- No machine-specific deploy steps, hostnames, or registries.
- Do not restate or widen merge authority here. See the cited section; this skill grants no authority.
