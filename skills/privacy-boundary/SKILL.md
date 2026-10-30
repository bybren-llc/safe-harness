---
name: privacy-boundary
description: Enforce the personal-boundary rule — no personal-store content, story IP, or private-store facts in repos. Use when drafting, reviewing, or scanning a diff for privacy leakage.
---

# Privacy boundary

**Source:** new
**Used by:** All seats, SecEng

## When to use

Before a commit, in every SecEng review, and whenever a brief or handoff cites a knowledge source. Binding text: `constitution/04` and the contributing guide.

Crossing this boundary is an O2 item and defaults to High.

## Three classes (generic)

| Class | Remote forge? | How to cite |
| --- | --- | --- |
| Personal store | Never | By concept name only. Never a path, excerpt, or file list. |
| Private store (including story IP) | Not assumed | Source pin supplied by Studio / Librarian. Never invent a pin. |
| Forge-backed knowledge base | Yes (business IP) | Register-first concept name or ID. Latest-wins. No invented links. |

The primary data store is the source of truth for work data that is not in the repo. The repo is the source of truth for intent, spec, plan, requirements, trace, review findings, and evidence. Do not copy repo evidence into a personal or private store. Do not copy personal-store or private-store facts into the repo.

## Refuse

- Personal-store paths, file names, or excerpts
- Story IP (characters, plot, world details)
- Private-store facts: LAN IPs, tokens, home paths, device identifiers, hostnames, machine names
- Invented pins
- Mass-imported chat dumps filed as "concepts"
- Secret values anywhere in the tree, a PR, or a decision pack

## How to cite

- Allowed: "See the personal-store entry for the authentication flow."
- Allowed: documentation-range examples (for example `192.0.2.1`).
- Forbidden: the actual path, IP, token, or excerpt.

## Stop rules

- Delivery never invents vault or store paths.
- Secrets live in vaults. The HITL owner owns the forge secrets and the vault side.
- If a scan finds a personal or private target in the repo, report it as a privacy finding to the GM and the HITL owner, not as a public issue that quotes the target.
