# Migration Plan — the issue tracker to GitHub (Wave 1)

**Status:** Proposed (pending owner concurrence)  
**Scope:** safe-harness repository only (other the issue tracker teams untouched)  
**Owner:** Delivery (QAS coordinates cutover timing with HITL)

---

## Overview

This plan transitions safe-harness from the issue tracker to GitHub Issues while preserving all the issue tracker history as a read-only archive. **Never delete the issue tracker history.** Every existing the issue tracker evidence URL must remain resolvable.

## Archive strategy

### the issue tracker remains accessible

- issue-tracker workspace: (organization-specific)
- Historical work items: archived pre-cutover items
- **Access:** Read-only archive; never delete
- **Evidence preservation:** All the issue tracker evidence URLs remain valid and resolvable
- **Citation:** Link to the issue tracker items directly when referencing historical context

### SAF-n to GitHub Issue mapping

**Frozen mapping table:** `trace/linear-saf-map.csv`

This CSV will be populated before the issue tracker retirement with actual mappings. Canonical columns match `trace/schema.md` and `trace/linear-saf-map.csv` (6 columns, including `pr`). `trace/linear-saf-map.csv` stays header-only until the migration.

Illustrative example only (placeholder values; not real mappings — do not copy into the CSV):

```csv
saf_id,linear_url,github_issue,pr,title,status
SAF-N,<linear-url>,#<issue>,#<pr>,<title>,<status>
```

**During Wave 1:** The mapping table is header-only. Populate it during migration execution (after the owner concurrence).

---

## Migration phases

### Phase 1: Preparation (Wave 1 PR lands)

**Done when:**
- [ ] Owner concurs on constitution/05 amendment
- [ ] Wave 1 PR merged to main
- [ ] GitHub Issue templates available (`.github/ISSUE_TEMPLATE/`)
- [ ] Labels created from `.github/labels.yml` (manual or automation)
- [x] First GitHub Issue created: "Trace-check blocking validations" (#7)
- [ ] Validations PR merged with `trace/.blocking` marker (creating the issue does not complete Phase 1; the marker waits on spec.md REQ IDs)
- [ ] Trace-check CI operational (bootstrap mode)

**Duration:** Immediate (gated on owner concurrence)

### Phase 2: Parallel operation (transition window)

**Done when:**
- [ ] Create GitHub Issues for archived the issue tracker items (archive mirrors)
- [ ] Populate `trace/linear-saf-map.csv` with actual mappings
- [ ] Test GitHub Issues workflow with one new work item
- [ ] Verify trace-check CI on a test PR
- [ ] Announce cutover date to team (owner + GM agreement)

**Duration:** TBD (set after owner concurrence)

**Activities:**
- Create GitHub Issues mirroring the issue tracker historical context (no duplication of full bodies; link back to the issue tracker)
- Update evidence references in prove/ to include GitHub Issue numbers
- Train team on GitHub conventions (branch naming, commit trailers, PR body requirements)

### Phase 3: Cutover

**Cutover date:** TBD (QAS sets after owner concurrence)

**Cutover actions:**
1. Freeze the issue tracker writes (team stops creating/updating the issue tracker items for safe-harness; other teams untouched)
2. Mark team read-only in issue-tracker workspace for safe-harness scope
3. Commit final `trace/linear-saf-map.csv` to main
4. Switch default work tracking to GitHub Issues
5. Update documentation to reference GitHub as SoR

**Done when:**
- [ ] the issue tracker writes frozen for safe-harness
- [ ] All active work migrated to GitHub Issues
- [ ] Team using GitHub Issues for new work
- [ ] trace/linear-saf-map.csv committed and complete
- [ ] Librarian's Linear-map freeze PR merged (row validation, `trace/linear-saf-map.sha256`, Frozen note in `schema.md`, and validation check passing)

### Phase 4: Archive maintenance

**Ongoing:**
- the issue tracker history remains accessible indefinitely
- Evidence URLs continue to resolve
- `trace/linear-saf-map.csv` maps historical references
- New work uses GitHub Issues exclusively

---

## Evidence preservation

### the issue tracker evidence URLs remain valid

Wave 0 evidence in `prove/d-p1/bolt-brief.md` and the issue tracker comments/reviews remain accessible. Archive URLs stay valid and resolvable.

**No URL changes required.** Continue citing these URLs in documentation and trace maps.

### Evidence schema update

Wave 0 evidence used `linear_issue` field.  
Wave 1+ evidence uses `issue` field (GitHub Issue `#N`).

Both are valid; tooling will handle both formats during transition.

---

## Open questions (resolve before cutover)

1. **Label creation:** Manual or automated? (Documented in `.github/labels.yml` only during Wave 1)
2. **Milestone creation:** When to create "Wave 1", "Wave 2", etc. milestones?
3. **Historical work:** Migrate to GitHub Issue or close in place?

---

## Rollback plan

If critical issues arise during cutover:

1. Reopen the issue tracker writes for team (safe-harness scope only)
2. Reconcile any GitHub-only work created during cutover attempt (copy context to the issue tracker or document in the issue tracker comments)
3. Continue using the issue tracker as temporary SoR
4. Investigate and resolve GitHub Issues workflow blockers
5. Retry cutover after fixes validated

**No data loss:** the issue tracker history always preserved; GitHub Issues are additive. Reconcile step ensures no work is orphaned.

---

## Other the issue tracker teams (out of scope)

- Other the issue tracker teams remain on Linear
- This migration affects **safe-harness only**
- No organization-wide the issue tracker retirement
- Other teams may adopt GitHub Issues independently on their own timeline

---

## Success criteria

The Phase 3 **Done when** list is authoritative. Migration is complete when those items are done, including:
- [ ] All active safe-harness work tracked in GitHub Issues
- [ ] `trace/linear-saf-map.csv` committed with complete mappings
- [ ] Librarian's Linear-map freeze PR merged (row validation, `trace/linear-saf-map.sha256`, Frozen note in `schema.md`, and validation check passing)
- [ ] Team trained and using GitHub conventions
- [ ] Trace-check CI operational and green
- [ ] the issue tracker archive accessible and evidence URLs resolve
- [ ] Zero the issue tracker writes for safe-harness post-cutover
