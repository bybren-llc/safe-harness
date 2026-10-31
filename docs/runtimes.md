# Runtime launch runbook

Use this file to run Claude Code or Codex from Cursor's integrated terminal at the **repo root**, and to start a Cursor cloud agent. This is the runbook for the v1.1 proof runs (R1 Cursor cloud, R2 Claude Code, R3 Codex) on #85.

One git worktree and one branch per agent. Agents never merge, never approve, never push to `main`, never tag, and never pass flags that skip approvals or sandboxing for those actions.

## Proof pass criteria

R1–R3 each fail unless all of the following hold:

- Each run loads `AGENTS.md` and follows the Before you start order.
- Each run goes through SecEng, QAS, and RTE PASS at its exact head.
- Evidence is recorded with `runtime` and `evidence_id`.
- At least one handoff crosses runtimes (for example, R2 picks up work or a review from R1).

These are the proof bar for #85. They are stricter than the Low-tier minimum. Record them in the portable evidence table in [`constitution/05-evidence-and-traceability.md`](../constitution/05-evidence-and-traceability.md).

## Setup: worktree and branch

From the repo root in Cursor's integrated terminal:

```bash
git worktree add ../<repo>-wt/<issue>-<runtime> -b <issue>-<slug>-<runtime>
cd ../<repo>-wt/<issue>-<runtime>
```

Example: issue 83, Claude Code, batch-b slug:

```bash
git worktree add ../safe-harness-wt/83-claude-code -b 83-batch-b-claude-code
```

`<runtime>` is `claude-code`, `codex`, or `cursor`. Do not reuse a worktree or branch across agents.

## Where the brief goes

Put the filled bolt brief at **`.briefs/<issue>.md`** in that worktree.

Why that path:

- The GitHub issue is the tracker handle. The bolt brief is the contract (scope, files, tier, stop rules, evidence). The issue form does not carry every field.
- A CLI agent needs a file it can open. One path means every runtime looks in the same place.
- Copy from [`templates/delivery-bolt-brief.md`](../templates/delivery-bolt-brief.md). Strip secrets and personal-store facts ([`skills/delegation-brief/SKILL.md`](../skills/delegation-brief/SKILL.md)).

Treat `.briefs/<issue>.md` as a working file. Do not put secrets in it. The durable copy after the run is the later `prove/v1.1-<runtime>/` record (#85). If the brief is missing, stop and ask.

Point the agent at the file by naming that path in the first prompt. There is no confirmed vendor flag that means "brief file."

## Claude Code

### Interactive

```bash
claude
```

First message: tell it to read `.briefs/<issue>.md`, then follow `AGENTS.md` Before you start.

### Headless

The public CLI documents `claude -p` (also `--print`) as the non-interactive form.

```bash
claude -p "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief."
```

To capture the session id for evidence, the public docs show `--output-format json`, which includes `session_id`:

```bash
claude -p --output-format json "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief."
```

Record `evidence_id` from that `session_id`. Set `runtime` to `claude-code`.

Do not pass flags that skip approvals or sandboxing. If a flag is not in the vendor's public docs, do not invent it.

## Codex

### Interactive

```bash
codex
```

First message: tell it to read `.briefs/<issue>.md`, then follow `AGENTS.md` Before you start. Codex reads root `AGENTS.md` natively.

### Headless

The public CLI documents `codex exec` as the non-interactive form.

```bash
codex exec "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief."
```

To capture the session id for evidence, the public docs show `--json`, whose stream includes a `thread.started` event with `thread_id`:

```bash
codex exec --json "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief."
```

Record `evidence_id` from that `thread_id`. Set `runtime` to `codex`.

Do not pass flags that skip approvals or sandboxing. If a flag is not in the vendor's public docs, do not invent it.

## What to verify after launch

The agent's first handoff must name, by repo path:

1. Root `AGENTS.md` (loaded).
2. The Before you start order: `intent.md` → `spec.md` → `docs/decisions/log.md` (Current shape) → the issue and `.briefs/<issue>.md` → cited REQ IDs.
3. `roles/implementer.md`.
4. Each skill it used, and whether the runtime auto-loaded it or it opened the path.

If the brief is missing, the agent stops and asks. If it skipped Before you start, stop the run and restart with the brief.

## Local checks

From the worktree root, before opening or updating the PR, run the checks in [`AGENTS.md`](../AGENTS.md):

```bash
yq eval '.' trace/trace-map.yaml
python3 skills/check-frontmatter.py
python3 scripts/check-denylist.py
python3 scripts/test_check_denylist.py
bash trace/check.sh
```

Also run the relative-link scan and fence-parity check the same way [`AGENTS.md`](../AGENTS.md) describes.

## Commit, push, open the PR, record evidence

1. Stage only the files the brief allows.
2. One or more ordinary commits. Trailer `Refs #N`. Do not invent REQ IDs. Do not add trailers by hand beyond what the brief requires.
3. Push the feature branch. Never push to `main`.
4. Open the PR with [`.github/pull_request_template.md`](../.github/pull_request_template.md). Include `Requirements: N/A` (or real IDs when they exist) and `Refs #N`.
5. Fill a portable evidence row:

| Field | What to write |
| --- | --- |
| `evidence_id` | Claude Code `session_id`, Codex `thread_id`, or Cursor cloud agent id |
| `runtime` | `claude-code` \| `codex` \| `cursor` |
| `exact_head` | Full SHA of the PR head |
| `issue` | `#N` |
| `actor` | Seat name |
| `gate` | The gate this row satisfies |
| `req_ids` | `N/A` while `spec.md` has no REQ IDs |

See [`constitution/05-evidence-and-traceability.md`](../constitution/05-evidence-and-traceability.md).

## Handoff to SecEng, QAS, and RTE

The implementer stops at Ready for QAS. Delivery and cloud agents never merge, never approve, and never post outside the assigned PR.

SecEng reviews (scanner, not fixer). QAS is independent of the implementer. Release · RTE PASSes the exact head. Merge seats are the owner, the GM, or Release · RTE only.

For R1–R3, each of SecEng, QAS, and RTE PASS must land on the same exact head, in that order. A new commit voids those verdicts.

## Cleanup

After the PR is merged by an allowed seat:

```bash
git worktree remove ../<repo>-wt/<issue>-<runtime>
git branch -d <issue>-<slug>-<runtime>
```

Delete the remote feature branch after merge if your forge does not do it. Do not delete `main`.

## Cursor cloud agents

Cursor cloud agents do not use a local `git worktree add` from this terminal. The cloud workspace is the working tree. Still one branch per agent, named `<issue>-<slug>-cursor` (or the issue-slug the launch already created).

Put the same brief at `.briefs/<issue>.md` on that branch, or paste the brief path and the Before you start order in the launch prompt. The agent reads root `AGENTS.md` and `.cursor/rules/safe-harness.mdc`.

Record `evidence_id` as the cloud agent id. Set `runtime` to `cursor`. The same merge, approve, push-to-main, tag, and skip-flag rules apply.

R1 on #85 is the Cursor cloud run.

## Driving agents through desktop apps

To be written after research.
