# Prove checklist — Wave 0 (targets only)

**Do not execute from this draft alone.** Coordinate Studio · Lead for D-P2. Report status to Kai.

Repo: `bybren-llc/safe-harness` (O1 locked).

**Wave 0 retrospective:** [wave-0-retro.md](wave-0-retro.md)

**RTE merge-rights amendment (PR #22):** [rte-merge-rights/decision-pack.md](rte-merge-rights/decision-pack.md)

## D-P1 — One Delivery bolt (spine A)

| Step | Target | Done? |
| --- | --- | --- |
| 1 | Empty `bybren-llc/safe-harness` exists + Cursor App access granted | ☑ |
| 2 | Constitution + adapters (docs stubs) landed in repo — PR #2, `740eb2a` | ☑ |
| 3 | Bolt brief from `../templates/delivery-bolt-brief.md` filled — [`d-p1/bolt-brief.md`](d-p1/bolt-brief.md) | ☑ |
| 4 | Linear issue: **human assignee** + optional agent delegate (no Linear Agents) — SAF-3 | ☑ |
| 5 | Low or Med tier preferred for first prove; avoid O2 unless intentional — Low | ☑ |
| 6 | Business-context HITL **before construct** (if Med/High/O2) → Implement → QAS (separate) → SecEng (if required) → RTE/collapse → HITL decision pack | ☑ — Low: business-context HITL N/A; QAS 2 rounds; RTE collapsed; MERGED by Kai (standing auth) — [`d-p1/bolt-brief.md#gates`](d-p1/bolt-brief.md#gates) |
| 7 | Exact-head evidence + portable evidence_id posted | ☑ — see [`d-p1/bolt-brief.md`](d-p1/bolt-brief.md) Evidence |
| 8 | Report vs M1–M6 (at least M3, M4, M6 touched) | ☑ — M3, M4, M6 in bolt brief Measure |

**Note:** Wave 0 Claude Code and Cursor adapters are documentation stubs only, not runnable harnesses yet. Runnable integration comes after D-P1/D-P2 prove.

## D-P2 — One Studio brief (spine B → A)

| Step | Target | Done? |
| --- | --- | --- |
| 1 | Coordinate Studio · Lead | ☐ |
| 2 | Studio emits handoff via `../templates/studio-to-delivery-handoff.md` | ☐ |
| 3 | Pins = Atlas and/or NAS only (no personal vault) | ☐ |
| 4 | Delivery accepts handoff checklist | ☐ |
| 5 | Optional: same or follow-on Bolt consumes handoff on spine A | ☐ |
| 6 | Report dual-spine peer behavior (not forge-only) | ☐ |

## Explicit non-goals of prove

- No personal vault sync
- No Linear Agents
- No ultracode-as-default
- No tmux required
- No silent SAW `dev` rewrite

---

## CD backlog / Follow-on (M6)

Wave 0 ships with **thin CI** (structure checks, markdown sanity) only. Full risk-tier CD path — including merge queues, deploy gates, feature flags, and rollback workflows — lands as M6 follow-on work. Current `.github/workflows/` establishes the foundation; production deployment automation comes later.

See constitution [03-cd-and-hitl.md](../constitution/03-cd-and-hitl.md) for CD spine principles.
