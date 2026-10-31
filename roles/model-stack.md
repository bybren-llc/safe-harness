# Model Stack (O4)

**Ultracode is NOT the default.** It may appear as one of many options after empiricism wins — never as the Wave 0 baseline.

## Default tiers

| Tier | Default models | Use |
| --- | --- | --- |
| **Orchestrator** | Fable 5.1+ | Seat coordination, Bolt planning, handoff acceptance, decision-pack assembly |
| **Heavy** | Opus 5.5 / Sonnet 5.5 by complexity | Architecture, high-ambiguity implement, SecEng deep review, hard QAS |
| **Light** | Haiku 5.5 | Research gather, confirmations, QAS routine checks, info lookups |

Complexity rule for Heavy: prefer **Opus 5.5** when ambiguity, security, or cross-spine design is high; **Sonnet 5.5** when scoped implement with clear AC.

## Role → model (every vendor harness)

Every adapter must publish a role→model card. No harness may silently override to ultracode-as-default.

| Role / seat | Default tier |
| --- | --- |
| the GM / ARCHitect | Orchestrator (+ Heavy for deep design) |
| Delivery · Lead | Orchestrator |
| Studio · Lead | Orchestrator |
| Ops · CoS | Orchestrator |
| Dispatcher · Board | Light (read-only sweep) |
| Implementer | Heavy (Sonnet default; Opus if complex) |
| QAS | Light routine / Heavy when independence risk high |
| SecEng | Heavy |
| BSA-like | Light → Orchestrator if AC shaping spans spines |
| RTE (collapsible) | Light |
| Librarian / Scout | Light (research); Orchestrator only when synthesizing handoff pins |

## Stop rules

- Do not set ultracode as Project/team default.
- Do not use Light tier alone for O2 high-risk construction.
- Empiricism may change this table; constitution update requires HITL concur.
