# Delivery Bolt Brief

**Spine:** A · **Owner:** Delivery · Lead · **Repo:** `bybren-llc/safe-harness` (Wave 0)

## Header

| Field | Value |
| --- | --- |
| Bolt ID | SAF-3 |
| Date (America/New_York) | 2026-10-29 |
| Goal (ties to M1–M6) | Prove D-P1: one Delivery bolt on spine A, end-to-end under exit states (M3, M4, M6) |
| Studio handoff ID | none (D-P2 separate) |
| Human assignee | Scott Graham |
| Agent delegate | Delivery · Lead (Grok Bot) via Cursor CloudAgent — not Linear Agent product |
| Risk tier | Low |
| O2 items in scope? | none |
| RTE collapse | Allowed |
| QAS actor | Kai · GM & lead ARCHitect (independent; ≠ implementer) |
| SecEng actor | N/A — Low tier: docs-only under prove/, no O2 items, no workflows/secrets touched |
| HITL approver | Scott Graham |
| POPM approver | Scott Graham |

## Decision pack (constitution/03 minimum)

| Field | Value |
| --- | --- |
| Linear issue | https://linear.app/cheddarfox/issue/SAF-3/prove-d-p1-one-delivery-bolt-spine-a-record-d-p1-bolt-brief-evidence |
| Exact-head SHA or PR | TBD at exact head (PR #<n>) |
| Evidence IDs | TBD — see Evidence table |
| QAS status | pending (Kai re-QAS on exact head) |
| SecEng status | N/A (Low tier only; rationale: docs-only, no O2 items, no workflows/secrets touched) |
| Risk tier + O2 details | Low; O2 checklist — pricing ☐ refunds ☐ auth ☐ deploy CI/workflows ☐ prod secrets ☐ privacy-boundary ☐ (none) |
| Ask | approve |

## Scope

- In: prove/d-p1/bolt-brief.md, prove/README.md D-P1 checklist
- Out: .github/workflows/**, constitution/adapters/templates content, D-P2, runnable adapters

## Units of Work

| UoW | Owner seat | Exit evidence |
| --- | --- | --- |
| UoW-1 "Fill bolt brief" | Delivery (CloudAgent) | this file at exact head, state Ready for QAS |
| UoW-2 "Update D-P1 checklist" | Delivery (CloudAgent) | README diff, state Ready for QAS |
| UoW-3 "Independent QAS" | Kai | re-QAS verdict on exact head |
| UoW-4 "HITL decision pack + merge" | Scott (HITL/POPM), with Kai merging under Scott's standing auth | MERGED |

## Gates

- [x] Human assignee identified before delivery starts
- [ ] Business-context HITL (if Med/High/O2) — N/A at Low (step 6 applies if Med/High/O2)
- [x] Implement → Ready for QAS
- [ ] QAS independence
- [ ] SecEng (if required) — N/A (Low; rationale above)
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

The implementing seat is the Cursor CloudAgent.

Ultracode: **not default**.

## Evidence (portable — constitution/05)

| evidence_id | runtime | exact_head | linear_issue | actor | gate |
| --- | --- | --- | --- | --- | --- |
| bc-2002b87a-8540-5b26-adcd-81a17f554bdb | cursor | see PR head | SAF-3 | bc-2002b87a-8540-5b26-adcd-81a17f554bdb | Implement → Ready for QAS |
| TBD | cursor | TBD | SAF-3 | Kai | QAS independence |
| TBD | cursor | TBD | SAF-3 | Scott Graham | HITL decision pack |

## Measure

Report outcomes vs M1–M6 at Bolt exit.

- **M1**: not exercised in D-P1
- **M2**: not exercised in D-P1
- **M3**: the bolt, its UoWs and the business-context gate are named and used
- **M4**: seat map Scott=HITL/POPM, Kai=GM/QAS/merge, Delivery=implement/PR owner, Studio=D-P2
- **M5**: not exercised in D-P1
- **M6**: evidence → independent QAS → HITL decision pack → merge without freezing the train; thin CI green

**Exit states (constitution/05)**: Ready for QAS → Approved for RTE (collapsed-RTE annotated) → Ready for HITL → MERGED (HITL only)
