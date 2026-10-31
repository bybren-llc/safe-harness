# bybren-llc/safe-harness Instance Decisions

Instance-specific decisions for the bybren-llc/safe-harness repository. Adopters record their own decisions in `docs/decisions/`.

## Model path (O4)

Ultracode is **not** the default model path. The default model stack is defined in `roles/model-stack.md`.

## Environment (O5)

- Private storage + cloud = ongoing environment
- Mac 24×7 during working runs OK
- Dark Factory = optional legacy accelerator, **not** required ceremony

## Non-goals

Instance-specific non-goals for safe-harness v1.0:

- No silent rewrite of SAW `dev`.
- No personal-vault tooling in Delivery lane; personal vault **never** GitHub/remote forge.
- No Linear agents (O6). Issue trackers are optional; the preferred path is design, specs, and PRDs in GitHub.
- No always-on 11-bot roster — on-demand specialists only.
- Do not silent-rewrite `safe-agentic-workflow`; new work lands only in `bybren-llc/safe-harness`.
- Freeze-the-train is exception, not default CD mode.

## SAW `dev` as reference

The maintainers copy patterns from SAW `dev` when they win comparisons. Do **not** rewrite SAW in place. New work lands in `bybren-llc/safe-harness`.
