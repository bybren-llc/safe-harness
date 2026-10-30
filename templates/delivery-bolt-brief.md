# Delivery Bolt Brief

**Spine:** A · **Owner:** Delivery · Lead · **Repo:** `bybren-llc/safe-harness`

## Header

| Field | Value |
| --- | --- |
| Bolt ID | |
| Date (America/New_York) | |
| Goal (ties to M1–M6) | |
| Studio handoff ID | (if any) |
| Human assignee | **(required)** the project's named HITL / POPM human (Round Table: Scott). Agent ≠ human. Do not invent a second human. |
| Agent delegate | (optional; humans remain assignees — `constitution/01-round-table.md`) |
| Risk tier | Low / Med / High |
| O2 items in scope? | pricing / refunds / auth / deploy CI / prod secrets / privacy-boundary / none |
| RTE | An RTE-executed merge always needs RTE PASS on the exact head (any tier). A Low PR merged by Kai or Scott may use the annotated async checklist instead of a per-PR verdict. Required at Med, High, and O2. Non-collapsible at Med+ (`constitution/02-safe-ai-dlc.md`, `constitution/03-cd-and-hitl.md`, `roles/release-rte.md`) |
| QAS actor | (required; never = implementer; distinguishable in GitHub — `constitution/05-evidence-and-linear.md`) |
| SecEng actor | (required if Med/High/O2; never = implementer; High/O2 never N/A — `constitution/03-cd-and-hitl.md`) |
| HITL approver | the project's named HITL / POPM human (Round Table: Scott). High/O2 and `constitution/` need that human's recorded own-words concur. Two distinct humans is recommended guidance, not a gate (`constitution/03-cd-and-hitl.md`). Agent ≠ human. |
| POPM approver | Same seat as HITL — the project's named HITL / POPM human (Round Table: Scott). Not a second human. |

## Decision pack (constitution/03 minimum)

| Field | Value |
| --- | --- |
| GitHub Issue | `#N` (repo source of truth; `constitution/05-evidence-and-linear.md`) |
| Exact-head SHA or PR | |
| Evidence IDs | |
| Requirements | `REQ-<CMP>-NNN` list (`constitution/03-cd-and-hitl.md`); `none yet (bootstrap)` while `spec.md` has no REQ IDs |
| QAS status | pass / change-request / N/A (Low tier only; rationale required). High/O2: never N/A and cannot be waived |
| SecEng status | pass / change-request / N/A (Low tier only; rationale required). High/O2: never N/A and cannot be waived |
| Risk tier + O2 details | (note if Kai downgraded any O2 item) |
| Ask | approve / change-request / escalate |

## Scope

- In:
- Out:

## Units of Work

| UoW | Owner seat | Exit evidence |
| --- | --- | --- |
| | | |

## Gates

- [ ] Human assignee identified before delivery starts
- [ ] Business-context HITL before construction on policy / secrets / risk (`constitution/02-safe-ai-dlc.md`); Low-risk green path may auto-flow
- [ ] Implement → Ready for QAS
- [ ] QAS independence
- [ ] SecEng (if required)
- [ ] RTE PASS when RTE executes (any tier); a Low PR merged by Kai or Scott may use the annotated async checklist (`constitution/03-cd-and-hitl.md` RTE placement)
- [ ] HITL decision pack (exact-head)
- [ ] MERGED (HITL only) / MERGED (HITL-delegated) / MERGED (delegated Kai/RTE) — exit states in `constitution/05-evidence-and-linear.md`

## Model plan (O4)

| Seat | Tier | Model |
| --- | --- | --- |
| Orchestration | Orchestrator | Fable 5.1+ |
| Implement | Heavy | Sonnet 5.5 / Opus 5.5 |
| QAS | Light/Heavy | Haiku 5.5 / … |
| SecEng | Heavy | Opus 5.5 preferred on O2 |

Ultracode: **not default**.

## Estimate

| Field | Estimate | Actual (at close) |
| --- | --- | --- |
| Agent-hours | | |
| Human-hours | | |
| Review/approval wait (hours) | | |
| Confidence (L/M/H) | | |

Capture actuals at close; compare actuals with estimates each sprint and report under M5 / M6.

## Measure

Report outcomes vs M1–M6 at Bolt exit.
