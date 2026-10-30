---
status: accepted
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# C3: SDLC = continuous deployment with risk-tier HITL

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

SDLC = CD with risk-tier HITL (not freeze by default)?

## Considered Options

* Yes
* Staged trains
* Hybrid

## Decision Outcome

Chosen option: "Yes", because Scott concurred the filled pack as written.

Decision text: Continuous deployment; verify before PR; layered automated review; merge queue + squash; flags and staged release; exact-head gates (approval binds to the commit SHA, and a new push makes it stale); production gate outside the model. HITL gate types: decision pack (blocks only that change unit); independence QAS/SecEng (blocks that unit until cleared); business-context HITL (blocks that Bolt's construction start); freeze-the-train is an org-wide exception only.

The CD + risk-tier principle stands. The specific "who approves per tier" mapping (W0-04) is superseded by PR #22 (`d88c884`, 2026-10-30). Risk-tier gate detail is now governed by #22; see [0006](0006-role-collapsing.md).

### Consequences

* Good, because HITL gates bind to a change unit and an exact head, not a freeze-the-train default.
* Partial supersession: W0-04's "low auto / medium one human / high two humans" flow was replaced by #22. Merge authority now follows a template default by risk tier and environment (dev/trunk: Kai/RTE; staging: auto; prod and constitution/High/O2: Scott's own-words concur). An agent merge never counts as human approval. "High = two distinct humans" is recommended guidance, not a gate, per [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) and Scott's answers on #22. With Scott as the only human, his own-words concur is the required human approval.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

`constitution/03-cd-and-hitl.md` states CD and tiers; PRs carry a tier label; QAS verdicts cite an exact head SHA.

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Cross-ref: W0-03 CD assumptions (active); W0-04 HITL without freeze (**superseded by PR #22**). Public framing that may be cited: the Anthropic [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook) (committed artifacts per stage, layered agentic review, human review kept for critical code, hooks as approval gates, agent acts up to the production gate and not past it). Record format: [MADR 4.0](https://adr.github.io/madr/).
