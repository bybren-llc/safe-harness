# bybren-llc/safe-harness Value Metrics (M1-M6)

These metrics measured the success of shipping safe-harness v1.0 as a multi-runtime template.

## Value metrics (M1–M6) — locked for v1.0

| ID | Metric | Pass signal |
| --- | --- | --- |
| **M1** | Multi-runtime template ships | One template path works for Claude Code, Codex, Cursor, local, Grok Bot |
| **M2** | tmux not required | Happy-path team run without Dark Factory/tmux; tmux optional accelerator |
| **M3** | SAFe + AI-DLC spine retained | Bolts / Units of Work / Mob Elaboration / human business-context gate named and taught |
| **M4** | Round Table seats map | Explicit map: the owner / the GM / Ops / Dispatcher / Delivery / Studio / Librarian / Scout + SAW roles ↔ harness seats |
| **M5** | Time-to-first owned ticket | New seat picks up and owns a ticket end-to-end under exit states within target SLA |
| **M6** | Deploy/release flow health | Spine (A): evidence → independence → HITL decision pack → CD green without freezing the train |

Each Bolt was reported against M1–M6.

## For Adopters

Define your own success metrics in `spec.md` or `constitution/00-north-star.md`. Tie every requirement to a metric.
