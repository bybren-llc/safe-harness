---
name: bolt-lifecycle
description: Run one bolt from brief through implement, evidence, the GM, RTE, and merge request. Use for a bounded unit of work on Low, Med, or High paths. Not for open-ended research or constitution edits without a brief.
---

# Bolt lifecycle

**Source:** generalize
**Used by:** Delivery · Lead, Implementer

## Authority

- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — Bolt / Unit of Work; human validate; QAS / SecEng / RTE collapse
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — tiers, O2, decision pack, exact-head, merge execution
- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — scanner, not fixer

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

A bolt is a time-boxed delivery unit that exits on evidence, not a date. Use this skill to run one bolt. Use [`orchestration-patterns`](../orchestration-patterns/SKILL.md) when the work spans several bolts or parallel sessions.

Cadence terms (Bolt, Unit of Work, human validate) follow the [SAFe](https://scaledagileframework.com/) ownership spine and the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook). Gates themselves are in the cited sections.

## Paths (reading order only)

The cited sections define the gates. This table is a reading order, not a grant of authority.

| Tier | Typical order |
| --- | --- |
| Low | Brief → implement → evidence → QAS → RTE as the cited sections require → merge request |
| Med | Same, plus the decision pack and RTE verdict the cited sections require |
| High / O2 | Business-context HITL before construction when the cited sections require it, then the High / O2 path there |

## Steps

1. Open or pick a GitHub Issue. Label work type, risk tier, and any O2 item named in the cited section.
2. Fill a bolt brief (`templates/delivery-bolt-brief.md`). Name the human assignee, agent delegate, and the QAS / SecEng actors the cited sections require.
3. Confirm AC. If AC is missing, stop and route to BSA-like / Studio. Do not invent AC. See [`acceptance-criteria`](../acceptance-criteria/SKILL.md).
4. When the cited sections require business-context HITL before construction, verify own words ([`hitl-concur-check`](../hitl-concur-check/SKILL.md)).
5. Branch `<issue#>-slug` from trunk (`main`). See [`github-conventions`](../github-conventions/SKILL.md).
6. Implement. Check the adopter's pattern library first ([`pattern-discovery`](../pattern-discovery/SKILL.md)).
7. Record portable evidence at the exact head ([`portable-evidence`](../portable-evidence/SKILL.md)).
8. Run the repo's documented check command ([`pre-pr-validation`](../pre-pr-validation/SKILL.md)). Open the PR.
9. Independent QAS at the exact head. Then RTE as the cited sections require for the tier.
10. Request merge. Merge execution: see the cited section; this skill grants no authority.

## Stop rules

- Do not merge from this skill. See the cited section; this skill grants no authority.
- Scanner, not fixer: see the cited `constitution/07` section.
- Do not collapse the GM, SecEng, or RTE except as the cited `constitution/02` section allows.
