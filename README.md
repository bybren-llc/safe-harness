# safe-harness

**SAW harness** — Safe Agentic Workflow multi-runtime work template (Wave 0).

Everyday **safe**, not SAFe the trademark. SAFe + AI-DLC remain the ownership/cadence spine.

Org: [`bybren-llc`](https://github.com/bybren-llc) · Reference only: [`safe-agentic-workflow`](https://github.com/bybren-llc/safe-agentic-workflow/tree/dev) `@dev` (do not silent-rewrite).

## Dual spine

| Spine | Owns | Optimizes |
| --- | --- | --- |
| **(A) CD execute/deploy** | Delivery | Evidence → risk-tier gates → merge queue → flags/rollback |
| **(B) Think/plan** | Studio | Multi-vault + non-code gates → handoff when knowledge becomes build |

## CI/CD is first-class

**CI/CD is a core product of safe-harness**, not optional theater. Trunk-based delivery to `main` (no Gitflow). Kai/Delivery manage PRs. Risk-tier CD path (Low/Med/High gates, deploy pipelines, merge queue, rollback) = M6 first-class deliverable. Wave 0 ships thin CI skeleton (`.github/workflows/`) proving gates exist; full risk-tier automation follows.

See [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) for trunk-based workflow, risk tiers, and O2 high-risk defaults.

## Start here

1. [`constitution/`](constitution/) — north star, seats, CD/HITL, privacy, Linear evidence, empiricism
2. [`roles/`](roles/) + [`roles/model-stack.md`](roles/model-stack.md) — seat cards + Fable/Opus/Sonnet/Haiku defaults (ultracode not default)
3. Adapters first: [`adapters/claude-code/`](adapters/claude-code/) · [`adapters/cursor/`](adapters/cursor/)
4. Prove scaffolds: [`prove/`](prove/) · handoff templates in [`templates/`](templates/)

## Value metrics (M1–M6)

Multi-runtime template ships · tmux not required · SAFe+AI-DLC retained · Round Table seats map · time-to-first owned ticket · deploy/release flow health.

## Privacy (non-negotiable)

Personal vault never remote/GitHub · NAS is SoT for work data · Atlas = forge/business IP · Story IP = NAS pins.

Kai owns Wave 0 · Delivery executes · Scott HITL/POPM.
