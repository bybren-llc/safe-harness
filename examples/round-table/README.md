# Instance operating notes

This folder holds operating notes and config for one instance. It is not a set of filled templates. Blank templates stay in `docs/` and `templates/`. Root `intent.md` and `spec.md` stay the adopter blanks.

These notes are a reusable starting point for orchestrating agents across runtimes. The first concrete slice is the v1.1 proof on #85: brief, loaders, worktree-per-agent, gate chain, evidence.

## Contents

- [`intent.md`](intent.md) — Example intent (Delivery draft for owner review). Shared-docs vision; v1.1 as the first slice.
- [`spec.md`](spec.md) — Example spec. Illustrative `EX-` IDs only; not registered.
- [`prd-v1.1-cross-runtime.md`](prd-v1.1-cross-runtime.md) — Example PRD for the v1.1 slice.
- [`design-runtime-loaders.md`](design-runtime-loaders.md) — Example design: how `AGENTS.md`, `CLAUDE.md`, `.cursor/rules`, and the adapters load.
- [`adr-example.md`](adr-example.md) — Example ADR shape (pointer files, not a numbered ADR).
- [`decisions.md`](decisions.md) — Instance decisions, plus a Current shape example.
- [`metrics.md`](metrics.md) — M1–M6 as already locked (v1.0).
- [`link-health.md`](link-health.md) — Link rot detection notes for this instance.
- [`linear-saf-map.csv`](linear-saf-map.csv) — Header-only issue-map draft.
- [`harness.yml`](harness.yml) — Instance harness snippet.
- [`CODEOWNERS`](CODEOWNERS) — Instance CODEOWNERS snippet.

## For adopters

Copy the blank templates from the repo root and from `docs/`. Use this folder as operating notes, not as the files you paste into a new repo.
