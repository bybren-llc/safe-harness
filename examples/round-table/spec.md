# Specification — safe-harness (example)

Example drafted by Delivery for owner review; spec is owner-owned.

This file is an instance example. Root [`../../spec.md`](../../spec.md) stays the canonical adopter template.

IDs written as `EX-<CMP>-NNN` below are **illustrative and not registered**. They are not `REQ-<CMP>-NNN` IDs. `trace/check.sh` must not treat them as live.

---

## Personal boundary rule

**NEVER include personal-vault content, story IP, or private-storage facts in this file or the repository.**

Prohibited: personal vault paths/excerpts, story IP (character names, plot details), private-storage facts (LAN IPs, tokens, `/home` paths).

**How to reference:** Cite by concept name only. Never paste actual IPs, tokens, paths, or personal details.

---

## Overview

safe-harness is a multi-runtime template. One intent, one spec, one constitution, and one decision log are shared by humans and by agents on Cursor, Claude Code, Codex, and other always-on assistant agents. Work moves through the same gates. The first slice to prove is the v1.1 cross-runtime path on #85: brief, loaders, one worktree per agent, gate chain, evidence.

This example is a reusable starting point for that shared-docs shape. It is not a spec for a later orchestration app.

## Requirements

Illustrative only. Not registered in `requirements/`. Not present in root `spec.md`.

| Example ID | Text | Metric |
| --- | --- | --- |
| EX-CON-001 | Humans own intent and spec. Agents execute plan, issues, code, tests, PRs, and evidence. | M3 |
| EX-ADP-001 | Claude Code, Cursor, and Codex each reach root `AGENTS.md` and `skills/INDEX.md` through pointer files, not forked skill bodies. | M1 |
| EX-ADP-002 | One worktree and one branch per agent. Launch from the repo root as [`../../docs/runtimes.md`](../../docs/runtimes.md) describes. | M1 |
| EX-TRC-001 | Evidence rows carry `evidence_id`, `runtime`, `exact_head`, `issue`, `actor`, `gate`, and `req_ids`. | M6 |
| EX-WFL-001 | Delivery and cloud agents never merge, never approve, never push to `main`. | M6 |

### Proof pass criteria (R1–R3)

Drawn from #85 and the W0.5 runbook. These are example success statements for the first slice, not registered REQs.

- Each run loads `AGENTS.md` and follows the Before you start order.
- Each run goes through SecEng, QAS, and RTE PASS at its exact head.
- Evidence is recorded with `runtime` and `evidence_id`.
- At least one handoff crosses runtimes (for example, R2 picks up work or a review from R1).

## Architecture

Components already in [`../../arch/components.yaml`](../../arch/components.yaml):

| ID | Name | Paths |
| --- | --- | --- |
| ARC-CON | Constitution | `constitution/` |
| ARC-ADP | Adapters | `adapters/` |
| ARC-ROL | Roles | `roles/` |
| ARC-TPL | Templates | `templates/` |
| ARC-PRV | Prove | `prove/` |
| ARC-TRC | Trace | `requirements/`, `arch/`, `trace/` |
| ARC-WFL | Workflows | `.github/workflows/` |

Loaders (W0, #86): `CLAUDE.md` points at root `AGENTS.md`; `.cursor/rules/safe-harness.mdc` is always-on; `adapters/codex/` documents native `AGENTS.md` load. No symlinks. See [`design-runtime-loaders.md`](design-runtime-loaders.md).

No further architecture is defined for a later app.

## Interfaces

What exists today:

- Root `AGENTS.md` (agent entry; Before you start load order).
- `CLAUDE.md`, `.cursor/rules/safe-harness.mdc`, `adapters/*/AGENTS.md`.
- Bolt brief: `templates/delivery-bolt-brief.md`. Working copy for a run: `.briefs/<issue>.md` ([`../../docs/runtimes.md`](../../docs/runtimes.md)).
- Portable evidence table (`constitution/05`).
- Issue and PR templates under `.github/`.

## Metrics

M1–M6 as already listed in [`metrics.md`](metrics.md) and locked by ADR 0001. This example invents none.

---

**Note:** Example only. Root `spec.md` is human-owned under constitution/05.
