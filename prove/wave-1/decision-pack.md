# Decision Pack — Wave 1: Repo-only Source of Truth

**PR:** TBD (to be set after PR creation)  
**Branch:** wave-1-repo-sot  
**Exact-head:** TBD (to be set after commit)  
**Status:** Awaiting Scott concurrence

**Owner:** Kai (coordinator)  
**Delivery:** Cursor CloudAgent  
**Tier:** Proposed Medium (O2: deploy CI / workflows touched; downgrade decision pending Kai at QAS)

---

## Executive summary

Wave 1 transitions safe-harness to **repository-only source of truth**. GitHub becomes the sole SoR for intent, spec, plan, requirements, trace map, review findings, and evidence. Linear is archived read-only. Constitution changes require Scott's explicit concurrence before merge.

**Key changes:**
1. constitution/05 amendment (repo as SoR, human/agent ownership split, trace enforcement)
2. constitution/03 amendment (GitHub conventions replace Linear)
3. Requirements tracing framework (REQ-<CMP>-NNN, trace map, trace-check CI)
4. CODEOWNERS: intent/spec human-owned (Scott only); requirements, trace and constitution are agent-authored behind a @cheddarfox review gate
5. GitHub Issue templates and label scheme
6. Migration plan (Linear → GitHub)

**O2 note:** This PR touches CI workflows (`.github/workflows/trace-check.yml`), an O2 high-risk item. See high-risk checklist and downgrade rationale below.

---

## Team concur record

**Note:** Scott's concurrence is separate and PENDING (see ## Ask section). Kai is coordinator, not a seat.

| Seat | Concur Status | Conditions (verbatim) | Link/Timestamp | Satisfied in PR |
| --- | --- | --- | --- | --- |
| **Studio** | Concurred (relayed via Kai, 2026-10-29 ~9:49 AM ET) | Verbatim pending from Kai | N/A | TBD |
| **Scout** | Concurred (relayed via Kai, 2026-10-29 ~9:49 AM ET) | Verbatim pending from Kai | N/A | TBD |
| **Librarian** | Concurred (relayed via Kai, 2026-10-29 ~9:49 AM ET) | Verbatim pending from Kai | N/A | TBD |
| **Ops** | Concurred (relayed via Kai, 2026-10-29 ~9:49 AM ET) | Verbatim pending from Kai | N/A | TBD |
| **Delivery** | Concurred (relayed via Kai, 2026-10-29 ~9:49 AM ET) | Delivery's conditions as sent to Kai, ~9:49 AM ET (summary):<br>(1) Scott concurs on the pack in his own words before the constitution merge<br>(2) CODEOWNERS on intent/spec<br>(3) trace-check bootstrap rule, warn-only until the first spec with REQs<br>(4) independence rules unchanged, and HITL delegation stays Low tier only<br>(5) migration archives Linear, doesn't delete it, and keeps SAF URLs resolvable via linear-saf-map.csv<br>(6) the O2 downgrade is Kai's or Scott's written call | ~9:49 AM ET | (1) decision-pack.md:697-709 (Ask section)<br>(2) .github/CODEOWNERS:7-9<br>(3) .github/workflows/trace-check.yml:39-40, constitution/05:127-129<br>(4) constitution/05:97-108 (D1), constitution/03:61-70 (independence)<br>(5) prove/wave-1/migration-plan.md:105-109, trace/linear-saf-map.csv:1<br>(6) decision-pack.md:571-574, :659-662 |

**Verbatim conditions pending:** Studio, Scout, Librarian, and Ops conditions to be provided by Kai with verifiable source text.

---

## Constitution changes (requires Scott concurrence)

All constitution changes are marked **"Proposed, pending Scott concurrence"** and effective only after Scott's explicit approval.

### Decision 1: Repository as sole source of truth

**Context:** Wave 0 used Linear as SoR. Wave 1 moves to GitHub repo-only.

