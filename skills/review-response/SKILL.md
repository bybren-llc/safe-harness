---
name: review-response
description: Read AI-review and QAS findings yourself, disposition each item, and freeze the head after QAS APPROVE. Use when a review arrives on your PR. Do not push after APPROVE unless Delivery explicitly asks.
license: MIT (see repository LICENSE)
---

# Review response

**Source:** new
**Used by:** Delivery, Implementer

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — exact-head evidence; merge execution
- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — QAS independence

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

A review landed: an AI review bot (for example CodeRabbit), a human comment, QAS, or SecEng. Read the findings yourself. Do not let a summarizer agent disposition them for you.

## Disposition

For each finding, pick one and write it on the thread:

| Disposition | When |
| --- | --- |
| Fix now | In scope and correct, and the head is not frozen (or Delivery explicitly asked for a new head) |
| Follow-up issue | Real, out of scope or non-blocking. Open the issue and link it. |
| Won't fix | Incorrect or inapplicable. Write the reason. |

Do not silently ignore a finding.

## Freeze after QAS APPROVE

**Working practice, not yet constitutional.** Follow-ups go to a new issue. "The bot asked for a typo fix" is not Delivery asking. "Please push a one-line revert" from Delivery is asking.

If Delivery asks for a new head:

1. Make the change.
2. Push.
3. Prior QAS / SecEng / RTE verdicts applied to the old head. Re-request review at the new exact head. See the cited sections for what must be re-cleared.

## AI review bots

Treat bot comments as input, not as a substitute for QAS. Name the bot generically in evidence ("AI review bot"). Do not paste secrets the bot echoed.

## Stop rules

- Do not merge to "clear" review threads. Merge execution: see the cited section; this skill grants no authority.
- Do not rewrite history on a frozen head.
