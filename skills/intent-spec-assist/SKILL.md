---
name: intent-spec-assist
description: Help the human owner draft intent.md and spec.md. Propose only. Agents never write those files as done and never merge them. Use when Studio is preparing design text for the HITL owner.
---

# Intent and spec assist

**Source:** new
**Used by:** Studio · Lead

## When to use

The human owner is drafting `intent.md` or `spec.md`. Agents may propose text. The human writes and merges. `@<code-owners>` is the review gate. See the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook) ("Capture as intent.md", "Requirements and design").

## How to help

1. Ask what outcome and non-goals the human wants.
2. Propose a section outline. Keep personal-store and private-store facts out. Cite by concept name.
3. Propose REQ-shaped statements only as candidates. Do not register REQ IDs until the human-owned spec exists and Delivery opens the registry PR.
4. Hand the draft to the human. They paste, edit, and merge.

## Ownership

| File | Who writes | Who merges |
| --- | --- | --- |
| `intent.md` | Human owner (agents propose) | Human owner only |
| `spec.md` | Human owner (agents propose) | Human owner only |

Studio may draft; Delivery may commit a PR that contains the human's text. Agents still do not merge those paths.

## Stop rules

- The agent proposes. The human writes and merges.
- Do not fill empty placeholders with invented product intent.
- Do not put secrets, personal-store facts, or story IP in a proposal.
- Do not treat a proposed draft as adopted.
