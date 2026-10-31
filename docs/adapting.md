# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 ByBren, LLC

# Adapting safe-harness

This guide helps you adapt the safe-harness template for your team.

## Two layers

The harness layer (role cards, skills, in-session build-and-verify loops, evidence schema) ships in this repository. Runtime adapters that wire the harness into specific coding tools arrive in v1.1. The orchestration layer (always-on managers, briefing, gate routing, merge authority) is a runtime-neutral contract, not part of the core harness. Agent auto-approve and auto-merge stay off; CI checks and independent review are the real gates.

## Fork vs 'Use this template'

Use GitHub's **'Use this template'** button to create a new repository. This gives you a clean history without the template's commit history. If you need to track upstream changes, fork instead, but most teams prefer a clean start.

## Configuration knobs

### 1. Owner identity and CODEOWNERS

Copy the template configuration files to your instance:

```bash
cp templates/harness.yml .github/harness.yml
cp templates/CODEOWNERS.example .github/CODEOWNERS
```

Edit `.github/harness.yml` and set `owner_identity` to your GitHub login or the decision authority's full name. This value is used to validate `decided_by` fields when dropping requirements sourced from `intent.md`.

Edit `.github/CODEOWNERS` and replace `<your-github-login>` with your actual GitHub login. CODEOWNERS enforces review gates on human-owned design files and agent-authored governance files.

**Important:** `owner_identity` in `.github/harness.yml` must match the `decided_by` value when dropping intent-sourced requirements. See `constitution/05-evidence-and-traceability.md`.

### 2. Roles roster

Edit the seat assignments table in `README.md` (the "This repo's seat assignments" section). Replace the placeholder assignments with your team's actual seat holders. Keep the role names on the left; update only the assignments on the right.

See `constitution/01-round-table.md` for seat definitions and `roles/` for detailed role cards.

### 3. Issue tracker

The template uses GitHub Issues by default. Issue templates live in `.github/ISSUE_TEMPLATE/`:
- `bolt.yml` — Delivery work (spine A)
- `decision.yml` — Decision concurrence requests
- `requirement.yml` — REQ state changes

Labels are defined in `.github/labels.yml`. Customize work types, risk tiers, and O2 items to fit your process.

If you keep Linear, see `constitution/05-evidence-and-traceability.md` for the dual-tracker approach. The template's Linear archive map (`trace/linear-saf-map.csv`) is frozen and should not be edited.

### 4. Agent runtimes

The template supports Cursor, Claude Code, and other runtimes. Adapter entry points:
- `adapters/cursor/AGENTS.md` — Cursor agent entry point
- `adapters/claude-code/AGENTS.md` — Claude Code agent entry point

Root agent entry point: `AGENTS.md`

Skills live in `skills/` as `skills/<slug>/SKILL.md`. Each runtime's adapter maps the canonical skill tree. See `skills/README.md`.

Grok Bot and local agents are supported but require manual skill import per bot. Do not add Codex or local adapter stubs here.

### 5. Branch protection

Recommended branch protection settings for `main`:

- Require pull request reviews (1+ approvals)
- Dismiss stale reviews when new commits are pushed
- Require status checks to pass:
  - `Structure & Docs Validation` (from `wave0-checks.yml`)
  - `Requirements Trace Validation` (from `trace-check.yml`)
  - CodeRabbit (if enabled)
- Require signed commits (recommended)
- Do not allow force pushes
- Do not allow deletions

See `docs/branch-protection.md` for the full policy. This guide describes the settings; it does not apply them automatically.

**Merge authority:** See `constitution/03-cd-and-hitl.md`. The template default: Delivery and cloud agents never merge. Nobody merges their own authored change. Merge execution follows risk-tier and environment rules.

## Running checks locally

Before opening or updating a PR, run these checks from the repo root:

```bash
# Wave 0 structure and docs validation
bash .github/workflows/wave0-checks.yml  # or run checks manually

# Trace validation
bash trace/check.sh

# Skills frontmatter
python3 skills/check-frontmatter.py

# Denylist
python3 scripts/check-denylist.py
python3 scripts/test_check_denylist.py

# Trace fixtures
bash trace/test-fixtures.sh
bash trace/fixtures/run.sh

# Template-ready (for template maintainers)
bash trace/check-template-ready.sh         # CI scope
bash trace/check-template-ready.sh --full  # full repo
```

CI workflows live in `.github/workflows/`:
- `wave0-checks.yml` — Structure, links, markdown syntax (blocking)
- `trace-check.yml` — Requirements trace validation (warn-only until `spec.md` has REQ IDs and `trace/.blocking` exists)
- `api-contract.yml` — OpenAPI contract checks (warn-only)
- `doc-drift.yml` — Documentation drift detection (warn-only)

See `AGENTS.md` for the required local checks before opening a PR.

## What not to change

Do not modify these governance invariants:

- Constitution files (`constitution/`) define the binding rules. Propose changes via PR with human review.
- Evidence fields in `constitution/05-evidence-and-traceability.md` (evidence_id, exact_head, actor, gate, req_ids, issue) are canonical. Do not rename or remove these fields.
- Trace map schema (`trace/schema.md`) and validation logic (`trace/check.sh`, `trace/validate-trace.sh`) enforce traceability. Changes require human review.
- Gate types and merge authority (`constitution/03-cd-and-hitl.md`) ensure safety. Downgrades require written rationale at QAS.
- CODEOWNERS review gates prevent accidental merges of governance files.

You may adapt risk tiers, O2 items, and seat assignments to fit your team. The constitution documents the **what** and **why**; your instance configures the **who** and **when**.

## Worked example

See `examples/round-table/` for this template's own configuration with real seat assignments and tool choices.
