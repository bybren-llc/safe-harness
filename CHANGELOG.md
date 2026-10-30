# Changelog

All notable changes to this project are documented in this file.

Format follows Keep a Changelog conventions. Product versions use SemVer (`MAJOR.MINOR.PATCH`). Per-merge tags stay `vYYYY.MM.DD-<shortsha>` as recorded in [`roles/release-rte.md`](roles/release-rte.md).

The `## [1.0.0] - 2026-10-30` date is to be confirmed at tag time.

Each merged row is `PR number — one-line summary (7-char merge SHA)`, taken from `git log --first-parent main` from the first Wave 0 commit through `f90ec1f`. In-flight rows that must land before the tag are marked `(pending merge, SHA TBD)`. Delivery will ask for one final commit that fills those SHAs.

## [Unreleased]

Placeholder rows for in-flight v1.0 work that will merge before tag `v1.0.0`. SHAs are TBD.

### Added

- #47 — AGENTS.md entry points + CODEOWNERS coverage (`pending merge, SHA TBD`)
- #48 — doc-drift + trace/ link coverage checks, warn-only (`pending merge, SHA TBD`)
- #51 — trace-check validations, warn-only (`pending merge, SHA TBD`)
- README rewrite (PR7) (`pending merge, SHA TBD`)

## [1.0.0] - 2026-10-30

First product release of safe-harness. Date to be confirmed when Release · RTE creates tag `v1.0.0` on the exact `main` SHA that RTE PASSed.

### Added

#### Constitution and governance

- #2 — Land Wave 0 constitution pack and thin CI (`740eb2a`)
- #4 — D-P1 steps 6–8 evidence and measure (`333edff`)
- #5 — Wave 0 meta-cycle retro and D1 decision pack (`8cbf842`)
- #6 — Wave 1 repo-only source of truth: constitution/05+03 amendments, trace registry, D1 (`6a06388`)
- #22 — Release · RTE merge-rights amendment (`d88c884`)
- #23 — Link-health and rot-detection spec (`8a9ab71`)
- #27 — Delegation map and #22 follow-ups (`132f890`)
- #41 — Branch-protection policy and apply/verify checklist (`afbaf4f`)

#### Templates

- #3 — D-P1 delivery bolt brief and checklist (`acd9f38`)
- #44 — Pull-request template and decision-log standing-concur row (`f90ec1f`)

#### Skills

- #32 — v1.0 skills library (`e52ca70`)

#### CI checks

Warn-only jobs do not block merge.

- #31 — API contract workflow (warn-only oasdiff + Schemathesis) (`79c92ed`)
- #43 — Skills frontmatter and skills/ link scan in CI (warn-only) (`c4a59c4`)

#### Privacy denylist

- #38 — Privacy scrub and fail-closed local denylist check (`0abdbca`)

#### ADRs and decision log

- #34 — 17 MADR ADRs and decision log (`2d45cf8`)

### Changed

#### Release flow

- #29 — Reconcile `release/flow.md` with constitution/03, constitution/05, and the Release · RTE card (`42dfe93`)

#### Renames

- #45 — Rename constitution/05 and role cards (`bfb7cef`)

### Fixed

- #42 — CodeRabbit follow-ups on v1.0 skills (`5afd7d5`)

### Security

- #38 — Privacy scrub and fail-closed local denylist check (`0abdbca`)

## Known follow-ups (v1.0.1 / v1.1)

Open issues. Titles are the issue titles as filed. Not part of 1.0.0.

- #52 — [v1.0.1 must-fix] Denylist: reject U+FEFF/NUL in decoded text; scan file and folder names, alongside the CI-secret denylist (v1.1)
- #55 — skills: follow-ups from #42 CodeRabbit review (duplicate frontmatter keys, skills/ link coverage, registry-PR wording)
- #56 — PR template: add a decision-pack link field (v1.1)
- #57 — PR template: don't prefill 'Requirements: N/A' once spec.md has REQ IDs
- #35 — v1.1: harden API contract workflow (SHA pin, oasdiff checksum, warn-only installs)
- #53 — Align constitution/05 D1 example with the decisions-log delegation record
- #7 — Trace-check blocking validations
