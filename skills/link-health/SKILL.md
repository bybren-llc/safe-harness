---
name: link-health
description: Run blocking in-repo link checks and a weekly non-blocking cross-system scan. Register-first, no invented links, link-rot label. Use when checking a PR's links or running the scheduled scan.
license: MIT (see repository LICENSE)
---

# Link health

**Source:** generalize
**Used by:** Librarian

## Authority

- [`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md) — blocking vs scheduled checks; CODEOWNERS paths
- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — Librarian is not a merge seat
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — merge execution

See the cited section; this skill grants no authority.

## When to use

On every authoring PR (in-repo links) and on the adopter's weekly scan (cross-system). Spec: `trace/link-health.md`. This skill keeps the process generic.

## Two layers

| Layer | What | Blocks merge? |
| --- | --- | --- |
| In-repo | Relative markdown links (and, when enabled, anchors and REQ IDs) in the checkout | Yes, when the repo's structure/link check is blocking |
| Cross-system | Issues, PRs, forge-backed knowledge-base citations, external URLs, archived tracker IDs | No. Scheduled, read-only. |

A flaky outside site must never block a merge.

## Rules

1. One trace map is the truth. Other docs cite it; they do not restate REQ text.
2. **No invented links.** A target you cannot verify is `UNKNOWN`. Register-first.
3. Rot is reported as issues labelled `link-rot`. Fixes are PRs. Both happen only in the reporting phase. Merge execution: see the cited section; this skill grants no authority.
4. Personal-store and private-store targets must not appear. If they do, report a privacy finding; do not quote the target in a public issue.
5. Skip placeholders, `<...>` samples, and documentation-range hosts.

## Weekly scan

Configurable schedule (the adopter names the weekday and timezone). Two phases:

### Scan phase (read-only)

Read-only: no repo writes, no PR comments, no channel posts. Collect findings only. Do not open issues, post a summary, or open a PR in this phase.

### Reporting phase (authorized only)

The human owner (HITL) authorizes the reporting phase. The delivery lead may file in-repo issues only. Each run needs an explicit go. The weekly schedule is not authorization.

When authorized for that run: open `link-rot` issues (the delivery lead may file in-repo issues only), send a weekly summary to Ops only with the human owner's OK (same external-write bar as [`signals-digest`](../signals-digest/SKILL.md) and the cited `constitution/07` section), and (for a clear rewrite) open a fix PR for a merge seat. A fix PR that is a security finding needs the human owner's explicit go (scanner, not fixer). See the cited section; this skill grants no authority.

Do not teach frozen-map locator forms or internal knowledge-base URL shapes. Cite concept names.

## Stop rules

- Do not invent a replacement URL.
- Do not merge. See the cited section; this skill grants no authority.
- Changes that would edit `intent.md`, `spec.md`, `requirements/`, or a REQ ID follow the cited `constitution/05` section.
