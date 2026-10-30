---
name: start-end-work
description: Start a work session (pick issue, branch, read brief) and end it (evidence posted, status, handoff). Use at session boundaries on Delivery work.
---

# Start and end work

**Source:** generalize
**Used by:** Delivery, Implementer

## Start

1. Pick the GitHub Issue. Confirm AC. If AC is missing, stop and route to BSA-like / Studio. Do not invent AC.
2. Read the bolt brief and any Studio handoff. Confirm lane and tier.
3. Update trunk (`main`) and create `<issue#>-slug` if needed.
4. State readiness or blockers. Do not start High/O2 construction without own-words HITL. See [`hitl-concur-check`](../hitl-concur-check/SKILL.md).

## End

1. Classify: complete / WIP / blocked.
2. Commit only if the head is not frozen. After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.
3. Post portable evidence and status on the issue or PR.
4. Hand off: remaining work, blockers, exact head, next seat.

## Mid-session health (optional)

- Branch name matches the issue
- Not behind trunk without a plan
- No secret files in the tree

## Stop rules

- Do not sync an optional external tracker as part of start/end.
- Do not merge at end-of-session.
- A consequential action needs the human's own words verified. An agent relaying approval is never approval.
