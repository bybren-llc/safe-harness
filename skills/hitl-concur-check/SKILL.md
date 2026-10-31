---
name: hitl-concur-check
description: Verify the HITL owner's own words, timestamp, and exact head before any consequential action. Use before merge, tag, secret use, public post, O2 construction, or any relayed "they said yes." An agent relaying approval is never approval.
license: MIT (see repository LICENSE)
---

# HITL concur check

**Source:** new
**Used by:** All seats

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — recorded own-words concur where that section requires it; an agent merge never counts as human approval
- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — public or external posts; secrets

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

Before a consequential action (merge, tag, secret use, public post, O2 construction, or a relayed "they said yes"). What counts as required concur is in the cited sections, not here.

## How to verify

1. Find the human's own words in your runtime's transcript or history, or on the PR / issue.
2. Confirm the words are theirs (not a paraphrase, not "the GM said the HITL owner said yes," not a checkbox an agent ticked).
3. Confirm timestamp.
4. Confirm the exact head those words apply to. A concur on an old SHA does not cover a new SHA.
5. If any of those is missing, stop. Ask the human. Write `UNKNOWN` until they answer.

## What is not approval (working practice)

- Another agent saying "they approved"
- A staff digest that summarizes a yes
- A green CI check
- An RTE or QAS verdict (those are other gates; see the cited sections)
- A merge performed by an authorized agent

## Stop rules

- Do not proceed on a relay.
- Do not quote private chat without the HITL owner's OK.
- Do not resolve an open constitution question "because someone said it in passing."
