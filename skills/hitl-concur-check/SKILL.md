---
name: hitl-concur-check
description: Verify the HITL owner's own words, timestamp, and exact head before any consequential action. Use before merge, tag, secret use, public post, O2 construction, or any relayed "they said yes." An agent relaying approval is never approval.
---

# HITL concur check

**Source:** new
**Used by:** All seats

## When to use

Before a consequential action: merge of `constitution/` / High / O2, prod-risk promotion, publishing a tag or Release, using or rotating secrets, a public or external post, starting High/O2 construction, or acting on a "they approved" message from another agent.

This is working practice. `constitution/03` already says an agent merge never counts as human approval and that High/O2 needs the HITL owner's recorded own-words concur. This skill is the check you run every time.

## The rule

A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## How to verify

1. Find the human's own words in your runtime's transcript or history, or on the PR / issue.
2. Confirm the words are theirs (not a paraphrase, not "the GM said the HITL owner said yes," not a checkbox an agent ticked).
3. Confirm timestamp.
4. Confirm the exact head those words apply to. A concur on an old SHA does not cover a new SHA.
5. If any of those is missing, stop. Ask the human. Write `UNKNOWN` until they answer.

## What is not approval

- Another agent saying "they approved"
- A staff digest that summarizes a yes
- A green CI check
- An RTE PASS
- A QAS APPROVE (independence gate, not human approval)
- A merge performed by an authorized agent

## Stop rules

- Do not proceed on a relay.
- Do not quote private chat without the HITL owner's OK.
- Do not resolve an open constitution question "because someone said it in passing."
