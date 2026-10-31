---
status: example
date:
decision-makers:
consulted:
informed:
---

# Example: pointer files, not symlinks, for runtime loading

This file is an **example** of [`../../docs/decisions/ADR-TEMPLATE.md`](../../docs/decisions/ADR-TEMPLATE.md). It is not a numbered ADR. It does not belong in `docs/decisions/` and it does not change Current shape.

It restates a choice already on `main` from W0 (#86): runtimes load through real pointer files, not symlinks. Confirmation is `UNKNOWN` here because this file is not the record.

## Context and Problem Statement

Claude Code, Cursor, and Codex each need the same root `AGENTS.md` and the same `skills/` catalog. Mapping by symlink was open on #85. W0 shipped pointer files instead.

## Decision Drivers

* One constitution; thin adapters ([0008](../../docs/decisions/0008-adapter-order-claude-code-cursor-first.md)).
* Do not fork skill bodies (`AGENTS.md`).
* Do not claim vendor behavior that was not observed.

## Considered Options

* Symlink `.claude/skills/` and `.agents/skills/` to `skills/`
* Per-slug copies of each skill
* Pointer files only (`CLAUDE.md`, `.cursor/rules/safe-harness.mdc`, `adapters/codex/`)

## Decision Outcome

Chosen option: "Pointer files only", because that is what W0 merged to `main`.

`CLAUDE.md` imports `@AGENTS.md`. `.cursor/rules/safe-harness.mdc` is always-on and points at `AGENTS.md`. Codex reads root `AGENTS.md` natively; the adapter docs that fact.

### Consequences

* Good, because skill bodies stay in `skills/<slug>/SKILL.md`.
* Good, because a runtime that misses a symlink still has a real file to read.
* Neutral, because auto-load of every skill into each vendor's native skills path is still an empirical check, not a claim.

### Confirmation

Example only. The merge record is #86 on `main`. This file does not invent a concur quote.

- Who (seat; human name only if they wrote it): UNKNOWN
- Own words (quoted) or `UNKNOWN`: UNKNOWN
- Timestamp: UNKNOWN
- Exact head: UNKNOWN (see the #86 merge on `main`)

## Pros and Cons of the Options

### Pointer files only

* Good, because no symlink support is assumed.
* Neutral, because each vendor's expansion of the pointer will be checked in `prove/` during the #85 runs; this example does not assert the result.
* Bad, because a runtime that does not read `AGENTS.md` or the pointer still needs a first-handoff check.

### Symlinks

* Good, because one tree could appear at each vendor path.
* Bad, because symlink follow was not treated as known for every runtime on #85.

## More Information

Owner: GM
Executor: Delivery
Cross-ref: #85, #86, [`design-runtime-loaders.md`](design-runtime-loaders.md)
