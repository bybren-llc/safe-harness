---
name: bolt-lifecycle
description: Run one bolt from brief through implement, evidence, QAS, RTE, and merge request. Use for a bounded unit of work on Low, Med, or High paths. Not for open-ended research or constitution edits without a brief.
---

# Bolt lifecycle

**Source:** generalize
**Used by:** Delivery · Lead, Implementer

## When to use

A bolt is a time-boxed delivery unit that exits on evidence, not a date. Use this skill to run one bolt. Use [`orchestration-patterns`](../orchestration-patterns/SKILL.md) when the work spans several bolts or parallel sessions.

Cadence terms (Bolt, Unit of Work, human validate) follow the [SAFe](https://scaledagileframework.com/) ownership spine and the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook).

## Paths

| Tier | Path |
| --- | --- |
| **Low** | Brief → implement → evidence → QAS → annotated RTE checklist (non-blocking) → merge request. Fast path for small, isolated fixes with testable AC. |
| **Med** | Same, plus a human decision pack and a required RTE PASS or HOLD. |
| **High / O2** | Business-context HITL before construction, decision pack, QAS, SecEng (never N/A), RTE PASS, and the HITL owner's own-words concur at the exact head. |

O2 items (pricing, refunds, auth, deploy CI/workflows, prod secrets, privacy-boundary) default to High unless the GM downgrades them in writing at QAS. See `constitution/03`.

## Steps

1. Open or pick a GitHub Issue. Label work type, risk tier, and any O2 item.
2. Fill a bolt brief (`templates/delivery-bolt-brief.md`). Name the human assignee, agent delegate, QAS actor (never the implementer), and SecEng actor when Med/High/O2.
3. Confirm AC. If AC is missing, stop and route to BSA-like / Studio. Do not invent AC. See [`acceptance-criteria`](../acceptance-criteria/SKILL.md).
4. On Med/High/O2, get business-context HITL before construction. Verify own words. See [`hitl-concur-check`](../hitl-concur-check/SKILL.md).
5. Branch `<issue#>-slug` from trunk (`main`). See [`github-conventions`](../github-conventions/SKILL.md).
6. Implement. Check the adopter's pattern library first ([`pattern-discovery`](../pattern-discovery/SKILL.md)).
7. Record portable evidence at the exact head ([`portable-evidence`](../portable-evidence/SKILL.md)).
8. Run the repo's documented check command ([`pre-pr-validation`](../pre-pr-validation/SKILL.md)). Open the PR.
9. Independent QAS at the exact head. Then RTE per tier.
10. Request merge. Delivery and cloud agents never merge.

**Low fast path** (small isolated fix): skip unused seats, keep QAS independent, keep an annotated RTE checklist, still freeze after `QAS: APPROVE`.

## After QAS APPROVE

After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

## Stop rules

- Do not merge. Do not treat an agent merge as human approval.
- A consequential action needs the human's own words verified. An agent relaying approval is never approval.
- Scanner, not fixer: no security fix PRs without the HITL owner's explicit go.
- Do not collapse QAS or SecEng. Do not collapse RTE at Med+.
- Do not restate gate text here — `constitution/03` is the rule.
