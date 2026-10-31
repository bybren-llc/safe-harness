# 04 — Privacy & Vaults

Non-negotiable standing rules. Delivery never invents vault paths.

## Secrets ownership

Secrets live in vaults. the owner owns both the GitHub secrets and the vault side. Never put a secret value in this repository, in a PR, or in a decision pack.

## Three vaults

| Vault | Storage | Remote forge? | Delivery lane? |
| --- | --- | --- | --- |
| **Personal** | Local → migrate to **private storage**; never Desktop long-term | **NEVER** | Out of lane |
| **Story IP** | **private storage pins** (may be private-storage) | Not assumed forge-backed | Consume via handoff pins only |
| **knowledge base** (a private repo) | Forge / business IP | Yes — forge-backed | Follow knowledge base agent contribution playbook |

## Private storage is SoT for work data (O3)

- Private storage = source of truth for work data.
- Workstations mount it; vaults live on private storage, not local Desktop.
- Personal vault migrates Desktop → private storage but **still never** syncs to GitHub/remote forge.
- knowledge base = forge/business IP; Story IP = private storage pins.

## Studio → Delivery handoff requirements

When spine (B) knowledge becomes buildable, Studio emits a handoff (see `../templates/studio-to-delivery-handoff.md`) with at least:

- Outcome / value link (M1–M6 or Bolt goal)
- AC / DoD (or BSA follow-on named)
- **Source pins** — knowledge base concept IDs and/or private storage paths — **never personal vault**
- Non-code gates already passed
- Suggested owner seat + RTE collapse allowed?
- Exit evidence expected on spine (A)

## Refuse mass-import chats as concepts

Chat dumps are not knowledge objects. Librarian / Studio must distill to pinned concepts with provenance. No bulk chat→vault import as “concepts.”

## Refuse list (Delivery)

- Any PR/CI that syncs personal vault content
- Paths claimed as “Desktop vault” as SoT
- Handoffs that cite personal vault as source pin
- Invented private storage paths not provided by Studio/Librarian

## Model cache / HF_HOME (private storage option A — locked 2026-10-28)

the owner concurred: Hugging Face and other model downloads land **direct on a private storage** via Docker `hf` → a private inference volume — **not** via Mac Desktop as a cache hop.

| Rule | Detail |
| --- | --- |
| SoT for weights/cache | a private storage (private inference volume path family — exact mount pins from Studio/Ops, never invent) |
| `HF_HOME` / hub cache | Point at private-storage-backed dirs inside the Docker / private inference volume env, not `~/` or Desktop |
| Mac role | Mount/consume; do not stage large downloads on Mac then copy |
| Privacy | Model weights ≠ personal vault; still never push caches into GitHub/`safe-harness` |
| Empiricism | Path pins and docker compose live with Studio/Ops; Delivery adapters only document the env contract |

When adapters document local/Ollama/HF lanes, require `HF_HOME` (and kin) to resolve on a private storage — Mac-local cache is non-compliant with Option A.
