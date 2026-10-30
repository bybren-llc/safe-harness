---
name: doc-drift
description: Detect and repair drift between governance docs, README, AGENTS.md, and skills after a merge. Use after a governance or adapter change, or when a later CI drift check warns.
---

# Doc drift

**Source:** generalize
**Used by:** Delivery, Librarian

## Authority

- [`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md) — intent/spec and CODEOWNERS-gated paths
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — merge execution

See the cited section; this skill grants no authority.

## When to use

A merge changed `constitution/`, `roles/`, adapters, or workflows. Matching README, AGENTS.md, and skills should still agree. This skill is repo-docs only. It does not sync an external vault.

A later warn-only CI check may pair with this skill. Until that check exists, run the steps by hand.

## Steps

1. Diff the merge against trunk's previous SHA.
2. Map changed paths to the docs that must mention them (README structure table, contributing flow, adapter README, this skills index, role cards).
3. Fix stale names and broken relative links.
4. Do not rewrite meaning. If the constitution changed, update pointers; do not restate gate text in a skill.
5. Open a docs PR. Do not sneak a policy change into a drift fix.

## Validate

Run the repo's documented link check and markdown syntax check. Paste literal output.

## Stop rules

- Repo docs only. No external vault format, no machine paths.
- Do not edit `intent.md` or `spec.md`. See the cited section; this skill grants no authority.
- Do not merge CODEOWNERS-gated paths. See the cited section; this skill grants no authority.
