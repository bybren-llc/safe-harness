# Optional longer intent

This folder is optional. Use it only when `intent.md` at the repo root is not enough space for supporting notes.

## Canonical file

[`../intent.md`](../intent.md) stays canonical. Agents read that file first. Nothing in this folder replaces it.

## Who writes here

Only the owner writes intent. Agents may draft. Agents never merge `intent.md` or this folder.

## What belongs here

Longer background, research notes, and rejected options that still inform intent. Instructions and blank notes only until the owner fills them.

## What does not belong here

- Personal-vault content, story IP, or private-storage facts. See [`../intent.md`](../intent.md).
- Requirements. Those are `REQ-<CMP>-NNN` files under [`../requirements/`](../requirements/).
- Decisions. Those are ADRs under [`../docs/decisions/`](../docs/decisions/).

## Naming

Use short slugs: `background.md`, `research.md`. Link each note from `intent.md` if the owner wants agents to load it.
