# AGENTS.md

This file is the agent entry point for **safe-harness**. Convention: [AGENTS.md](https://agents.md/). Human-facing context stays in [`README.md`](README.md) and [`CONTRIBUTING.md`](CONTRIBUTING.md). The constitution is the rule. This file points at it; it does not restate it.

## What this repo is

safe-harness is a multi-runtime template for everyday, safe AI-assisted development. Humans set direction and keep the safety gates. Agents execute. Governance lives in [`constitution/`](constitution/). Seat cards live in [`roles/`](roles/).

## Rules agents follow

Do not restate these here. Read the linked file and follow it.

- **Merge invariants** (who may merge, exact-head gates, agents-must-not-merge): [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md)
- **Security findings** (scanner, not fixer): [`constitution/07-roles-and-lanes.md`](constitution/07-roles-and-lanes.md)
- **External posts** (no public or external posts without the HITL owner's explicit OK): [`constitution/07-roles-and-lanes.md`](constitution/07-roles-and-lanes.md) (file-level; no general external-post heading) and [`#x-writes`](constitution/07-roles-and-lanes.md#x-writes) (X only)
- **Personal-vault boundary** (personal vault never enters this repo or a remote forge): [`constitution/04-privacy-and-vaults.md`](constitution/04-privacy-and-vaults.md)

Review gates (not ownership) are listed in [`.github/CODEOWNERS`](.github/CODEOWNERS).

## Skills

Canonical skills live in [`skills/`](skills/) as `skills/<slug>/SKILL.md`. Adapters map that tree into the runtime. Do not fork skill bodies.

## Adapters

Runtime-specific notes:

- [`adapters/claude-code/AGENTS.md`](adapters/claude-code/AGENTS.md)
- [`adapters/cursor/AGENTS.md`](adapters/cursor/AGENTS.md)

Other runtimes: add an adapter following this pattern. A runtime that does not auto-load `skills/` requires a manual skill import. Do not add adapter stubs here before they exist.

## Local checks

From the repo root, run the same checks as [`.github/workflows/wave0-checks.yml`](.github/workflows/wave0-checks.yml) and [`.github/workflows/trace-check.yml`](.github/workflows/trace-check.yml) before you open or update a PR.

Required paths (must exist; source of truth is the `required_paths` list in `wave0-checks.yml`):

- `constitution/README.md`
- `constitution/00-north-star.md`
- `constitution/01-round-table.md`
- `constitution/02-safe-ai-dlc.md`
- `constitution/03-cd-and-hitl.md`
- `constitution/04-privacy-and-vaults.md`
- `constitution/05-evidence-and-traceability.md`
- `constitution/06-empiricism.md`
- `roles/model-stack.md`
- `adapters/claude-code/README.md`
- `adapters/cursor/README.md`
- `prove/README.md`
- `.github/harness.yml`

Relative-link scan: every markdown file at repo root and under `constitution/`, `roles/`, `adapters/`, `templates/`, and `prove/`. Skip `https://`, `#`, and `mailto:` destinations. Every other destination must exist.

Code-fence check: even count of fenced-block markers in every `*.md` (same parity check as `wave0-checks.yml`).

Trace check (warn-only until `spec.md` has REQ IDs **and** `trace/.blocking` exists):

```bash
yq eval '.' trace/trace-map.yaml
```

Skills frontmatter and denylist (from the repo root):

```bash
python3 skills/check-frontmatter.py
python3 scripts/check-denylist.py
python3 scripts/test_check_denylist.py
```

## Stop

Delivery and cloud agents never merge, never approve, and never post outside the assigned PR.
