# Skills library (v1.0)

**License:** MIT (see [../LICENSE](../LICENSE))
**Copyright:** © 2026 ByBren, LLC
**Attribution:** See [../NOTICE](../NOTICE)

Canonical path: `skills/<slug>/SKILL.md`.

Each skill is institutional knowledge for one job. Adapters map this directory into the runtime's native location. Skills that mention a gate, merge, release, concur, or freeze rule cite the governing file by relative path (for example [`constitution/03-cd-and-hitl.md`](../constitution/03-cd-and-hitl.md) or [`roles/release-rte.md`](../roles/release-rte.md)) and say **see the cited section; this skill grants no authority**. They do not paraphrase a rule in a way that adds or changes authority.

**Upstream provenance:** Safe-harness v1.0 ports, generalizes, or derives 25 skills from the public upstream [bybren-llc/safe-agentic-workflow](https://github.com/bybren-llc/safe-agentic-workflow) (SAW) at commit [`26ca58b`](https://github.com/bybren-llc/safe-agentic-workflow/tree/26ca58b), plus 13 new skills from this repo's constitution and role cards. See the Upstream Source column in the index below.

Authoring follows the public skill and rules conventions:

- [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills)
- [Cursor rules](https://docs.cursor.com/context/rules)
- [AGENTS.md](https://agents.md/)
- [The AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook)

## Standing practice

**Practice guidance (not a constitutional rule).** These two lines apply to every authoring seat:

1. After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.
2. A consequential action needs the human's own words verified. An agent relaying approval is never approval.

See [`review-response`](review-response/SKILL.md) and [`hitl-concur-check`](hitl-concur-check/SKILL.md).

## Frontmatter

Every `SKILL.md` must have YAML frontmatter with at least:

```yaml
---
name: slug
description: What the skill does and when to use it.
---
```

Every skill also states **Source** (`port` / `generalize` / `new`) and **Used by** (seat names).

## Sanitization rules

1. Seat names stay generic: HITL owner (POPM), GM / lead architect, `<org>`, `@<code-owners>`.
2. No private infrastructure: use "forge-backed knowledge base", "primary data store". No hostnames, LAN IPs, home paths, machine names, or vault paths.
3. No channel IDs, board IDs, or record IDs. Schedules are configurable.
4. Model names become tier names (Orchestrator, Heavy, Light). Concrete models belong only in an adapter example config.
5. "No public or external posts without the HITL owner's explicit OK."
6. Public URLs only from the allowlist in this README. No other external links.
7. Do not invent links. Record `UNKNOWN` when a target is unverified (register-first).
8. Never print secret values.

Allowed public URLs (where they help):

- https://adr.github.io/madr/
- https://scaledagileframework.com/
- https://agents.md/
- https://claude.com/resources/articles/the-ai-native-sdlc-playbook
- https://docs.claude.com/en/docs/claude-code/skills
- https://docs.cursor.com/context/rules

## How adapters load skills

| Runtime | How `skills/` is loaded |
| --- | --- |
| Claude Code | Map each `skills/<slug>/` to the runtime skills directory (typically `.claude/skills/<slug>/SKILL.md`). See the [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills) docs and [`adapters/claude-code/README.md`](../adapters/claude-code/README.md). |
| Cursor | Map selected skills into Cursor rules or the runtime skills directory. See [Cursor rules](https://docs.cursor.com/context/rules) and [`adapters/cursor/README.md`](../adapters/cursor/README.md). |
| Grok Bot | Does **not** auto-load this repo's `skills/` folder. **Setup:** import each skill as its own skill on the bot — one folder per skill, containing a `SKILL.md` with `name` and `description` frontmatter. Copy or link each `skills/<slug>/` folder. This directory stays the source of truth. |

Trigger tests per skill (does the runtime load the right skill for a prompt) are **UNKNOWN** to automate per runtime. v1.0 does not ship hook files. Whether generic hooks (protected-path block, no secrets in diff) ship later is **UNKNOWN**.

## Local check

From the repo root:

```text
python3 skills/check-frontmatter.py
```

This check requires every `skills/<slug>/SKILL.md` to start with YAML frontmatter (`---` / `name: <slug>` / `description: <when to use it>` / `---`) that parses cleanly, and `name` to match the folder slug. It does not replace the structure and link checks.

## Index (38 skills)

| # | Skill | Action | Upstream Source | Used by |
| --- | --- | --- | --- | --- |
| 1 | [bolt-lifecycle](bolt-lifecycle/SKILL.md) | generalize | [SAW](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/safe-ai-dlc/SKILL.md), [safe-workflow](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/safe-workflow/SKILL.md), templates/delivery-bolt-brief.md, constitution/02, constitution/03 | Delivery · Lead, Implementer |
| 2 | [github-conventions](github-conventions/SKILL.md) | generalize | [SAW safe-workflow](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/safe-workflow/SKILL.md), constitution/03 | All authoring seats |
| 3 | [decision-pack](decision-pack/SKILL.md) | new | constitution/03, prove/*/decision-pack.md | Delivery, GM |
| 4 | [adr-madr](adr-madr/SKILL.md) | generalize | [SAW confluence-docs](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/confluence-docs/SKILL.md) (ADR template), [MADR](https://adr.github.io/madr/) | GM, Delivery |
| 5 | [requirements-trace](requirements-trace/SKILL.md) | new | trace/schema.md, requirements/README.md, constitution/05 | Delivery, Studio, BSA-like |
| 6 | [portable-evidence](portable-evidence/SKILL.md) | new | constitution/05, README | All seats |
| 7 | [qas-review](qas-review/SKILL.md) | generalize | roles/qas.md, [SAW qas agent](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/agents/qas.md), [testing-patterns](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/testing-patterns/SKILL.md) | QAS |
| 8 | [seceng-review](seceng-review/SKILL.md) | generalize | roles/seceng.md, [SAW security-audit](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/security-audit/SKILL.md), [security-engineer agent](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/agents/security-engineer.md) | SecEng |
| 9 | [rte-release-gate](rte-release-gate/SKILL.md) | generalize | roles/release-rte.md, constitution/03, [SAW release-patterns](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/release-patterns/SKILL.md), [rte agent](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/agents/rte.md) | Release · RTE |
| 10 | [release-notes-and-tag](release-notes-and-tag/SKILL.md) | generalize | roles/release-rte.md, [SAW release command](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/release.md) | Release · RTE |
| 11 | [pre-pr-validation](pre-pr-validation/SKILL.md) | generalize | [SAW pre-pr command](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/pre-pr.md), [PRE_PR_VALIDATION_CHECKLIST](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/docs/sop/PRE_PR_VALIDATION_CHECKLIST.md) | Delivery, Implementer |
| 12 | [review-response](review-response/SKILL.md) | new | Round Table practice (freeze rule), Anthropic playbook | Delivery, Implementer |
| 13 | [delegation-brief](delegation-brief/SKILL.md) | generalize | templates/delivery-bolt-brief.md, roles/implementer.md, [SAW agent-coordination](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/agent-coordination/SKILL.md) | Delivery · Lead |
| 14 | [lane-routing](lane-routing/SKILL.md) | generalize | constitution/07, constitution/01, [SAW agent-coordination](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/agent-coordination/SKILL.md) | All seats |
| 15 | [hitl-concur-check](hitl-concur-check/SKILL.md) | new | constitution/03, Round Table practice | All seats |
| 16 | [privacy-boundary](privacy-boundary/SKILL.md) | new | constitution/04, CONTRIBUTING.md, intent.md/spec.md headers, roles/studio-lead.md | All seats, SecEng |
| 17 | [studio-handoff](studio-handoff/SKILL.md) | port | templates/studio-to-delivery-handoff.md, roles/studio-lead.md | Studio · Lead, Delivery |
| 18 | [acceptance-criteria](acceptance-criteria/SKILL.md) | generalize | [SAW spec-creation](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/spec-creation/SKILL.md), [bsa agent](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/agents/bsa.md), roles/bsa-like.md | BSA-like, Studio |
| 19 | [intent-spec-assist](intent-spec-assist/SKILL.md) | new | Anthropic playbook, intent.md/spec.md ownership | Studio · Lead |
| 20 | [cve-watch](cve-watch/SKILL.md) | new | roles/librarian-signals.md, constitution/07, [SAW audit-deps command](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/audit-deps.md) | Librarian, SecEng |
| 21 | [link-health](link-health/SKILL.md) | generalize | trace/link-health.md, roles/librarian-signals.md | Librarian |
| 22 | [stack-and-model-check](stack-and-model-check/SKILL.md) | generalize | roles/scout-story-media.md, roles/model-stack.md | Scout |
| 23 | [role-model-card](role-model-card/SKILL.md) | generalize | roles/model-stack.md | GM, adapter maintainers |
| 24 | [board-sweep](board-sweep/SKILL.md) | new | roles/dispatcher-board.md, constitution/07 | Dispatcher · Board |
| 25 | [ops-rollup](ops-rollup/SKILL.md) | new | roles/ops-cos.md | Ops · CoS |
| 26 | [concur-queue](concur-queue/SKILL.md) | new | roles/ops-cos.md, constitution/03 | Ops · CoS |
| 27 | [signals-digest](signals-digest/SKILL.md) | generalize | roles/librarian-signals.md | Librarian |
| 28 | [research-brief](research-brief/SKILL.md) | new | roles/scout-story-media.md | Scout, Studio |
| 29 | [start-end-work](start-end-work/SKILL.md) | generalize | [SAW start-work](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/start-work.md), [end-work](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/end-work.md), [check-workflow](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/check-workflow.md) | Delivery, Implementer |
| 30 | [retro](retro/SKILL.md) | generalize | [SAW retro command](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/retro.md), prove/wave-0-retro.md, constitution/06 | Delivery, GM, Ops |
| 31 | [doc-drift](doc-drift/SKILL.md) | generalize | [SAW vault-sync](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/vault-sync/SKILL.md), [update-docs command](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/update-docs.md) | Delivery, Librarian |
| 32 | [env-promotion](env-promotion/SKILL.md) | generalize | constitution/03, [SAW deployment-sop](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/deployment-sop/SKILL.md) | RTE, Delivery (adopters) |
| 33 | [rollback-rehearsal](rollback-rehearsal/SKILL.md) | generalize | constitution/03, [SAW rollback-dev](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/rollback-dev.md), [remote-rollback](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/remote-rollback.md) | RTE, Delivery |
| 34 | [api-contract-check](api-contract-check/SKILL.md) | new | tool docs (Schemathesis, oasdiff) | Delivery, QAS (adopters) |
| 35 | [git-advanced](git-advanced/SKILL.md) | port | [SAW git-advanced](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/git-advanced/SKILL.md) | Implementer |
| 36 | [testing-evidence](testing-evidence/SKILL.md) | generalize | [SAW testing-patterns](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/testing-patterns/SKILL.md), Anthropic playbook | Implementer, QAS |
| 37 | [pattern-discovery](pattern-discovery/SKILL.md) | port | [SAW pattern-discovery](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/pattern-discovery/SKILL.md), [search-pattern command](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/commands/search-pattern.md) | Implementer, BSA-like |
| 38 | [orchestration-patterns](orchestration-patterns/SKILL.md) | port | [SAW orchestration-patterns](https://github.com/bybren-llc/safe-agentic-workflow/blob/26ca58b/.claude/skills/orchestration-patterns/SKILL.md), Anthropic playbook | Delivery, GM |

## Not in v1.0

| Item | Why |
| --- | --- |
| `labels-sync` | Waits on the HITL owner's manual-vs-automated decision (High / O2). |
| `tracker-adapter-linear` | External trackers are optional. A short note lives in [`requirements-trace`](requirements-trace/SKILL.md). |
| Stack-specific pattern skills (API, frontend, row-level security, migrations, payments) | Adopter code-repo concern. Generic contract checks live in [`api-contract-check`](api-contract-check/SKILL.md); migrations stay a prod-risk item in [`env-promotion`](env-promotion/SKILL.md). |
| Always-on multi-agent pipeline / factory session tooling | Dropped as a standing roster. Useful bits live in [`lane-routing`](lane-routing/SKILL.md) and [`delegation-brief`](delegation-brief/SKILL.md). |
| Machine-specific deploy commands | Dropped. See [`env-promotion`](env-promotion/SKILL.md) and [`rollback-rehearsal`](rollback-rehearsal/SKILL.md). |
| Generic hooks | **UNKNOWN** whether v1.0 later ships a protected-path or secrets-in-diff hook. |
| Skill trigger tests | **UNKNOWN** how to automate per runtime. |

Cadence language (Bolts, Units of Work, human validate) follows the [SAFe](https://scaledagileframework.com/) ownership spine plus the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook). SAFe trademark ceremony is not required. Skills ported or generalized from the public upstream [bybren-llc/safe-agentic-workflow](https://github.com/bybren-llc/safe-agentic-workflow) (SAW) cite that repo in the Upstream Source column.

## Authoring a new skill

1. Add `skills/<slug>/SKILL.md` with `name` and `description`.
2. State Source and Used by.
3. If the skill mentions a gate, merge, release, concur, or freeze rule, cite the governing file by relative path and write "see the cited section; this skill grants no authority."
4. Run `python3 skills/check-frontmatter.py` and the repo link check.
5. Link the skill from this index.
6. Keep every external URL on the allowlist above.
