# Adapter — Cursor (Wave 0 first)

**License:** MIT (see [../../LICENSE](../../LICENSE))
**Copyright:** © 2026 ByBren, LLC
**Attribution:** See [../../NOTICE](../../NOTICE)

Maps constitution → Cursor rules + Projects / Cloud Agents.  
**Project = Delivery train** (spine A). Studio think/plan stays peer — not buried inside Delivery Project settings.

## Mapping

| Constitution | Cursor expression |
| --- | --- |
| North star / dual spine | Project rules: Delivery owns A; consume Studio handoffs only |
| Round Table | Rules naming seats + stop-the-line; Cloud Agent = delegate not assignee |
| SAFe + AI-DLC | Bolt checklist rule; human validate before construct on Med/High |
| CD + HITL | PR template / rule: risk tier, O2 list, decision pack link |
| Privacy | Rules: never commit personal vault; private storage SoT; knowledge base forge OK |
| Evidence + GitHub Issues | Rule: portable evidence payload (`evidence_id`, `runtime`, `exact_head`, `issue`, `actor`, `gate`) + human assignee — see `constitution/05-evidence-and-traceability.md` |
| Model stack (O4) | Project model defaults per role card — **ultracode not default** |
| Empiricism | Changelog of default changes only after HITL concur |

## Project = Delivery train

- One Cursor Project for `bybren-llc/safe-harness` Delivery work.
- Cloud Agents run as **agent delegates**; the issue tracker **human assignee** remains.
- Studio briefs may be referenced as read-only context; Studio does not own this Project.

## Rules stub list (future `.cursor/rules` or Project rules)

1. `dual-spine.mdc` — A vs B boundary  
2. `hitl-o2.mdc` — high-risk list + tiers; Cloud Agents / Delivery never merge; authorized the GM / Release · RTE trunk merges per constitution/03
3. `privacy-vaults.mdc` — personal never remote; private storage SoT  
4. `evidence.mdc` — SoR + portable evidence payload (evidence_id, runtime, exact_head, issue, actor, gate); the issue tracker archive is read-only  
5. `model-stack.mdc` — O4 tiers; ultracode not default  
6. `independence.mdc` — never collapse QAS/SecEng  

## Explicit non-defaults

- Ultracode not Project default.
- tmux/Dark Factory not required.
- No the issue tracker Agents in Wave 0.

## Skills library (v1.0)

Canonical skills live in [`../../skills/`](../../skills/README.md) as `skills/<slug>/SKILL.md`.

This adapter maps selected skills into Cursor rules (`.cursor/rules`) or the runtime skills directory the project uses. Prefer pointing at the canonical file over forking the text. See [Cursor rules](https://docs.cursor.com/context/rules).

Runtime-specific role→model examples stay in this adapter. Skills themselves use tier names only.

Trigger tests (does a prompt load the right skill) are **UNKNOWN** to automate in v1.0. Generic hooks are **UNKNOWN** and not shipped.

## Local / HF cache (Option A)

If a Cursor/local lane uses HF or similar caches: a private storage via Docker `hf` → the private inference volume (the owner's Option A). Do not default `HF_HOME` to machine home. See `constitution/04-privacy-and-vaults.md`.
