# Delivery Bolt Brief

**Spine:** A · **Owner:** Delivery · Lead · **Repo:** `bybren-llc/safe-harness` (Wave 0)

## Header

| Field | Value |
| --- | --- |
| Bolt ID | |
| Date (America/New_York) | |
| Goal (ties to M1–M6) | |
| Studio handoff ID | (if any) |
| Human assignee | **(required)** |
| Agent delegate | (optional; not Linear Agent product) |
| Risk tier | Low / Med / High |
| O2 items in scope? | pricing / refunds / auth / deploy CI / prod secrets / privacy-boundary / none |
| RTE collapse | Allowed at Low (annotated) only / Not allowed — never at Med+ (`constitution/02`) |
| QAS actor | (required; never = implementer) |
| SecEng actor | (required if Med/High/O2; never = implementer) |
| HITL approver | (required; High requires two distinct human approvers) |
| POPM approver | (required for final approval) |

## Decision pack (constitution/03 minimum)

| Field | Value |
| --- | --- |
| Linear issue | |
| Exact-head SHA or PR | |
| Evidence IDs | |
| QAS status | pass / change-request / N/A (Low tier only; rationale required) |
| SecEng status | pass / change-request / N/A (Low tier only; rationale required) |
| Risk tier + O2 details | |
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
- [ ] Business-context HITL (if Med/High/O2) — **Wave 0 intentionally broader than strict Low-only policy; ensures HITL cannot be skipped**
- [ ] Implement → Ready for QAS
- [ ] QAS independence
- [ ] SecEng (if required)
- [ ] RTE PASS, or Low-only annotated async checklist (`constitution/02`: never collapse at Med+)
- [ ] HITL decision pack (exact-head)
- [ ] MERGED (HITL only) or MERGED (delegated Kai/RTE) — exit states in `constitution/05`

## Model plan (O4)

| Seat | Tier | Model |
| --- | --- | --- |
| Orchestration | Orchestrator | Fable 5.1+ |
| Implement | Heavy | Sonnet 5.5 / Opus 5.5 |
| QAS | Light/Heavy | Haiku 5.5 / … |
| SecEng | Heavy | Opus 5.5 preferred on O2 |

Ultracode: **not default**.

## Measure

Report outcomes vs M1–M6 at Bolt exit.
