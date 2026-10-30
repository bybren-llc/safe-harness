---
name: testing-evidence
description: Give the agent a feedback loop — failing test first for bugs, paste literal output as evidence, never weaken a test during a fix. Use while implementing or while QAS is checking evidence.
---

# Testing evidence

**Source:** generalize
**Used by:** Implementer, QAS

## When to use

Any time you change behavior or claim a fix. Follow the [AI-native SDLC playbook](https://claude.com/resources/articles/the-ai-native-sdlc-playbook) ("Give Claude a feedback loop"): the agent needs a command it can re-run.

Jest, Playwright, and similar runners are examples only. Use the repo's documented test command.

## Rules

1. **Bugs:** write or reveal a failing test first. Then fix. Then show the test pass.
2. **Paste literal output.** A sentence that says "tests passed" is not evidence.
3. **Never weaken a test to make a fix green.** If the test is wrong, say so and change it with a reason QAS can review.
4. Prefer isolation: no shared mutable state, no hard-coded foreign IDs, clean up side effects.
5. Do not bypass the access layer the product uses (the "just hit the database" shortcut) unless the test is explicitly a storage test.

## Evidence block

```text
command: <the repo's documented test command>
result: <literal output>
exact_head: <sha>
req_ids: [REQ-<CMP>-NNN]
```

## Stop rules

- Do not skip the suite on High / O2 because a subset was green.
- Do not store secrets in fixtures.
- QAS may re-run the same command. If they cannot, the evidence is incomplete.
