---
name: studio-handoff
description: Emit or accept the Studio to Delivery handoff artifact (AC, sources, privacy class, exit evidence). Use when spine B knowledge becomes buildable on spine A.
license: MIT (see repository LICENSE)
---

# Studio → Delivery handoff

**Source:** port
**Used by:** Studio · Lead, Delivery

## Authority

- [`constitution/04-privacy-and-vaults.md`](../../constitution/04-privacy-and-vaults.md) — handoff minimum; source pins
- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — RTE collapse at Low only
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — merge execution (Studio does not merge Delivery work)

See the cited section; this skill grants no authority.

## When to use

Spine B (think/plan) has something Delivery can build. Emit the handoff. Delivery does not start a bolt from a chat dump or a "just start coding" note.

Template: `templates/studio-to-delivery-handoff.md`.

## Minimum fields

| Field | Rule |
| --- | --- |
| Handoff ID | Stable slug. No board or record IDs from an external tool. |
| Outcome / value | M1–M6 and/or the bolt goal |
| Summary | ≤5 lines |
| AC / DoD | Testable, or a named BSA follow-on |
| Source pins | Generic source pin (forge-backed concept or private-store pin from Studio / Librarian). Never a personal-store pin. |
| Privacy class | Personal / private-store / forge-backed. See [`privacy-boundary`](../privacy-boundary/SKILL.md). |
| Non-code gates passed | List |
| Suggested owner seat | Delivery lane owner |
| RTE collapse | As the cited `constitution/02` section allows |
| Risk tier guess | Low / Med / High + O2 items |
| Exit evidence expected | What spine A must attach |
| Out of scope | Explicit |

## Refuse (emitter)

- Personal-store citations
- Mass-imported chat dumps as concepts
- Invented source pins
- Missing AC with no BSA follow-on

## Accept checklist (Delivery)

- [ ] Pins resolve
- [ ] AC is testable or BSA is named
- [ ] Risk tier + O2 scanned
- [ ] Human assignee identified (agent delegate optional)
- [ ] Bolt brief opened from `templates/delivery-bolt-brief.md`

## Stop rules

- Studio does not own the Delivery merge. See the cited section; this skill grants no authority.
- Delivery does not invent pins.
- Do not put secret values in the handoff.
