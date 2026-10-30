---
name: api-contract-check
description: Run contract tests and breaking-change diffs on an adopter's OpenAPI spec. Warn-only first. Use when the adopter has a spec path configured. Skip cleanly when none exists.
---

# API contract check

**Source:** new
**Used by:** Delivery, QAS (adopters)

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — High / O2; deploy CI / workflows

See the cited section; this skill grants no authority.

## When to use

An adopting product repo has an OpenAPI (or equivalent) spec. This template repo has no spec. The skill is a template: skip with a notice when no spec path is configured.

A later warn-only CI job may pair with this skill. Until then, run locally.

## Steps

1. Read the configured spec path (proposed default: `openapi.yaml`; **UNKNOWN** until the adopter sets it).
2. If the path is missing, print a skip notice and exit 0. Do not invent a spec.
3. If present, run the adopter's documented property-based contract tester (Schemathesis is an example) against the spec, and a breaking-change diff (oasdiff is an example) against the previous released spec.
4. Report: new violations, breaking changes, skip/warn/fail. v1.0 default is warn-only.
5. Paste literal output as evidence.

## Stop rules

- Do not add an OpenAPI file to this template repo "to make the check interesting."
- Do not treat warn-only as a pass that hides a known break on a High / O2 API change. See the cited section; this skill grants no authority.
- Tool names are examples. Pin versions in the adopter's workflow when that O2 PR lands. Do not add extra URLs here.
