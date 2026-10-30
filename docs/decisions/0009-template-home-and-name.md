---
status: accepted
date: 2026-10-28
decision-makers: Scott (HITL/POPM)
consulted: Kai (GM & lead ARCHitect), Studio · Lead
informed: Round Table seats
---

# O1: Template home and name

## Context and Problem Statement

Wave 0 rethought the predecessor template, SAW (Safe Agentic Workflow), as a modern multi-runtime work harness for Claude Code, Codex, Cursor, local models and Grok Bot. It keeps the SAFe + AI-DLC ownership/cadence spirit (Bolts, Units of Work, human validation of business context, exit states, QAS/SecEng independence).

Where the new template lives and what it's called.

## Considered Options

* `safe-agentic-workflow-v3`
* `saw-harness`
* `agentic-workflow`
* `safe-agentic-harness`
* `agentic-spine`
* org home vs personal

## Decision Outcome

Chosen option: "`bybren-llc/safe-harness`, an org-owned repo with internal (org-visible) visibility", because Scott picked `saw-harness` first, then renamed to `safe-harness` at creation.

Picked as `saw-harness` first (card at 11:12 AM ET on 2026-10-28), then renamed to `safe-harness` at creation. Scott created `bybren-llc/safe-harness` himself (GitHub `created_at` 2026-10-28 15:32 UTC = 11:32 AM ET), and that became the final name. "SAW" keeps reading as Safe Agentic Workflow, with "safe" in its everyday sense, not the SAFe trademark. Anything other than the personal vault is created under the org so the org can see it.

### Consequences

* Good, because the template is org-owned and org-visible, not personal-vault-owned.
* Good, because the everyday word "safe" is not the SAFe trademark.

### Confirmation

Scott (HITL/POPM), one-pass concur of the Wave 0 pack:

> **2026-10-28, 11:10 AM ET:** "yes then A - concur on all as written lets' go for it!"

> **2026-10-28, 11:11 AM ET:** "good plans / specs = better chance of success.  lead this up Sir and OWN it.  let's see what our team is capable of"

The repo exists under the org with internal visibility; README names it and its lineage.

## More Information

Owner: Kai (GM). Executor: Delivery · Lead.

Cross-ref: [0016](0016-authorize-new-template-repo.md) (E2 authorize the repo). Record format: [MADR 4.0](https://adr.github.io/madr/).
