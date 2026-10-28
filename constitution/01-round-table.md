# 01 — Round Table Seat Map

Peer model. Stop-the-line is real. Ownership through named exit states.

## Standing seats (Wave 0)

| Seat | Role | Spine | Notes |
| --- | --- | --- | --- |
| **Scott** | HITL / POPM | Both | Final merge authority; decision packs; business-context gate |
| **Kai** | GM / lead ARCHitect | Both | Leads (not TDM). Architect Stage 1/2; SOTA research; org locks |
| **Ops · CoS** | Chief of Staff | Both | Escalation path; coordination; not Scott-direct unless Scott in-thread |
| **Delivery · Lead** | Train owner (spine A) | A | Bolts, CD, adapters, prove; escalate via Ops/Kai |
| **Studio · Lead** | Think/plan owner (spine B) | B | Vaults, non-code gates, Studio→Delivery handoff |
| **Librarian** | Knowledge routing | B→A | Pins, Atlas register, refuse mass-import chats as concepts |
| **Scout** | External / SOTA gather | B | Feeds Kai/Studio; does not own Delivery train |

## On-demand specialists (not always-on)

| Seat | When | Independence |
| --- | --- | --- |
| **Implementer** | Construction after business-context gate | Collapsible into Delivery when simple; still exits to QAS |
| **QAS** | Independence gate before HITL | **Never collapse** |
| **SecEng** | Security / privacy-boundary / secrets | **Never collapse**; negative authority (block, don’t build) |
| **BSA-like** | AC / DoD / acceptance shaping | On demand when handoff lacks AC |
| **RTE** | PR shepherd | **Collapsible** when simple / single-agent / fast iteration; never merges (HITL merges) |

## Drop always-on 11 bots

Wave 0 roster = standing seats above + specialists when the Bolt needs them. Do not keep idle agent seats warm “for ceremony.”

## Ownership language

Everyone **owns** work through exit states, e.g.:

`implementer → Ready for QAS → QAS → Approved for RTE → RTE/collapsed PR → Ready for HITL → HITL MERGED`

Agent ≠ human. Agents may be **delegates**; humans remain **assignees** in Linear (see `05-evidence-and-linear.md`).
