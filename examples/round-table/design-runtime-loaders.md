# Design: runtime loaders (example)

Example only. Filled from [`../../docs/design/DESIGN-TEMPLATE.md`](../../docs/design/DESIGN-TEMPLATE.md). Describes how this repo loads instructions today. Not a design for a later orchestration app.

| Field | Value |
| --- | --- |
| Topic / subsystem | Runtime loaders |
| Status | Example of the W0 shape on `main` |
| Related ADRs | [0008](../../docs/decisions/0008-adapter-order-claude-code-cursor-first.md); [`adr-example.md`](adr-example.md) |
| Related REQ IDs | none yet (illustrative EX-ADP-001 in [`spec.md`](spec.md) is not registered) |
| Related PRD codes | FR-001, FR-005 |

This is a reusable starting point for orchestrating agents across runtimes. The first slice is the v1.1 proof: brief, loaders, worktree-per-agent, gate chain, evidence.

## 1. Problem

DS-P-001: Each runtime must load the same constitution, seats, and skills. A runtime that only reads its own file, or a symlink the vendor does not follow, would miss `AGENTS.md`.

## 2. Scope

| Code | In or out | Item |
| --- | --- | --- |
| DS-S-001 | In | Root `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/safe-harness.mdc`, `adapters/claude-code/`, `adapters/cursor/`, `adapters/codex/`, `skills/INDEX.md` |
| DS-S-002 | In | One worktree and one branch per agent ([`../../docs/runtimes.md`](../../docs/runtimes.md)) |
| DS-S-003 | Out | Forked skill bodies |
| DS-S-004 | Out | Any later app's architecture (not defined) |

## 3. Shape

DS-SH-001: No symlinks. Real pointer files only.

- `CLAUDE.md` is `@AGENTS.md` plus pointers to `skills/INDEX.md` and `adapters/claude-code/README.md`.
- `.cursor/rules/safe-harness.mdc` is always-on. It points at `AGENTS.md`, `skills/INDEX.md`, and `adapters/cursor/README.md`.
- Codex reads root `AGENTS.md` natively. `adapters/codex/README.md` and `adapters/codex/AGENTS.md` document that; they do not replace the root file.
- Canonical skills stay at `skills/<slug>/SKILL.md`. The catalog is `skills/INDEX.md`.
- `AGENTS.md` Before you start: `intent.md` → `spec.md` → Current shape → the issue and bolt brief → cited REQ IDs.

## 4. Contracts

| Code | Contract | Path or interface |
| --- | --- | --- |
| DS-C-001 | Agent entry | `AGENTS.md` |
| DS-C-002 | Claude Code pointer | `CLAUDE.md` |
| DS-C-003 | Cursor pointer | `.cursor/rules/safe-harness.mdc` |
| DS-C-004 | Codex adapter | `adapters/codex/AGENTS.md` |
| DS-C-005 | Brief for a run | `.briefs/<issue>.md` (working copy of `templates/delivery-bolt-brief.md`) |

## 5. Alternatives considered

| Code | Alternative | Why not |
| --- | --- | --- |
| DS-A-001 | Symlink `.claude/skills/` and `.agents/skills/` to `skills/` | W0 shipped pointer files, not symlinks. Vendor symlink support was not assumed. |
| DS-A-002 | Fork skill text into each adapter | `AGENTS.md`: do not fork skill bodies. |

## 6. Risks and open questions

| Code | Kind | Text |
| --- | --- | --- |
| DS-Q-001 | Question | Whether each vendor expands the pointer at run time is an empirical check on #85, not claimed here. |
| DS-Q-002 | Question | Scope of a later orchestration app that would reuse these loaders is not defined. |
| DS-RK-001 | Risk | A session that ignores `AGENTS.md` fails the proof loader bar. |
