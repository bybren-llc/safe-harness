# safe-harness

**Org:** bybren-llc  
**Owner:** Kai · GM & lead ARCHitect  
**Status:** Wave 0 active → Wave 1 proposed

Safe Agentic Workflow harness for everyday safe AI-assisted development. Dual-spine (CD execute/deploy + think/plan), trunk-based delivery, risk-tiered gates, and evidence-first practices.

**Not SAFe™ the trademark.** SAFe + AI-DLC = ownership/cadence spine.

---

## Quick start

1. Read [`constitution/README.md`](constitution/README.md) — governance framework
2. Review [`constitution/00-north-star.md`](constitution/00-north-star.md) — dual spine, M1–M6 metrics
3. Map seats in [`constitution/01-round-table.md`](constitution/01-round-table.md)
4. Follow gates in [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) (risk tiers, O2 high-risk)
5. Track evidence per [`constitution/05-evidence-and-linear.md`](constitution/05-evidence-and-linear.md)

**Wave 1 (proposed):** Repository as sole source of truth. See [`prove/wave-1/decision-pack.md`](prove/wave-1/decision-pack.md) for constitution amendments pending Scott concurrence.

---

## Structure

| Path | Purpose |
| --- | --- |
| [`constitution/`](constitution/) | Governance framework (risk tiers, gates, ownership, evidence) |
| [`roles/`](roles/) | Round Table seat definitions |
| [`adapters/`](adapters/) | Runtime-specific adapters (Claude Code, Cursor, Codex, local) |
| [`templates/`](templates/) | Brief and handoff templates (Bolt, Studio→Delivery) |
| [`prove/`](prove/) | Evidence and bolt records (D-P1, D-P2, etc.) |
| [`arch/`](arch/) | Component registry (ARC-<CMP>) — Wave 1 |
| [`requirements/`](requirements/) | REQ-<CMP>-NNN registry — Wave 1 |
| [`trace/`](trace/) | Trace map (state tracking, evidence linkage) — Wave 1 |
| [`intent.md`](intent.md) | Human-owned design intent — Wave 1 |
| [`spec.md`](spec.md) | Human-owned specification — Wave 1 |
| [`.github/workflows/`](.github/workflows/) | CI/CD automation (Wave 0: thin skeleton; Wave 1: trace-check) |

---

## Wave 1 additions (proposed)

**Pending Scott concurrence:**
- Repository as sole source of truth (GitHub repo; Linear archived)
- Human/agent ownership split (CODEOWNERS for intent, spec, constitution, requirements, trace)
- Requirements tracing (REQ-<CMP>-NNN, trace states, trace-check CI)
- GitHub Issue templates (bolt, requirement, decision)
- Migration plan (Linear → GitHub, evidence preservation)

See [`prove/wave-1/decision-pack.md`](prove/wave-1/decision-pack.md) for full details.

---

## Key concepts

### Dual spine (peer)

- **(A) CD execute/deploy** — Delivery lane, spine A, forge/CI-native
- **(B) Think/plan** — Studio lane, spine B, multi-vault knowledge

Both share Round Table principles, exit states, and ownership. They differ in gates and storage.

### Risk tiers

- **Low**: Auto when green (tests + evidence met); human assignee still named
- **Med**: One human decision pack
- **High**: Two distinct humans; agent ≠ human

**O2 high-risk items default to High** unless downgraded in writing at QAS. Delivery may propose a downgrade rationale; Kai decides at QAS: pricing, refunds, auth, deploy CI/workflows, prod secrets, privacy-boundary crosses.

### Exit states

1. Ready for QAS
2. Approved for RTE (or collapsed-RTE annotated)
3. Ready for HITL
4. MERGED (HITL only) — Wave 0
5. MERGED (HITL-delegated) — Wave 1: Low tier only

### Evidence (portable)

Each evidence row includes:
- `evidence_id` (runtime-native unique ID)
- `runtime` (cursor / claude-code / grok-bot / etc.)
- `exact_head` (commit SHA or PR head)
- `issue` (GitHub Issue `#N` — Wave 1; `linear_issue` Wave 0)
- `actor` (agent or human handle)
- `gate` (which gate this evidence satisfies)
- `req_ids` (REQ-<CMP>-NNN list — Wave 1)

### Requirements (Wave 1)

**Requirements = definition of success.** Each REQ-<CMP>-NNN has:
- `source`: spec.md#anchor or intent.md#anchor
- `exit_criterion`: Concrete pass/fail condition
- `metric`: M1–M6 tie or custom metric name

**Trace map:** [`trace/trace-map.yaml`](trace/trace-map.yaml) (fixed path)  
**Trace states:** Placed / Deferred / Dropped / Missing  
**Trace-check CI:** `.github/workflows/trace-check.yml` (bootstrap: warn-only until first spec lands)

---

## Human vs. agent ownership (Wave 1)

**Humans own and accept only design:**
- `intent.md`, `spec.md` — Humans (Scott / Kai) own and accept; agents may propose but **never merge**

**Agents own everything else end-to-end:**
- Plan, GitHub Issues, code, tests, PRs, evidence
- **Requirements registry** (`requirements/`) — agents author; human-reviewed PR required
- **Trace map** (`trace/`) — agents author; human-reviewed PR required
- **Constitution changes** — agents author; human-reviewed PR required

**CODEOWNERS = review gate, not ownership:** `.github/CODEOWNERS` enforces @cheddarfox review for intent, spec, constitution, requirements, and trace. Agents author requirements, trace, and constitution changes; humans review and approve before merge.

---

## GitHub conventions (Wave 1)

**Branch naming:** `<issue#>-slug` (e.g., `42-add-trace-check`)

**Commit conventions:**
- Subject: Reference the issue number (e.g., `Add trace-check CI (#42)`) or natural subject
- Trailer: `Refs #N` — references GitHub Issue
- Trailer: `Req: REQ-<CMP>-NNN` — satisfies requirement
- No Linear SAF tags (Linear retired for safe-harness)

**PR body:** `Requirements: REQ-<CMP>-NNN, ...` line

**Labels:** See `.github/labels.yml` (work types, risk tiers, O2 items, exit states, gate labels)

---

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for:
- Personal boundary rule (never include personal-vault content, story IP, or NAS-private facts)
- GitHub workflow (issues, branches, commits, PRs)
- Risk tiers and O2 high-risk items
- Evidence schema and trace linkage

---

## Metrics (M1–M6)

See [`constitution/00-north-star.md`](constitution/00-north-star.md):

- **M1**: Multi-runtime template ships
- **M2**: tmux not required
- **M3**: SAFe + AI-DLC spine retained
- **M4**: Round Table seats map
- **M5**: Time-to-first owned ticket
- **M6**: Deploy/release flow health

---

## Status

- **Wave 0:** ✅ Complete (constitution, thin CI, D-P1 prove)
- **Wave 1:** 🟡 Proposed (repo-only SoR, tracing, GitHub conventions) — awaiting Scott concurrence

See [`prove/README.md`](prove/README.md) for wave checklist and [`prove/wave-1/decision-pack.md`](prove/wave-1/decision-pack.md) for Scott's decision asks.

---

## Reference

- **SAW:** `bybren-llc/safe-agentic-workflow` @ `dev` (reference only; never silent-rewrite)
- **Linear archive:** SAF-1 through SAF-5 (read-only after Wave 1 cutover)
- **Mapping table:** [`trace/linear-saf-map.csv`](trace/linear-saf-map.csv) (populated before cutover)

---

**Provenance:** ADR pack concurred 2026-10-28 (C1–C8 / O1–O6 / E1–E3).
