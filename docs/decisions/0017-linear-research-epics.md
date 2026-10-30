---
status: superseded by #6
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# E3: Linear research epics?

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

This is an execute authorization, not an architecture choice: may Delivery open Linear research epics?

## Considered Options

* Yes
* Not yet

## Decision Outcome

Chosen option: "Yes", because Scott authorized Delivery to open research epics, still without Linear Agents ([0014](0014-linear-agents-out-of-wave-0.md)).

Status: superseded by #6 (`6a06388`, merged 2026-10-29). The repo became the only system of record and Linear was archived read-only, so the authorization to open Linear research epics no longer applies.

### Consequences

* Historical: Delivery may open research epics, still without Linear Agents.
* Supersession: #6 made the repo the sole system of record and archived Linear read-only. `trace/linear-saf-map.csv` stays frozen and untouched.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Cross-ref: [0014](0014-linear-agents-out-of-wave-0.md) (O6); W0-07 and W0-09 (superseded by PR #6). Record format: [MADR 4.0](https://adr.github.io/madr/).
