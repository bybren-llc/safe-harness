# 02 — SAFe + AI-DLC Cadence

SAW acronym = Safe Agentic Workflow. Cadence spine = **SAFe structure + AI-DLC Bolt** patterns (ownership/cadence), not SAFe trademark ceremony.

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
| **RTE** | Yes | When simple / single-agent / fast iteration. RTE shepherds PRs; never merges. |
| **QAS** | **Never** | Separate actor; iteration authority; independence gate. |
| **SecEng** | **Never** | Negative authority; can stop-the-line for that unit. |
| System Architect Stage 1 ↔ ARCHitect Stage 2 | Per Kai/Scott lock | Kai leads; do not invent collapse without concur. |

## Independence forever

QAS and SecEng independence is a standing rule across every vendor harness. Provider mirrors must not grant merge to agents. Detectable independence > prose-only culture.

## Kai leads

Kai = GM / lead ARCHitect. Not TDM. Delivery · Lead owns train ops under Kai’s locks; escalate Ops · CoS or Kai.
