---
name: portable-evidence
description: Record a portable evidence row (evidence_id, runtime, exact_head, issue, actor, gate, req_ids) that any runtime can read. Use whenever a gate needs proof.
license: MIT (see repository LICENSE)
---

# Portable evidence

**Source:** new
**Used by:** All seats

## Authority

- [`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md) — portable evidence fields; exact-head
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — exact-head at gates

See the cited section; this skill grants no authority.

## When to use

Every gate that asks for proof gets a portable row. Do not rely on one runtime's session ID alone. The field list is in the cited `constitution/05` section.

## Row

| Field | Rule |
| --- | --- |
| `evidence_id` | Runtime-native unique ID (session, run, cloud-agent id, local uuid). Examples only; do not copy real IDs from another team's run. |
| `runtime` | `cursor` / `claude-code` / `grok-bot` / `codex` / `local` / other |
| `exact_head` | Commit SHA or PR head under review |
| `issue` | GitHub Issue `#N` |
| `actor` | Seat or human handle |
| `gate` | Which gate this row satisfies |
| `req_ids` | List of `REQ-<CMP>-NNN` |

Example shape (placeholders):

```yaml
evidence:
  - evidence_id: <runtime-native-id>
    runtime: cursor
    exact_head: <sha>
    issue: "#N"
    actor: Delivery · Lead
    gate: Implement → Ready for QAS
    req_ids:
      - REQ-<CMP>-NNN
```

## How to attach

- Paste literal command output. Do not paraphrase a pass.
- Point at in-repo paths. Do not copy evidence into a personal store or private store.
- New commits create a new exact head. Prior rows stay as history; the live gate must cite the new head.

## Stop rules

- No secret values, tokens, or vault paths in a row or its attachments.
- No real session or agent IDs from other orgs.
- Evidence over assertion. A bolt exits on evidence, not a date.
