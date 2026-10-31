# bybren-llc/safe-harness Instance Decisions

Instance-specific decisions for the bybren-llc/safe-harness repository. Adopters record their own decisions in `docs/decisions/`.

## Current shape (example)

Example of the Current shape section on [`../../docs/decisions/log.md`](../../docs/decisions/log.md). Canonical statements live there. This block adds only the W0 loader choice already on `main`, as an instance snapshot.

A PR that changes a decision updates Current shape and the index in the same PR.

1. Standing design is the numbered list in [`../../docs/decisions/log.md`](../../docs/decisions/log.md) (ADRs 0001–0017).
2. Runtimes load through pointer files, not symlinks (`CLAUDE.md`, `.cursor/rules/safe-harness.mdc`, `adapters/codex/`). Example write-up: [`adr-example.md`](adr-example.md). Record: #86 on `main`.

No other decisions are added here.

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

## GitHub conventions migration

**Branch naming:** `<issue#>-slug` (e.g., `42-add-trace-check`) replaced `SAF-N-slug` Linear convention.

**Cutover:** Linear conventions (SAF-N branches, [SAF-N] prefixes) remained valid until cutover date; GitHub conventions took over at cutover. See `linear-saf-map.csv` in this directory for the migration map.

## Merge authority (the owner's recorded decisions)

### Amendment 2026-10-29

the owner (HITL), 2026-10-29, verbatim:

> **1:54 PM ET:** "we're definitely gonna be able to lend me agents merge man for sure especially in development ... let's imagine if we had a dev staging and PROD we would be able to handle things and testing throughout each"

> **1:55 PM ET:** "we're trying to get things set up so that others can take our work and be able to run with it and take that template and use it so we don't wanna put these kind of restrictions that don't really make sense when we're trying to make things go faster by managing expectations through design and specifications"

### Earlier delegation (2026-10-29 ET)

> **1:05 PM ET:** "No agents that are working for us can't merge, but you and I release train engineer can"

> **1:50 PM ET:** "RTE can go if you approve"

### #22 concur (2026-10-30)

Recorded on #22 squash [`d88c884`](https://github.com/bybren-llc/safe-harness/commit/d88c884c14c64aa2dbc244c89290818df423924e).

## Model cache / HF_HOME (Option A — locked 2026-10-28)

the owner concurred: Hugging Face and other model downloads land **direct on a private storage** via Docker `hf` → a private inference volume — **not** via Mac Desktop as a cache hop.

Option A:

| Role | Rule |
| --- | --- |
| **private storage** | SoT for cache: `HF_HOME`, model downloads, the owner's vault |
| **Mac role** | Mount/consume; do not stage large downloads on Mac then copy |

Model weights ≠ personal vault; still never push caches into `bybren-llc/safe-harness`.

Mac-local cache is non-compliant with Option A.

When adapters document local/Ollama/HF lanes, require `HF_HOME` (and kin) to resolve on a private storage.

## Linear archive (Wave 1 migration)

Linear issues SAF-1 through SAF-5 remain accessible as read-only archive. **Never delete Linear history.** Every existing Linear evidence URL must remain resolvable.

Migration plan (`prove/wave-1/migration-plan.md`) includes:
- SAF-n to GitHub Issue mapping table (`trace/linear-saf-map.csv`)
- Evidence URL preservation strategy (Linear URLs remain valid; cite them by link)
- Archive access instructions
- Cutover date: TBD (set after owner concurrence)
- Scope: safe-harness only (other Linear teams like STO are untouched)

**Delivery owns migration and closeout.** The GM coordinates with the owner on cutover timing.

## Empiricism dogma (instance-specific)

Techniques that win in controlled comparison replace prior defaults. These are the safe-harness instance dogma items at risk:

| Dogma at risk | Measure |
| --- | --- |
| Ultracode-as-default | Task success + time-to-exit vs O4 role→model cards |
| tmux/Dark Factory required | M2 happy path without tmux |
| Always-on 11 bots | Idle cost vs on-demand specialist latency (M5) |

**SAW reference:** SAW `dev` remains reference until a comparison says otherwise — still no silent rewrite.

## v1.0 tag concur (instance history)

The recorded concur covered safe-harness v1.0 PRs and the initial `v1.0.0` tag only. Later product tags need their own current concur. First product SemVer tag was `v1.0.0`.
