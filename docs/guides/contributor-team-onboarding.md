# Contributor-team onboarding

This guide is for an outside Claude Code team that will pick up
[safe-harness](https://github.com/bybren-llc/safe-harness) issues from a
local clone. **safe-harness itself is the product being completed.** You are
not adapting the template for a new adopter project. You are finishing this
repository.

The writing and correctness team (Team White) owns intent, technical writing,
and correctness. Outside teams do the hands-on implementation. Do not edit
[`intent.md`](../../intent.md) or [`spec.md`](../../spec.md). Do not invent
REQ IDs.

**As of 2026-11-04.** The issue map below is a snapshot. GitHub Issues are
the source of truth: [open issues](https://github.com/bybren-llc/safe-harness/issues).
Re-read the live issue before you start.

---

## 1. What safe-harness is and where it fits

[safe-agentic-workflow (SAW)](https://github.com/bybren-llc/safe-agentic-workflow)
is the frozen gold reference and pattern library. Patterns migrate in. Nobody
rewrites SAW in place. That lock is [ADR 0007](../decisions/0007-new-template-not-silent-saw-rewrite.md).

**safe-harness** is the new multi-runtime workflow built from SAW. It is a
template for everyday, safe AI-assisted development: humans set direction and
keep the safety gates; agents execute. One constitution, thin adapters.
Claude Code, Codex, Cursor, and later runtimes share one set of intent and
design docs.

| Layer | What it is | Where |
| --- | --- | --- |
| Binding rules | Constitution | [`constitution/`](../../constitution/README.md) |
| Seat cards | Round Table roles | [`roles/`](../../roles/README.md) |
| Skills | Canonical `skills/<slug>/SKILL.md` | [`skills/INDEX.md`](../../skills/INDEX.md) |
| Adapters | Runtime mapping only | [`adapters/claude-code/`](../../adapters/claude-code/README.md), [`adapters/cursor/`](../../adapters/cursor/README.md), [`adapters/codex/`](../../adapters/codex/README.md) |
| Human index | Adopter-facing overview | [`README.md`](../../README.md) |
| Agent entry | Load order and local checks | [`AGENTS.md`](../../AGENTS.md) |
| Human contributing | Change flow (not a policy source) | [`CONTRIBUTING.md`](../../CONTRIBUTING.md) |

Claude Code also reads [`CLAUDE.md`](../../CLAUDE.md), which imports
`AGENTS.md`. Adapter notes: [`adapters/claude-code/AGENTS.md`](../../adapters/claude-code/AGENTS.md).
How to launch a runtime from this repo: [`docs/runtimes.md`](../runtimes.md).
Adopting the template for a *different* product is [`docs/adapting.md`](../adapting.md);
that is not this team's job.

Current shape of the design (latest-wins): [`docs/decisions/log.md`](../decisions/log.md).
Adapter order: [ADR 0008](../decisions/0008-adapter-order-claude-code-cursor-first.md).

---

## 2. Intent-and-design framework (as this repo applies it)

Load in the [`AGENTS.md`](../../AGENTS.md) "Before you start" order, then the
issue and its bolt brief. Stop and ask if the bolt brief is missing.

| Artifact | Role in this repo | Path |
| --- | --- | --- |
| Intent | Human-owned purpose and scope. Placeholder until the owner fills it. Agents propose only; they never write it as done and never merge it. | [`intent.md`](../../intent.md), optional [`intent/`](../../intent/README.md) |
| Spec | Human-owned specification. Requirements are derived from it. No REQ IDs yet. | [`spec.md`](../../spec.md) |
| REQ IDs | Agent-authored `REQ-<CMP>-NNN` registry, human-reviewed. Do not invent IDs while the spec has none. | [`requirements/`](../../requirements/README.md) |
| Decision log and ADRs | Latest-wins index plus one MADR 4.0 file per decision | [`docs/decisions/log.md`](../decisions/log.md), [`docs/decisions/`](../decisions/), template [`ADR-TEMPLATE.md`](../decisions/ADR-TEMPLATE.md) |
| Templates | Bolt brief and Studio→Delivery handoff | [`templates/delivery-bolt-brief.md`](../../templates/delivery-bolt-brief.md), [`templates/studio-to-delivery-handoff.md`](../../templates/studio-to-delivery-handoff.md) |
| Trace | Trace map and schema. Warn-only until the spec has REQ IDs **and** `trace/.blocking` exists. | [`trace/trace-map.yaml`](../../trace/trace-map.yaml), [`trace/schema.md`](../../trace/schema.md) |
| Prove | Evidence and bolt records | [`prove/README.md`](../../prove/README.md) |
| Constitution | Binding governance | [`constitution/`](../../constitution/README.md) |
| Roles | Seat cards (file names are seats, not people) | [`roles/`](../../roles/README.md) |

Optional longer product and design surfaces (not a substitute for intent or
spec): [`docs/prd/PRD-TEMPLATE.md`](../prd/PRD-TEMPLATE.md),
[`docs/design/`](../design/README.md). Component registry:
[`arch/components.yaml`](../../arch/components.yaml).

### Walk one issue through the flow

Take the path and tier rules from the repo's own docs. Do not invent a
shortcut.

1. **Bolt brief.** Delivery fills [`templates/delivery-bolt-brief.md`](../../templates/delivery-bolt-brief.md)
   (issue form: [`.github/ISSUE_TEMPLATE/bolt.yml`](../../.github/ISSUE_TEMPLATE/bolt.yml)).
   The brief names the human assignee, agent delegate, tier, O2 items, QAS /
   SecEng / RTE actors, scope, and evidence. If the brief is missing, stop.
   Skills: [`bolt-lifecycle`](../../skills/bolt-lifecycle/SKILL.md),
   [`start-end-work`](../../skills/start-end-work/SKILL.md).
2. **PR.** Branch, implement, record portable evidence, run the local checks
   in [`AGENTS.md`](../../AGENTS.md), and open a PR from
   [`.github/pull_request_template.md`](../../.github/pull_request_template.md).
   While `spec.md` has no REQ IDs, the PR body uses a bare `Requirements: N/A`
   line and a rationale on the next line. Conventions:
   [`skills/github-conventions/SKILL.md`](../../skills/github-conventions/SKILL.md).
   Pre-PR checks: [`skills/pre-pr-validation/SKILL.md`](../../skills/pre-pr-validation/SKILL.md).
3. **QAS, SecEng, and RTE gates.** Independent QAS posts a COMMENT review with
   `QAS: APPROVE` or `QAS: CHANGES NEEDED` at the exact head
   ([`roles/qas.md`](../../roles/qas.md)). SecEng is required at Med, High,
   and O2; Low may mark N/A with rationale
   ([`roles/seceng.md`](../../roles/seceng.md)). RTE placement and the Low
   async-checklist path are in
   [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md)
   and [`roles/release-rte.md`](../../roles/release-rte.md). Operating
   procedure: [`release/flow.md`](../../release/flow.md). Cadence and
   independence: [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md).
4. **Owner concur where required.** `constitution/`, High, and O2 need the
   owner's recorded own-words concur at the exact head. Med needs a human
   decision pack. Low does not add that concur gate. Verify own words:
   [`skills/hitl-concur-check/SKILL.md`](../../skills/hitl-concur-check/SKILL.md).
   An agent relaying approval is never approval.
5. **Merge.** Only the owner, the GM, or Release · RTE merge, and only under
   [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md).
   Delivery and cloud agents never merge or approve.

Risk tiers, O2 defaults, exact-head, and who may execute a trunk merge live
in [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md).
Exit states live in
[`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md).
After `QAS: APPROVE` the implementer head is frozen
([`roles/implementer.md`](../../roles/implementer.md),
[`CONTRIBUTING.md`](../../CONTRIBUTING.md)).

---

## 3. Issue map (snapshot)

**As of 2026-11-04.** Source of truth:
[github.com/bybren-llc/safe-harness/issues](https://github.com/bybren-llc/safe-harness/issues).
Tier comes from the issue's `tier:*` label or, if none, from the issue body.
`untiered` means neither has a tier. **Ready** means the issue has a bolt
brief and is not otherwise blocked. Take only rows marked **ready**.

**NOT FOR PICKUP** (do not start these):

- [#96](https://github.com/bybren-llc/safe-harness/issues/96) — the GM seat
  is drafting it; owner concur is required.
- [#95](https://github.com/bybren-llc/safe-harness/pull/95) — waiting on the
  owner (open High PR; `constitution/` change).
- Queued Low follow-up (not yet filed) — aligns the async-checklist Low
  merge path. Delivery owns it and does it after #95.

[#85](https://github.com/bybren-llc/safe-harness/issues/85) is the v1.1 epic
(plan only; no GitHub sub-issues). Open child work named in that plan:
[#82](https://github.com/bybren-llc/safe-harness/issues/82) (R3 / Codex
candidate) and [#83](https://github.com/bybren-llc/safe-harness/issues/83)
(R1 / R2 wording batches plus deferred nits). W0 and W0.5 already landed on
`main` (runtime loader pointers, link-scan coverage, design surface, runtime
launch runbook). Comment-only follow-ups on #85 are not separate issues.

| Issue | What it is | Tier | Status | Pickup |
| --- | --- | --- | --- | --- |
| [#7](https://github.com/bybren-llc/safe-harness/issues/7) | Make trace-check blocking (validations + `trace/.blocking`) | Medium (O2 deploy-ci) | Plan-stage bolt; still warn-only until spec REQ IDs and the marker land | blocked (no bolt brief; O2) |
| [#15](https://github.com/bybren-llc/safe-harness/issues/15) | Labels sync from `.github/labels.yml` | High (O2 deploy-ci) | Open question: manual vs automated | blocked (no bolt brief; O2) |
| [#21](https://github.com/bybren-llc/safe-harness/issues/21) | Link-health spec (Librarian) | Low | Spec landed; remaining AC is the weekly scan routine | blocked (Librarian cadence; log is #89) |
| [#28](https://github.com/bybren-llc/safe-harness/issues/28) | Parked gate/authority items from #27 | untiered (body: High/O2 for (a)/(b)) | Waiting on owner answers for (a) and (b); (c) recorded as #30 | blocked (owner decision) |
| [#30](https://github.com/bybren-llc/safe-harness/issues/30) | Decision record for the delegation-map pack | untiered | Concurrence already recorded; leftover link edit | blocked (record, not a build bolt) |
| [#35](https://github.com/bybren-llc/safe-harness/issues/35) | Harden API-contract workflow | High/O2 (body) | Parked hardening notes | blocked (no bolt brief; O2) |
| [#39](https://github.com/bybren-llc/safe-harness/issues/39) | Skill install layout breaks relative constitution links | Low (body) | Design question; overlaps #72 | blocked (no bolt brief) |
| [#40](https://github.com/bybren-llc/safe-harness/issues/40) | Denylist check in CI via repo secret | High/O2 (body) | v1.1 security/CI work | blocked (no bolt brief; O2) |
| [#46](https://github.com/bybren-llc/safe-harness/issues/46) | Hash-pin PyYAML in skills-checks | High/O2 (body) | v1.1 workflow hardening | blocked (no bolt brief; O2) |
| [#49](https://github.com/bybren-llc/safe-harness/issues/49) | Docs follow-ups from #29 QAS/RTE | Low (body) | Four Low wording items still open | blocked (no bolt brief) |
| [#50](https://github.com/bybren-llc/safe-harness/issues/50) | SecEng delta-confirm duty on High/O2 | High (body) | Constitution amendment; needs owner concur | blocked (no bolt brief; owner concur) |
| [#52](https://github.com/bybren-llc/safe-harness/issues/52) | Denylist residuals + path-name scan | Med (part 1, body) / High/O2 (part 2, body) | #85 parks part 1 as later R4 after owner go | blocked (no bolt brief; scanner-not-fixer) |
| [#53](https://github.com/bybren-llc/safe-harness/issues/53) | Align constitution/05 D1 example | High (body) | Constitution edit; needs owner concur | blocked (no bolt brief; owner concur) |
| [#54](https://github.com/bybren-llc/safe-harness/issues/54) | Bootstrap rule for the `Req:` trailer | untiered | Needs a chosen rule, then docs | blocked (no bolt brief) |
| [#55](https://github.com/bybren-llc/safe-harness/issues/55) | Skills follow-ups (frontmatter, link scan, wording) | Medium (item 2 is High/O2 in the body) | Three deferred review items | blocked (no bolt brief) |
| [#56](https://github.com/bybren-llc/safe-harness/issues/56) | PR template decision-pack field | High | `.github/` template change | blocked (no bolt brief) |
| [#57](https://github.com/bybren-llc/safe-harness/issues/57) | Stop prefilling `Requirements: N/A` once REQs exist | Low | Bootstrap-only template tweak | blocked (no bolt brief) |
| [#60](https://github.com/bybren-llc/safe-harness/issues/60) | Restore or relocate dropped adapter pointer lines | Low | Needs a decision (restore vs close) | blocked (decision; no bolt brief) |
| [#64](https://github.com/bybren-llc/safe-harness/issues/64) | test-fixtures.sh EXIT trap and diagnostics | Low | Test-harness robustness; AC written | blocked (no bolt brief) |
| [#69](https://github.com/bybren-llc/safe-harness/issues/69) | Implementer self-check gaps | untiered | v1.1 harness-gap | blocked (no bolt brief) |
| [#70](https://github.com/bybren-llc/safe-harness/issues/70) | `scripts/self-check` entry point | untiered | v1.1 harness-gap | blocked (no bolt brief) |
| [#71](https://github.com/bybren-llc/safe-harness/issues/71) | Per-runtime hooks that call self-check | untiered (O2 deploy-ci label) | v1.1 harness-gap; tier to confirm at QAS | blocked (no bolt brief) |
| [#72](https://github.com/bybren-llc/safe-harness/issues/72) | `scripts/gen-adapters` + CI drift check | untiered | v1.1 harness-gap; folds #39 | blocked (no bolt brief) |
| [#73](https://github.com/bybren-llc/safe-harness/issues/73) | Root `CLAUDE.md` that imports `AGENTS.md` | untiered | Pointer file is on `main`; issue still open | blocked (no bolt brief; confirm remaining AC) |
| [#74](https://github.com/bybren-llc/safe-harness/issues/74) | Orchestration contract + orchestrator adapters | untiered | v1.1 harness-gap | blocked (no bolt brief) |
| [#75](https://github.com/bybren-llc/safe-harness/issues/75) | In-loop role cards with skills and loops | untiered | v1.1 harness-gap | blocked (no bolt brief) |
| [#76](https://github.com/bybren-llc/safe-harness/issues/76) | Role-started vs brief-only experiment | untiered | Blocked on #70–#73 and #75 | blocked (precondition; no bolt brief) |
| [#77](https://github.com/bybren-llc/safe-harness/issues/77) | PR-body and label lint | untiered | v1.1 harness-gap | blocked (no bolt brief) |
| [#78](https://github.com/bybren-llc/safe-harness/issues/78) | Source-URL provenance rule | untiered | v1.1 harness-gap | blocked (no bolt brief) |
| [#80](https://github.com/bybren-llc/safe-harness/issues/80) | Role-term drift lint in self-check | untiered | v1.1 harness-gap | blocked (no bolt brief) |
| [#81](https://github.com/bybren-llc/safe-harness/issues/81) | O2 downgrade authority when GM and QAS are split | untiered | Policy decision for the GM; #85 parks it after that decision | blocked (GM decision; no bolt brief) |
| [#82](https://github.com/bybren-llc/safe-harness/issues/82) | Adopter docs for `owner_identity` and CODEOWNERS | untiered (#85 treats as Low R3) | v1.1 #85 child (Codex proof candidate) | blocked (no bolt brief) |
| [#83](https://github.com/bybren-llc/safe-harness/issues/83) | Grouped #61 follow-ups (wording / records) | untiered (#85 splits Low batches vs owner-concur) | v1.1 #85 child (R1/R2 candidates + deferred nits) | blocked (no bolt brief) |
| [#85](https://github.com/bybren-llc/safe-harness/issues/85) | v1.1 epic: prove Claude Code, Codex, Cursor | untiered | Plan. W0/W0.5 on `main`. R1–R3 not started. Follow-ups in comments | blocked (epic; no implementer brief) |
| [#89](https://github.com/bybren-llc/safe-harness/issues/89) | Weekly link-health summary (long-lived) | untiered | Librarian scan log; stays open. Spec: [`examples/round-table/link-health.md`](../../examples/round-table/link-health.md) | blocked (not an implementer bolt) |
| [#95](https://github.com/bybren-llc/safe-harness/pull/95) | RTE executes Low merges after RTE PASS | High | Open PR. Gates recorded; waiting on owner concur at exact head | NOT FOR PICKUP |
| [#96](https://github.com/bybren-llc/safe-harness/issues/96) | Owner self-merge vs nobody-merges-own-change | High | Triage only. GM drafts; owner concur after #95 | NOT FOR PICKUP |
| — | Queued Low follow-up: align async-checklist Low merge path | Low (as named) | Not filed. Delivery owns; after #95 | NOT FOR PICKUP |

No open issue in this snapshot is **ready**. When Delivery attaches a bolt
brief and the row is not in the NOT FOR PICKUP list, the live GitHub issue
wins over this table.

---

## 4. Hard rules for an outside team

Read the linked files. Do not restate them in briefs or PRs.

| Rule | Where it lives |
| --- | --- |
| Agents never merge or approve PRs | [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) (merge authority; Delivery and cloud agents never merge) |
| Implementers freeze the branch after QAS | [`roles/implementer.md`](../../roles/implementer.md) (head freeze); also [`CONTRIBUTING.md`](../../CONTRIBUTING.md) |
| Agents are scanners, not fixers, for security findings | [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) (Security findings) |
| No external posts | [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) (file-level; [`#x-writes`](../../constitution/07-roles-and-lanes.md#x-writes) is X only) |
| No `Co-authored-by` trailers | [`skills/github-conventions/SKILL.md`](../../skills/github-conventions/SKILL.md); [`roles/implementer.md`](../../roles/implementer.md) |

Related stops (link, do not restate): personal-vault boundary
[`constitution/04-privacy-and-vaults.md`](../../constitution/04-privacy-and-vaults.md);
lane map [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md);
privacy skill [`skills/privacy-boundary/SKILL.md`](../../skills/privacy-boundary/SKILL.md).
This repo is public. Use seat names only (owner, GM, Delivery, QAS, SecEng,
RTE). Do not name clients, private origins, or people.

---

## 5. Claude Code starter prompt

Copy and paste from a local clone at the repo root. Take only issues marked
**ready** in this guide (or in a later snapshot that replaces it).

```text
You are an Implementer on safe-harness. safe-harness itself is the product
being completed. Do not treat this as an adopter fork.

1. Read AGENTS.md and follow Before you start in order: intent.md, spec.md,
   docs/decisions/log.md, the issue and its bolt brief, then the REQ IDs the
   issue cites. Stop and ask if the bolt brief is missing. Do not invent
   REQ IDs.
2. Read docs/guides/contributor-team-onboarding.md. Take only issues that
   guide marks ready. Do not pick up #95, #96, or the queued Low
   async-checklist follow-up Delivery owns after #95.
3. Load the seat cards you will sit or hand off to: roles/implementer.md,
   roles/qas.md, roles/seceng.md, roles/release-rte.md, roles/delivery-lead.md,
   and roles/README.md. Follow skills/bolt-lifecycle/SKILL.md and
   templates/delivery-bolt-brief.md. Claude Code notes:
   adapters/claude-code/AGENTS.md and CLAUDE.md.
4. Implement only the brief. Run the local checks AGENTS.md lists before you
   open a PR. Freeze the head after QAS APPROVE. Never merge, never approve,
   never post outside the assigned PR, never add Co-authored-by trailers,
   never force-push or rewrite history. Security findings: scanner, not fixer.
```
