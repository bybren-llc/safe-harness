---
name: release-notes-and-tag
description: Draft release notes from the decision pack, REQs, and evidence, plus a CHANGELOG entry. Use when a release is being prepared. Do not publish a tag unless the named executor is doing it.
license: MIT (see repository LICENSE)
---

# Release notes and tag

**Source:** generalize
**Used by:** Release · RTE

## Authority

- [`roles/release-rte.md`](../../roles/release-rte.md) — RTE owns release notes and tagging. A release that contains prod-risk tier changes (migrations, money/pricing/refunds, auth/permissions, deploy CI/workflows, prod secrets, privacy-boundary (O2)) is tagged only after the HITL's concur on that release; all other releases are tagged once RTE PASS is recorded. Per-merge `vYYYY.MM.DD-<shortsha>` and product SemVer (`vMAJOR.MINOR.PATCH`); GitHub Release notes match the CHANGELOG entry.
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — O2 (deploy CI / workflows); who may execute a release step

See the cited section; this skill grants no authority.

## When to use

When a release is being prepared. Drafting notes is the RTE job in the cited role card. After merge, Release · RTE tags per [`roles/release-rte.md`](../../roles/release-rte.md). This skill does not publish a tag.

## Draft

Build notes from:

- Decision pack ask and outcome
- `REQ-<CMP>-NNN` list and exit criteria
- Portable evidence rows at the merge SHA
- CHANGELOG entry (Keep a Changelog style is a proposal until the adopter locks it)

Do not invent links. Mark missing sources `UNKNOWN`.

## Tag format

RTE owns release notes and tagging. A release that contains prod-risk tier changes (migrations, money/pricing/refunds, auth/permissions, deploy CI/workflows, prod secrets, privacy-boundary (O2)) is tagged only after the HITL's concur on that release; all other releases are tagged once RTE PASS is recorded. Per-merge tag format is `vYYYY.MM.DD-<shortsha>` (date in America/New_York, 7-char merge SHA). Product releases use SemVer tags (`vMAJOR.MINOR.PATCH`): after merge, Release · RTE tags the main merge SHA, and re-PASSes that SHA first if it differs from the PASSed PR head. The GitHub Release notes match the CHANGELOG entry. Per-merge date-sha tags stay as documented. See [`roles/release-rte.md`](../../roles/release-rte.md).

## Steps

1. Confirm the merge SHA and the gates required by the cited sections sit on that SHA.
2. Draft notes and the CHANGELOG row. Do not bump versions across long-lived branches (this template is trunk-based).
3. Hand the draft to the named executor.
4. Release · RTE (only): after merge, tag the main merge SHA and publish the GitHub Release as [`roles/release-rte.md`](../../roles/release-rte.md) states. Re-PASS that SHA first if it differs from the PASSed PR head. O2/High applies only to deploy-CI and workflow tag-automation steps (`constitution/03-cd-and-hitl.md` Deploy CI / workflows); the GM may downgrade those in writing at QAS. Do not treat publication as unassigned.

## Stop rules

- Do not run machine-specific version-bump or multi-branch sync scripts.
- Do not put secret values in notes.
- Do not invent an executor. See the cited section; this skill grants no authority.
