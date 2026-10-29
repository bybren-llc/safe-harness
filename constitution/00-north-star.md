# 00 — North Star

## Dual spine (peer)

| Spine | Name | Owner lane | Optimizes |
| --- | --- | --- | --- |
| **(A)** | CD execute/deploy | Delivery | Evidence → gates → merge → release health |
| **(B)** | Think/plan | Studio | Multi-vault knowledge + non-code gates → handoff when knowledge becomes build |

Spines share Round Table principles, exit states, and ownership language. They differ in gates and storage. Overfitting to forge/CI alone is a fail.

## Value metrics (M1–M6) — locked

| ID | Metric | Pass signal |
| --- | --- | --- |
| **M1** | Multi-runtime template ships | One template path works for Claude Code, Codex, Cursor, local, Grok Bot |
| **M2** | tmux not required | Happy-path team run without Dark Factory/tmux; tmux optional accelerator |
| **M3** | SAFe + AI-DLC spine retained | Bolts / Units of Work / Mob Elaboration / human business-context gate named and taught |
| **M4** | Round Table seats map | Explicit map: Scott / Kai / Ops / Delivery / Studio / Librarian / Scout + SAW roles ↔ harness seats |
| **M5** | Time-to-first owned ticket | New seat picks up and owns a ticket end-to-end under exit states within target SLA |
| **M6** | Deploy/release flow health | Spine (A): evidence → independence → HITL decision pack → CD green without freezing the train |

Delivery reports each Bolt against M1–M6.

## Empiricism

Techniques that win in controlled comparison replace prior defaults. See `06-empiricism.md`. Ultracode is **not** the default model path (O4).

## Environment (O5)

- NAS + cloud = ongoing env.
- Mac 24×7 during working runs OK.
- Dark Factory = optional legacy accelerator, **not** required ceremony.

## Non-goals (Wave 0)

- No silent rewrite of SAW `dev`.
- No personal-vault tooling in Delivery lane; personal vault **never** GitHub/remote forge.
- No Linear Agents (O6).
- No always-on 11-bot roster — on-demand specialists only.
- Do not silent-rewrite `safe-agentic-workflow`; Wave 0 lands only in `bybren-llc/safe-harness`.
- Freeze-the-train is exception, not default CD mode.
