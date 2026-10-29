# Wave 0 Meta-Cycle Retrospective

**Epic:** SAF-1 · **Delivery:** Kai & Delivery · Lead · **Date:** 2026-10-29 · **Time zone:** America/New_York (EDT)

## 1. Summary

Wave 0 delivered the initial prove cycle end-to-end:
- **SAF-1** (epic) closed
- **Constitution** merged via [PR #2](https://github.com/bybren-llc/safe-harness/pull/2) @ `740eb2a`
- **D-P1 bolt brief** merged via [PR #3](https://github.com/bybren-llc/safe-harness/pull/3) @ `acd9f389`
- **D-P1 evidence** merged via [PR #4](https://github.com/bybren-llc/safe-harness/pull/4) @ `333edff8`

All PRs passed Structure & Docs Validation, underwent CodeRabbit automated review, and received independent human QAS before merge.

## 2. Cycle Time

| PR | Opened (EDT) | Merged (EDT) | Duration | Commits | QAS Rounds | CodeRabbit Rounds |
|----|-------------|-------------|----------|---------|------------|-------------------|
| [#2](https://github.com/bybren-llc/safe-harness/pull/2) | 2026-10-28 15:12:22 | 2026-10-29 06:38:01 | ~15h 26m | 7 | 1 (APPROVE @ `fb74ba5`) | 3 reviews |
| [#3](https://github.com/bybren-llc/safe-harness/pull/3) | 2026-10-29 06:43:56 | 2026-10-29 07:54:42 | ~1h 11m (71 min) | 2 | 2 (CHANGES @ `0952071`, APPROVE @ `41b969f`) | 2 reviews |
| [#4](https://github.com/bybren-llc/safe-harness/pull/4) | 2026-10-29 07:58:13 | 2026-10-29 08:56:31 | ~58 min | 2 | 2 (CHANGES @ `2c3a821`, APPROVE @ `067053f`) | 1 review |

**Evidence:**
- PR #2 timestamps: https://github.com/bybren-llc/safe-harness/pull/2
- PR #3 timestamps: https://github.com/bybren-llc/safe-harness/pull/3, merge SHA `acd9f389bc1f54ab79dbfa1e9732a80c957a10d0`
- PR #4 timestamps: https://github.com/bybren-llc/safe-harness/pull/4, merge SHA `333edff8`

**Notes on QAS rounds:** Kai posted verdicts as COMMENTED reviews with "APPROVE" or "CHANGES NEEDED" in the review body because GitHub blocks the author account from using REQUEST_CHANGES or APPROVE review states.

## 3. CodeRabbit vs QAS Catches

### PR #2 — Constitution + thin CI

**CodeRabbit findings (3 reviews, 8 actionable + 1 nitpick):**
- [Review 1 @ `ed1dc32`](https://github.com/bybren-llc/safe-harness/pull/2#pullrequestreview-295bf6c0): 8 actionable (Major: workflow link-check, fence validation, evidence payload, HITL gates, brief decision-pack fields, SecEng requirements, pre-construct HITL scope)
- [Review 2 @ `d629a92`](https://github.com/bybren-llc/safe-harness/pull/2#pullrequestreview-41011def): 1 Major (QAS/SecEng N/A constraint to Low tier with rationale)
- [Review 3 @ `fb74ba5`](https://github.com/bybren-llc/safe-harness/pull/2#pullrequestreview-bda56306): 0 actionable, noted thin-CI limitations as decision-pack (M6)

**Kai QAS findings:**
- [QAS @ `fb74ba5`](https://github.com/bybren-llc/safe-harness/pull/2#pullrequestreview-295bf6c0): APPROVE; verified CR Major fix (QAS/SecEng N/A rows), downgraded risk tier High→Low with written rationale (read-only non-deploy CI), SecEng N/A justified

**Classification:**
- **Overlap:** QAS/SecEng N/A constraint (CR Major, QAS verified fix)
- **CR-only:** Workflow implementation details (link-check subshell bug, fence state tracking, markdown parser limits), template completeness (evidence payload fields, HITL/approver fields)
- **QAS-only:** Risk-tier downgrade authority (O2 workflow item → Low via written rationale), SecEng N/A justification review

**Implications:** CodeRabbit caught structural/implementation issues in workflow code and template completeness; QAS exercised human judgment on risk-tier classification and policy application. No critical findings escaped both.

### PR #3 — D-P1 Bolt Brief

**CodeRabbit findings (2 reviews):**
- [Review 1 @ `0952071`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-82c3d09f): 1 Major (evidence placeholders, actor field, exact_head mismatch)
- [Review 2 @ `41b969f`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-b6bd8b37): 1 Minor outside-diff (M3 "used" vs "named" gate wording)

**Kai QAS findings:**
- [QAS CHANGES NEEDED @ `0952071`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-295bf6c0): CR Major accepted + 3 additional (exact-head should be PR not SHA, merge gate wording contradiction, model plan placeholder)
- [QAS APPROVE @ `41b969f`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-b6bd8b37): All must-fixes verified; CR Minor carried to D-P1 follow-on as non-blocking

**Classification:**
- **Overlap:** Evidence placeholders and actor/exact_head issues (CR Major, QAS expanded scope)
- **CR-only:** M3 gate wording (Minor, non-blocking)
- **QAS-only:** Merge gate wording contradicting UoW-4, model plan placeholder

**Implications:** CodeRabbit identified data-completeness issues; QAS caught semantic inconsistencies between sections (merge gate vs UoW wording). Combined coverage prevented conflicting documentation.

### PR #4 — D-P1 Evidence + Measure

**CodeRabbit findings (1 review):**
- [Review 1 @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-295bf6c0): 4 actionable (Major: exit-state label must stay `MERGED (HITL only)` verbatim per constitution/05; HITL gates need delegation annotation with durable link; runtime column should be `grok-bot` not `cursor` for Kai's rows; README step 6 needs bolt-brief link)

**Kai QAS findings:**
- [QAS CHANGES NEEDED @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-295bf6c0): All 4 CR findings accepted as valid; #1 (exit state) overrides SAF-4 AC #3 which was wrong
- [QAS APPROVE @ `067053f`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-295bf6c0): All must-fixes verified; decision-pack D1 carried as non-blocking

**Classification:**
- **Overlap:** All 4 findings (CR caught, QAS triaged and accepted)
- **CR-only:** None
- **QAS-only:** None; QAS added decision-pack D1 (governed constitution amendment for delegated-HITL)

**Implications:** CodeRabbit correctly identified a governance violation (prove doc attempting to redefine constitution/05 labels). QAS validated the finding, overrode a conflicting AC, and elevated the governance question to decision-pack D1. Perfect coverage: CR prevented the violation, QAS ensured proper escalation.

## 4. Where the Train Stalled

### Overnight stall (PR #2)
**Timeline:** PR #2 opened 2026-10-28 15:12:22 EDT, merged 2026-10-29 06:38:01 EDT (~15h 26m).  
**Cause (per Delivery log):** A handoff ping to wake the reviewer didn't fire or was missed overnight, delaying the final QAS round.  
**Fix:** Priority pings established for Wave 1 handoffs.  
**Evidence:** PR #2 had 7 commits and 3 CodeRabbit reviews spanning the overnight period; the final QAS APPROVE @ `fb74ba5` came morning of Oct 29.

### PR-event routine didn't fire for PR #4's first head
**Timeline:** PR #4 created 07:58:13 EDT; CodeRabbit review posted 12:07:20 UTC (08:07:20 EDT) for commit `2c3a821`.  
**Cause (per Delivery log):** An event-driven automation that should have triggered on CodeRabbit completion for PR #4's first head didn't fire as expected.  
**Impact:** Minor delay; workflow continued manually.  
**Evidence:** [CodeRabbit review timestamp](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-295bf6c0) vs PR creation timestamp show ~9-minute gap, but Kai QAS at 12:19:56 UTC (08:19:56 EDT) indicates the routine gap was brief.

### Author-account review limitation
**Impact:** Kai (PR author on all three) could not use GitHub's REQUEST_CHANGES or APPROVE review states, forcing COMMENTED reviews with verdict in body text.  
**Workaround:** Each QAS review explicitly stated "treat as CHANGES NEEDED" or "treat as APPROVE."  
**Visibility:** All QAS verdicts were clear and auditable; no ambiguity in merge decisions.  
**Evidence:** [PR #3 QAS @ `0952071`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-295bf6c0), [PR #4 QAS @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-295bf6c0)

### Brief wording vs constitution/05 exit states (PR #4)
**Issue:** SAF-4 acceptance criteria asked to relabel the exit state from `MERGED (HITL only)` to an alternate phrasing. QAS rejected this in PR #4: prove docs cannot redefine constitution/05 labels.  
**Resolution:** CodeRabbit Major finding accepted; exit-state label restored verbatim; delegation recorded as evidence per [Linear SAF-1 comment `54d37e98`](https://linear.app/cheddarfox/issue/SAF-1/).  
**Decision pack:** Carried as D1 — should constitution/05 gain a governed amendment for delegated-HITL merge at Low tier?  
**Evidence:** [PR #4 CodeRabbit review](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-295bf6c0), [QAS CHANGES NEEDED @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-295bf6c0)

## 5. M1–M6 Status

| Metric | Status | Evidence |
|--------|--------|----------|
| **M1** (Studio → Delivery handoff) | Unexercised | D-P2 (Studio brief, spine B) not yet executed; D-P1 was spine A only |
| **M2** (Multi-runtime prove) | Partially exercised | Cursor CloudAgent (bc-2002b87a…) + Grok Bot (Kai QAS, runtime=grok-bot) verified; no Claude Code or other runtimes in Wave 0 |
| **M3** (Bolt + UoWs + gates named & used) | Met | [D-P1 bolt brief](d-p1/bolt-brief.md) names bolt SAF-3, 4 UoWs, 8 gates; business-context HITL gate marked N/A at Low tier (named, not used per Low-tier exception); all other gates exercised |
| **M4** (Seat map) | Met | Scott=HITL/POPM, Kai=GM/QAS/merge, Delivery·Lead=implement/PR owner; documented in [bolt brief](d-p1/bolt-brief.md#header) and exercised across PRs #2–#4 |
| **M5** (Forge sync + CI/CD paths) | Partially exercised | GitHub forge sync verified (PRs #2–#4); thin CI (Structure & Docs Validation) green; full CD path (deploy gates, merge queues, rollback) deferred to M6 follow-on |
| **M6** (QAS → HITL → merge velocity) | Met | PR #3 cycle 71 min, PR #4 cycle 58 min (evidence → QAS → HITL decision pack → merge); thin CI green on all PRs; no train freeze; [PR #3](https://github.com/bybren-llc/safe-harness/pull/3) + [PR #4](https://github.com/bybren-llc/safe-harness/pull/4) timestamps verify |

**Baseline (from [d-p1/bolt-brief.md](d-p1/bolt-brief.md#measure)):**
- M1, M2, M5 explicitly noted as "not exercised in D-P1" or partial
- M3, M4, M6 targeted and delivered

## 6. Wave 1 Proposals

1. **CR-completion trigger reliability:** Investigate and harden the PR-event routine that didn't fire for PR #4's first head. Consider fallback polling or manual trigger if event-driven approach remains brittle. (Tied to: PR #4 stall finding.)

2. **HITL delegation evidence field:** Propose `hitl_delegate` evidence field for Low-tier delegated-HITL merge, so delegation is machine-readable in constitution/05 evidence schema instead of prose-only. Requires governed amendment (see D1 below). (Tied to: PR #4 governance finding, decision-pack D1.)

3. **D-P2 Studio run:** Execute D-P2 (Studio brief, spine B → A handoff) to fully exercise M1 and the dual-spine model. (Tied to: M1 unexercised.)

4. **Cycle-time target:** Establish a cycle-time SLO for Low-tier PRs (e.g. < 2 hours from open to merge for docs-only changes) to measure M6 velocity objectively. PR #3 (71 min) and PR #4 (58 min) set a baseline. (Tied to: M6 measurement.)

5. **Multi-runtime coverage:** Expand M2 by proving Claude Code adapter or another runtime alongside Cursor CloudAgent in Wave 1. (Tied to: M2 partially exercised.)

6. **Thin-CI → full-CI evolution:** Add workflow checks that Wave 0 deferred (CommonMark-aware link parser, recursive file discovery, fence-state tracking) as M6 follow-on work. (Tied to: M5, PR #2 CodeRabbit findings deferred as decision-pack.)

## 7. Decision Pack D1 for Scott (HITL)

**Question:** Should `constitution/05` receive a governed amendment that codifies delegated-HITL merge at Low tier?

**Context:**
- **Current practice:** Scott Graham issued standing Wave 0 merge authorization (2026-10-28) allowing Kai to merge Low-tier PRs after CodeRabbit complete + independent QAS APPROVE + green checks. HITL remains required for Deploy and High/O2 work.
- **Evidence location:** Delegation recorded in [Linear SAF-1 comment `54d37e98`](https://linear.app/cheddarfox/issue/SAF-1/), referenced from [prove/d-p1/bolt-brief.md](d-p1/bolt-brief.md) HITL gates and merge evidence rows.
- **Exit-state label:** Stays verbatim `MERGED (HITL only)` per constitution/05; prove docs cannot redefine canonical labels.

**Options:**

**A. Amend constitution/05 with `hitl_delegate` field**
- Add `hitl_delegate` (string, optional) to portable evidence schema
- Scope: Low tier only; require `hitl_delegate` to name the delegating HITL actor + authorization record link
- Exit state gains governed alternate: `MERGED (HITL)` when `hitl_delegate` is present, `MERGED (HITL only)` when HITL direct
- **Pros:** Machine-readable delegation; no prose ambiguity; preserves HITL authority while enabling velocity at Low tier
- **Cons:** Requires constitution amendment (governed change); adds schema complexity

**B. Keep evidence-only convention**
- No schema change; delegation continues to be recorded as evidence prose (actor + gate annotations)
- Exit state stays `MERGED (HITL only)` in all cases
- **Pros:** No constitution change; simpler schema; current practice already works
- **Cons:** Delegation is prose-only, not machine-readable; exit-state label ambiguous (doesn't distinguish direct vs delegated)

**C. Drop delegation; Scott merges everything**
- All merges wait for Scott's explicit HITL approval, regardless of tier
- **Pros:** Simplest governance model; unambiguous HITL responsibility
- **Cons:** Sacrifices M6 velocity; Scott becomes bottleneck for Low-tier docs changes

**Delivery's recommendation:** **Option A** (amend with `hitl_delegate` field).

**Rationale:**
- Wave 0 proved Low-tier delegation works (PR #3 71 min, PR #4 58 min cycles with delegated merge)
- Evidence-only approach (option B) delivered the outcome but left governance ambiguous (PR #4 required QAS override of a conflicting AC to keep the canonical label)
- Machine-readable delegation enables future automation (e.g. CI enforcement: block non-delegate merge at Low tier when delegation is active)
- Governed amendment preserves HITL authority: Scott controls who holds `hitl_delegate` and under what conditions

**Risks:**
- **Governance complexity:** Adding a constitution field requires Scott's explicit concur and versioning discipline
- **Abuse potential:** Delegated actor must remain independent (current: Kai as GM/QAS, not implementer); delegation scope must stay narrow (Low tier only)
- **Audit trail:** Requires durable authorization record (current: Linear SAF-1 comment); must not expire or become unresolvable

**What would change if approved:**
- `constitution/05-evidence-and-linear.md`: Add `hitl_delegate` field to evidence schema (§ Evidence Format), document scope/constraints (Low tier, named HITL actor, authorization link required), add governed exit state `MERGED (HITL)` with delegation semantics
- `templates/delivery-bolt-brief.md`: Add `hitl_delegate` field to Evidence table, update HITL gate wording to permit delegation at Low tier with authorization annotation
- `prove/d-p1/bolt-brief.md` (as example): Retroactively document `hitl_delegate` field in evidence rows where Kai merged under Scott's standing auth
- `.github/workflows/`: Optionally add CI check to enforce delegation rules (e.g. reject PR merge if `hitl_delegate` field present but no authorization link, or if tier > Low)

**Status:** **Awaiting Scott concur.** Constitution remains untouched pending decision. If approved, Delivery will prepare the amendment PR (SAF-6 or follow-on epic). If declined, current evidence-only practice (option B) continues with documented ambiguity accepted.

---

**Document ends.** Retro complete at 2026-10-29. See [prove/README.md](README.md) for Wave 0 checklist outcomes.
