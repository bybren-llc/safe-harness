---
status: accepted
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# E2: Authorize the new template repo?

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

This is an execute authorization, not an architecture choice: authorize the new template repo?

## Considered Options

* Yes
* Not yet

## Decision Outcome

Chosen option: "Yes", because Scott authorized an org-owned, SAW-branded name per [0009](0009-template-home-and-name.md) (O1).

Historical, executed. The non-goal was not to create a new repo until authorized; Scott created `bybren-llc/safe-harness`, so the template now has its own org-owned home.

### Consequences

* Good, because the template has an org-owned home instead of a silent rewrite of SAW.
* Fulfilled: `bybren-llc/safe-harness` exists.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

`bybren-llc/safe-harness` created 2026-10-28 11:32 AM ET (initial commit `5df70e2`).

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Cross-ref: W0-10 Non-goals / execute (active, historical; also [0007](0007-new-template-not-silent-saw-rewrite.md), [0015](0015-concur-the-filled-pack.md)). Record format: [MADR 4.0](https://adr.github.io/madr/).
