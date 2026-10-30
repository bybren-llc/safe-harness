---
name: pattern-discovery
description: Check the adopter's existing pattern library before writing new code. Use before new API, UI, storage, or test work in a product repo.
---

# Pattern discovery

**Source:** port
**Used by:** Implementer, BSA-like

## When to use

Before writing new product code. This template repo has no pattern library. In an adopter's code repo, their library is the first stop.

## Steps

1. Open the adopter's pattern index (README or catalog they named). Categories are whatever they use (API, UI, storage, testing, security, CI, config).
2. If a pattern exists: read it, apply its customization notes, run its validation command.
3. If it does not: search the codebase for a similar implementation. If you find one, propose extraction to BSA-like / the GM. If you do not, follow local conventions and report the gap.
4. Do not copy a pattern from another product stack "because we used it elsewhere."

## Stop rules

- Point at the adopter's own library. Do not point at a dropped stack-specific skill.
- Security cross-cuts (auth, validation, errors) stay in the adopter's security patterns and in [`seceng-review`](../seceng-review/SKILL.md).
- Missing library: say `UNKNOWN` and search the tree. Do not invent a `patterns/` tree in this template repo.
