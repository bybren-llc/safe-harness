---
name: intent-spec-assist
description: Help the human owner draft intent.md and spec.md. Propose only. Agents never write those files as done and never merge them. Use when Studio is preparing design text for the HITL owner.
---

# Intent and spec assist

**Source:** new
**Used by:** Studio · Lead

## Authority

- [`constitution/05-evidence-and-linear.md`](../../constitution/05-evidence-and-linear.md) — humans own and accept intent and spec; agents never merge those paths

See the cited section; this skill grants no authority.

## When to use

The human owner is drafting `intent.md` or `spec.md`. Agents may propose text. Who writes and who merges is in the cited section. See the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook) ("Capture as intent.md", "Requirements and design").

## How to help

1. Ask what outcome and non-goals the human wants.
2. Propose a section outline. Keep personal-store and private-store facts out. Cite by concept name.
3. Propose REQ-shaped statements only as candidates. A candidate `source` is `spec.md#anchor` or `intent.md#anchor` (the same forms as the cited section and `trace/schema.md`). Do not register REQ IDs until that human-owned source exists and Delivery opens the registry PR.
4. Hand the draft to the human. They paste, edit, and merge.

## Ownership

See the cited section; this skill grants no authority. Studio may draft; Delivery may commit a PR that contains the human's text. Merge of those paths follows the cited section.

## Stop rules

- The agent proposes. The human writes and merges as the cited section requires.
- Do not fill empty placeholders with invented product intent.
- Do not put secrets, personal-store facts, or story IP in a proposal.
- Do not treat a proposed draft as adopted.
