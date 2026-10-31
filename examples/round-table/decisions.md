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
