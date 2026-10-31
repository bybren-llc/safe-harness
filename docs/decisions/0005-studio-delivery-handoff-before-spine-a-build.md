---
status: accepted
date: 2026-10-28
decision-makers: owner (HITL/POPM)
consulted: the GM (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# C5: Studio→Delivery handoff before spine-A build

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Require a Studio→Delivery handoff before spine-A build?

## Considered Options

* Yes
* Soft guideline

## Decision Outcome

Chosen option: "Yes", because owner concurred the filled pack as written.

Decision text: When work becomes build, Studio hands Delivery a brief with: outcome/value link (M1–M6 or Bolt goal), acceptance criteria/DoD, source pins (business-knowledge concept IDs and/or private storage path references, never the personal vault), non-code gates already passed, suggested owner seat, and expected exit evidence on spine A. Studio flow: Brief → Evidence (sources cited, no invented links) → Gate (privacy/PII/IP class) → Concur (the owner) → Ship/verify/log.

### Consequences

* Good, because spine-A build starts from a brief with value link, DoD, source pins, and already-passed non-code gates.
* Good, because the personal vault is never a source pin.

### Confirmation

owner (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

A handoff/bolt-brief template exists in `templates/`; spine-A Bolts that start from Studio work link a handoff brief.

## More Information

Owner: the GM (GM). Executor: Delivery · Lead.

Cross-ref: W0-08 Vaults + handoff (active; also [0004](0004-privacy-and-vault-boundaries.md)). Record format: [MADR 4.0](https://adr.github.io/madr/).
