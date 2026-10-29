# Wave 0 Meta-Cycle Retrospective

**Epic:** SAF-1 · **Delivery:** Kai & Delivery · Lead · **Date:** 2026-10-29 · **Time zone:** America/New_York (EDT)

## 1. Summary

Wave 0 delivered the initial prove cycle end-to-end:
- **SAF-1** (epic) closed
- **Constitution** merged via [PR #2](https://github.com/bybren-llc/safe-harness/pull/2) @ `740eb2a`
- **D-P1 bolt brief** merged via [PR #3](https://github.com/bybren-llc/safe-harness/pull/3) @ `acd9f389`
- **D-P1 evidence** merged via [PR #4](https://github.com/bybren-llc/safe-harness/pull/4) @ `333edff8`

All PRs passed Structure & Docs Validation, underwent CodeRabbit automated review, and received independent QAS by Kai (non-implementer) before merge.

## 2. Cycle Time

| PR | Opened (EDT) | Merged (EDT) | Duration | Commits | QAS Rounds | CodeRabbit Rounds |
|----|-------------|-------------|----------|---------|------------|-------------------|
| [#2](https://github.com/bybren-llc/safe-harness/pull/2) | 2026-10-28 15:12:22 | 2026-10-29 06:38:01 | ~15h 26m | 7 | 1 (APPROVE @ `fb74ba5`) | 2 reviews |
| [#3](https://github.com/bybren-llc/safe-harness/pull/3) | 2026-10-29 06:43:56 | 2026-10-29 07:54:42 | ~1h 11m (71 min) | 2 | 2 (CHANGES @ `0952071`, APPROVE @ `41b969f`) | 2 reviews |
| [#4](https://github.com/bybren-llc/safe-harness/pull/4) | 2026-10-29 07:58:13 | 2026-10-29 08:56:31 | ~58 min | 2 | 2 (CHANGES @ `2c3a821`, APPROVE @ `067053f`) | 1 review |

**Evidence:**
- PR #2 timestamps: https://github.com/bybren-llc/safe-harness/pull/2
- PR #3 timestamps: https://github.com/bybren-llc/safe-harness/pull/3, merge SHA `acd9f389bc1f54ab79dbfa1e9732a80c957a10d0`
- PR #4 timestamps: https://github.com/bybren-llc/safe-harness/pull/4, merge SHA `333edff8`

**Notes on QAS rounds:** QAS verdicts were posted as COMMENTED reviews with "APPROVE" or "CHANGES NEEDED" in the review body because reviews came from the PR-authoring GitHub account (`cheddarfox`), which GitHub blocks from using REQUEST_CHANGES or APPROVE review states.

## 3. CodeRabbit vs QAS Catches

### PR #2 — Constitution + thin CI

**CodeRabbit findings (2 reviews, 9 actionable + 1 nitpick):**
- [Review 1 @ `ed1dc32`](https://github.com/bybren-llc/safe-harness/pull/2#pullrequestreview-5688373795): 8 actionable + 1 nitpick (Major: workflow link-check, fence validation, evidence payload, HITL gates, brief decision-pack fields, SecEng requirements, pre-construct HITL scope)
- [Review 2 @ `d629a92`](https://github.com/bybren-llc/safe-harness/pull/2#pullrequestreview-5689145897): 1 Major (QAS/SecEng N/A constraint to Low tier with rationale)

**Kai QAS findings:**
- [QAS APPROVE @ `fb74ba5`](https://github.com/bybren-llc/safe-harness/pull/2#pullrequestreview-5696343738): Verified CR Major fix (QAS/SecEng N/A rows), downgraded risk tier High→Low with written rationale (read-only non-deploy CI), SecEng N/A justified; noted thin-CI limitations as decision-pack for follow-on work

**Classification:**
- **Overlap:** QAS/SecEng N/A constraint (CR Major, QAS verified fix)
- **CR-only:** Workflow implementation details (link-check subshell bug, fence state tracking, markdown parser limits), template completeness (evidence payload fields, HITL/approver fields)
- **QAS-only:** Risk-tier downgrade authority (O2 workflow item → Low via written rationale), SecEng N/A justification review

**Implications:** CodeRabbit caught structural/implementation issues in workflow code and template completeness; QAS exercised human judgment on risk-tier classification and policy application. No critical findings escaped both.

### PR #3 — D-P1 Bolt Brief

**CodeRabbit findings (2 reviews):**
- [Review 1 @ `0952071`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-5696472789): 1 Major (evidence placeholders, actor field, exact_head mismatch)
- [Review 2 @ `41b969f`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-5696882028): 1 Minor outside-diff (M3 "used" vs "named" gate wording)

**Kai QAS findings:**
- [QAS CHANGES NEEDED @ `0952071`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-5696808123): CR Major accepted + 3 additional (exact-head should be PR not SHA, merge gate wording contradiction, model plan placeholder)
- [QAS APPROVE @ `41b969f`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-5697239991): All must-fixes verified; CR Minor carried to D-P1 follow-on as non-blocking

**Classification:**
- **Overlap:** Evidence placeholders and actor/exact_head issues (CR Major, QAS expanded scope)
- **CR-only:** M3 gate wording (Minor, non-blocking)
- **QAS-only:** Merge gate wording contradicting UoW-4, model plan placeholder

**Implications:** CodeRabbit identified data-completeness issues; QAS caught semantic inconsistencies between sections (merge gate vs UoW wording). Combined coverage prevented conflicting documentation.

### PR #4 — D-P1 Evidence + Measure

**CodeRabbit findings (1 review):**
- [Review 1 @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-5697391802): 4 actionable (Major: exit-state label must stay `MERGED (HITL only)` verbatim per constitution/05; HITL gates need delegation annotation with durable link; runtime column should be `grok-bot` not `cursor` for Kai's rows; README step 6 needs bolt-brief link)

**Kai QAS findings:**
- [QAS CHANGES NEEDED @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-5697573204): All 4 CR findings accepted as valid; #1 (exit state) overrides SAF-4 AC #3 which was wrong
- [QAS APPROVE @ `067053f`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-5698021770): All must-fixes verified; decision-pack D1 carried as non-blocking

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
**Evidence:** PR #2 had 7 commits and 2 CodeRabbit reviews spanning the overnight period; the final QAS APPROVE @ `fb74ba5` came morning of Oct 29.

### PR-event routine didn't fire for PR #4's first head
**Timeline:** PR #4 created 07:58:13 EDT; CodeRabbit review posted 12:07:20 UTC (08:07:20 EDT) for commit `2c3a821`.  
**Cause (per Delivery log):** An event-driven automation that should have triggered on CodeRabbit completion for PR #4's first head didn't fire as expected.  
**Impact:** Minor delay; workflow continued manually.  
**Evidence:** [CodeRabbit review timestamp](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-5697391802) vs PR creation timestamp show ~9-minute gap, but Kai QAS at 12:19:56 UTC (08:19:56 EDT) indicates the routine gap was brief.

### Author-account review limitation
**Impact:** QAS reviews were posted from the PR-authoring GitHub account (`cheddarfox`), which GitHub blocks from using REQUEST_CHANGES or APPROVE review states, forcing COMMENTED reviews with verdict in body text.  
**Workaround:** Each QAS review explicitly stated "treat as CHANGES NEEDED" or "treat as APPROVE."  
**Visibility:** All QAS verdicts were clear and auditable; no ambiguity in merge decisions.  
**Evidence:** [PR #3 QAS CHANGES @ `0952071`](https://github.com/bybren-llc/safe-harness/pull/3#pullrequestreview-5696808123), [PR #4 QAS CHANGES @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-5697573204)

### Brief wording vs constitution/05 exit states (PR #4)
**Issue:** SAF-4 acceptance criteria asked to relabel the exit state from `MERGED (HITL only)` to an alternate phrasing. QAS rejected this in PR #4: prove docs cannot redefine constitution/05 labels.  
**Resolution:** CodeRabbit Major finding accepted; exit-state label restored verbatim; delegation recorded as evidence per [Linear SAF-1 comment `54d37e98`](https://linear.app/cheddarfox/issue/SAF-1#comment-54d37e98).  
**Decision pack:** Carried as D1 — should constitution/05 gain a governed amendment for delegated-HITL merge at Low tier?  
**Evidence:** [PR #4 CodeRabbit review](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-5697391802), [QAS CHANGES NEEDED @ `2c3a821`](https://github.com/bybren-llc/safe-harness/pull/4#pullrequestreview-5697573204)

## 5. M1–M6 Status

| Metric | Status | Evidence |
|--------|--------|----------|
| **M1** (Multi-runtime template ships) | Unexercised | No template shipped; Wave 0 delivered constitution docs and prove baseline only. Pass signal: one template path works for Claude Code, Codex, Cursor, local, Grok Bot |
| **M2** (tmux not required) | Unexercised | Not tested in Wave 0; no tmux ceremony documented but happy-path team run without Dark Factory/tmux not explicitly proven. Pass signal: happy-path team run without Dark Factory/tmux; tmux optional accelerator |
| **M3** (SAFe + AI-DLC spine retained) | Met | [D-P1 bolt brief](d-p1/bolt-brief.md) names and teaches: Bolts (SAF-3), Units of Work (4 UoWs), business-context HITL gate (named at Low tier, N/A per Low-tier exception); exercised across PRs #2–#4. Pass signal: Bolts / Units of Work / Mob Elaboration / human business-context gate named and taught |
| **M4** (Round Table seats map) | Met | Explicit map documented in [bolt brief](d-p1/bolt-brief.md#header) and exercised: Scott=HITL/POPM, Kai=GM/QAS/merge, Delivery·Lead=implement/PR owner; matches Round Table ↔ harness seats. Pass signal: explicit map Scott / Kai / Ops / Delivery / Studio / Librarian / Scout + SAW roles ↔ harness seats |
| **M5** (Time-to-first owned ticket) | Partially exercised | SAF-3 and SAF-4 picked up and owned end-to-end by Delivery·Lead (CloudAgent delegate) under exit states; no target SLA defined or measured for "time-to-first". Pass signal: new seat picks up and owns a ticket end-to-end under exit states within target SLA |
| **M6** (Deploy/release flow health) | Met | Spine A: evidence → independence (Kai QAS ≠ implementer) → HITL decision pack → CD green (Structure & Docs Validation) without freezing train. PR #3 cycle 71 min, PR #4 cycle 58 min; all [PRs #2](https://github.com/bybren-llc/safe-harness/pull/2)–[#4](https://github.com/bybren-llc/safe-harness/pull/4) merged continuously. Pass signal: Spine (A): evidence → independence → HITL decision pack → CD green without freezing the train |

**Baseline (from [d-p1/bolt-brief.md](d-p1/bolt-brief.md#measure)):**
- M1, M2 explicitly noted as "not exercised in D-P1"
- M3, M4, M6 targeted and delivered; M5 partially exercised (no target SLA)

## 6. Wave 1 Proposals

1. **CR-completion trigger reliability:** Investigate and harden the PR-event routine that didn't fire for PR #4's first head. Consider fallback polling or manual trigger if event-driven approach remains brittle. (Tied to: PR #4 stall finding.)

2. **HITL delegation evidence field:** Propose `hitl_delegate` evidence field for Low-tier delegated-HITL merge, so delegation is machine-readable in constitution/05 evidence schema instead of prose-only. Requires governed amendment (see D1 below). (Tied to: PR #4 governance finding, decision-pack D1.)

3. **Multi-runtime template:** Ship one template path that works for Claude Code, Codex, Cursor, local, and Grok Bot to fully exercise M1. (Tied to: M1 unexercised.)

4. **tmux-optional prove:** Document and prove happy-path team run without Dark Factory/tmux to exercise M2. (Tied to: M2 unexercised.)

5. **Time-to-first-ticket SLA:** Define target SLA for M5 and measure a new seat picking up and owning a ticket end-to-end under exit states. (Tied to: M5 partially exercised; no target SLA defined in Wave 0.)

6. **CI/CD hardening:** Add workflow checks for thin-CI limitations identified in PR #2 (CommonMark-aware link parser, recursive file discovery, fence-state tracking) to strengthen M6 CD green signal. (Tied to: M6 met with thin CI; PR #2 thin-CI limitations deferred as follow-on work.)

## 7. Decision Pack D1 for Scott (HITL)

**Question:** Should `constitution/05` receive a governed amendment that codifies delegated-HITL merge at Low tier?

**Context:**
- **Current practice:** Scott Graham issued standing Wave 0 merge authorization (2026-10-28) allowing Kai to merge Low-tier PRs after CodeRabbit complete + independent QAS APPROVE + green checks. HITL remains required for Deploy and High/O2 work.
- **Evidence location:** Delegation recorded in [Linear SAF-1 comment `54d37e98`](https://linear.app/cheddarfox/issue/SAF-1#comment-54d37e98), referenced from [prove/d-p1/bolt-brief.md](d-p1/bolt-brief.md) HITL gates and merge evidence rows.
- **Exit-state label:** Stays verbatim `MERGED (HITL only)` per constitution/05; prove docs cannot redefine canonical labels.

**Options:**

**A. Amend constitution/05 with structured `hitl_delegate` field**
- Add `hitl_delegate` (structured object, optional) to portable evidence schema with fields:
  - `delegating_actor` (string): the HITL actor who granted delegation (e.g. "Scott Graham")
  - `delegate_actor` (string): the actor authorized to merge (e.g. "Kai")
  - `authorization_url` (string): durable link to the authorization record
  - `scope` (string): delegation scope (e.g. "low" for Low-tier only)
- Exit state gains governed label: `MERGED (HITL-delegated)` when `hitl_delegate` is present; `MERGED (HITL only)` remains unchanged for direct HITL merge
- **Pros:** Machine-readable delegation; no prose ambiguity; preserves HITL authority while enabling velocity at Low tier; distinct exit labels clarify direct vs delegated
- **Cons:** Requires constitution amendment (governed change); adds schema complexity

**B. Keep evidence-only convention**
- No schema change; delegation continues to be recorded as prose-only evidence (actor + gate annotations)
- Exit state stays `MERGED (HITL only)` in all cases
- **Pros:** No constitution change; simpler schema; current practice already works
- **Cons:** Delegation is prose-only, not machine-readable; exit-state label doesn't distinguish direct vs delegated

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
- **Audit trail:** Requires durable authorization record (current: [Linear SAF-1 comment `54d37e98`](https://linear.app/cheddarfox/issue/SAF-1#comment-54d37e98)); must not expire or become unresolvable

**What would change if approved:**
- `constitution/05-evidence-and-linear.md`: Add structured `hitl_delegate` field (delegating_actor, delegate_actor, authorization_url, scope) to evidence schema (§ Evidence Format), document scope/constraints (Low tier only), add governed exit state `MERGED (HITL-delegated)` with delegation semantics; keep `MERGED (HITL only)` unchanged for direct HITL merge
- `templates/delivery-bolt-brief.md`: Add `hitl_delegate` field to Evidence table, update HITL gate wording to permit delegation at Low tier with authorization annotation
- `prove/d-p1/bolt-brief.md` (as example): Retroactively document `hitl_delegate` field in evidence rows where Kai merged under Scott's standing auth
- `.github/workflows/`: Optionally add CI check to enforce delegation rules (e.g. reject PR merge if `hitl_delegate` field present but no authorization link, or if tier > Low)

**Status:** **Awaiting Scott concur.** Constitution remains untouched pending decision. If approved, Delivery will prepare the amendment PR (SAF-6 or follow-on epic). If declined, current evidence-only practice (option B) continues with documented ambiguity accepted.

---

**Document ends.** Retro complete at 2026-10-29. See [prove/README.md](README.md) for Wave 0 checklist outcomes.
