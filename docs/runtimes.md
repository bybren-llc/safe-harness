# Runtime launch runbook

Use this file to run Claude Code or Codex from Cursor's integrated terminal at the **repo root**, and to start a Cursor cloud agent. This is the runbook for the v1.1 proof runs (R1 Cursor cloud, R2 Claude Code, R3 Codex) on #85.

One git worktree and one branch per agent. Agents never merge, never approve, never push to `main`, never tag, and never pass flags that skip approvals or sandboxing for those actions.

## Proof pass criteria

R1–R3 each fail unless all of the following hold:

- Each run loads `AGENTS.md` and follows the Before you start order.
- Each run goes through SecEng PASS, QAS APPROVE, and RTE PASS at its exact head.
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
claude -p "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief." --allowedTools "Read,Edit,Write,Bash(git status),Bash(git diff),Bash(git diff --stat),Bash(yq eval '.' trace/trace-map.yaml),Bash(python3 skills/check-frontmatter.py),Bash(python3 scripts/check-denylist.py),Bash(python3 scripts/test_check_denylist.py),Bash(bash trace/check.sh)"
```

To capture the session id for evidence, the public docs show `--output-format json`, which includes `session_id`:

```bash
claude -p "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief." --output-format json --allowedTools "Read,Edit,Write,Bash(git status),Bash(git diff),Bash(git diff --stat),Bash(yq eval '.' trace/trace-map.yaml),Bash(python3 skills/check-frontmatter.py),Bash(python3 scripts/check-denylist.py),Bash(python3 scripts/test_check_denylist.py),Bash(bash trace/check.sh)"
```

Headless runs only edit files and run the local checks. The operator commits, pushes, and opens the PR from the worktree, and records `session_id` as `evidence_id`. Set `runtime` to `claude-code`.

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
codex exec --sandbox workspace-write "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief."
```

To capture the session id for evidence, the public docs show `--json`, whose stream includes a `thread.started` event with `thread_id`:

```bash
codex exec --sandbox workspace-write --json "Read .briefs/<issue>.md. Follow AGENTS.md Before you start. Implement only that brief."
```

Headless runs only edit files and run the local checks. The operator commits, pushes, and opens the PR from the worktree, and records `thread_id` as `evidence_id`. Set `runtime` to `codex`.

Do not pass flags that skip approvals or sandboxing. `--sandbox workspace-write` is the expected sandbox for a run that edits the worktree; it is a sandbox mode, not a bypass. If a flag is not in the vendor's public docs, do not invent it.

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

Headless runs only edit files and run the local checks. They do not commit, push, or open the PR. The operator does those steps from the worktree and records the agent's `thread_id` or `session_id` as `evidence_id`.

1. Stage only the files the brief allows.
2. One or more ordinary commits. Trailer `Refs #N`. Do not invent REQ IDs. Do not add trailers by hand beyond what the brief requires.
3. Push the feature branch. Never push to `main`.
4. Open the PR with [`.github/pull_request_template.md`](../.github/pull_request_template.md). Include `Requirements: N/A` (or real IDs when they exist) and `Refs #N`.
5. Fill a portable evidence row for each gate, and record the handoff:

| Field | What to write |
| --- | --- |
| `evidence_id` | Claude Code `session_id`, Codex `thread_id`, or Cursor cloud agent id |
| `runtime` | `claude-code` \| `codex` \| `cursor` |
| `exact_head` | Full SHA of the PR head |
| `issue` | `#N` |
| `actor` | Seat name |
| `gate` | The gate this row satisfies |
| `req_ids` | `[]` while `spec.md` has no REQ IDs |

Write one row each for Implement → Ready for QAS, SecEng, QAS, and RTE. For the required cross-runtime handoff, record the source and target `evidence_id`s on those rows. Every row for that run uses the same `exact_head`.

See [`constitution/05-evidence-and-traceability.md`](../constitution/05-evidence-and-traceability.md).

## Handoff to SecEng, QAS, and RTE

The implementer stops at Ready for QAS. Delivery and cloud agents never merge, never approve, and never post outside the assigned PR.

SecEng reviews (scanner, not fixer). QAS is independent of the implementer. Release · RTE PASSes the exact head. Merge seats are the owner, the GM, or Release · RTE only.

For R1–R3, SecEng PASS, QAS APPROVE, and RTE PASS must land on the same exact head, in that order. A new commit voids those verdicts.

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

Use this section when a person runs Claude Code or Codex from a desktop machine instead of a cloud agent. The repo stays the source of truth: every runtime loads `AGENTS.md`, then intent, spec, decisions and the brief, in the order set out in [AGENTS.md](../AGENTS.md). Gates (QAS, SecEng, RTE) stay on the pull request, the same as for every other runtime.

