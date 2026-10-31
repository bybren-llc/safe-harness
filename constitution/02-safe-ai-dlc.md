# 02 — SAFe + AI-DLC Cadence

Cadence spine = **SAFe structure + AI-DLC Bolt** patterns (ownership/cadence), not SAFe trademark ceremony.

## Units

| Unit | Meaning |
| --- | --- |
| **Bolt** | Time-boxed delivery unit with exit on **evidence**, not a date |
| **Unit of Work** | Ticket-sized ownership chunk inside a Bolt |
| **Mob Elaboration** | Shared shaping before construction when risk/ambiguity is high |
| **Human validate** | Business-context HITL before construction on policy / secrets / risk |

## Human gate before construction

AI-DLC rule: humans validate business context before agents build when the change touches policy, pricing, auth, secrets, privacy boundaries, or unclear AC. Low-risk green path may auto-flow per risk tier (`03-cd-and-hitl.md`).

## Role collapsing

| Role | Collapsible? | Rule |
| --- | --- | --- |
| **RTE** | **No at Med+** | Release · RTE is an independent final release gate under continuous deployment (no trains). At Low, an annotated, non-blocking async RTE checklist is allowed, with no per-PR verdict required. At Med, High and O2, RTE PASS or HOLD is mandatory. RTE stays non-collapsible at Med+. It runs a per-PR release check with an RTE PASS or HOLD verdict, time-boxed to 15 minutes or less at Medium and lighter at Low. It fires as soon as Delivery sends its ready-for-release packet. It owns release notes and tagging after the HITL's release concur. Product releases use SemVer tags (`vMAJOR.MINOR.PATCH`). Per-merge tags use `vYYYY.MM.DD-<shortsha>` (date in America/New_York, 7-char merge SHA). It verifies evidence instead of re-reviewing code. On trunk it may merge once checks are green and the GM's independent QAS APPROVE, SecEng PASS (or PASS-with-notes), and its own RTE PASS are on the exact head (Low may mark SecEng N/A with rationale); the owner's recorded concur is required for constitution/, High, and O2. It never merges its own change. An RTE merge never counts as human approval. See [`roles/release-rte.md`](../roles/release-rte.md). |
| **QAS** | **Never** | Separate actor; iteration authority; independence gate. |
| **SecEng** | **Never** | Negative authority; can stop-the-line for that unit. |
| System Architect Stage 1 ↔ ARCHitect Stage 2 | Per the GM/the owner lock | the GM leads; do not invent collapse without concur. |

## Independence forever

QAS and SecEng independence is a standing rule across every vendor harness. Provider mirrors must not grant merge to Delivery or cloud agents, and must not treat an agent merge as human approval. Authorized trunk mergers are the GM and Release · RTE under [`03-cd-and-hitl.md`](03-cd-and-hitl.md). Detectable independence > prose-only culture.

## the GM leads

the GM = GM / lead ARCHitect. Not TDM. the GM handles High-tier or cross-lane work only. Delivery · Lead owns projects end to end under the GM’s locks; escalate Ops · CoS or the GM. Lane map: [`07-roles-and-lanes.md`](07-roles-and-lanes.md).
