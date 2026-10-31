# 07 — Roles and lanes (delegation map)

**Complements:** `01-round-table.md` (seat map), `03-cd-and-hitl.md` (merge authority)

This file is the lane-ownership map. Seats and exit states stay in `01-round-table.md`. Merge authority, RTE PASS, and HOLD override stay in the files cited below.

## Lane owners

| Seat | Lane | Owns |
| --- | --- | --- |
| **Delivery · Lead** | Spine A | Projects end to end |
| **Ops · CoS** | Staff (both spines) | Digests and rolls |
| **the GM** (GM & lead ARCHitect) | Cross-lane / High | High-tier or cross-lane work only. Standing GM and QAS duties stay on [`roles/gm-architect.md`](../roles/gm-architect.md) |
| **Librarian** | Knowledge | Knowledge signals, research, and CVE scans |
| **Scout** | Story and research | Tool, model, and price calls |
| **Studio · Lead** | Spine B | Stories |
| **Release · RTE** | Release gate | Final release gate (cite #22; do not restate) |
| **Dispatcher · Board** | Staff (next to Ops) | Tracking board; Scheduled sweep (time set by adopter) |
| **the owner** (HITL / POPM) | Human gate | Prod-risk items; constitution / High / O2 concur; X writes; secrets |

## Release · RTE (cite, do not restate)

Release · RTE is the final release gate. The merged #22 text is the rule:

- [`constitution/03-cd-and-hitl.md`](03-cd-and-hitl.md) — Merge authority, Who may execute a trunk merge, RTE placement, HOLD override
- [`roles/release-rte.md`](../roles/release-rte.md)
- [`release/flow.md`](../release/flow.md)

It merges only with the GM's QAS APPROVE plus its own RTE PASS on the exact head. Overriding an RTE HOLD lets only the GM or the owner merge. See those files. Record: [PR #22](https://github.com/bybren-llc/safe-harness/pull/22) at [`d88c884`](https://github.com/bybren-llc/safe-harness/commit/d88c884c14c64aa2dbc244c89290818df423924e).

## Dispatcher · Board

New staff role next to Ops. Card: [`roles/dispatcher-board.md`](../roles/dispatcher-board.md).

- Owns the tracking board. The only write is a limited exception: update board records to surface status.
- Runs a scheduled sweep (no repo, PR, or channel writes)
- Only surfaces things: it never decides, posts, or merges

## Security findings (every agent)

Every agent is a **scanner, not a fixer**, for security findings. It files issues or drafts alerts. It makes no fix PRs without the owner's explicit go.

## X writes

Nothing is written to X except by the owner.

## Prod-risk

Prod-risk items (migrations, money, permissions, deploy) still need the owner. The standing prod-promotion list is in [`constitution/03-cd-and-hitl.md`](03-cd-and-hitl.md).
