# Changelog

All notable changes to this project are documented in this file.

Format follows Keep a Changelog conventions. Product versions use SemVer (`MAJOR.MINOR.PATCH`). Per-merge tags stay `vYYYY.MM.DD-<shortsha>` as recorded in [`roles/release-rte.md`](roles/release-rte.md).

The heading stays `## [1.0.0] - TBD` until tag time.

Each merged row is `PR number — one-line summary (7-char merge SHA)`, taken from `git log --first-parent main` from the first Wave 0 commit through HEAD.

## [Unreleased]

Merged v1.0 rows recorded here until Release · RTE creates tag `v1.0.0`. The product tag does not exist yet. SHAs below are on `main`.

### Added

- #47 — AGENTS.md entry points + CODEOWNERS coverage (`202d29c`)
- #48 — doc-drift + trace/ link coverage checks, warn-only (`606d4b6`)
- #51 — trace-check validations, warn-only (`27fbc68`)
- #59 — Rewrite README for v1.0 (generic, template-ready) (`7fc391d`)

## [1.0.0] - TBD

First product release of safe-harness. After merge, Release · RTE tags the main merge SHA, and re-PASSes that SHA first if it differs from the PASSed PR head. The tag is created under the recorded concur.

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
