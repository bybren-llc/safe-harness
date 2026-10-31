# 04 — Privacy & Vaults

Non-negotiable standing rules. Delivery never invents vault paths.

## Secrets ownership

Secrets live in vaults. the owner owns both the GitHub secrets and the vault side. Never put a secret value in this repository, in a PR, or in a decision pack.

## Three vaults

| Vault | Storage | Remote forge? | Delivery lane? |
| --- | --- | --- | --- |
| **Personal** | **Private storage**; never a workstation folder | **NEVER** | Out of lane |
| **Story IP** | **private storage pins** (may be private-storage) | Not assumed forge-backed | Consume via handoff pins only |
| **knowledge base** (a private repo) | Forge / business IP | Yes — forge-backed | Follow knowledge base agent contribution playbook |

## Private storage is SoT for work data

- Private storage = source of truth for work data.
- Workstations mount it; vaults live on private storage, not local Desktop.
- The personal vault lives on private storage and never syncs to a remote forge.
- knowledge base = forge/business IP; Story IP = private storage pins.

## Studio → Delivery handoff requirements

When spine (B) knowledge becomes buildable, Studio emits a handoff (see `../templates/studio-to-delivery-handoff.md`) with at least:

- Outcome / value link (Bolt goal or your defined metrics)
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

## Model cache / HF_HOME

Model downloads land directly on private storage, not on a workstation cache. Document your model-cache and machine roles here.

Never push caches into a remote forge.
