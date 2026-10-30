---
name: link-health
description: Run blocking in-repo link checks and a weekly non-blocking cross-system scan. Register-first, no invented links, link-rot label. Use when checking a PR's links or running the scheduled scan.
---

# Link health

**Source:** generalize
**Used by:** Librarian · Signals

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
3. Rot is reported as issues labelled `link-rot`. Fixes are PRs. The Librarian never merges, including its own PRs.
4. Personal-store and private-store targets must not appear. If they do, report a privacy finding; do not quote the target in a public issue.
5. Skip placeholders, `<...>` samples, and documentation-range hosts.

## Weekly scan

Configurable schedule (the adopter names the weekday and timezone). Read-only: no repo writes, no PR comments, no channel posts. Outputs: `link-rot` issues, a weekly summary to Ops, and (for a clear rewrite) a fix PR for a merge seat.

Do not teach frozen-map locator forms or internal knowledge-base URL shapes. Cite concept names.

## Stop rules

- Do not invent a replacement URL.
- Do not merge.
- Changes that would edit `intent.md`, `spec.md`, `requirements/`, or a REQ ID go through `@<code-owners>`.
