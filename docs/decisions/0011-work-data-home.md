---
status: accepted
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# O3: Work-data home

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Where work data and vaults live.

## Considered Options

* workstation-local
* private network storage
* cloud

## Decision Outcome

Chosen option: "A private NAS (redundant storage) is the source of truth for work data", because Scott concurred the filled pack as written.

Workstations mount it, with local working copies only when the network is down. The personal vault, the internal business-knowledge repo's working data, and story IP live on private storage paths, not desktop copies. Desktop-held personal data migrates to the private storage.

### Consequences

* Good, because work data has a private-storage source of truth and desktop copies are not the home.
* Good, because the personal vault, business-knowledge working data, and story IP stay on private storage paths.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

The repo contains no private storage paths; Studio briefs cite storage paths only as pinned references in private channels; SecEng and link-health exclude private targets.

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Scott's O1–O6 answers were typed at 2026-10-28, 11:09 AM ET in a longer message that names private storage and hardware. That message is not quoted here. Record format: [MADR 4.0](https://adr.github.io/madr/).
