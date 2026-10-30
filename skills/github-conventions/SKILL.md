---
name: github-conventions
description: Apply trunk GitHub conventions — branch names, plain commit subjects, Refs/Req trailers, and the PR Requirements line. Use when starting a branch, committing, or opening a PR.
---

# GitHub conventions

**Source:** generalize
**Used by:** All authoring seats

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — GitHub conventions (branch, trailers, PR Requirements line)
- [`constitution/05-evidence-and-linear.md`](../../constitution/05-evidence-and-linear.md) — labels and issue types

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks. That includes "fix up the PR title" and "add a trailer."

## When to use

Any time you create a branch, commit, or open a PR in a repo that adopted this template.

## Rules

**Branch:** `<issue#>-slug` off trunk (`main`). Example: `42-add-trace-check`. No personal names or dates in the branch name.

**Commit subject:** Plain working wording. A natural subject, optionally with the issue number in the subject (`Add trace-check CI (#42)`). Do not add co-author trailers.

**Trailers** (trace linkage):

```text
Refs #42
Req: REQ-<CMP>-NNN
```

**PR body:** include a `Requirements: REQ-<CMP>-NNN, …` line listing every requirement the change addresses. If the repo has no REQ IDs yet, say so explicitly rather than inventing IDs.

**Labels:** work type (`bolt`, `decision`, `requirement`), risk tier (`tier:low`, `tier:medium`, `tier:high`), O2 items (`o2:pricing`, `o2:refunds`, `o2:auth`, `o2:deploy-ci`, `o2:secrets`, `o2:privacy`), and gate/exit labels from the adopter's label set.

## Legacy note

Older branches or commits may use a ticket-prefix form (`SAF-N-slug`, `[SAF-N]` subjects). Treat that as archive/legacy. New work uses the GitHub Issue number.

## Stop rules

- Do not force-push trunk. See [`git-advanced`](../git-advanced/SKILL.md).
- Do not invent REQ IDs. See [`requirements-trace`](../requirements-trace/SKILL.md).
- Commit subjects stay plain. No marketing language, no secret values.
