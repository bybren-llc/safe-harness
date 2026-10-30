# Adapter — Cursor (Wave 0 first)

Maps constitution → Cursor rules + Projects / Cloud Agents.  
**Project = Delivery train** (spine A). Studio think/plan stays peer — not buried inside Delivery Project settings.

## Mapping

| Constitution | Cursor expression |
| --- | --- |
| North star / dual spine | Project rules: Delivery owns A; consume Studio handoffs only |
| Round Table | Rules naming seats + stop-the-line; Cloud Agent = delegate not assignee |
| SAFe + AI-DLC | Bolt checklist rule; human validate before construct on Med/High |
| CD + HITL | PR template / rule: risk tier, O2 list, decision pack link |
| Privacy | Rules: never commit personal vault; NAS SoT; Atlas forge OK |
| Evidence + Linear | Rule: portable evidence payload (`evidence_id`, `runtime`, `exact_head`, `linear_issue`, `actor`, `gate`) + human assignee — see `constitution/05-evidence-and-traceability.md` |
| Model stack (O4) | Project model defaults per role card — **ultracode not default** |
| Empiricism | Changelog of default changes only after HITL concur |

## Project = Delivery train

- One Cursor Project for `bybren-llc/safe-harness` Delivery work.
- Cloud Agents run as **agent delegates**; Linear **human assignee** remains.
- Studio briefs may be referenced as read-only context; Studio does not own this Project.

## Rules stub list (future `.cursor/rules` or Project rules)

1. `dual-spine.mdc` — A vs B boundary  
2. `hitl-o2.mdc` — high-risk list + tiers; Cloud Agents / Delivery never merge; authorized Kai / Release · RTE trunk merges per constitution/03
3. `privacy-vaults.mdc` — personal never remote; NAS SoT  
4. `evidence-linear.mdc` — SoR + portable evidence payload (evidence_id, runtime, exact_head, linear_issue, actor, gate); no Linear Agents  
5. `model-stack.mdc` — O4 tiers; ultracode not default  
6. `independence.mdc` — never collapse QAS/SecEng  

## Explicit non-defaults

- Ultracode not Project default.
- tmux/Dark Factory not required.
- No Linear Agents in Wave 0.

## Local / HF cache (Option A)

If a Cursor/local lane uses HF or similar caches: MainSqueeze NAS via Docker `hf`→`local-ai` (Scott Option A). Do not default `HF_HOME` to machine home. See `constitution/04-privacy-and-vaults.md`.
