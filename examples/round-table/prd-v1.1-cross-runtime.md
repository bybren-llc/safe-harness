# Product requirements — v1.1 cross-runtime proof (example)

Example drafted by Delivery for owner review.

Filled from [`../../docs/prd/PRD-TEMPLATE.md`](../../docs/prd/PRD-TEMPLATE.md) for one instance. Not a live PRD. `FR-` / `NFR-` codes here are citations only. They do not register `REQ-<CMP>-NNN` IDs. Root `spec.md` stays canonical for REQ IDs.

This is a reusable starting point for orchestrating agents across runtimes. The v1.1 proof on #85 is the first concrete slice: brief, loaders, worktree-per-agent, gate chain, evidence.

## How this relates to spec.md

Optional longer product context for the slice. Registry IDs are not opened by this file. See [`spec.md`](spec.md) for illustrative `EX-` markers only.

## Where this grows

The same structure is intended to seed an orchestration app's intent and PRD later. The scope of that app is not yet defined.

## 1. Goals

| Code | Goal |
| --- | --- |
| G-001 | Teammates on Cursor, Claude Code, Codex, and other always-on assistant agents, plus humans, share one intent and one design set. |
| G-002 | They hand work to each other through the same gates, on one or several projects at once, toward a larger vision. |
| G-003 | First slice: prove the implementer path on Cursor cloud (R1), Claude Code (R2), and Codex (R3) per #85. |

## 2. Non-goals

| Code | Non-goal |
| --- | --- |
| NG-001 | No new spend, seats, or keys without the owner (#85). |
| NG-002 | Delivery and cloud agents never merge, never approve, never push to `main`. |
| NG-003 | No edits to `constitution/`, `.github/workflows/`, `trace/`, root `spec.md`, or root `intent.md` inside R1–R3 (#85). |
| NG-004 | No features, name, or architecture for a later orchestration app. That scope is open. |

## 3. Users

| Code | User or seat | Need |
| --- | --- | --- |
| U-001 | Human owner (HITL/POPM) | Owns intent and spec; merge seat; spend gate. |
| U-002 | GM / lead architect | QAS on the proof; plan review. |
| U-003 | Implementer (the runtime under test) | Runs one Low-tier bolt from the brief. |
| U-004 | SecEng, QAS, Release · RTE | Independent gates on the exact head. |

## 4. Domain and contracts

| Code | Domain fact or contract |
| --- | --- |
| D-001 | Root `AGENTS.md` is the agent entry. Claude Code and Cursor load it through pointer files. Codex reads it natively. No forked skill bodies. |
| D-002 | One worktree and one branch per agent. Brief at `.briefs/<issue>.md`. |
| D-003 | Portable evidence: `evidence_id`, `runtime`, `exact_head`, `issue`, `actor`, `gate`, `req_ids` (`constitution/05`). |
| D-004 | Merge seats: owner, GM, or Release · RTE only (`constitution/03`). |

## 5. Functional requirements

Maps-to stays `none yet`. Do not write `REQ-<CMP>-NNN` here.

| Code | Requirement | Maps to |
| --- | --- | --- |
| FR-001 | Each run loads `AGENTS.md` and follows the Before you start order. | none yet |
| FR-002 | Each run goes through SecEng PASS, QAS APPROVE, and RTE PASS at its exact head. | none yet |
| FR-003 | Evidence is recorded with `runtime` and `evidence_id`. | none yet |
| FR-004 | At least one handoff crosses runtimes (for example, R2 picks up work or a review from R1). | none yet |
| FR-005 | W0 pointer files stay the load path (no symlinks). | none yet |

### Proof pass criteria (R1–R3)

Same four bars as FR-001–FR-004. A run that misses any one is a FAIL for that runtime (#85).

## 6. Non-functional requirements

| Code | Requirement | Maps to |
| --- | --- | --- |
| NFR-001 | No flags that skip approvals or sandboxing for merge, approve, push to `main`, or tag. | none yet |
| NFR-002 | No force-push and no history rewrite. Branches update by merging `main` (#85). | none yet |
| NFR-003 | No public or external posts; no comments outside the assigned PR. | none yet |

## 7. Phases

| Code | Phase | In | Out |
| --- | --- | --- | --- |
| PH-001 | W0 | Pointer files for Claude Code, Cursor, Codex. Merged as #86. | Skill-body forks; symlink mapping. |
| PH-002 | W0.5 | Design-surface templates and this runbook. | Workflow or `trace/` edits (PR B). |
| PH-003 | R1 | Cursor cloud, #83 Batch A. | Other batches. |
| PH-004 | R2 | Claude Code, #83 Batch B. | Other batches. |
| PH-005 | R3 | Codex, #82. | Owner-identity or CODEOWNERS edits. |
| PH-006 | R4 | #52 part 1, only after the owner's go. | #52 part 2 (High/O2). |

## 8. Assumptions

| Code | Assumption |
| --- | --- |
| A-001 | #85 is the plan. W0 is already on `main`. |
| A-002 | Existing Cursor, Claude Code, and Codex seats can run without new spend. If not, the run stops (#85). |
| A-003 | Root `spec.md` still has no registered REQ IDs. Evidence `req_ids` is `N/A` until the owner fills spec. |

## 9. Open questions

| Code | Question | Owner |
| --- | --- | --- |
| Q-001 | What is the scope of a later orchestration app that would reuse this intent and PRD? | owner |
| Q-002 | Remaining #85 GM and owner questions not closed on the issue. | GM / owner |

## 10. Risks

| Code | Risk | Mitigation |
| --- | --- | --- |
| RK-001 | A runtime does not load `AGENTS.md`. | First-handoff names the path; FAIL if missing (#85). |
| RK-002 | A new commit after QAS voids the exact-head verdicts. | Freeze the head after QAS APPROVE. |
| RK-003 | Inventing scope for a later app. | Where this grows: scope not defined. |
