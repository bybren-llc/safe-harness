# Skills library (v1.0)

Canonical path: `skills/<slug>/SKILL.md`.

Each skill is institutional knowledge for one job. Adapters map this directory into the runtime's native location. Skills do not restate the constitution; they point at it by number (`constitution/03`, `constitution/05`) and name seats, not file paths that later PRs may rename.

Authoring follows the public skill and rules conventions:

- [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills)
- [Cursor rules](https://docs.cursor.com/context/rules)
- [AGENTS.md](https://agents.md/)
- [The AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook)

## Standing practice (v1.0)

These two rules are working practice. They apply to every authoring seat:

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
| Grok Bot | **UNKNOWN.** The exact loading path for a repo `skills/` directory is not decided in v1.0. Keep this directory as the source of truth until an adapter lands. |

Trigger tests per skill (does the runtime load the right skill for a prompt) are **UNKNOWN** to automate per runtime. v1.0 does not ship hook files. Whether generic hooks (protected-path block, no secrets in diff) ship later is **UNKNOWN**.

## Index (38 skills)

| # | Skill | Source | Used by |
| --- | --- | --- | --- |
| 1 | [bolt-lifecycle](bolt-lifecycle/SKILL.md) | generalize | Delivery · Lead, Implementer |
| 2 | [github-conventions](github-conventions/SKILL.md) | generalize | All authoring seats |
| 3 | [decision-pack](decision-pack/SKILL.md) | new | Delivery, GM |
| 4 | [adr-madr](adr-madr/SKILL.md) | generalize | GM, Delivery |
| 5 | [requirements-trace](requirements-trace/SKILL.md) | new | Delivery, Studio, BSA-like |
| 6 | [portable-evidence](portable-evidence/SKILL.md) | new | All seats |
| 7 | [qas-review](qas-review/SKILL.md) | generalize | QAS |
| 8 | [seceng-review](seceng-review/SKILL.md) | generalize | SecEng |
| 9 | [rte-release-gate](rte-release-gate/SKILL.md) | generalize | Release · RTE |
| 10 | [release-notes-and-tag](release-notes-and-tag/SKILL.md) | generalize | Release · RTE |
| 11 | [pre-pr-validation](pre-pr-validation/SKILL.md) | generalize | Delivery, Implementer |
| 12 | [review-response](review-response/SKILL.md) | new | Delivery, Implementer |
| 13 | [delegation-brief](delegation-brief/SKILL.md) | generalize | Delivery · Lead |
| 14 | [lane-routing](lane-routing/SKILL.md) | generalize | All seats |
| 15 | [hitl-concur-check](hitl-concur-check/SKILL.md) | new | All seats |
| 16 | [privacy-boundary](privacy-boundary/SKILL.md) | new | All seats, SecEng |
| 17 | [studio-handoff](studio-handoff/SKILL.md) | port | Studio · Lead, Delivery |
| 18 | [acceptance-criteria](acceptance-criteria/SKILL.md) | generalize | BSA-like, Studio |
| 19 | [intent-spec-assist](intent-spec-assist/SKILL.md) | new | Studio · Lead |
| 20 | [cve-watch](cve-watch/SKILL.md) | new | Librarian · Signals, SecEng |
| 21 | [link-health](link-health/SKILL.md) | generalize | Librarian · Signals |
| 22 | [stack-and-model-check](stack-and-model-check/SKILL.md) | generalize | Scout · Story Media |
| 23 | [role-model-card](role-model-card/SKILL.md) | generalize | GM, adapter maintainers |
| 24 | [board-sweep](board-sweep/SKILL.md) | new | Dispatcher · Board |
| 25 | [ops-rollup](ops-rollup/SKILL.md) | new | Ops · CoS |
| 26 | [concur-queue](concur-queue/SKILL.md) | new | Ops · CoS |
| 27 | [signals-digest](signals-digest/SKILL.md) | generalize | Librarian · Signals |
| 28 | [research-brief](research-brief/SKILL.md) | new | Scout, Studio |
| 29 | [start-end-work](start-end-work/SKILL.md) | generalize | Delivery, Implementer |
| 30 | [retro](retro/SKILL.md) | generalize | Delivery, GM, Ops |
| 31 | [doc-drift](doc-drift/SKILL.md) | generalize | Delivery, Librarian |
| 32 | [env-promotion](env-promotion/SKILL.md) | generalize | RTE, Delivery (adopters) |
| 33 | [rollback-rehearsal](rollback-rehearsal/SKILL.md) | generalize | RTE, Delivery |
| 34 | [api-contract-check](api-contract-check/SKILL.md) | new | Delivery, QAS (adopters) |
| 35 | [git-advanced](git-advanced/SKILL.md) | port | Implementer |
| 36 | [testing-evidence](testing-evidence/SKILL.md) | generalize | Implementer, QAS |
| 37 | [pattern-discovery](pattern-discovery/SKILL.md) | port | Implementer, BSA-like |
| 38 | [orchestration-patterns](orchestration-patterns/SKILL.md) | port | Delivery, GM |

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

Cadence language (Bolts, Units of Work, human validate) follows the [SAFe](https://scaledagileframework.com/) ownership spine plus the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook). SAFe trademark ceremony is not required.

## Authoring a new skill

1. Add `skills/<slug>/SKILL.md` with `name` and `description`.
2. State Source and Used by.
3. Point at constitution numbers and seat names. Do not copy gate text.
4. Run the sanitization grep in this PR's body (or the later CI denylist).
5. Link the skill from this index.
6. Keep every external URL on the allowlist above.
