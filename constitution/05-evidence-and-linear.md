# 05 — Evidence & Linear

## Linear = System of Record (Wave 0)

- Tickets hold ownership, exit state, and evidence links.
- **Human assignee** + **agent delegate** (O6).
- **Linear Agents OUT of Wave 0** — do not enable/configure Linear Agents for this wave.

## Evidence before HITL

Evidence lands in Linear before Ready for Review / HITL decision pack. Preserve SAW spirit:

- Evidence over assertion
- Bolt exits on evidence, not a date
- Four always-on evidence types + conditional (UI / RLS / perf / `#EXPORT_CRITICAL`) — map per Bolt

## Portable evidence IDs

Do not rely on Claude-only session IDs. Each runtime posts a portable ID:

| Field | Rule |
| --- | --- |
| `evidence_id` | Runtime-native unique ID (session, run, cloud agent id, local run uuid) |
| `runtime` | `claude-code` \| `cursor` \| `codex` \| `local` \| `grok-bot` \| … |
| `exact_head` | Commit SHA or PR head |
| `linear_issue` | Issue key |
| `actor` | Agent id or human handle |
| `gate` | Which gate this evidence satisfies |

## Independence detectable

QAS and SecEng actors must be distinguishable from implementer in Linear (assignee/delegate labels or explicit fields). Prose-only “we were careful” is insufficient for High tier.

## Exit states (canonical names)

Use consistent labels across runtimes:

1. Ready for QAS  
2. Approved for RTE (or collapsed-RTE path annotated)  
3. Ready for HITL  
4. MERGED (HITL only)

## Wave 0 Linear writes

Research epics may open only when Kai/Scott authorize. This constitution draft does **not** create issues by itself.
