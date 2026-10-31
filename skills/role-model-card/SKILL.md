---
name: role-model-card
description: Publish and keep a role-to-model-tier card per adapter. Use when adding an adapter or changing defaults. Ultracode is not the default. Do not run Light-only on O2 construction.
license: MIT (see repository LICENSE)
---

# Role → model-tier card

**Source:** generalize
**Used by:** GM, adapter maintainers

## Authority

- [`constitution/06-empiricism.md`](../../constitution/06-empiricism.md) — defaults change only after HITL concur on the pack
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — O2 construction is not Light-only work

See the cited section; this skill grants no authority. The seat→tier table below is a template pointer at [`roles/model-stack.md`](../../roles/model-stack.md), not a new lock.

## When to use

Every adapter publishes a role→tier card. No harness silently overrides the card to a single "always maximum" default.

## Tiers only

| Tier | Use |
| --- | --- |
| Orchestrator | Seat coordination, bolt planning, handoff acceptance, decision-pack assembly |
| Heavy | Architecture, high-ambiguity implement, SecEng deep review, hard QAS |
| Light | Research gather, confirmations, routine the GM, lookups |

Concrete model names and versions belong only in the adapter's **example config**, not in this skill and not as a repo-wide default.

## Default seat → tier (template)

| Seat | Default tier |
| --- | --- |
| GM / lead architect | Orchestrator (+ Heavy for deep design) |
| Delivery · Lead | Orchestrator |
| Studio · Lead | Orchestrator |
| Ops · CoS | Orchestrator |
| Dispatcher · Board | Light |
| Implementer | Heavy |
| QAS | Light routine / Heavy when independence risk is high |
| SecEng | Heavy |
| BSA-like | Light; Orchestrator if AC spans spines |
| Release · RTE | Light (notes) / Heavy not required for the evidence checklist |
| Librarian / Scout | Light (research); Orchestrator only when synthesizing a handoff |

## Stop rules

- Ultracode is not the default (see the model-stack role card).
- Do not use Light alone for O2 construction. See the cited section; this skill grants no authority.
- Do not put vendor model versions in the skill body.
- Changing defaults is an empiricism pack plus HITL concur as the cited `constitution/06` section requires.