**Options:**
1. **[RECOMMENDED]** Repo-only: GitHub repo is sole SoR; Linear archived read-only
2. Dual SoR: Keep Linear + GitHub in parallel (complexity, drift risk)
3. Status quo: Continue with Linear (misaligned with repo-native workflow)

**Recommendation:** Option 1 (repo-only). Aligns with repo-native evidence, simplifies handoffs, enables audit via git history.

**Risks:**
- Team learning curve on GitHub conventions
- Evidence migration overhead
- Potential Linear→GitHub mapping gaps

**Mitigations:**
- Structured GitHub Issue templates
- Comprehensive migration plan with mapping table
- Linear archive preserved (no deletion)
- Bootstrap CI rule (warn-only until first spec lands)

**Status:** Awaiting Scott concurrence

---

### Decision 2: Human vs. agent ownership split

**Context:** Define clear boundaries for human-owned design vs. agent-owned execution.

**Proposal:**

**Humans (Scott only) own and accept only intent.md and spec.md:**
- `intent.md`, `spec.md` — Scott owns and accepts; agents may propose edits but **never merge**

**Agents own everything else end-to-end:**
- Plan, GitHub Issues, code, tests, PRs, evidence
- **Requirements registry** (`requirements/`) — agents author; human-reviewed PR required (CODEOWNERS: @cheddarfox)
- **Trace map** (`trace/`) — agents author; human-reviewed PR required (CODEOWNERS: @cheddarfox)
- **Constitution changes** — agents author; human-reviewed PR required (CODEOWNERS: @cheddarfox)
- **Workflows and CODEOWNERS** — agents author; human-reviewed PR required (CODEOWNERS: @cheddarfox)

**CODEOWNERS = review gate, not ownership:**

`.github/CODEOWNERS` requires @cheddarfox review for:
- `intent.md`, `intent/`, `spec.md` (human-owned design)
- `requirements/` (agent-authored, human review required)
- `constitution/` (agent-authored, human review required)
- `trace/` (agent-authored, human review required)

**Studio write path:** Studio drafts intent.md + spec.md → Delivery commits in PR → Scott approves via CODEOWNERS.

**Distinction:** Humans own design (accept/reject intent and spec content). Agents own execution (author requirements, trace, constitution changes, code, tests), but CODEOWNERS enforces human review gates before merge.

**Risks:**
- Potential bottleneck on human reviews
- Agent workflow friction on CODEOWNERS gates

**Mitigations:**
- Clear templates reduce review friction
- Agents propose edits; humans approve quickly
- Most work (code, tests, PRs) remains agent-owned

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 3: Requirements = definition of success

**Context:** Requirements (REQ-<CMP>-NNN) are derived from spec.md and define success criteria.

**Proposal:**
- Each requirement has: source (spec anchor), exit_criterion (pass/fail), metric (M1–M6 tie)
- Trace states: Placed / Deferred / Dropped / Missing
- Deferred/Dropped need: rationale, decided_by, decided_at
- Deferred needs: defer_to (target date/milestone)
- Dropping REQ from intent.md needs Scott's sign-off

**Special rule:** Dropping a REQ whose source is `intent.md#*` requires `decided_by: Scott Graham`.

**Trace-check CI enforcement:**
- Fail on Missing state
- Fail on Placed requirement with no evidence
- Fail on Deferred/Dropped missing required fields

**Risks:**
- Administrative overhead on REQ tracking
- CI false positives during development
- Team resistance to structured tracing

**Mitigations:**
- Templates reduce overhead
- Bootstrap rule (warn-only until first spec lands)
- Clear schema and examples

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 4: req_ids column on evidence rows

**Context:** Evidence rows need REQ linkage for trace enforcement.

**Proposal:** Evidence schema adds `req_ids` list (alongside evidence_id, runtime, exact_head, issue, actor, gate).

Wave 0: `linear_issue`  
Wave 1: `issue` (GitHub `#N`) + `req_ids` (list of REQ-<CMP>-NNN)

**Risks:**
- Breaking change from Wave 0
- Tooling updates required

