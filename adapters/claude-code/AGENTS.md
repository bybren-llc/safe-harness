# AGENTS.md — Claude Code adapter

Parent: [`../../AGENTS.md`](../../AGENTS.md). Constitution first; this file is runtime mapping only.

## This adapter

Maps the constitution into Claude Code teams, workflows, and hooks. Docs stub. See [`README.md`](README.md).

- Role cards: [`../../roles/`](../../roles/). Copy into the runtime agent directory (typically `.claude/agents/`). Do not invent defaults. [`roles/PLACEHOLDER.md`](roles/PLACEHOLDER.md) is a pointer, not a card.
- Skills: [`../../skills/`](../../skills/) as `skills/<slug>/SKILL.md`. Map each slug to `.claude/skills/<slug>/SKILL.md`. Do not rewrite skill bodies here.
- Hooks: deny personal-vault paths; deny Delivery and cloud-agent merges. See [`README.md`](README.md).

Codex, local, and Grok Bot adapters are **Later**.
