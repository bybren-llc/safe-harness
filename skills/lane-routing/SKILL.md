---
name: lane-routing
description: Route work by the delegation map and refuse out-of-lane work. Use when picking up an issue, escalating, or deciding which seat owns a request.
license: MIT (see repository LICENSE)
---

# Lane routing

**Source:** generalize
**Used by:** All seats

## Authority

- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — lane owners; scanner, not fixer; public posts
- [`constitution/01-round-table.md`](../../constitution/01-round-table.md) — seat map
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — merge execution (do not restate it here)
- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — QAS / SecEng never collapse

See the cited section; this skill grants no authority.

**Practice guidance (not a constitutional rule):** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

Before you start work that might belong to another seat. The tables below are a reading aid. The cited sections are the map.

## Lane owners

| Seat | Owns |
| --- | --- |
| Delivery · Lead | Spine A projects end to end |
| Studio · Lead | Spine B stories and handoffs |
| Ops · CoS | Digests, rolls, concur queue |
| Dispatcher · Board | Tracking board; scheduled read-only sweep |
| Librarian | Signals, read-only external research, CVE scans, link health |
| Scout | Tool, model, and price research |
| Release · RTE | Final release gate |
| GM / lead architect | High-tier or cross-lane work only. Not a day-to-day single-lane owner. |
| HITL owner (POPM) | Human gate: prod-risk, constitution / High / O2 concur, secrets, public posts |
| QAS / SecEng / BSA-like / Implementer | On-demand specialists. QAS and SecEng never collapse. |

The GM leads. The GM is not a traffic-manager seat that orchestrates every ticket.

## How to route

1. Name the lane from the table.
2. If it is High or crosses lanes, route to the GM (or escalate via Ops).
3. If it is a security finding, every seat is a scanner: file, do not fix, unless the HITL owner explicitly said to fix.
4. If it is a public or external post, only the HITL owner writes.
5. If it is out of your lane, refuse and point at the owning seat.

## Escalation

Blocked work goes to Ops · CoS, then the GM. Do not page the HITL owner unless they are already in the thread or the item is their gate (concur, secrets, prod-risk, public posts).

## Stop rules

- Do not decide, post, or merge from a staff seat. See the cited section; this skill grants no authority.
- Do not take single-lane delivery away from Delivery · Lead.
