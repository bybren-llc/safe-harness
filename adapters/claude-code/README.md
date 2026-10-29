# Adapter — Claude Code (Wave 0 first)

Maps constitution → Claude Code teams / workflows / hooks. Thin stub — no ultracode-as-default.

## Mapping

| Constitution | Claude Code expression |
| --- | --- |
| Round Table seats | Team member / agent role defs (placeholders below) |
| SAFe + AI-DLC Bolts | Workflow: elaborate → human gate → construct → QAS → RTE → HITL |
| CD + HITL risk tiers | Hooks advisory→blocking on O2 paths when supported; else checklist in decision pack |
| Privacy / vaults | Deny tools/paths that touch personal vault; Atlas via forge; Story via NAS pins only |
| Evidence + Linear | Portable `evidence_id` + session id; human assignee / agent delegate fields in issue body |
| Empiricism | No default model override to ultracode |
| Model stack (O4) | Role→model in agent frontmatter: orchestrator Fable 5.1+; heavy Opus/Sonnet 5.5; light Haiku 5.5 |

## Role def placeholders

Place under future repo `.claude/agents/` (names only — bodies land at create time):

```
kai-gm-architect.md
delivery-lead.md
studio-lead.md   # consult-only on Delivery train
implementer.md
qas.md
seceng.md
bsa-like.md
rte-collapsible.md
```

Each file must include: mission, spine, may-collapse, independence, model tier, stop rules — copy from `../../roles/`.

## Hooks (intent)

| Hook intent | Behavior |
| --- | --- |
| Pre-construct | Require business-context HITL note on Med/High / O2 — **Wave 0 intentionally broader than strict Low-only; ensures HITL cannot be skipped** |
| Pre-PR | Exact-head + evidence_id + Linear key present |
| Merge attempt by agent | Deny — HITL only |
| Personal-vault path | Deny |

Wave 0: document intents here; implement when `safe-harness` exists.

## Explicit non-defaults

- Ultracode **not** team default model.
- Dark Factory / tmux **not** required for happy path.
- Linear Agents **not** wired.

## Local / HF cache (Option A)

NAS Option A (Scott 2026-10-28): Docker `hf` → MainSqueeze `local-ai`. Adapters that touch local inference must set `HF_HOME` (and related hub caches) to NAS-backed paths — never Mac Desktop. Exact pins from Studio/Ops; do not invent paths. Weights never enter the GitHub template.
