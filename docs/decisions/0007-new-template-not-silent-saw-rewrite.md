---
status: accepted
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# C7: New template, not a silent SAW rewrite

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

New template (not a silent SAW rewrite); SAW stays reference?

## Considered Options

* Yes
* Amend

## Decision Outcome

Chosen option: "Yes", because Scott concurred the filled pack as written.

Decision text: Build a new template harness. SAW stays reference, pattern library and migration source, frozen as reference. Don't fork the methodology silently. One core + thin adapters.

### Consequences

* Good, because SAW stays a frozen reference and is not rewritten in place.
* Good, because one constitution plus thin adapters is the template shape.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

safe-harness exists as its own repo; README explains its relation to SAW as reference only; no PRs to SAW were made for Wave 0.

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Cross-ref: W0-10 Non-goals / execute (active, historical; also [0015](0015-concur-the-filled-pack.md), [0016](0016-authorize-new-template-repo.md)). Record format: [MADR 4.0](https://adr.github.io/madr/).
