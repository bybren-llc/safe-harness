---
status: "superseded (RTE clause) by #22"
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# C6: Role collapsing

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

RTE collapsible; QAS + SecEng never; drop always-on 11 bots?

## Considered Options

* Yes
* Amend

## Decision Outcome

Chosen option: "Yes", because Scott concurred the filled pack as written on 2026-10-28.

Decision text: RTE may collapse when simple. QAS and SecEng never collapse. Drop the always-on 11 SAFe bots and collapse lanes until a lane overloads. Kai leads, and TDM is reactive, not the primary orchestrator.

Status: superseded (RTE clause) by #22 (`d88c884`, merged 2026-10-30). Release · RTE is now an independent, non-collapsible final release gate. Trunk merge rights are in [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md). The QAS/SecEng-never-collapse and drop-the-11-bots parts of C6 still stand.

### Consequences

* Historical: RTE could collapse when simple; QAS and SecEng could not; the always-on 11-bot roster was dropped.
* Supersession (RTE clause only): #22 made Release · RTE non-collapsible. Merge authority is in [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md), replacing W0-04's "low auto / medium one human / high two humans" flow. An agent merge never counts as human approval. "High = two distinct humans" is recommended guidance, not a gate, per constitution/03 and Scott's answers on #22. With Scott as the only human, his own-words concur is the required human approval.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

Historical: `roles/` no longer carries a collapsible-RTE card as current (PR #22 removed it); `roles/release-rte.md` describes the gate.

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Cross-ref: W0-05 Ownership / collapsing (RTE part superseded by PR #22); W0-04 HITL without freeze (**superseded by PR #22**). Record format: [MADR 4.0](https://adr.github.io/madr/).