### 1. One worktree and branch per brief

1. Write the brief to `.briefs/<issue>.md`. This folder is git-ignored, so don't commit briefs.
2. Make a worktree for that brief: `git worktree add ../<repo>-wt/<issue>-<runtime> -b <issue>-<slug>-<runtime>`. Claude Code can also make one with `claude -w <issue>-<runtime>`; Claude's worktrees land in `.claude/worktrees/`, which is also git-ignored.
3. Run exactly one agent in each worktree. Remove the worktree when its PR merges or closes (`git worktree remove ../<repo>-wt/<issue>-<runtime>`). Headless runs don't clean up their worktrees on their own.

### 2. Claude Code

- Claude Code reads `CLAUDE.md`, and when that file exists it skips `AGENTS.md`. This repo's `CLAUDE.md` imports `@AGENTS.md`; keep that import, or Claude Code won't load the harness.
- Interactive: run `claude` in the worktree.
- Headless: `claude -p "$(cat .briefs/<issue>.md)" --output-format json --allowedTools "Read,Edit,Write,Bash(git status),Bash(git diff),Bash(git diff --stat),Bash(yq eval '.' trace/trace-map.yaml),Bash(python3 skills/check-frontmatter.py),Bash(python3 scripts/check-denylist.py),Bash(python3 scripts/test_check_denylist.py),Bash(bash trace/check.sh)"`. Headless runs only edit files and run the local checks. The operator commits, pushes, and opens the PR from the worktree, records `session_id` as `evidence_id`, and copies the JSON output to `prove/v1.1-<runtime>/` as [Commit, push, open the PR, record evidence](#commit-push-open-the-pr-record-evidence) already says. Continue the same session with `claude -p --resume <session_id> "<follow-up>"`.
- Don't use `--bare`. It skips the repo's `CLAUDE.md`, rules and skills, and it doesn't work with subscription sign-in.
- Docs: [headless mode](https://code.claude.com/docs/en/headless), [worktrees](https://code.claude.com/docs/en/worktrees), [desktop](https://code.claude.com/docs/en/desktop), [Remote Control](https://code.claude.com/docs/en/remote-control).

### 3. Codex

- Codex reads `AGENTS.md` directly ([AGENTS.md guide](https://developers.openai.com/codex/guides/agents-md)). See [adapters/codex](../adapters/codex/README.md).
- Interactive: run `codex` in the worktree.
- Headless: `codex exec --sandbox workspace-write --json "$(cat .briefs/<issue>.md)"`. Capture stdout. Headless runs only edit files and run the local checks. The operator commits, pushes, and opens the PR from the worktree, records `thread_id` as `evidence_id`, and copies the JSON output to `prove/v1.1-<runtime>/` as [Commit, push, open the PR, record evidence](#commit-push-open-the-pr-record-evidence) already says. Continue with `codex exec resume <thread_id> "<follow-up>"`. For scripted control, use the [Codex SDK](https://github.com/openai/codex/blob/main/sdk/typescript/README.md).
- Don't use `codex mcp-server`; it has been removed. Use `codex exec` or the SDK instead.
- Don't share one Codex sign-in file between concurrent jobs or across machines. Run Codex jobs one at a time on a host, or give each its own `CODEX_HOME`.
- Docs: [non-interactive mode](https://learn.chatgpt.com/docs/non-interactive-mode), [git worktrees](https://learn.chatgpt.com/docs/environments/git-worktrees), [remote connections](https://learn.chatgpt.com/docs/remote-connections).

### 4. Desktop apps as the window

The Claude desktop app and the Codex app can open the same repo and the same worktrees as the CLIs. Use them to watch and steer a run. They don't replace the brief, the evidence or the gates.

### 5. Rules for every desktop run

- Sign in through each vendor's own flow on the unmodified app or CLI. Never copy, extract or share sign-in tokens.
- Don't run subscription-signed-in Codex in GitHub Actions on a public repo. See [CI/CD auth](https://learn.chatgpt.com/docs/auth/ci-cd-auth). Run `codex exec` only on a trusted machine against a local clone, and only on branches your own team created; treat PR content from outsiders as untrusted input.
- Don't script the desktop apps' GUIs. There's no supported API, and it breaks easily.
- An agent never merges, force-pushes or edits history. A headless run only edits files and runs the local checks. The operator commits, pushes, and opens the PR from the worktree, records `thread_id`/`session_id` as `evidence_id`, and hands off with `git show --stat`, `git rev-parse HEAD` and the evidence paths.
- Usage limits are shared with the owner's own use of the same plan. Don't raise limits or add paid tiers without the owner's approval.