**Mitigations:**
- Both formats valid during transition
- Clear migration path in trace/schema.md
- Examples in prove/wave-1/

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 5: D1 delegated-HITL at Low tier

**Context:** Enable HITL delegation for Low-tier work (e.g., docs-only changes).

**Proposal:** New exit label `MERGED (HITL-delegated)` usable only at Low tier, with structured `hitl_delegate` record:

```yaml
hitl_delegate:
  delegating_actor: Scott Graham
  delegate_actor: Kai
  authorization_url: <link>
  scope: low  # Must be "low" only
```

**Restrictions:**
- Low tier only
- Delegation explicit, recorded, scoped
- Delegate may not further delegate

**Risks:**
- Delegation abuse (using at Med/High)
- Unclear delegation boundaries

**Mitigations:**
- CI enforces Low tier only
- Structured record with authorization URL
- Distinct exit label (differentiated from HITL only)

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 6: GitHub conventions replace Linear

**Context:** constitution/03 currently references Linear (SAF-N branches, Linear issue links).

**Proposal:** Update constitution/03 to document GitHub conventions:
- Branch: `<issue#>-slug` (replaces `SAF-N-slug`)
- Commit prefix: `[wave-1]` (no Linear SAF tags)
- Commit trailers: `Refs #N` + `Req: REQ-<CMP>-NNN`
- PR body: `Requirements: REQ-<CMP>-NNN, ...` line

**Risks:**
- Team muscle memory on old conventions
- Documentation lag during transition

**Mitigations:**
- CONTRIBUTING.md documents new conventions
- Examples in prove/wave-1/
- Migration plan includes team training

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 7: Personal boundary rule

**Context:** Never include personal-vault content, story IP, or NAS-private facts in repo.

**Proposal:** Add personal-boundary rule to:
- CONTRIBUTING.md
- intent.md preamble
- spec.md preamble

**Rule:** Cite by concept name only; never paste actual IPs, tokens, paths, personal details.

**Risks:**
- Accidental leaks during agent/human contributions
- Unclear boundary definition

**Mitigations:**
- Explicit rule in high-visibility files
- Examples in CONTRIBUTING.md
- QAS checks for violations

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 8: Trace map Deferred/Dropped metadata

**Context:** Deferred and Dropped REQs need decision provenance.

**Proposal:** Deferred/Dropped entries must carry:
- `rationale` (why deferred/dropped + conditions)
- `decided_by` (decision owner: Scott, Kai, or "Scott + Kai")
- `decided_at` (ISO 8601 date)
- `defer_to` (for Deferred only: target date or milestone)

**Special rule:** Dropping REQ from intent.md needs Scott sign-off recorded.

**Deferred dates:** Live in trace map only, never in GitHub Issue fields.

**Risks:**
- Administrative overhead
- Incomplete decision records

**Mitigations:**
- Trace-check CI enforces required fields
- Template examples in trace/schema.md

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 9: arch/components.yaml seeding order

**Context:** Need component registry before REQ-<CMP>-NNN IDs can be assigned.

**Proposal:** Seed arch/components.yaml first in Wave 1, mark "pending Kai approval". Components:
- ARC-CON (Constitution)
- ARC-ADP (Adapters)
- ARC-ROL (Roles)
- ARC-TPL (Templates)
- ARC-PRV (Prove)
- ARC-TRC (Trace)
- ARC-WFL (Workflows)

**Risks:**
- Component list incomplete
- Naming collisions or ambiguity

**Mitigations:**
- Seeded from actual repo structure (no invented product components)
- Marked "pending Kai approval" for review
- Extensible (add components as needed)

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 10: Templates (intent, spec, trace schema, M1–M6 pointer)

**Context:** Provide structured templates for intent.md, spec.md (human-owned: Scott only), and trace map (agent-authored).

**Proposal:** Create:
- intent.md (with research appendix: fit band, license, footprint, sources, UNKNOWN markers)
- spec.md (with personal-boundary rule, M1–M6 pointer)
- trace/schema.md (state vocabulary: Placed/Deferred/Dropped/Missing, required fields)
- trace/trace-map.yaml (fixed path)

