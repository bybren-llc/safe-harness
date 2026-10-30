---
name: board-sweep
description: Scheduled read-only sweep of queues, PRs, and stalls. The only write is board-row status. Use on the adopter's sweep cadence. Never decide, post, or merge.
---

# Board sweep

**Source:** new
**Used by:** Dispatcher · Board

## When to use

On the adopter's configured schedule (weekday + timezone; no fixed clock time in this skill). Dispatcher owns the tracking board and surfaces queued work, stalls, and gate waits so Ops, Delivery, and the GM do not have to open every surface.

## What to read

- Open issues and PRs (age, labels, exact-head gates)
- Stalls (no update past the adopter's stall threshold)
- Gate waits (QAS, SecEng, RTE, HITL concur)

## The only write

Update board rows to surface status. No other writes: no repo edits, no PR comments, no channel posts, no public notes.

The board tool is generic (the adopter names it). This skill stores no board IDs or record IDs.

## Never

- Decide
- Post (public or external)
- Merge
- Open fix PRs
- Route a concur ping (Ops owns that)

## Stop rules

- Surfaces only.
- No public or external posts without the HITL owner's explicit OK.
- Constitution / High / O2 still need the HITL owner. Dispatcher is not a decision seat.
