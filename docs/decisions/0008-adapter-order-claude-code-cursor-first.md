---
status: accepted
date: 2026-10-28
decision-makers: owner (HITL/POPM)
consulted: GM consulted: the GM (GM consulted: the GM (GM & lead ARCHitect) lead ARCHitect) lead ARCHitect, Studio · Lead, Studio · Lead
informed: Round Table seats
---

# C8: Wave 0 adapters = Claude Code + Cursor first

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Wave 0 adapters = Claude Code + Cursor first; Codex/local/Grok next?

## Considered Options

* Yes
* Reorder

## Decision Outcome

Chosen option: "Yes", because owner concurred the filled pack as written.

Decision text: One constitution; each runtime is a thin adapter, not a forked methodology. Claude Code (subagents/teams/workflows; map SAFe roles to agent defs; hooks for exit states). Cursor (Cloud Agents + Projects coordinator; project = Delivery train; rules mirror constitution). Next: Codex (role TOML from same role cards), local models (narrow tools, strict stop rules), Grok Bot (persistent seats, routines, digests; hands code to adapters).

### Consequences

* Good, because Wave 0 ships two adapters against one constitution.
* Good, because later runtimes (Codex, local, Grok Bot) reuse the same role cards rather than forking the methodology.

### Confirmation

owner (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

`adapters/claude-code/` and `adapters/cursor/` exist and reference the same constitution; parity check in PR4 (AGENTS.md per adapter).

## More Information

Owner: the GM (GM). Executor: Delivery · Lead.

Cross-ref: W0-06 Multi-runtime (active). Record format: [MADR 4.0](https://adr.github.io/madr/).
