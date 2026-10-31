# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 ByBren, LLC

# Round-table example: safe-harness team configuration

This directory shows how the safe-harness team (ByBren, LLC) configured their own instance. Use it as a worked example when adapting the template for your team.

## Configuration files

### harness.yml

```yaml
owner_identity: "Scott Graham"
```

The `owner_identity` matches the decision authority's full name and is used to validate `decided_by` fields when dropping requirements sourced from `intent.md`.

### CODEOWNERS

```
/intent.md              @cheddarfox
/intent/                @cheddarfox
/spec.md                @cheddarfox
/requirements/          @cheddarfox
/constitution/          @cheddarfox
/trace/                 @cheddarfox
/trace/.blocking        @cheddarfox
/arch/                  @cheddarfox
/AGENTS.md              @cheddarfox
/adapters/**/AGENTS.md  @cheddarfox
/skills/                @cheddarfox
/.github/CODEOWNERS     @cheddarfox
/.github/workflows/     @cheddarfox
```

GitHub login `@cheddarfox` gates all human-owned design files and agent-authored governance files.

## Seat assignments

From `README.md`:

| Seat | Assignment |
| --- | --- |
| Human owner (HITL/POPM) | Human owner |
| GM / lead architect | GM |
| QAS | GM (never the implementer of the change under review) |
| Delivery · Lead | Delivery lead |
| Studio · Lead | Studio lead |
| Ops · CoS | Ops · CoS |
| Dispatcher · Board | Dispatcher · Board |
| Librarian | Librarian |
| Scout | Scout |
| Release · RTE | Release · RTE |
| SecEng | SecEng |
| Implementer / BSA-like | On demand |

See `constitution/01-round-table.md` for the full roster with role descriptions.

## Agent runtimes

Cursor and Claude Code adapters are active:
- `adapters/cursor/AGENTS.md`
- `adapters/claude-code/AGENTS.md`

Skills live in `skills/` as `skills/<slug>/SKILL.md`. Both runtimes map the same canonical skill tree.

## Issue tracker

GitHub Issues with labels from `.github/labels.yml`:
- Work types: `bolt`, `decision`, `requirement`
- Risk tiers: `tier:low`, `tier:medium`, `tier:high`
- O2 items: `o2:pricing`, `o2:refunds`, `o2:auth`, `o2:deploy-ci`, `o2:prod-secrets`, `o2:privacy-boundary`
- Exit states: `needs-scott-concur`, `ready-for-qas`, `qas-approved`, etc.

Issue templates:
- `.github/ISSUE_TEMPLATE/bolt.yml`
- `.github/ISSUE_TEMPLATE/decision.yml`
- `.github/ISSUE_TEMPLATE/requirement.yml`

## Branch protection

Trunk: `main`

Required checks:
- Structure & Docs Validation (`wave0-checks.yml`)
- Requirements Trace Validation (`trace-check.yml`)
- CodeRabbit (required review input, not a substitute for QAS/SecEng)

Merge authority per `constitution/03-cd-and-hitl.md`:
- Low tier: RTE executes after QAS APPROVE and checks green
- Med/High tier: RTE executes after QAS APPROVE, checks green, and Scott concur (recorded own-words at exact head)

Delivery and cloud agents never merge. Nobody merges their own authored change.

## Adapting for your team

1. Copy `templates/harness.yml` to `.github/harness.yml` and set your `owner_identity`
2. Copy `templates/CODEOWNERS.example` to `.github/CODEOWNERS` and set your GitHub login
3. Update the seat assignments table in `README.md`
4. Customize issue labels in `.github/labels.yml`
5. Configure branch protection on `main`
6. See `docs/adapting.md` for the complete guide
