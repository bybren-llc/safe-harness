---
name: release-notes-and-tag
description: Draft release notes from the decision pack, REQs, and evidence, plus a CHANGELOG entry. Use when a release is being prepared. Do not publish a tag unless the named executor is doing it.
license: MIT (see repository LICENSE)
---

# Release notes and tag

**Source:** generalize
**Used by:** Release · RTE

## Authority

- [`roles/release-rte.md`](../../roles/release-rte.md) — who drafts notes; per-merge `vYYYY.MM.DD-<shortsha>` and product SemVer (`vMAJOR.MINOR.PATCH`, first `v1.0.0`); after merge, Release · RTE tags the main merge SHA under the recorded concur, with a GitHub Release whose notes match the CHANGELOG entry
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — O2 (deploy CI / workflows); who may execute a release step

See the cited section; this skill grants no authority.

## When to use

When a release is being prepared. Drafting notes is the RTE job in the cited role card. After merge, Release · RTE tags the main merge SHA and publishes the GitHub Release under the recorded concur, as [`roles/release-rte.md`](../../roles/release-rte.md) states. This skill does not publish a tag.

## Draft

Build notes from:

- Decision pack ask and outcome
- `REQ-<CMP>-NNN` list and exit criteria
- Portable evidence rows at the merge SHA
- CHANGELOG entry (Keep a Changelog style is a proposal until the adopter locks it)

Do not invent links. Mark missing sources `UNKNOWN`.

## Tag format

Per-merge tag format is `vYYYY.MM.DD-<shortsha>` (date in America/New_York, 7-char merge SHA). Product releases use SemVer tags (`vMAJOR.MINOR.PATCH`, first `v1.0.0`): after merge, Release · RTE tags the main merge SHA, and re-PASSes that SHA first if it differs from the PASSed PR head. The tag is created under the recorded concur, with a GitHub Release whose notes match the CHANGELOG entry. Per-merge date-sha tags stay as documented. See [`roles/release-rte.md`](../../roles/release-rte.md).

## Steps

1. Confirm the merge SHA and the gates required by the cited sections sit on that SHA.
2. Draft notes and the CHANGELOG row. Do not bump versions across long-lived branches (this template is trunk-based).
3. Hand the draft to the named executor.
4. Release · RTE (only): after merge, tag the main merge SHA and publish the GitHub Release as [`roles/release-rte.md`](../../roles/release-rte.md) states, under the recorded concur. Re-PASS that SHA first if it differs from the PASSed PR head. Tagging/release automation is deploy CI / workflows → O2 → High unless the GM downgrades in writing at QAS (`constitution/03-cd-and-hitl.md`). Do not treat publication as unassigned.

## Stop rules

- Do not run machine-specific version-bump or multi-branch sync scripts.
- Do not put secret values in notes.
- Do not invent an executor. See the cited section; this skill grants no authority.
