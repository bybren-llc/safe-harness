# Adapter — Claude Code

**License:** MIT (see [../../LICENSE](../../LICENSE))
**Copyright:** © 2026 ByBren, LLC
**Attribution:** See [../../NOTICE](../../NOTICE)

Maps constitution → Claude Code teams / workflows / hooks. Thin stub — no single-maximum default.

## Mapping

| Constitution | Claude Code expression |
| --- | --- |
| Round Table seats | Team member / agent role defs (placeholders below) |
| SAFe + AI-DLC Bolts | Workflow: elaborate → human gate → construct → QAS → RTE → HITL |
| CD + HITL risk tiers | Hooks advisory→blocking on O2 paths when supported; else checklist in decision pack |
| Privacy / vaults | Deny tools/paths that touch personal vault; knowledge base via forge; Story via private storage pins only |
| Evidence + the issue tracker | Portable `evidence_id` + session id; human assignee / agent delegate fields in issue body |
| Empiricism | No default model override to a single maximum-capability model |
| Model stack | Role→model in agent frontmatter, one model per tier (Orchestrator / Heavy / Light) per `roles/model-stack.md` |

## Role def placeholders

Place under the runtime `.claude/agents/` (names only — bodies land at create time):

```
gm-architect.md
delivery-lead.md
studio-lead.md   # consult-only on Delivery train
implementer.md
qas.md
seceng.md
bsa-like.md
release-rte.md
```

Each file must include: mission, spine, may-collapse, independence, model tier, stop rules — copy from `../../roles/`.

## Hooks (intent)

| Hook intent | Behavior |
| --- | --- |
| Pre-construct | Require business-context HITL note on Med/High / O2 — intentionally broader than strict Low-only; ensures HITL cannot be skipped |
| Pre-PR | Exact-head + evidence_id + the issue tracker key present |
| Merge attempt by agent | Deny Delivery and cloud agents; allow authorized the GM / Release · RTE trunk merges that meet constitution/03 |
| Personal-vault path | Deny |

Document hook intents here; implement them in your runtime.

## Explicit non-defaults

- A single maximum-capability model is **not** the team default.
- Issue-tracker agents **not** wired.

## Skills library

Canonical skills live in [`../../skills/`](../../skills/README.md) as `skills/<slug>/SKILL.md`.

This adapter maps each slug into the Claude Code skills directory (typically `.claude/skills/<slug>/SKILL.md`) by copy or symlink at install time. Do not rewrite skill bodies in the adapter tree. See the [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills) docs.

Runtime-specific role→model examples stay in this adapter. Skills themselves use tier names only.

Trigger tests (does a prompt load the right skill) are **UNKNOWN** to automate. Generic hooks are **UNKNOWN** and not shipped.

## Local / HF cache

Document your model-cache and machine roles here. Adapters that touch local inference must set `HF_HOME` (and related hub caches) to private-storage-backed paths. Exact pins from Studio/Ops; do not invent paths. Weights never enter the GitHub template.
