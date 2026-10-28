# Delivery Bolt Brief

**Spine:** A · **Owner:** Delivery · Lead · **Repo:** `bybren-llc/safe-harness` (Wave 0)

## Header

| Field | Value |
| --- | --- |
| Bolt ID | |
| Date (America/New_York) | |
| Goal (ties to M1–M6) | |
| Studio handoff ID | (if any) |
| Human assignee | |
| Agent delegate | (optional; not Linear Agent product) |
| Risk tier | Low / Med / High |
| O2 items in scope? | pricing / refunds / auth / deploy CI / prod secrets / privacy-boundary / none |
| RTE collapse | Allowed / Not allowed |
| QAS actor | (required; never = implementer) |
| SecEng actor | (required if Med/High/O2; never = implementer) |

## Scope

- In:
- Out:

## Units of Work

| UoW | Owner seat | Exit evidence |
| --- | --- | --- |
| | | |

## Gates

- [ ] Business-context HITL (if Med/High/O2)
- [ ] Implement → Ready for QAS
- [ ] QAS independence
- [ ] SecEng (if required)
- [ ] RTE or collapsed-RTE annotated
- [ ] HITL decision pack (exact-head)
- [ ] MERGED by human

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
