---
status: accepted
date: 2026-10-28
decision-makers: the owner (HITL/POPM)
consulted: the GM (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# O5: Always-on / Dark Factory environment

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Whether a persistent always-on environment is required.

## Considered Options

* tmux Dark Factory required
* optional ongoing environment

## Decision Outcome

Chosen option: "An ongoing environment on private on-prem compute plus cloud", because the owner concurred the filled pack as written.

A workstation may stay on during working runs. Dark Factory is an optional legacy/ongoing environment, not required ceremony (ties to M2).

### Consequences

* Good, because Dark Factory / tmux is not required ceremony (M2: tmux not required).
* Good, because an ongoing environment on private on-prem compute plus cloud is enough.

### Confirmation

the owner (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

The happy path in adapters needs no tmux; Dark Factory is documented as optional only.

## More Information

Owner: the GM. Executor: Delivery · Lead.

the owner's O1–O6 answers were typed at 2026-10-28, 11:09 AM ET in a longer message that names private storage and hardware. That message is not quoted here. Record format: [MADR 4.0](https://adr.github.io/madr/).
