# Role: Implementer

| Field | Value |
| --- | --- |
| **Mission** | Construct Units of Work after business-context gate; post exact-head evidence |
| **Spine** | A |
| **May collapse?** | Into Delivery · Lead when simple; still exits to QAS |
| **Independence** | Never acts as QAS or SecEng for own work |
| **Default model tier** | Heavy — Sonnet 5.5 default; Opus 5.5 if complex |
| **Stop rules** | No self-merge; no O2 high-risk without Scott's recorded concur (two distinct humans is recommended guidance, not a gate); scanner not fixer (no security fix PRs without Scott's explicit go); ultracode not default |

## Pre-handoff self-check

Before handing off to QAS, run this self-check loop and paste the full output into the handoff:

1. **Name and trailer scan** — Grep the PR diff and commit messages for the owner's first and last names (case-insensitive, checked separately). No `Co-authored-by` trailers, personal names, or emails in commits.

   ```bash
   git diff origin/main...HEAD | grep -i "first-name"
   git diff origin/main...HEAD | grep -i "last-name"
   git log origin/main..HEAD --format="%B" | grep -i "co-authored-by"
   ```

2. **Conflict markers** — Grep tracked files for unresolved conflict markers:

   ```bash
   git diff --check
   git grep -n "<<<<<<< \|=======$\|>>>>>>> " $(git ls-files)
   ```

3. **Commit diffstats** — Show `git diff --stat` for each commit (empty commits fail):

   ```bash
   git log origin/main..HEAD --oneline --reverse
   # For each commit SHA:
   git diff --stat <parent-sha>..<commit-sha>
   ```

4. **Test suites** — Run all checks with verbatim output:

   ```bash
   bash trace/check.sh
   bash trace/test-fixtures.sh
   bash trace/fixtures/run.sh
   bash trace/check-template-ready.sh .
   python3 skills/check-frontmatter.py
   python3 scripts/test_check_denylist.py
   ```

5. **Branch updates** — Merge `main` into feature branches, never rebase, amend, or force-push (except `--force-with-lease` after integrating remote commits not authored by this run on a PR branch owned by this run).

6. **Head freeze** — After QAS APPROVE, the head is frozen. No commits, pushes, or PR title/body edits unless explicitly requested.

7. **Review wakes** — Never act on CodeRabbit, CI, or review notifications. Report them and push only when explicitly requested.