**Risks:**
- Template incompleteness
- Mismatch between template and enforcement

**Mitigations:**
- Templates aligned with trace-check CI
- Examples in comments
- Iterative refinement post-Wave 1

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 11: Migration plan scope and frozen mapping table

**Context:** Linear SAF-1 through SAF-5 need GitHub Issue equivalents.

**Proposal:**
- Migration plan: prove/wave-1/migration-plan.md
- Frozen mapping table: trace/linear-saf-map.csv (header-only stub now; populate before cutover)
- Archive Linear (never delete); every Linear evidence URL remains resolvable
- Scope: safe-harness only (other Linear teams like STO untouched)
- Cutover date: TBD (set after Scott concurrence)
- Owner: Delivery (Kai coordinates timing with Scott)

**Risks:**
- Mapping gaps or lost context
- Cutover disruption
- Team confusion during parallel operation

**Mitigations:**
- Phased migration (prep → parallel → cutover → archive)
- Complete mapping table before cutover
- Linear preserved indefinitely
- Team training on GitHub conventions

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 12: CI scope (blocking vs. non-blocking)

**Context:** Trace-check CI needs to fail fast on repo-internal gaps but not on external transient issues.

**Proposal:**
- **Blocking trace-check** (`.github/workflows/trace-check.yml`): Repo-internal gaps only (REQ with no ARC, Missing state, Placed with no evidence, Deferred/Dropped missing fields)
- **Non-blocking scheduled check** (separate workflow, read-only): Cross-system link validation, external URLs, spec anchor existence

**Bootstrap rule:** Trace-check runs **warn-only** until first spec.md with REQ IDs lands, then becomes **blocking**. This allows Wave 1 to land without failing its own gate.

**Risks:**
- CI noise during bootstrap
- False confidence from warn-only mode
- External link checks not enforced

**Mitigations:**
- Clear bootstrap rule documented in constitution/05 and trace/schema.md
- Non-blocking external checks catch link rot separately
- Explicit transition from warn-only → blocking

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 13: Evidence canonical in repo; vaults cite by link

**Context:** Avoid evidence duplication across repo and private vaults.

**Proposal:** Evidence for safe-harness is canonical in the repo. Vaults (personal, NAS) and Atlas cite evidence by link without duplicating it.

**Risks:**
- Vault access friction (need repo access to see evidence)
- Privacy boundary violations if repo cited from personal vault

**Mitigations:**
- Personal-boundary rule enforced
- Repo is accessible to authorized team
- Vaults reference by concept + link, no duplication

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 14: GitHub milestones per wave

**Context:** Organize work by wave (Wave 1, Wave 2, etc.).

**Proposal:** Document one GitHub milestone per wave in `.github/labels.yml` commentary. Create milestones manually or via approved automation after Scott concurrence. Do not create via API during Wave 1.

**Risks:**
- Milestone creep or misalignment
- Manual creation overhead

**Mitigations:**
- One milestone per wave (clear scope)
- Document only during Wave 1
- Automation post-concurrence

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 15: needs-scott-concur label

**Context:** PRs changing intent, spec, or constitution need Scott's review before merge.

**Proposal:** Add `needs-scott-concur` label (distinct from general `needs-concur`). Required on any PR touching:
- intent.md, intent/
- spec.md
- constitution/
- requirements/ (REQ changes)
- trace/ (trace map changes)

**Risks:**
- Label misuse or omission
- Scott bottleneck

**Mitigations:**
- CODEOWNERS enforcement (Scott must approve)
- Label documented in `.github/labels.yml`
- Clear workflow in CONTRIBUTING.md

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 16: Cycle time metrics

**Context:** Define cycle time for M6 measurement.

**Proposal:** Add cycle time definitions to constitution/05:
- **Primary:** First PR opened to merge (PR lifecycle)
- **Secondary:** Issue opened to closed (issue lifecycle)

Report per Bolt in prove/ records. Track blocking gates separately (QAS turnaround, HITL turnaround).

