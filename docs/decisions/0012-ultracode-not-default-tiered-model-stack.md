---
status: accepted
date: 2026-10-28
decision-makers: the owner (HITL/POPM)
consulted: the GM (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# O4: Ultracode not default; tiered model stack

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Default orchestration mode and model selection.

## Considered Options

* ultracode as default
* ultracode as one option + an explicit model stack

## Decision Outcome

Chosen option: "Ultracode is one of several options, not the default", because the owner concurred the filled pack as written.

The real default is a tiered model stack: the most capable orchestrator-class model (newest when released) orchestrates; frontier heavy-lift models do implementation by complexity; small fast models do research, confirmations, QAS and info jobs. Role→model cards are mirrored in every vendor harness, using the models that vendor offers.

### Consequences

* Good, because ultracode is not the default path.
* Good, because each vendor harness mirrors the same role→model cards using the models that vendor offers.

### Confirmation

the owner (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

A role→model card (e.g. `roles/model-stack.md`) exists and each adapter references it; no adapter hard-codes ultracode as default.

## More Information

Owner: the GM. Executor: Delivery · Lead.

the owner's O1–O6 answers were typed at 2026-10-28, 11:09 AM ET in a longer message that names private storage and hardware. That message is not quoted here. Record format: [MADR 4.0](https://adr.github.io/madr/).
