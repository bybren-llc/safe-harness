# Decision log

Latest-wins index of recorded decisions. The later row wins when a later decision replaces an earlier one; the earlier ADR stays on disk with status `superseded`.

Format: [MADR 4.0](https://adr.github.io/madr/). Files live in this directory as `NNNN-<slug>.md`.

## Convention

Every new decision gets:

1. A GitHub Decision issue (template: `.github/ISSUE_TEMPLATE/decision.yml`)
2. A MADR 4.0 ADR in this directory

The log is latest-wins. Wave 0 C1–C8 / O1–O6 / E1–E3 were one-pass concurred as a pack (see [0015](0015-concur-the-filled-pack.md)). Later decisions each get their own Decision issue. #30 is the Decision issue for the delegation-map record (#27 / #28(c)).

## Index

| ID | Title | Status | Date | Superseded by |
| --- | --- | --- | --- | --- |
| [0001](0001-lock-m1-m6-as-value-metrics.md) | C1 Value metrics M1–M6 | accepted | 2026-10-28 | — |
| [0002](0002-dual-spine-cd-execute-and-think-plan.md) | C2 Dual spine | accepted | 2026-10-28 | — |
| [0003](0003-sdlc-continuous-deployment-risk-tier-hitl.md) | C3 CD with risk-tier HITL | accepted | 2026-10-28 | (gate mapping: #22) |
| [0004](0004-privacy-and-vault-boundaries.md) | C4 Privacy and vault boundaries | accepted | 2026-10-28 | — |
| [0005](0005-studio-delivery-handoff-before-spine-a-build.md) | C5 Studio→Delivery handoff | accepted | 2026-10-28 | — |
| [0006](0006-role-collapsing.md) | C6 Role collapsing | superseded (RTE clause) by #22 | 2026-10-28 | PR #22 `d88c884` (2026-10-30) |
| [0007](0007-new-template-not-silent-saw-rewrite.md) | C7 New template, SAW reference | accepted | 2026-10-28 | — |
| [0008](0008-adapter-order-claude-code-cursor-first.md) | C8 Claude Code + Cursor first | accepted | 2026-10-28 | — |
| [0009](0009-template-home-and-name.md) | O1 Template home and name | accepted | 2026-10-28 | — |
| [0010](0010-high-risk-hitl-paths.md) | O2 High-risk HITL paths | accepted | 2026-10-28 | — |
| [0011](0011-work-data-home.md) | O3 Work-data home | accepted | 2026-10-28 | — |
| [0012](0012-ultracode-not-default-tiered-model-stack.md) | O4 Ultracode not default; model stack | accepted | 2026-10-28 | — |
| [0013](0013-always-on-dark-factory-environment.md) | O5 Always-on environment optional | accepted | 2026-10-28 | — |
| [0014](0014-linear-agents-out-of-wave-0.md) | O6 the issue tracker Agents out | superseded by #6 | 2026-10-28 | PR #6 `6a06388` (2026-10-29) |
| [0015](0015-concur-the-filled-pack.md) | E1 Concur pack | accepted | 2026-10-28 | — |
| [0016](0016-authorize-new-template-repo.md) | E2 New template repo | accepted | 2026-10-28 | — |
| [0017](0017-linear-research-epics.md) | E3 the issue tracker research epics | superseded by #6 | 2026-10-28 | PR #6 `6a06388` (2026-10-29) |
| #30 | Decision: delegation map (#27) concurrence record | accepted | 2026-10-30 | — |
| — | Relayed Wave 0 delegated-HITL merge authorization | recorded (human-owner confirmation of the 2026-10-28 relay pending; D1 #53) | 2026-10-28 | — |
| — | Standing concur for safe-harness v1.0 PRs | recorded (expires at the v1.0.0 tag) | 2026-10-30 | — |
| — | W0-04 stub (HITL without freeze) | superseded | 2026-10-28 | PR #22 `d88c884` |
| — | W0-07 stub (Evidence in the issue tracker) | superseded | 2026-10-28 | PR #6 `6a06388` |
| — | W0-09 stub (Linear SoR) | superseded | 2026-10-28 | PR #6 `6a06388` |

W0-04, W0-07 and W0-09 are superseded stubs. They do not have their own ADR files. W0-04's gate mapping is recorded on [0003](0003-sdlc-continuous-deployment-risk-tier-hitl.md) and [0006](0006-role-collapsing.md). W0-07 and W0-09 are recorded here and on [0014](0014-linear-agents-out-of-wave-0.md).

## Relayed Wave 0 delegated-HITL merge authorization

**Date:** 2026-10-28 ~4:11 PM EDT  
**Kind:** Relayed authorization. This is not the human owner's own words. The grant was made by the human owner (HITL/POPM) and relayed via the GM.

**Scope:** This relayed record applies at Low/D1 only. The GM may merge Wave 0 `bybren-llc/safe-harness` PRs once CodeRabbit is complete on the exact head, the GM's independent QAS is APPROVE on that exact head, and the required checks are green.

**Limits:** The delivery lead never merges. The human owner's HITL is still required for any deploy and for High/O2 items. This record does not amend `constitution/05`. D1 is a separate decision.

**Provenance:** SAF-1 comment `54d37e98`, as already cited in `constitution/05-evidence-and-traceability.md`.

Human-owner confirmation of this 2026-10-28 relayed record is still pending (D1, tracked in #53). This entry does not present the 2026-10-28 record as the human owner's own words.

## Standing concur for safe-harness v1.0 PRs (2026-10-30)

**Date:** 2026-10-30 1:15 PM ET  
**Kind/Provenance:** the human owner's own words, given directly to the GM in the owner's Grok Bot chat on 2026-10-30 at 1:15 PM ET; the GitHub copy is the GM's verbatim relay.

the owner's 2026-10-30 1:15 PM ET standing concur satisfies the High/O2 HITL requirement only for safe-harness PRs merged before the v1.0.0 tag. Each such PR still needs QAS, SecEng and RTE PASS at its own exact head, and its merge note quotes the concur. It expires when v1.0.0 is tagged and is not a reusable template rule.

The current verbatim basis for v1.0 merges is the human owner's standing concur of 2026-10-30 1:15 PM ET: "I'm asking you all to manage all the way without my intervention. On the safe-harness we want to use it in this work. So finish and deliver that then adapt to the new project."
