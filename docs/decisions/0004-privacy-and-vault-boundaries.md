---
status: accepted
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# C4: Privacy and vault boundaries

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Privacy: personal never remote · story IP on private storage · business knowledge forge-backed?

## Considered Options

* Yes
* Amend

## Decision Outcome

Chosen option: "Yes", because Scott concurred the filled pack as written.

Decision text: The personal vault is never remote, never on GitHub, and out of the Delivery lane. Story IP lives on private storage paths, which are the source of truth: pin paths, keep thin snapshots, never dump trees into desktop copies. Business knowledge and IP live in an internal, forge-backed knowledge repo under its contribution rules (register first, pin sources, `UNKNOWN:` over invention, agents don't merge their own PRs).

### Consequences

* Good, because the personal vault stays off remote forges and out of Delivery.
* Good, because story IP and business knowledge have named homes (private storage paths; an internal, forge-backed knowledge repo) without dumping trees into desktop copies.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

`constitution/04-privacy-and-vaults.md` matches; CONTRIBUTING personal-boundary rule; link-health scope excludes personal/private targets; SecEng checks for private paths in diffs.

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Cross-ref: W0-08 Vaults + handoff (active; also [0005](0005-studio-delivery-handoff-before-spine-a-build.md)). Record format: [MADR 4.0](https://adr.github.io/madr/).
