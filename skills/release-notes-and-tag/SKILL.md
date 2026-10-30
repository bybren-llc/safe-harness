---
name: release-notes-and-tag
description: Draft release notes from the decision pack, REQs, and evidence, plus a CHANGELOG entry. Use when a release is being prepared. Do not publish a tag unless the named executor is doing it.
license: MIT (see repository LICENSE)
---

# Release notes and tag

**Source:** generalize
**Used by:** Release · RTE

## Authority

- [`roles/release-rte.md`](../../roles/release-rte.md) — who drafts notes; tag format as written there; tag and Release publication pending their own O2 PR
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — O2 (deploy CI / workflows); who may execute a release step

See the cited section; this skill grants no authority.

## When to use

When a release is being prepared. Drafting notes is the RTE job in the cited role card. Who executes the tag and the forge Release is named by the HITL owner under the cited sections. This skill does not name an executor and does not publish a tag.

## Draft

Build notes from:

- Decision pack ask and outcome
- `REQ-<CMP>-NNN` list and exit criteria
- Portable evidence rows at the merge SHA
- CHANGELOG entry (Keep a Changelog style is a proposal until the adopter locks it)

Do not invent links. Mark missing sources `UNKNOWN`.

## Tag format — UNKNOWN

The cited role card records a date-SHA format. A SemVer product tag is a later proposal. **UNKNOWN** which one the HITL owner locks until that release PR. Do not tag until that decision is written in the cited sections or a later ADR.

## Steps

1. Confirm the merge SHA and the gates required by the cited sections sit on that SHA.
2. Draft notes and the CHANGELOG row. Do not bump versions across long-lived branches (this template is trunk-based).
3. Hand the draft to the named executor.
4. Executor (only): create the tag and publish the Release as the cited sections allow. If publication is still pending its O2 PR, stop and ask.

## Stop rules

- Do not run machine-specific version-bump or multi-branch sync scripts.
- Do not put secret values in notes.
- Do not invent an executor. See the cited section; this skill grants no authority.
