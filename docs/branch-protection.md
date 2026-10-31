# Branch protection for `main`

Who may merge remains [`constitution/03-cd-and-hitl.md`](../constitution/03-cd-and-hitl.md): only the owner, the GM, or Release · RTE. Delivery and cloud agents never merge. The GitHub ruleset below does not encode that seat list. This file describes the applied ruleset. A repository administrator applied it. Adopters configure their own rulesets using this structure.

## Recommended ruleset on `main`

Adopters configure a GitHub ruleset on `main` using this structure. The ruleset should require a pull request with 0 required approvals, require three status checks to pass (strict on up-to-date branches), and block force-pushes and deletion.

### Ruleset settings

| Setting | Value |
| --- | --- |
| Target | `main` branch |
| Enforcement | Active |
| Require pull request before merging | On |
| Required approvals | **0** |
| Require status checks to pass | On |
| Require branches to be up to date before merging | On (strict) |
| Required status checks | `Structure & Docs Validation` (GitHub Actions); `Requirements Trace Validation` (GitHub Actions); `API Contract Checks` (GitHub Actions). Each check is pinned to GitHub Actions as the expected source. |
| Block force pushes | On |
| Block deletions | On |
| Bypass list | Configured. Adopters choose their own bypass list. |

### Required status checks

The ruleset requires these three checks before merge:

1. **Structure & Docs Validation** (GitHub Actions) — job in `.github/workflows/wave0-checks.yml`. Includes the conflict-marker check and the template-ready check (CI scope).
2. **Requirements Trace Validation** (GitHub Actions) — job in `.github/workflows/trace-check.yml`. This check is **warn-only** until `spec.md` has REQ IDs **and** `trace/.blocking` exists. In warn-only mode trace findings exit 0 and do not block merges. Structural failures still fail the check in any mode: missing `yq`, invalid or multi-document `trace/trace-map.yaml`, the owner-identity check, an invalid requirements count, and the fixture-test steps.
3. **API Contract Checks** (GitHub Actions) — job in `.github/workflows/api-contract.yml`. oasdiff and Schemathesis findings do not fail the job (`continue-on-error`). Setup steps (spec lookup, base fetch, tool download/install) have no `continue-on-error`, so a setup failure fails the required check and blocks merge until rerun.

**CodeRabbit** and the two non-required warn-only checks (**Doc drift**, **Skills frontmatter & link scan**) are **not** required status checks. CodeRabbit review is process, handled by Delivery triage. The warn-only checks exit 0 and do not block merges.

### Why 0 required approvals

QAS is a COMMENT review: pull requests are authored by the same account the GM reviews through, and GitHub does not let a pull request's author APPROVE or REQUEST_CHANGES on their own PR. The independent QAS verdict is a COMMENT with an explicit `QAS: APPROVE` / `QAS: CHANGES NEEDED` line (see the README glossary).

Requiring one or more approving reviews, or requiring a code-owner review, would deadlock merges on that account.

The review gate is therefore process, not a GitHub approval count:

- Independent QAS APPROVE on the exact head (COMMENT)
- Independent SecEng where constitution/03 requires it
- RTE PASS on the exact head where constitution/03 and [`roles/release-rte.md`](../roles/release-rte.md) require it
- the owner's recorded own-words concur for `constitution/`, High, and O2

RTE PASS is not a GitHub required status check. Do not add it to the required-check list.

### Bypass list

The ruleset bypass list is configured on the ruleset. Adopters choose their own bypass list members. The bypass is for administrators and designated accounts, not for Delivery or cloud agents.

### Planned upgrade: separate bot identity

A separate bot identity (GitHub App or bot user) that can post real APPROVE reviews is the planned upgrade. That would let required approvals be raised above 0 without deadlocking the authoring account. The HITL owner decides whether and when to add that identity. Do not raise required approvals in the ruleset until that decision is recorded.

## Apply checklist (repo admin)

After this file is on `main`, a repository administrator applies the ruleset:

1. Open the repository **Settings**.
2. Open **Rules → Rulesets**.
3. Create a new ruleset or edit the existing ruleset for `main`.
4. Set **Target branches** to `main` (by name or pattern).
5. Set **Enforcement status** to Active.
6. Under **Branch protections**, enable **Require a pull request before merging**.
7. Set **Required approvals** to `0`.
8. Enable **Require status checks to pass before merging**.
9. Enable **Require branches to be up to date before merging** (strict mode).
10. Add the three required checks. Each check must have run on a recent pull request to appear in the picker. Pin the expected source (GitHub Actions) for each:
    - `Structure & Docs Validation` — GitHub Actions
    - `Requirements Trace Validation` — GitHub Actions
    - `API Contract Checks` — GitHub Actions
11. Do **not** add `CodeRabbit`, `Doc drift`, or `Skills frontmatter & link scan` as required checks. They are not blocking.
12. Enable **Block force pushes**.
13. Enable **Block deletions**.
14. Configure the **Bypass list**. Adopters choose their own bypass list members.
15. Save the ruleset.

Alternatively, use the GitHub CLI or API:

```bash
gh api repos/{owner}/{repo}/rulesets
```

## Verify

After the ruleset is applied:

1. **The ruleset is active.** Settings → Rules → Rulesets lists an active ruleset targeting `main`.
2. **A test pull request shows the checks as required, from the pinned sources.** Open a test PR targeting `main`. The three required checks appear as required (merge waits on them). `Structure & Docs Validation`, `Requirements Trace Validation`, and `API Contract Checks` are all reported by GitHub Actions. CodeRabbit, Doc drift, and Skills frontmatter checks are not required.
3. **The bypass list is configured.** The ruleset shows the intended bypass list members.
4. **Force-push and deletion are blocked.** Run the force-push test as a non-bypass user. A bypass user push is not a valid test. The same non-bypass user must not be able to delete `main`.
