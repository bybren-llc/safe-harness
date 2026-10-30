# 01 — Round Table Seat Map

Peer model. Stop-the-line is real. Ownership through named exit states.

## Standing seats (Wave 0)

| Seat | Role | Spine | Notes |
| --- | --- | --- | --- |
| **Scott** | HITL / POPM | Both | Final human merge authority (constitution/, High, and O2; prod-risk at prod); decision packs; business-context gate |
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
| **RTE** | Release gate | **Independent gate**; may merge on trunk per constitution/03 (checks green + Kai's independent QAS APPROVE + RTE PASS at exact head; Scott concur on constitution/, High, and O2) |

## Drop always-on 11 bots

Wave 0 roster = standing seats above + specialists when the Bolt needs them. Do not keep idle agent seats warm “for ceremony.”

## Ownership language

Everyone **owns** work through exit states, e.g.:

`implementer → Ready for QAS → QAS → Approved for RTE → RTE PASS (in parallel with Scott concur where required) → Ready for HITL → MERGED (HITL only | HITL-delegated | delegated Kai/RTE)`

Canonical merged states live in `05-evidence-and-linear.md`. Record who executed the merge. RTE-executed merges use **MERGED (delegated Kai/RTE)**, not HITL MERGED.

Agent ≠ human. Agents may be **delegates**; humans remain **assignees** in Linear (see `05-evidence-and-linear.md`).
