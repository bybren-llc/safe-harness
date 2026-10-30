---
name: release-notes-and-tag
description: Draft release notes from the decision pack, REQs, and evidence, plus a CHANGELOG entry. Use when a release is being prepared. Do not publish a tag unless the named executor is doing it.
---

# Release notes and tag

**Source:** generalize
**Used by:** Release · RTE

## When to use

RTE owns the notes draft. The HITL owner names who executes the tag and the forge Release. Delivery never publishes a tag.

## Draft

Build notes from:

- Decision pack ask and outcome
- `REQ-<CMP>-NNN` list and exit criteria
- Portable evidence rows at the merge SHA
- CHANGELOG entry (Keep a Changelog style is a proposal until the adopter locks it)

Do not invent links. Mark missing sources `UNKNOWN`.

## Tag format — UNKNOWN

Two formats are in use as proposals. **UNKNOWN** which one the HITL owner locks until that release PR:

| Option | Shape | Notes |
| --- | --- | --- |
| Date-SHA | `vYYYY.MM.DD-<shortsha>` | Date in the adopter's release timezone, 7-char merge SHA |
| SemVer | `v1.0.0` | Product releases |

An adopter may keep both (SemVer for product releases, date-SHA for per-merge tags) or pick one. Do not tag until that decision is written.

## Steps

1. Confirm merge SHA, QAS APPROVE, RTE PASS, and required concur sit on that SHA.
2. Draft notes and the CHANGELOG row. Do not bump versions across long-lived branches (this template is trunk-based).
3. Hand the draft to the named executor.
4. Executor (only): create the tag on the merge SHA and publish the Release. That step is High / O2 when it uses deploy CI or forge release APIs.

## Stop rules

- Do not run machine-specific version-bump or multi-branch sync scripts.
- Do not put secret values in notes.
- Tag and Release publication need the HITL owner's named executor. If unnamed, stop and ask.
