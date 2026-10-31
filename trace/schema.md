# Trace Map Schema — safe-harness

**Path:** `trace/trace-map.yaml`  
**Enforced by:** `.github/workflows/trace-check.yml`

---

## Requirement states (vocabulary)

The trace-check CI parses these exact state values:

| State | Meaning | Required fields |
| --- | --- | --- |
| **Placed** | Active requirement; evidence required | source, exit_criterion, metric, req_ids linkage |
| **Deferred** | Intentionally postponed | rationale, decided_by, decided_at, defer_to |
| **Dropped** | Permanently removed from scope | rationale, decided_by, decided_at |
| **Missing** | Referenced without a definition | (CI fails when blocking) |

---

## Required fields

### Placed requirements

```yaml
id: REQ-<CMP>-NNN
component: ARC-<CMP>
state: Placed
title: Brief requirement title
source: spec.md#anchor-name  # or intent.md#anchor-name
exit_criterion: |
  Concrete pass/fail condition
metric: <metric>  # a success metric defined in constitution/00
description: |
  Full requirement text
```

Evidence linkage: at least one evidence row must reference this REQ ID via `req_ids`.

### Deferred requirements

```yaml
id: REQ-<CMP>-NNN
component: ARC-<CMP>
state: Deferred
title: Brief requirement title
source: spec.md#anchor-name
rationale: |
  Why deferred and conditions for revisiting
decided_by: the GM  # or owner_identity from .github/harness.yml (exactly, for intent-sourced drops)
decided_at: YYYY-MM-DD  # ISO 8601 date
defer_to: 2026-11-15  # Target date or milestone reference
```

**Special rule:** Dropping a REQ whose `source` is `intent.md#*` requires owner sign-off. Record as `decided_by: <owner_identity>` (exactly matching `.github/harness.yml`) plus link in `rationale`.

### Dropped requirements

```yaml
id: REQ-<CMP>-NNN
component: ARC-<CMP>
state: Dropped
title: Brief requirement title
source: spec.md#anchor-name
rationale: |
  Why permanently removed
decided_by: the GM
decided_at: YYYY-MM-DD
```

**Special rule:** Dropping a REQ whose `source` is `intent.md#*` requires owner sign-off. Record as `decided_by: <owner_identity>` (exactly matching `.github/harness.yml`) plus link in `rationale`.

---

## the issue tracker to GitHub Issue mapping

**Example mapping table:** `examples/round-table/linear-saf-map.csv` (this template's instance example)

Adopters create their own mapping table for their issue tracker. The CSV file is header-only until populated before issue tracker migration:
```csv
saf_id,issue_tracker_url,github_issue,pr,title,status
```

**Columns:**
- `saf_id`: Issue tracker ID (e.g., EX-1)
- `issue_tracker_url`: Full issue tracker URL
- `github_issue`: Mirror GitHub Issue number (e.g., #1; assigned at creation, may not equal tracker ID)
- `pr`: Pull request that closed the issue (e.g., #3)
- `title`: Issue title
- `status`: Archived

**Example data (placeholders only):**
```csv
EX-1,<issue-tracker-url>,#1,#2,Example requirement,Archived
EX-2,<issue-tracker-url>,#2,#3,Example feature,Archived
```

Populate the actual mapping for your instance before issue tracker migration.

---

## Trace-check CI enforcement

**Bootstrap rule:** Runs **warn-only** until the first `spec.md` with REQ IDs lands **AND** a code-owner-reviewed PR adds the marker file `trace/.blocking`. Until both conditions are met, trace-check warns but does not block merges.

Once blocking, CI fails when:
1. Any requirement in state **Missing**
2. Any **Placed** requirement has no evidence row with its ID in `req_ids`
3. Any **Deferred** or **Dropped** requirement missing: `rationale`, `decided_by`, or `decided_at`
4. Any **Deferred** requirement missing: `defer_to`
5. Spec REQ ↔ trace-map reconciliation
6. Empty trace map in blocking mode
7. `requirements/*.yaml` registry validation
8. Issue + PR `Requirements:` linkage enforcement
9. Evidence rows from bolt briefs/decision packs
10. Source-anchor validation (intent.md or spec.md anchors exist)

---

## Evidence schema

Evidence rows (in bolt briefs, decision packs, or trace map) reference requirements:

```yaml
evidence:
  - evidence_id: bc-2002b87a-8540-5b26-adcd-81a17f554bdb  # Required
    runtime: cursor
    exact_head: 41b969f4ff5bc41f6ebc79ec6492cf1855be67de  # Required
    issue: "#42"
    actor: Delivery · Lead  # Required
    gate: Implement → Ready for QAS  # Required
    req_ids:
      - REQ-CON-001
      - REQ-TRC-002
```

**Required evidence fields:** `evidence_id`, `exact_head`, `actor`, `gate`. Evidence rows without these fields do not count.

---

## Repo-internal vs. external checks

**Blocking trace-check** (this workflow) covers repo-internal gaps only:
- REQ with no ARC component
- REQ with no GitHub Issue reference
- PR with no REQ linkage (when required)
- Missing or unevidenced REQs
- Deferred/Dropped missing required fields

External link checks (issue-tracker archive, external URLs, evidence URL reachability) are not a shipped workflow. Keep them out of the blocking trace-check so transient network issues do not fail merges. spec.md anchor existence is validated by `trace/check.sh` when blocking.

---

## Metrics pointer

Success metrics: `constitution/00-north-star.md` (example set: `examples/round-table/metrics.md`)
