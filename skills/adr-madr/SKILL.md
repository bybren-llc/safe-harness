---
name: adr-madr
description: Write one Architecture Decision Record per decision in MADR 4.0 with a Confirmation section, and update the decision log. Use when locking a structural, options, or execute decision.
license: MIT (see repository LICENSE)
---

# ADR (MADR 4.0)

**Source:** generalize
**Used by:** GM, Delivery

## Authority

- [`constitution/05-evidence-and-traceability.md`](../../constitution/05-evidence-and-traceability.md) — repo is SoR
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — constitution changes need recorded concur; exact-head

See the cited section; this skill grants no authority.

**Practice guidance (not a constitutional rule):** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

One ADR per decision. The repo is the source of truth. Do not publish the ADR to an external wiki as the record.

Format: [MADR](https://adr.github.io/madr/) 4.0, plus a `## Confirmation` section that records who concurred, in what words, at what head.

## Steps

1. Take the next number under `docs/decisions/` (four-digit prefix).
2. Fill: status, date, deciders, context, considered options, decision outcome, consequences, Confirmation.
3. If a later decision supersedes or amends this one, add a "Superseded/amended by" link to the later ADR and to the in-repo issue or PR that changed the rule.
4. Add a row to `docs/decisions/log.md`: ID, date, decider, ADR link, Decision issue, merge SHA, status.
5. Keep Confirmation non-empty. If the HITL owner's verbatim concur is not on hand, write `UNKNOWN` and say what is missing. Do not invent a quote.

## Confirmation

Record:

- Who (seat + human name only if they wrote it)
- Own words (quoted) or `UNKNOWN`
- Timestamp
- Exact head

## Stop rules

- No private names, hostnames, or vault paths. Sanitize options that name private stores or vendor model versions; point at the off-repo source if the HITL owner wants verbatim text kept elsewhere.
- External URLs: [MADR](https://adr.github.io/madr/) and in-repo links only, unless the HITL owner adds another allowlisted URL.
- Do not edit `constitution/` in the same change as an ADR import unless that is the agreed PR. ADRs record decisions; the constitution is the binding text.
