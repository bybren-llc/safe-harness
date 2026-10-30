---
name: pre-pr-validation
description: Run the repo's documented local checks, link check, and trace check before opening a PR, and paste the literal output as evidence. Use immediately before gh pr create or equivalent.
license: MIT (see repository LICENSE)
---

# Pre-PR validation

**Source:** generalize
**Used by:** Delivery, Implementer

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — exact-head; O2 architect-review triggers (deploy CI, auth, secrets)

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks. Do not run this skill to "clean up" a frozen head unless Delivery explicitly asked for a new head.

## When to use

Before every PR on an unfrozen head.

## Steps

1. Confirm the working tree is what you intend to ship. No secret files, no personal-store paths.
2. Rebase onto latest trunk (`main`) if the brief allows. See [`git-advanced`](../git-advanced/SKILL.md).
3. Run **the repo's documented check command** (CI script, make target, or workflow job you can run locally). Do not substitute a stack-specific command from another repo.
4. Run the in-repo link check and the trace check. Trace-check runs on every PR with no path filter; do not skip it. Paste literal output.
5. Confirm branch name, commit subjects, and the PR `Requirements:` line. See [`github-conventions`](../github-conventions/SKILL.md).
6. Confirm related docs or skills that the diff requires. See [`doc-drift`](../doc-drift/SKILL.md).
7. Report PASS / WARNING / BLOCKER. Open the PR only on PASS (warnings recorded in the body).

## Evidence

Paste the command and its output into the PR or the bolt brief. Paraphrase is not evidence.

## Stop rules

- Block on red checks. Do not open a "CI will catch it" PR for a known local failure.
- Architect-review triggers (deploy CI, auth, secrets, IaC, migrations) escalate before the PR, not after. See the cited section; this skill grants no authority.
