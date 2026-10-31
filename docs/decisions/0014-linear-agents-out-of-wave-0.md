---
status: "superseded by #6"
date: 2026-10-28
decision-makers: the owner (HITL/POPM)
consulted: the GM (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# O6: the issue tracker Agents out of Wave 0

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Whether to adopt the issue tracker Agents in Wave 0.

## Considered Options

* adopt
* out of Wave 0

## Decision Outcome

Chosen option: "out of Wave 0", because the owner's 2026-10-28 answer was "not a thing for us yet".

Status: superseded by #6 (`6a06388`, merged 2026-10-29). The GitHub repo is now the sole system of record for intent, spec, plan, requirements, trace map, review findings and evidence. the issue tracker is archived read-only. That replaces W0-07's "evidence in the issue tracker", W0-09's "Linear SoR with human assignee + agent delegate", and O6's the issue tracker Agents question, which no longer applies.

### Consequences

* Historical: the issue tracker Agents were out of Wave 0.
* Supersession: #6 archived the issue tracker read-only and made the repo the sole system of record, so the issue tracker Agents question no longer applies.

### Confirmation

the owner (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

## More Information

Owner: the GM (GM). Executor: Delivery · Lead.

Cross-ref: W0-09 PM / tickets (**superseded by PR #6**); W0-07 Evidence & independence (**superseded by PR #6**; independence/no-merge-grant intent carried by #22). Also [0017](0017-linear-research-epics.md). Record format: [MADR 4.0](https://adr.github.io/madr/).
