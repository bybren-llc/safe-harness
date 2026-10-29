# 04 — Privacy & Vaults

Non-negotiable standing rules. Delivery never invents vault paths.

## Three vaults

| Vault | Storage | Remote forge? | Delivery lane? |
| --- | --- | --- | --- |
| **Personal** | Local → migrate to **NAS**; never Desktop long-term | **NEVER** | Out of lane |
| **Story IP** | **NAS pins** (may be NAS-private) | Not assumed forge-backed | Consume via handoff pins only |
| **Atlas** (`wtfb-atlas`) | Forge / business IP | Yes — forge-backed | Follow Atlas agent contribution playbook |

## NAS is SoT for work data (O3)

- NAS = source of truth for work data (RAID5).
- Mac **mounts** NAS; vaults live **on NAS**, not Desktop.
- Personal vault migrates Desktop → NAS but **still never** syncs to GitHub/remote forge.
- Atlas = forge/business IP; Story IP = NAS pins.

## Studio → Delivery handoff requirements

When spine (B) knowledge becomes buildable, Studio emits a handoff (see `../templates/studio-to-delivery-handoff.md`) with at least:

- Outcome / value link (M1–M6 or Bolt goal)
- AC / DoD (or BSA follow-on named)
- **Source pins** — Atlas concept IDs and/or NAS paths — **never personal vault**
- Non-code gates already passed
- Suggested owner seat + RTE collapse allowed?
- Exit evidence expected on spine (A)

## Refuse mass-import chats as concepts

Chat dumps are not knowledge objects. Librarian / Studio must distill to pinned concepts with provenance. No bulk chat→vault import as “concepts.”

## Refuse list (Delivery)

- Any PR/CI that syncs personal vault content
- Paths claimed as “Desktop vault” as SoT
- Handoffs that cite personal vault as source pin
- Invented NAS paths not provided by Studio/Librarian

## Model cache / HF_HOME (NAS Option A — locked 2026-10-28)

Scott concurred: Hugging Face and other model downloads land **direct on MainSqueeze NAS** via Docker `hf` → MainSqueeze `local-ai` — **not** via Mac Desktop as a cache hop.

| Rule | Detail |
| --- | --- |
| SoT for weights/cache | MainSqueeze NAS (`local-ai` path family — exact mount pins from Studio/Ops, never invent) |
| `HF_HOME` / hub cache | Point at NAS-backed dirs inside the Docker/`local-ai` env, not `~/` or Desktop |
| Mac role | Mount/consume; do not stage large downloads on Mac then copy |
| Privacy | Model weights ≠ personal vault; still never push caches into GitHub/`safe-harness` |
| Empiricism | Path pins and docker compose live with Studio/Ops; Delivery adapters only document the env contract |

When adapters document local/Ollama/HF lanes, require `HF_HOME` (and kin) to resolve on MainSqueeze — Mac-local cache is non-compliant with Option A.
