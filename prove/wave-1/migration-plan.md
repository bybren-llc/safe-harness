# Migration Plan — Linear to GitHub (Wave 1)

**Status:** Proposed (pending Scott concurrence)  
**Scope:** safe-harness repository only (other Linear teams like STO untouched)  
**Owner:** Delivery (Kai coordinates cutover timing with Scott)

---

## Overview

This plan transitions safe-harness from Linear to GitHub Issues while preserving all Linear history as a read-only archive. **Never delete Linear history.** Every existing Linear evidence URL must remain resolvable.

## Archive strategy

### Linear remains accessible

- Linear workspace: `cheddarfox`
- Historical issues: SAF-1 through SAF-5 (and any others created before cutover)
- **Access:** Read-only archive; never delete
- **Evidence preservation:** All Linear evidence URLs remain valid and resolvable
- **Citation:** Link to Linear issues directly when referencing historical context

### SAF-n to GitHub Issue mapping

**Frozen mapping table:** `trace/linear-saf-map.csv`

This CSV will be populated before Linear retirement with actual mappings:

```csv
saf_id,linear_url,github_issue,title,status
SAF-1,https://linear.app/cheddarfox/issue/SAF-1/...,#1,ADR pack concur,Archived
SAF-3,https://linear.app/cheddarfox/issue/SAF-3/...,#3,D-P1 delivery bolt,Archived
SAF-4,https://linear.app/cheddarfox/issue/SAF-4/...,#4,D-P1 evidence + measure,Archived
SAF-5,https://linear.app/cheddarfox/issue/SAF-5/...,TBD,Wave 0 retro,Active
```

**During Wave 1:** The mapping table header exists but has no fake issue numbers. Populate it during migration execution (after Scott concurrence).

---

## Migration phases

### Phase 1: Preparation (Wave 1 PR lands)

**Done when:**
- [ ] Scott concurs on constitution/05 amendment
- [ ] Wave 1 PR merged to main
- [ ] GitHub Issue templates available (`.github/ISSUE_TEMPLATE/`)
- [ ] Labels documented (`.github/labels.yml`)
- [ ] Trace-check CI operational (bootstrap mode)

**Duration:** Immediate (gated on Scott concurrence)

### Phase 2: Parallel operation (transition window)

**Done when:**
- [ ] Create GitHub Issues for SAF-1 through SAF-5 (archive mirrors)
- [ ] Populate `trace/linear-saf-map.csv` with actual mappings
- [ ] Test GitHub Issues workflow with one new work item
- [ ] Verify trace-check CI on a test PR
- [ ] Announce cutover date to team (Scott + Kai agreement)

**Duration:** TBD (set after Scott concurrence)

**Activities:**
- Create GitHub Issues mirroring Linear historical context (no duplication of full bodies; link back to Linear)
- Update evidence references in prove/ to include GitHub Issue numbers
- Train team on GitHub conventions (branch naming, commit trailers, PR body requirements)

### Phase 3: Cutover

**Cutover date:** TBD (Kai sets after Scott concurrence)

**Cutover actions:**
1. Freeze Linear writes (safe-harness team stops creating/updating Linear issues)
2. Mark Linear workspace read-only for safe-harness
3. Commit final `trace/linear-saf-map.csv` to main
4. Switch default work tracking to GitHub Issues
5. Update documentation to reference GitHub as SoR

**Done when:**
- [ ] Linear writes frozen for safe-harness
- [ ] All active work migrated to GitHub Issues
- [ ] Team using GitHub Issues for new work
- [ ] trace/linear-saf-map.csv committed and complete

### Phase 4: Archive maintenance

**Ongoing:**
- Linear history remains accessible indefinitely
- Evidence URLs continue to resolve
- `trace/linear-saf-map.csv` maps historical references
- New work uses GitHub Issues exclusively

---

## Evidence preservation

### Linear evidence URLs remain valid

Wave 0 evidence in `prove/d-p1/bolt-brief.md` and Linear comments/reviews remain accessible:

- SAF-1: https://linear.app/cheddarfox/issue/SAF-1/... (concur comment)
- SAF-3: https://linear.app/cheddarfox/issue/SAF-3/... (D-P1 bolt)
- SAF-4: https://linear.app/cheddarfox/issue/SAF-4/... (evidence follow-up)
- SAF-5: https://linear.app/cheddarfox/issue/SAF-5/... (Wave 0 retro)

**No URL changes required.** Continue citing these URLs in documentation and trace maps.

### Evidence schema update

Wave 0 evidence used `linear_issue` field.  
Wave 1+ evidence uses `issue` field (GitHub Issue `#N`).

Both are valid; tooling will handle both formats during transition.

---

## Open questions (resolve before cutover)

1. **Label creation:** Manual or automated? (Documented in `.github/labels.yml` only during Wave 1)
2. **Milestone creation:** When to create "Wave 1", "Wave 2", etc. milestones?
3. **PR #5 (SAF-5 Wave 0 retro):** Migrate to GitHub Issue or close in place?

---

## Rollback plan

If critical issues arise during cutover:

1. Reopen Linear writes for safe-harness
2. Continue using Linear as temporary SoR
3. Investigate and resolve GitHub Issues workflow blockers
4. Retry cutover after fixes validated

**No data loss:** Linear history always preserved; GitHub Issues are additive.

---

## Other Linear teams (out of scope)

- **STO** and other Linear teams remain on Linear
- This migration affects **safe-harness only**
- No organization-wide Linear retirement
- Other teams may adopt GitHub Issues independently on their own timeline

---

## Success criteria

Migration is complete when:
- [ ] All active safe-harness work tracked in GitHub Issues
- [ ] `trace/linear-saf-map.csv` committed with complete mappings
- [ ] Team trained and using GitHub conventions
- [ ] Trace-check CI operational and green
- [ ] Linear archive accessible and evidence URLs resolve
- [ ] Zero Linear writes for safe-harness post-cutover
