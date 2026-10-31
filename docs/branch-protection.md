# Branch protection for `main`

Who may merge remains [`constitution/03-cd-and-hitl.md`](../constitution/03-cd-and-hitl.md): only the owner, the GM, or Release · RTE. Delivery and cloud agents never merge. The GitHub rules below do not encode that seat list. This file records both the live configuration and the intended future settings. A repository administrator applies intended settings after they are decided and land on `main`.

## Live: active ruleset on `main`

A ruleset on `main` requires three checks before merge: **Requirements Trace Validation**, **Structure & Docs Validation**, and **API Contract Checks**. This ruleset is active and enforced. It does not restrict who may merge (seat-list enforcement waits on the owner).

## Intended settings (not yet applied)

The intended configuration below uses a **classic branch protection rule** on `main` (Settings → Branches → Branch protection rules). Classic rules are the ones that make the branch report as protected. These settings are not yet applied; a repository administrator applies them after this policy lands on `main`, using the checklist at the end of this file.

| Setting | Value |
| --- | --- |
| Branch name pattern | `main` |
| Require a pull request before merging | On |
| Required number of approvals | **0** |
| Require review from Code Owners | Off |
| Dismiss stale pull request approvals when new commits are pushed | Off |
| Require approval of the most recent reviewable push | Off |
| Require status checks to pass before merging | On |
| Require branches to be up to date before merging | On |
| Required status checks | `Structure & Docs Validation` (GitHub Actions); `Requirements Trace Validation` (warn-only, GitHub Actions); `API Contract Checks` (warn-only, GitHub Actions). Pin each expected source. Without a pinned source, the shared account could post a passing status itself. |
| Allow force pushes | Off (block force-pushes) |
| Allow deletions | Off (block deletion) |
| Do not allow bypassing the above settings (include administrators) | Off — the repo admin keeps bypass |

Leave other optional toggles off unless the HITL owner adds them later (conversation resolution, signed commits, linear history, restrict who can push, lock branch).

## Required status checks

Add these three names, matching the check as it appears on pull requests:

1. **Structure & Docs Validation** (GitHub Actions) — job in `.github/workflows/wave0-checks.yml`. Includes the conflict-marker check and the template-ready check (CI scope).
2. **Requirements Trace Validation** (warn-only, GitHub Actions) — job in `.github/workflows/trace-check.yml`. This check is **warn-only** until `spec.md` has REQ IDs **and** `trace/.blocking` exists. In warn-only mode trace findings exit 0 and do not block merges. Structural failures still fail the check in any mode: missing `yq`, invalid or multi-document `trace/trace-map.yaml`, the owner-identity check, an invalid requirements count, and the fixture-test steps.
3. **API Contract Checks** (warn-only, GitHub Actions) — job in `.github/workflows/api-contract.yml`. oasdiff and Schemathesis findings do not fail the job (`continue-on-error`). Setup steps (spec lookup, base fetch, tool download/install) have no `continue-on-error`, so a setup failure fails the required check and blocks merge until rerun.

**CodeRabbit** and the two non-required warn-only checks (**Doc drift**, **Skills frontmatter & link scan**) are **not** required status checks. CodeRabbit review is process, handled by Delivery triage. The warn-only checks exit 0 and do not block merges.

## Why 0 required approvals

QAS is a COMMENT review: pull requests are authored by the same account the GM reviews through, and GitHub does not let a pull request's author APPROVE or REQUEST_CHANGES on their own PR. The independent QAS verdict is a COMMENT with an explicit `QAS: APPROVE` / `QAS: CHANGES NEEDED` line (see the README glossary).

Requiring one or more approving reviews, or requiring a code-owner review, would deadlock merges on that account.

The review gate is therefore process, not a GitHub approval count:

- Independent QAS APPROVE on the exact head (COMMENT)
- Independent SecEng where constitution/03 requires it
- RTE PASS on the exact head where constitution/03 and [`roles/release-rte.md`](../roles/release-rte.md) require it
- the owner's recorded own-words concur for `constitution/`, High, and O2

RTE PASS is not a GitHub required status check. Do not add it to the required-check list.

## Admin bypass

Leave "Do not allow bypassing the above settings" (also labeled "Include administrators") **off**. The repository administrator may bypass the rule. That bypass is for the admin, not for Delivery or cloud agents.

## Planned upgrade: separate bot identity

A separate bot identity (GitHub App or bot user) that can post real APPROVE reviews is the planned upgrade. That would let required approvals be raised above 0 without deadlocking the authoring account. The HITL owner decides whether and when to add that identity. Do not raise required approvals in this rule until that decision is recorded.

## Apply checklist (repo admin)

After this file is on `main`:

1. Open the repository **Settings**.
2. Open **Branches**.
3. Under **Branch protection rules**, choose **Add rule** (classic rule, not a ruleset). A ruleset may protect the branch without making it report as protected.
4. Set **Branch name pattern** to `main`.
5. Enable **Require a pull request before merging**.
6. Set **Required number of approvals before merging** to `0`.
7. Leave **Require review from Code Owners** unchecked.
8. Leave **Dismiss stale pull request approvals when new commits are pushed** unchecked.
9. Leave **Require approval of the most recent reviewable push** unchecked.
10. Enable **Require status checks to pass before merging**.
11. Enable **Require branches to be up to date before merging**.
12. Add required checks, using the names as they appear in the picker (a check must have run on a recent pull request to appear). Pin the expected source for each. Without a pinned source, the shared account could post a passing status itself.
   - `Structure & Docs Validation` — GitHub Actions
   - `Requirements Trace Validation` — GitHub Actions
   - `API Contract Checks` — GitHub Actions (warn-only)
13. Do **not** add `CodeRabbit`, `Doc drift`, or `Skills frontmatter & link scan` as required checks. They are not blocking.
14. Leave **Allow force pushes** unchecked.
15. Leave **Allow deletions** unchecked.
16. Leave **Do not allow bypassing the above settings** / **Include administrators** unchecked (repo admin keeps bypass).
17. Save the rule.

## Verify

1. **The branch shows protected.** Settings → Branches lists a protection rule on `main`. The `main` branch reports as protected (`protected: true`).
2. **A test pull request shows the checks as required, from the pinned sources.** Open a test PR targeting `main`. The three required checks appear as required (merge waits on them). `Structure & Docs Validation`, `Requirements Trace Validation`, and `API Contract Checks` are all reported by GitHub Actions. CodeRabbit, Doc drift, and Skills frontmatter checks are not required.
3. **Include administrators is Off.** Settings shows "Include administrators" (enforce for admins) Off, as intended.
4. **Force-push and deletion are blocked.** Run the force-push test as a non-admin with no bypass permission. An admin push is not a valid test. The same non-admin must not be able to delete `main`.
