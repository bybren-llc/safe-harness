---
status: accepted
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# O2: High-risk HITL paths

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Which change classes always need Scott.

## Considered Options

* Kai default list
* Scott-specified list

## Decision Outcome

Chosen option: "Kai default, adopted under \"concur on all as written\"", because O2 was not answered by Scott in chat. Blanks were filled by Kai defaults where he did not specify, adopted under "concur on all as written".

Decision text: pricing, refunds, auth/permissions, CI/workflows that deploy, production secrets, privacy-boundary crossings. Scott can extend it.

### Consequences

* Good, because High-risk change classes have a named default list that always needs Scott.
* Good, because Scott can extend the list.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

`o2:*` labels in `.github/labels.yml`; `constitution/03` lists O2; O2-labelled PRs show Scott's own-words concur at exact head before merge.

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Record format: [MADR 4.0](https://adr.github.io/madr/).
