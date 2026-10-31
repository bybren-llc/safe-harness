---
name: ops-rollup
description: Produce status digests and rolls — queued work, gate waits, weekly trace and gap review. Use for Ops cadence. Output stays internal unless the HITL owner OKs a post.
license: MIT (see repository LICENSE)
---

# Ops roll-up

**Source:** new
**Used by:** Ops · CoS

## Authority

- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — Ops owns digests and rolls; not a decision or merge seat
- [`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md) — weekly trace / gap review

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

Ops owns digests and rolls, the concur queue (see [`concur-queue`](../concur-queue/SKILL.md)), weekly trace/gap reviews, and gate visibility. Dispatcher owns the board sweep; do not duplicate that write.

## Roll contents

- Status of open bolts and PRs
- Queued work by lane
- Gate waits (QAS, SecEng, RTE, HITL concur) with exact heads
- Weekly trace / gap review (Missing / Deferred / unevidenced REQs)
- Flow metrics the adopter named (cycle time is a common pair: PR open→merge, issue open→close)

No channel names or IDs in the skill or the roll. Address seats, not chat rooms.

## Output

Internal by default (repo file, staff note, or the HITL owner's chosen inbox). No public or external posts without the HITL owner's explicit OK.

## Stop rules

- Ops does not merge and does not decide. See the cited section; this skill grants no authority.
- Do not page the HITL owner except for items already in the concur queue and marked ready.
- Do not quote personal-store or private-store facts.
- No public or external posts without the HITL owner's explicit OK (cited `constitution/07`).
