---
name: orchestration-patterns
description: Run long-running, multi-step agent work with evidence-based delivery and a choice between parallel sessions and subagents. Use when one session cannot finish the bolt.
license: MIT (see repository LICENSE)
---

# Orchestration patterns

**Source:** port
**Used by:** Delivery, GM

## Authority

- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — QAS independence
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — merge execution; exact-head

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

Multi-step work, parallel sessions, or subagents. Pair with [`delegation-brief`](../delegation-brief/SKILL.md) and [`bolt-lifecycle`](../bolt-lifecycle/SKILL.md). See the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook) ("Parallel sessions and subagents").

## Agent loop

1. Goal and AC (from the brief; do not invent AC)
2. Pattern discovery
3. Implement → run the repo's documented check → pass / fix / blocked
4. Attach portable evidence
5. Independent QAS before any merge request

If blocked, escalate to Ops or the GM with attempts, exact head, and the ask. Do not keep spinning.

## Parallel sessions vs subagents

| Mode | When |
| --- | --- |
| Subagent | Nested, short, returns evidence to the parent (explore, review, research) |
| Parallel sessions | Sibling bolts or independent files, each with its own brief and branch |

Do not give two sessions the same files without a lock or a split. Do not let a subagent merge.

## Checkpoints

Every handful of tool calls: update the task list, summarize if the context is large, write a handoff if the session will end.

At session boundaries: completed, in progress, remaining, blockers, exact head, evidence posted.

## Stop rules

- Evidence over assertion.
- Independent QAS before a merge request: see the cited section; this skill grants no authority.
- Do not let a subagent merge. See the cited section; this skill grants no authority.
