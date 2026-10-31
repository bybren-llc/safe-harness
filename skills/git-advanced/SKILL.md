---
name: git-advanced
description: Merge main to update feature branches, bisect, cherry-pick, and conflict resolution. Use on feature branches. Trunk is main. Never force-push shared branches.
license: MIT (see repository LICENSE)
---

# Git advanced

**Source:** port
**Used by:** Implementer

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — trunk is `main`; exact-head

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

## When to use

Updating a feature branch from trunk, finding a regression with bisect, cherry-picking, or resolving conflicts. Trunk is `main`.

## Forbidden

- Force-push to trunk or any shared branch (including PR branches you don't own)
- `--force-with-lease` on shared branches (use it only on your own private work branches before you share them)
- Rebase or amend commits that others have already pulled
- Merge commits onto trunk from the client (use the repo's PR merge policy)
- `git commit --no-verify`

## Safe

- Merge `main` into your feature branch to update it (plain commits, no rebase)
- `git merge --abort` / `git cherry-pick --abort`
- `git reflog` to recover

## Update a feature branch from trunk

**Constitutional rule:** Update feature branches by merging main. No rebase. No force-push on shared branches.

```text
git fetch origin
git checkout <issue#>-slug
git merge origin/main
# resolve conflicts if any, git add, git commit
git push origin <issue#>-slug
```

This creates a plain merge commit. If the PR is already open, the new commit updates the PR head. QAS reviews at the new exact head.


## Bisect

```text
git bisect start
git bisect bad
git bisect good <known-good-sha>
# run the repo's documented test command
git bisect good   # or git bisect bad
git bisect reset
```

Optional: `git bisect run <test-command>`.

## Cherry-pick

```text
git cherry-pick <sha>
# or a range: git cherry-pick <oldest>^..<newest>
```

Resolve, `git add`, `git cherry-pick --continue`.

## Conflicts

1. `git status`
2. Edit out the conflict markers
3. `git add` the resolved files
4. Continue the merge or cherry-pick

Merge main often on long-running feature branches so conflicts stay small.

## Stop rules

- No secrets in commits. If you committed one, stop and follow SecEng; do not rewrite history without their go.
- Run the repo's documented check command before you push a rewritten feature branch.
