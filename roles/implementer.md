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

1. **Name, email, and trailer scan** — Run the project's denylist check (fails if unconfigured), scan for email addresses in added lines, and check for `Co-authored-by` trailers.

   ```bash
   python3 scripts/check-denylist.py
   git diff origin/main...HEAD | grep "^+" | grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
   git log origin/main..HEAD --format="%B" | grep -i "co-authored-by"
   ```

2. **Conflict markers** — Check for unresolved conflict markers (use directional markers only to avoid matching Markdown underlines):

   ```bash
   git diff --check
   git grep -n "^<<<<<<< \|^>>>>>>> " $(git ls-files)
   ```

3. **Commit diffstats** — Show `git diff --stat` for each commit (empty commits fail):

   ```bash
   git log origin/main..HEAD --oneline --reverse
   # For each commit SHA:
   git diff --stat <parent-sha>..<commit-sha>
   ```

4. **Test suites** — Run all checks with verbatim output. Link and code-fence checks run only in CI; include CI result at pushed head.

   ```bash
   bash trace/check.sh
   bash trace/test-fixtures.sh
   bash trace/fixtures/run.sh
   # Generate or copy .template-ready-denylist.local first (see .template-ready-denylist.example)
   bash trace/check-template-ready.sh .
   python3 skills/check-frontmatter.py
   python3 scripts/test_check_denylist.py
   ```

5. **Branch updates** — Merge `main` into feature branches, never rebase, amend, or force-push.

6. **Head freeze** — After QAS APPROVE, the head is frozen. No commits, pushes, or PR title/body edits unless explicitly requested.

7. **Review wakes** — Don't self-start on CodeRabbit, CI, or review notifications. Route them to the coordinator (Delivery), which assigns responses per `skills/review-response`. Every finding gets a response. No pushes after QAS APPROVE unless explicitly requested.
