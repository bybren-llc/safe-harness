---
status: accepted
date: 2026-10-28
decision-makers: owner (HITL/POPM)
consulted: GM consulted: the GM (GM consulted: the GM (GM & lead ARCHitect) lead ARCHitect) lead ARCHitect, Studio · Lead, Studio · Lead
informed: Round Table seats
---

# C1: Lock M1–M6 as Wave 0 value metrics

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence). The cycle under test was: R&D → draft → the owner concur → execute → measure against M1–M6.

Lock M1–M6 as Wave 0 value metrics?

## Considered Options

* Yes
* Yes with edits
* No (rewrite)

## Decision Outcome

Chosen option: "Yes", because owner concurred the filled pack as written.

Decision text: M1 multi-runtime template ships (Wave 0: Claude Code + Cursor adapters live; Codex/local/Grok next, same constitution). M2 tmux not required (happy path in-process; tmux optional display only). M3 SAFe + AI-DLC spine retained (Bolts / Units of Work / Mob Elaboration / human validate still taught). M4 Round Table seats map (Scott/Kai/Ops/Delivery/Studio/Librarian/Scout + on-demand SAFe specialists). M5 time-to-first owned ticket (new seat owns a ticket under exit states; measure human minutes + SLA after first prove). M6 deploy/release flow health (risk-tier CD path; evidence → independence → decision pack; revert/incident as guardrails).

### Consequences

* Good, because every Bolt and decision pack has a fixed measurement set.
* Good, because empiricism has something to compare against: techniques that win in controlled comparison replace prior defaults.

### Confirmation

owner (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

Every Bolt retro and decision pack reports against M1–M6; `spec.md` keeps an M1–M6 pointer; a reviewer can find a measurement row per metric in `prove/`.

## More Information

Owner: the GM (GM). Executor: Delivery · Lead.

Cross-ref: W0-01 Value metrics (active). Public framing that may be cited: the Anthropic [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook). Record format: [MADR 4.0](https://adr.github.io/madr/).
