# Model Stack

**A single maximum-capability model is NOT the default.** It may appear as one of many options after empiricism wins — never as the initial baseline.

## Default tiers

| Tier | Use |
| --- | --- |
| **Orchestrator** | Seat coordination, Bolt planning, handoff acceptance, decision-pack assembly |
| **Heavy** | Architecture, high-ambiguity implement, SecEng deep review, hard QAS |
| **Light** | Research gather, confirmations, QAS routine checks, info lookups |

Complexity rule for Heavy: prefer the strongest Heavy model when ambiguity, security, or cross-spine design is high; a lighter Heavy model for scoped implementation with clear AC.

## Role → model (every vendor harness)

Every adapter must publish a role→model card. No harness may silently override to a single maximum-capability default.

| Role / seat | Default tier |
| --- | --- |
| the GM / ARCHitect | Orchestrator (+ Heavy for deep design) |
| Delivery · Lead | Orchestrator |
| Studio · Lead | Orchestrator |
| Ops · CoS | Orchestrator |
| Dispatcher · Board | Light (read-only sweep) |
| Implementer | Heavy |
| QAS | Light routine / Heavy when independence risk high |
| SecEng | Heavy |
| BSA-like | Light → Orchestrator if AC shaping spans spines |
| Release · RTE (No at Med+) | Light |
| Librarian / Scout | Light (research); Orchestrator only when synthesizing handoff pins |

## Stop rules

- Do not set a single maximum-capability model as Project/team default.
- Do not use Light tier alone for O2 high-risk construction.
- Empiricism may change this table; constitution update requires HITL concur.
