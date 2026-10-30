---
name: requirements-trace
description: Add or update REQ-<CMP>-NNN rows and trace-map states (Placed, Deferred, Dropped, Missing). Use when deriving success criteria from spec or intent. Never edit human-owned intent.md or spec.md.
---

# Requirements trace

**Source:** new
**Used by:** Delivery, Studio, BSA-like

## Authority

- [`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md) — REQ format; trace states; who may author vs merge `requirements/` and `trace/`; intent/spec ownership

See the cited section; this skill grants no authority.

## When to use

Requirements are the definition of success. Use this skill to add or update a `REQ-<CMP>-NNN` and its row in `trace/trace-map.yaml`. Do not use it to edit `intent.md` or `spec.md` — those are human-owned. See [`intent-spec-assist`](../intent-spec-assist/SKILL.md) to propose draft text.

## Identifier

`REQ-<CMP>-NNN` where `<CMP>` is the three-letter code after `ARC-` in `arch/components.yaml`. For example, use `REQ-TRC-001` with `component: ARC-TRC`. Do not invent a component. Do not invent a REQ ID that is not going into the registry.

## Trace states

| State | Meaning | Required extra fields |
| --- | --- | --- |
| Placed | Active; evidence required | `source`, `exit_criterion`, `metric` |
| Deferred | Postponed | `rationale`, `decided_by`, `decided_at`, `defer_to` |
| Dropped | Permanently removed | `rationale`, `decided_by`, `decided_at` |
| Missing | Referenced but undefined | CI fails. Do not leave work in Missing. |

`source` is `spec.md#anchor` or `intent.md#anchor`. Dropping a REQ whose source is `intent.md#*` needs the HITL owner's sign-off.

## Steps

1. Confirm the source anchor exists or mark the REQ proposal as blocked on the human owner.
2. Add `requirements/REQ-<CMP>-NNN.yaml` from the template.
3. Add or update the row in `trace/trace-map.yaml`.
4. Link evidence with `req_ids`. See [`portable-evidence`](../portable-evidence/SKILL.md).
5. Who may author vs merge `requirements/` and `trace/` is in the cited section. See the cited section; this skill grants no authority.

## External trackers

An external issue tracker is optional. The preferred path is design, specs, and work items in the repo and GitHub Issues. If an adopter keeps an external tracker, record linkage in the issue body. Do not treat the tracker as the source of truth. Do not run tracker agents.

A frozen legacy map, if present, is archive-only. Do not teach it as the live convention.

## Stop rules

- Never edit `intent.md` or `spec.md`.
- Never invent links or REQ IDs.
- Trace-check may be warn-only until the human-owned spec has REQ IDs and the blocking marker exists. Warn-only is not permission to skip the fields.
