---
status: accepted
date: 2026-10-28
decision-makers: owner (HITL/POPM)
consulted: GM consulted: the GM (GM consulted: the GM (GM & lead ARCHitect) lead ARCHitect) lead ARCHitect, Studio · Lead, Studio · Lead
informed: Round Table seats
---

# C2: Dual spine (A CD execute/deploy + B think/plan)

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Confirm the dual spine?

## Considered Options

* Yes
* No (single spine)

## Decision Outcome

Chosen option: "Yes", because owner concurred the filled pack as written.

Decision text: (A) CD execute/deploy: evidence → risk-tier gates → merge queue → flags/rollback. (B) Think/plan: multi-vault knowledge + non-code gates → handoff when knowledge becomes build. Peer spines with shared Round Table language. Product CD is Delivery-owned. Studio ships vault concepts, digests and rankings. Don't overfit to forge/CI only.

### Consequences

* Good, because execute/deploy and think/plan stay peer lanes with shared language.
* Good, because product CD stays Delivery-owned and Studio is not forced through forge/CI.

### Confirmation

owner (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

Constitution and README describe both spines; role cards name a spine; the bolt label (spine A) and Studio briefs (spine B) both exist in use.

## More Information

Owner: the GM (GM). Executor: Delivery · Lead.

Cross-ref: W0-02 Dual spine (active). Public framing that may be cited: the Anthropic [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook). Record format: [MADR 4.0](https://adr.github.io/madr/).
