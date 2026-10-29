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
decided_by: Kai  # or "Scott Graham" or "Scott + Kai"
decided_at: 2026-10-29  # ISO 8601 date
defer_to: 2026-11-15  # Target date or milestone reference
```

**Special rule:** Dropping a REQ whose `source` is `intent.md#*` requires Scott's sign-off. Record as `decided_by: Scott Graham` plus link in `rationale`.

### Dropped requirements

```yaml
id: REQ-<CMP>-NNN
component: ARC-<CMP>
state: Dropped
title: Brief requirement title
source: spec.md#anchor-name
rationale: |
  Why permanently removed
decided_by: Kai
decided_at: 2026-10-29
```

**Special rule:** Dropping a REQ whose `source` is `intent.md#*` requires Scott's sign-off. Record as `decided_by: Scott Graham` plus link in `rationale`.

---

## Trace-check CI enforcement

**Bootstrap rule (Wave 1):** Runs **warn-only** until the first `spec.md` with REQ IDs lands, then becomes **blocking**.

Once blocking, CI fails when:
1. Any requirement in state **Missing**
2. Any **Placed** requirement has no evidence row with its ID in `req_ids`
3. Any **Deferred** or **Dropped** requirement missing: `rationale`, `decided_by`, or `decided_at`
4. Any **Deferred** requirement missing: `defer_to`
5. Any requirement `source` references a non-existent anchor in intent.md or spec.md

---

## Evidence schema

Evidence rows (in bolt briefs, decision packs, or trace map) reference requirements:

```yaml
evidence:
  - evidence_id: bc-2002b87a-8540-5b26-adcd-81a17f554bdb
    runtime: cursor
    exact_head: 41b969f4ff5bc41f6ebc79ec6492cf1855be67de
    issue: "#42"
    actor: Delivery · Lead
    gate: Implement → Ready for QAS
    req_ids:
      - REQ-CON-001
      - REQ-TRC-002
```

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