**Risks:**
- Gaming metrics (optimizing for cycle time over quality)
- Incomplete gate tracking

**Mitigations:**
- Secondary metric (issue lifecycle) cross-checks
- Gate turnaround tracked separately
- Empirical comparison (constitution/06)

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 17: Trace map fixed path

**Context:** Fix trace map path for consistent tooling.

**Proposal:** Trace map at `trace/trace-map.yaml` (fixed). Seed as stub. trace-check CI reads this path. Document in README.md.

**Risks:**
- Path conflicts (if multiple trace maps needed)
- Tooling lock-in to single file

**Mitigations:**
- Single source of truth (no multiple trace maps)
- Extensible format (YAML supports large files)
- Documented in trace/schema.md

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 18: Rename constitution/05-evidence-and-linear.md (follow-up)

**Context:** constitution/05 filename still references "linear" despite Wave 1 moving to GitHub-only. Renaming in this PR would break existing links in Wave 0 documentation.

**Proposal:** Propose rename as a follow-up PR after Wave 1 lands:
- Current: `constitution/05-evidence-and-linear.md`
- Proposed: `constitution/05-evidence-and-trace.md` or `constitution/05-source-of-truth.md`

**Why not in Wave 1:**
- Breaking change for existing links in prove/d-p1/bolt-brief.md and other Wave 0 docs
- Filename change is cosmetic; content update is substantive
- Cleaner to land content change first, then rename

**Recommendation:** Approve the follow-up rename principle; exact new filename TBD (Kai decides).

**Risks:**
- Filename remains misaligned with content temporarily
- Link rot if rename not coordinated

**Mitigations:**
- Follow-up PR updates all internal links atomically
- Git preserves file history across rename
- Search for "05-evidence-and-linear" confirms all references updated

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

### Decision 19: Sticky blocking mode for trace-check

**Context:** Today, removing REQ IDs from `spec.md` would drop trace-check back to warn-only (bootstrap rule). This could allow requirements to be silently removed.

**Proposal:** Enable sticky blocking mode via one or both mechanisms:
1. Turn on "require code owner review" on `main` branch protection (GitHub setting)
2. Add a CODEOWNED `trace/.blocking` marker file in a follow-up

**Current mitigation:** `spec.md` is CODEOWNED (@cheddarfox), so Scott must approve any changes. This works *only if* branch protection requires code-owner review.

**Known limitation:** The authoring account (`cheddarfox`) cannot satisfy CODEOWNERS on its own PRs; Kai posts COMMENT reviews for that reason. This limits the effectiveness of CODEOWNERS as a gate without branch protection enabled.

