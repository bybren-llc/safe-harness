# Requirements Registry — safe-harness

**Ownership:** Agents (derived from human-owned spec.md)

Requirements are the **definition of success**. Each requirement receives a unique `REQ-<CMP>-NNN` identifier and references its source in `spec.md`.

## Trace states

| State | Meaning | Required fields |
| --- | --- | --- |
| **Placed** | Active requirement; evidence required | source, exit_criterion, metric |
| **Deferred** | Intentionally postponed | rationale (why deferred + when to revisit) |
| **Dropped** | Permanently removed from scope | rationale (why no longer needed) |
| **Missing** | Referenced but not yet defined | (CI fails on Missing state) |

## Format

Each requirement is a YAML file: `REQ-<CMP>-NNN.yaml`

Required fields for **Placed** requirements:
- `id`: REQ-<CMP>-NNN
- `component`: ARC-<CMP> (from arch/components.yaml)
- `state`: Placed | Deferred | Dropped | Missing
- `title`: Brief description
- `source`: spec.md#anchor (or intent.md#anchor)
- `exit_criterion`: Concrete pass/fail condition
- `metric`: M1–M6 tie (from constitution/00) or named metric
- `description`: Full requirement text

Optional fields:
- `rationale`: Required for Deferred/Dropped; explains why
- `dependencies`: List of other REQ-<CMP>-NNN IDs
- `notes`: Additional context

## Evidence linkage

Evidence rows (in bolt briefs or decision packs) reference requirements via the `req_ids` column:

```yaml
evidence:
  - evidence_id: bc-2002b87a-8540-5b26-adcd-81a17f554bdb
    runtime: cursor
    exact_head: 41b969f4ff5bc41f6ebc79ec6492cf1855be67de
    issue: "#3"
    actor: Delivery · Lead
    gate: Implement → Ready for QAS
    req_ids:
      - REQ-CON-001
      - REQ-TRC-001
```

## Trace check CI

The `.github/workflows/trace-check.yml` workflow enforces:
1. Every requirement in state **Placed** must have at least one evidence row with its ID in `req_ids`
2. No requirements in state **Missing** (CI fails)
3. **Deferred** and **Dropped** requirements must have a `rationale` field

See `REQ-TEMPLATE.yaml` for the requirement file template.
