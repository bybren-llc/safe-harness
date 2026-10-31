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
| **Missing** | Referenced but not yet defined | (CI fails when blocking) |

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
metric: M6  # M1–M6 from constitution/00, or custom metric name
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
decided_by: QAS  # or owner_identity from .github/harness.yml (exactly, for intent-sourced drops)
decided_at: 2026-10-29  # ISO 8601 date
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
decided_by: QAS
decided_at: 2026-10-29
```

**Special rule:** Dropping a REQ whose `source` is `intent.md#*` requires owner sign-off. Record as `decided_by: <owner_identity>` (exactly matching `.github/harness.yml`) plus link in `rationale`.

---

## the issue tracker to GitHub Issue mapping

**Frozen mapping table:** `trace/linear-saf-map.csv`

The CSV file is header-only until populated before Linear cutover:
```csv
saf_id,linear_url,github_issue,pr,title,status
```

**Columns:**
- `saf_id`: Linear issue ID (e.g., SAF-1)
- `linear_url`: Full Linear issue URL
- `github_issue`: Mirror GitHub Issue number (e.g., #1; assigned at creation, may not equal SAF-n)
- `pr`: Pull request that closed the issue (e.g., #3)
- `title`: Issue title
- `status`: Archived

**Example data (placeholders only):**
```csv
SAF-1,<linear-url>,#1,#2,ADR pack concur,Archived
SAF-2,<linear-url>,#2,#2,Constitution + thin CI,Archived
SAF-3,<linear-url>,#3,#3,D-P1 delivery bolt,Archived
```

Populate the actual mapping before Linear closeout (migration-plan.md Phase 2).

---

## Trace-check CI enforcement

**Bootstrap rule (Wave 1):** Runs **warn-only** until the first `spec.md` with REQ IDs lands **AND** a code-owner-reviewed PR adds the marker file `trace/.blocking`. Until both conditions are met, trace-check warns but does not block merges.

Once blocking, CI fails when:
1. Any requirement in state **Missing**
2. Any **Placed** requirement has no evidence row with its ID in `req_ids`
3. Any **Deferred** or **Dropped** requirement missing: `rationale`, `decided_by`, or `decided_at`
4. Any **Deferred** requirement missing: `defer_to`
5. *(Required before blocking activation; follow-up issue TBD)* Spec REQ ↔ trace-map reconciliation
6. *(Required before blocking activation; follow-up issue TBD)* Empty trace map in blocking mode
7. *(Required before blocking activation; follow-up issue TBD)* `requirements/*.yaml` registry validation
8. *(Required before blocking activation; follow-up issue TBD)* Issue + PR `Requirements:` linkage enforcement
9. *(Required before blocking activation; follow-up issue TBD)* Evidence rows from bolt briefs/decision packs
10. *(Required before blocking activation; follow-up issue TBD)* Source-anchor validation (intent.md or spec.md anchors exist)

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

**Non-blocking scheduled check** (separate workflow, read-only):
- Cross-system link validation (Linear archive, external URLs)
- spec.md anchor existence validation
- Evidence URL reachability

External link checks remain non-blocking to avoid failing builds on transient network issues.

---

## Metrics pointer

M1–M6 definitions: `constitution/00-north-star.md`
