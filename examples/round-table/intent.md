# Intent — safe-harness (example)

Example drafted by Delivery for owner review; intent is owner-owned.

This file is an instance example. Root [`../../intent.md`](../../intent.md) stays the canonical adopter template.

---

## Personal boundary rule

**NEVER include personal-vault content, story IP, or private-storage facts in this file or the repository.**

Prohibited: personal vault paths/excerpts, story IP (character names, plot details), private-storage facts (LAN IPs, tokens, `/home` paths).

**How to reference:** Cite by concept name only. Never paste actual IPs, tokens, paths, or personal details.

---

## Purpose

Teammates on different AI systems (Cursor, Claude Code, Codex, and other always-on assistant agents) and humans share one set of intent and design docs. They hand work to each other through the same gates, and they work on one or several projects at once toward a larger vision.

safe-harness is the template that holds those shared docs, seats, and gates. Humans set direction and keep the safety gates. Agents execute and produce evidence.

## Scope

**In (what exists now):**

- One constitution, one role set, one skills library.
- Thin adapters for Cursor, Claude Code, and Codex. Pointer files (`CLAUDE.md`, `.cursor/rules/safe-harness.mdc`, `adapters/codex/`) load the same root `AGENTS.md`.
- Dual spines: Delivery (code) and Studio (stories and research).
- Evidence rows with `evidence_id` and `runtime`. Exact-head gates. Agents never merge or approve.

**First concrete slice (v1.1, #85):** prove that an implementer in each of Cursor cloud, Claude Code, and Codex can run a real Low-tier change through the same brief, loaders, worktree-per-agent, gate chain, and evidence path. Sequence already on the issue: W0 loaders (merged), W0.5 design surface, then R1 Cursor cloud, R2 Claude Code, R3 Codex, then R4 (#52) only after the owner gives the go.

**Out:**

- Personal vault never enters this repo or a remote forge.
- Delivery and cloud agents never merge, never approve, never push to `main`.
- No silent rewrite of the predecessor template.
- No new spend or seats without the owner (#85).
- Scope of any later orchestration app is not defined here.

## Success criteria

Standing metrics remain M1–M6 as locked in [`../../docs/decisions/0001-lock-m1-m6-as-value-metrics.md`](../../docs/decisions/0001-lock-m1-m6-as-value-metrics.md) and listed in [`metrics.md`](metrics.md). This example does not add metrics.

v1.1 proof success is the R1–R3 pass list in [`prd-v1.1-cross-runtime.md`](prd-v1.1-cross-runtime.md) and [`../../docs/runtimes.md`](../../docs/runtimes.md). No extra numbers.

## Where this grows

The same structure — shared intent and design, one brief, loaders, one worktree per agent, the gate chain, and evidence — is intended to seed an orchestration app's intent and PRD later. The scope of that app is not yet defined. Do not treat this file as that app's spec.

## Research appendix (optional)

### Fit band

Small teams (about 1–10 people) working with AI agents who need structured governance, clear ownership, and evidence-based decisions. Source: root `README.md`.

### License

MIT. Source: `LICENSE`.

### Footprint

No new spend or infra without the owner. Cloud-agent runs use included usage. If a runtime needs a paid seat or a new key, the run stops and goes to the owner. Source: #85. Compute and storage envelope beyond that is **UNKNOWN**.

### Sources

- Root `README.md`, `AGENTS.md`, `constitution/`, `docs/decisions/`
- #85 (v1.1 plan and W0.5 comments)
- This directory's operating notes

No other sources are claimed.

---

**Note:** Example only. Root `intent.md` is human-owned under constitution/05. Only the owner writes intent.