**Additional context:** External link-check stays separate and non-blocking (Librarian's spec + weekly routine after merge).

**Options:**
1. **[RECOMMENDED]** Enable "require code owner review" on `main` + add `trace/.blocking` marker in follow-up (defense in depth)
2. Enable "require code owner review" on `main` only (relies on GitHub branch protection)
3. Add `trace/.blocking` marker only (relies on CODEOWNERS without branch protection)
4. Status quo (accept that removing REQ IDs returns to warn-only)

**Recommendation:** Option 1. Both mechanisms together provide defense in depth.

**Risks:**
- Branch protection may slow down Low-tier merges
- `trace/.blocking` adds a file dependency
- Known limitation: authoring account cannot self-satisfy CODEOWNERS

**Mitigations:**
- HITL delegation (D1) already addresses Low-tier velocity
- `trace/.blocking` is simple and explicit
- Branch protection + external reviews handle authoring-account limitation

**Status:** Awaiting Scott concurrence (see Team concur record above)

---

## O2 high-risk checklist (constitution/03)

This PR touches **Deploy CI / workflows** (O2 item):
- [x] Pricing — N/A
- [x] Refunds — N/A
- [x] Auth — N/A
- [x] **Deploy CI / workflows — YES** (`.github/workflows/trace-check.yml` added)
- [x] Prod secrets — N/A
- [x] Privacy-boundary crosses — N/A (personal-boundary rule added as safeguard)

**Downgrade rationale (proposed by Delivery; downgrade decision pending Kai in writing at QAS):**

O2 item "Deploy CI / workflows" defaults to High tier. **Proposed downgrade to Medium** is justified by:

1. **Read-only CI**: trace-check has `permissions: contents: read` only; no write, deploy, or secret access
2. **Bootstrap rule**: Runs warn-only until first spec.md lands; cannot block this PR's own merge
3. **Validation scope**: Checks YAML syntax and repo-internal gaps only; no external calls or mutations
4. **Rollback path**: Revert PR or disable workflow via GitHub UI if issues arise
5. **Independent QAS**: Kai reviews as separate actor (≠ implementer)

**Delivery's recommendation:** Medium tier acceptable. One human decision pack (this document) + QAS independence sufficient. SecEng N/A (no secrets, no deploy mutations, no auth changes).

**Kai's downgrade decision (written, PR #6 review 5699823929):** **Medium accepted, conditional.** `trace-check.yml` is read-only (`contents: read`), runs on `pull_request` not `pull_request_target`, has no secrets, does no deploys, makes no writes, and is warn-only until the first REQ-bearing `spec.md`. Rollback is a revert. **Conditions:** fixes #3 (`.github/CODEOWNERS` and `.github/workflows/` covered by CODEOWNERS) and #4 (no unpinned `latest` binary download) land on the next tip. If they don't land, the tier stays **High**. Medium still needs Scott's own concur, because this PR amends the constitution.

---

## QAS + SecEng status

| Role | Actor | Status | Rationale |
| --- | --- | --- | --- |
| **QAS** | Kai | CHANGES NEEDED @ 8bc26e0e (review 5699823929) | Independent review (≠ implementer); O2 decision: Medium accepted conditional on fixes #3 and #4 landing |
| **SecEng** | N/A | N/A | Medium tier (Kai's decision); no O2 secrets/auth/privacy mutations; read-only CI; downgrade rationale above |

---

## Requirements addressed

TBD (populate after REQ-<CMP>-NNN IDs defined in trace map)

Expected requirements:
- REQ-CON-001: Repository as sole source of truth
- REQ-CON-002: Human/agent ownership split
- REQ-TRC-001: Requirements tracing framework
- REQ-TRC-002: Trace-check CI enforcement
- REQ-WFL-001: Read-only trace-check workflow

---

## Evidence

| evidence_id | runtime | exact_head | issue | actor | gate | req_ids |
| --- | --- | --- | --- | --- | --- | --- |
| TBD | cursor | TBD | #TBD | Delivery · Lead (Cursor CloudAgent) | Implement → Ready for QAS | REQ-CON-001, REQ-TRC-001, REQ-WFL-001 |

---

## Files changed

**Constitution amendments:**
- constitution/03-cd-and-hitl.md (GitHub conventions, O2 downgrade authority)
- constitution/05-evidence-and-linear.md (repo as SoR, human/agent split, trace enforcement, cycle time, D1 delegated-HITL)

**Architecture & tracing:**
- arch/components.yaml (ARC-<CMP> registry, pending Kai approval)
- requirements/README.md (trace states, evidence linkage)
- requirements/REQ-TEMPLATE.yaml (requirement template)
- trace/schema.md (state vocabulary, required fields, M1–M6 pointer)
- trace/trace-map.yaml (stub)
- trace/linear-saf-map.csv (header-only stub)

**Human-owned templates (Scott only):**
- intent.md (skeleton with personal-boundary rule, research appendix)
- spec.md (skeleton with personal-boundary rule, M1–M6 pointer)

**GitHub configuration:**
- .github/CODEOWNERS (@cheddarfox for intent, spec, constitution, requirements, trace)
- .github/ISSUE_TEMPLATE/bolt.yml (Bolt/UoW template)
- .github/ISSUE_TEMPLATE/requirement.yml (REQ state change template)
- .github/ISSUE_TEMPLATE/decision.yml (concurrence request template)
- .github/labels.yml (work types, risk tiers, O2 items, exit states, gate labels, needs-scott-concur)

**CI workflow:**
- .github/workflows/trace-check.yml (read-only, bootstrap rule, warn-only until first spec)

**Documentation:**
- CONTRIBUTING.md (personal-boundary rule, GitHub conventions, ownership split, workflow)
- prove/wave-1/migration-plan.md (Linear → GitHub phases, evidence preservation, mapping table)
- prove/wave-1/decision-pack.md (this file)

---

## Risk summary

**High risks:**
1. Constitution changes without team alignment → **Mitigated:** Team concur record (Studio, Scout, Librarian, Ops, Delivery) above
2. CI false positives blocking work → **Mitigated:** Bootstrap rule (warn-only), read-only permissions
3. Evidence migration gaps or lost context → **Mitigated:** Linear preserved indefinitely, mapping table, phased migration
4. Personal-vault leaks to repo → **Mitigated:** Personal-boundary rule in CONTRIBUTING.md + intent/spec preambles
5. CODEOWNERS bottleneck → **Mitigated:** Clear templates, most work agent-owned (code/tests/PRs)

**Medium risks:**
1. Team learning curve on GitHub conventions
2. Trace-check CI administrative overhead
3. Deferred dates in trace map vs. issue fields (confusion)

**Low risks:**
1. Label creation method (manual vs. automation)
2. Component registry incompleteness

---

## Rollback plan

If critical issues arise post-merge:
1. Revert this PR (git revert)
2. Linear remains accessible (no writes needed; read-only archive sufficient)
3. Investigate and fix GitHub Issues workflow blockers
4. Re-propose Wave 1 after fixes

**No data loss:** Linear preserved, repo history immutable, evidence portable.

---

## Ask

**Scott:** Please review and concur on:
1. Repository as sole source of truth (Linear → GitHub)
2. Human vs. agent ownership split (Scott only owns and accepts intent.md and spec.md; agents own and author everything else with CODEOWNERS review gates)
3. Requirements tracing framework (REQ-<CMP>-NNN, trace states, trace-check CI)
4. D1 delegated-HITL at Low tier
5. All constitution/03 and constitution/05 amendments
6. O2 downgrade: Kai's decision recorded — Medium accepted conditional on fixes #3 and #4
7. Migration plan scope and timing (cutover date TBD)
8. Follow-up rename of constitution/05-evidence-and-linear.md (Decision 18)
9. Sticky blocking mode: enable "require code owner review" on `main` and/or add `trace/.blocking` marker (Decision 19)

**Kai:** After Scott concurs and fixes land:
1. QAS re-review at new exact-head (after fixes #1-12 from review 5699823929)
2. Merge decision (HITL)
3. Set Linear cutover date
4. Coordinate team training on GitHub conventions

**Note:** Kai's O2 downgrade decision already recorded above (Medium accepted conditional).

---

## MERGE HOLD

**Do not merge until:**
- [ ] Scott concurs on all constitution changes (recorded in this decision pack or PR comments)
- [ ] Kai completes QAS independence review (exact-head, separate actor ≠ implementer)
- [ ] Kai's written O2 tier decision recorded: **Medium accepted on condition that CODEOWNERS (#3: `.github/CODEOWNERS` and `.github/workflows/` covered) and the yq pin (#4: no unpinned `latest` binary download) land; otherwise it stays High** (Kai, PR #6 review 5699823929)
- [ ] If High tier: two distinct human approvals required
- [ ] CodeRabbit review complete (if applicable)
- [ ] trace-check CI green (bootstrap mode: warn-only expected)
- [ ] Wave 0 checks green (structure validation, markdown links)

**After merge:**
- Kai merges (HITL delegated or HITL only, per Scott's approval)
- Execute migration plan Phase 2 (parallel operation)
- Set Linear cutover date
- Train team on GitHub conventions

---

**Status:** Awaiting Scott concurrence  
**Next action:** Scott reviews decision pack and constitution amendments  
**Delivery owner:** Kai (coordinates with Scott)
