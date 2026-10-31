---
name: git-advanced
description: Bisect, cherry-pick, and conflict resolution with safety rules. Update branches by merging main. Trunk is main.
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

Finding a regression with bisect, cherry-picking, or resolving conflicts. Trunk is `main`.

## Forbidden

- Force-push any branch
- Merge commits onto trunk from the client (use the repo's PR merge policy)
- `git commit --no-verify`
- Rewriting history (amend, rebase) on pushed branches

## Safe

- `git merge --abort` / `git cherry-pick --abort`
- `git reflog` to recover

## Update branch from trunk (before a PR, or when Delivery asked for a new head)

Update by merging `main`, never by rebase, amend, or force-push. See `roles/implementer.md` § Branch updates.

```text
git fetch origin
git merge origin/main
# resolve conflicts, git add, git commit
git push origin <issue#>-slug
```

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

Rebase often on long-running feature branches so conflicts stay small.

## Stop rules

- No secrets in commits. If you committed one, stop and follow SecEng; do not rewrite history without their go.
- Run the repo's documented check command before you push a rewritten feature branch.
