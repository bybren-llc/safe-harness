# Link Health & Rot Detection — safe-harness

**Status:** PROPOSED (Librarian · Signals draft, pending QAS by Kai and @cheddarfox review)  
**Owner seat:** Librarian · Signals ([`../roles/librarian-signals.md`](../roles/librarian-signals.md))  
**Component:** ARC-TRC (trace), with proposed CI extensions under ARC-WFL  
**Authority:** constitution/05 "CI scope" and Decision 12 in [`../prove/wave-1/decision-pack.md`](../prove/wave-1/decision-pack.md) (Librarian concur conditions 1–4)  
**Last updated:** 2026-10-29

---

## 1. Purpose

Keep every link between safe-harness artifacts, GitHub issues and PRs, the Atlas vault, external sources, and the retired Linear SAF archive resolvable, and catch link rot before a reader does. The repo is the sole source of truth ([`../constitution/05-evidence-and-linear.md`](../constitution/05-evidence-and-linear.md)); this spec makes that claim checkable.

Principles (from the Librarian concur, Wave 1):

1. **One trace map is the truth.** [`trace-map.yaml`](trace-map.yaml) is canonical for REQ/ARC. Other places cite it; they do not restate REQ text.
2. **Blocking stays in-repo.** Only checks that need nothing but the checked-out tree may block a merge.
3. **Cross-system and external checks are scheduled and non-blocking**, so a flaky outside site can never block a merge.
4. **Read-only by default.** Rot is reported as GitHub issues labelled `link-rot`. Every fix is a PR that a human or Kai merges. The Librarian never merges, including its own PRs.
5. **No invented links.** A target that cannot be verified is recorded as `UNKNOWN`, never guessed (register-first).
6. **Changes to intent, spec, or REQ IDs are human-reviewed.** A link fix that would touch `intent.md`, `spec.md`, `requirements/`, or a REQ ID goes through CODEOWNERS review like any other change.

## 2. Scope

| # | Link class | Examples | Checked by |
| --- | --- | --- | --- |
| L1 | Relative file links in markdown | `[x](../roles/qas.md)`, reference-style `[x]: path.md` | Blocking (in-repo) |
| L2 | Anchors / fragments | `constitution/05-evidence-and-linear.md#ci-scope`, `spec.md#anchor` in REQ `source` | Blocking (in-repo) |
| L3 | REQ / ARC references | `REQ-<CMP>-NNN` in trace map, docs, PR bodies; `component: ARC-<CMP>` | Blocking (in-repo) for the tree; PR-body linkage per trace-check follow-up |
| L4 | Issue / PR references from the repo | `#N`, `Refs #N`, `github.com/bybren-llc/safe-harness/issues/N`, `/pull/N` | Weekly scan (needs the GitHub API) |
| L5 | Other private GitHub targets | blob/tree URLs into `bybren-llc/*` at a branch or SHA, commit URLs | Weekly scan (GitHub connector) |
| L6 | Atlas links, both directions | safe-harness → private Atlas repo paths / concept IDs; Atlas citations (`source_url`) → safe-harness | Weekly scan (GitHub connector) |
| L7 | External URLs | vendor docs, papers, `https://` anything not covered above | Weekly scan (HTTP) |
| L8 | Linear SAF references | `SAF-n`, `[SAF-n]`, `linear.app/cheddarfox/issue/SAF-n/...` | Weekly scan, resolved through the active map (§5.2) |

Out of scope: personal vault and NAS-private targets. They must never appear in this repo ([`../constitution/04-privacy-and-vaults.md`](../constitution/04-privacy-and-vaults.md), [`../CONTRIBUTING.md`](../CONTRIBUTING.md)). If the scan ever finds one, it is reported as a **privacy finding** to Kai and Scott directly, not as a public `link-rot` issue, and the issue body never quotes the target.

Files scanned: every tracked `*.md`, `*.yaml`, `*.yml`, and `*.csv` at `main` HEAD, plus open PR bodies and issue bodies for L3/L4/L8 references. Fenced code blocks are scanned for L4–L8 only (they often hold example URLs); examples marked as placeholders (`example`, `<...>`, RFC 5737 / RFC 2606 hosts) are skipped.

## 3. Blocking vs. non-blocking split

### 3.1 Blocking in-repo checks (pull_request + push to main)

These need only the checkout, so they can block without flake risk.

**Already live** in [`../.github/workflows/wave0-checks.yml`](../.github/workflows/wave0-checks.yml) ("Check markdown relative links"): L1 for root `*.md` and `constitution/ roles/ adapters/ templates/ prove/`.

**Already live** in [`../.github/workflows/trace-check.yml`](../.github/workflows/trace-check.yml) (warn-only until `trace/.blocking`): REQ → ARC component exists in `arch/components.yaml`.

**PROPOSED extensions** (to land as their own Low/High-tier issues; workflow edits are O2 `deploy-ci` and default to High):

| Check | Rule | Fails when |
| --- | --- | --- |
| B1 coverage | Extend the L1 scan to every tracked `*.md` (adds `trace/`, `requirements/`, `arch/`, `.github/`, any new `docs/`) | A relative target does not exist |
| B2 anchors | For L2 links into in-repo markdown, the fragment must match a heading slug (GitHub slug rules) or an explicit HTML anchor in the target. Non-REQ fragment links into `spec.md` and `intent.md` stay in B2 and can block a PR. REQ `source:` anchors on those files are excluded from B2 | Fragment not found |
| B3 REQ sources | Each REQ `source:` (`spec.md#…` / `intent.md#…`) must resolve through both checks. The B3 trace-check follow-up is authoritative for blocking; the weekly scan is advisory only. Not B2 | Anchor missing |
| B4 REQ references | Every `REQ-[A-Z]{3}-[0-9]{3}` mentioned in tracked files exists in `trace/trace-map.yaml` or `requirements/REQ-*.yaml`, in any state | Unknown REQ ID |
| B5 SAF map integrity | Once the map is frozen (§5), the active map (§5.2) must match its recorded checksum | Checksum mismatch |

B3 and B4 belong to the trace-check blocking-activation follow-up (constitution/05 "Additional validations") and should be built there, not duplicated. B1, B2 and B5 extend the Wave 0 link step. None of B1–B5 makes a network call.

### 3.2 Weekly non-blocking scan (scheduled, read-only)

Covers L4–L8 plus a re-run of L1–L3 against `main` HEAD as a cross-check. It never fails a build, never comments on PRs, and never pushes. Its only outputs are `link-rot` issues, a weekly summary, and (for clear-cut rewrites) a fix PR for human/Kai merge.

**Runner:** the Librarian, from the Grok Bot box, through the GitHub connector acting as the connected account. **No credentials, tokens, or secrets are stored in this repository** and none are required by it. A GitHub Actions version of the same scan is possible later (see Appendix B) but is not required.

## 4. Rot detection rules

### 4.1 Verdicts

Every target gets one verdict per scan:

| Verdict | Meaning |
| --- | --- |
| `ok` | Resolves (HTTP 2xx, or the API returns the object) |
| `redirect-ok` | Resolves after redirects to an equivalent target; recorded so the source can be updated |
| `moved` | Resolves, but to a different canonical location (renamed file, transferred issue/repo, permanent redirect to a different path) |
| `stale` | Resolves, but is no longer the right target (closed-as-not-planned issue cited as live work, a branch URL whose path no longer exists at HEAD but does at an old SHA) |
| `broken` | Does not resolve (404 / 410 / DNS failure / repeated 5xx not classified as `transient` / object missing) |
| `transient` | Temporary: in-scan retries exhausted after `Retry-After` / rate-limit or a similar short-lived condition (see §4.2). Not rot. Does not increment failure state and never opens a `link-rot` issue. Counted only in the weekly summary. |
| `auth-unknown` | Private target the scanner cannot see; not counted as rot (see §4.4) |
| `skipped` | Placeholder, example host, or excluded by rule |

### 4.2 HTTP (L7)

- `HEAD` first; fall back to `GET` (range `bytes=0-0`) on 403/405/501 because many sites reject `HEAD`.
- Timeout 15 s, 3 attempts per scan with backoff (2 s, 8 s, 30 s). Honour `Retry-After` on 429/503 up to 120 s. If a 429/503 has `Retry-After` greater than 120 s, the verdict for this scan is `transient`, which takes precedence over the repeated-5xx `broken` rule.
- Up to 10 redirects. `301`/`308` to a different path → `moved` (propose an update). `302`/`303`/`307` → `redirect-ok` unless the final page is a login or a generic home page (soft-404), which is `broken`.
- Soft-404 heuristic: final status 200 but the page `<title>` or first heading matches "not found / page doesn't exist", or the final URL is the site root when the source was a deep link.
- `4xx` other than 401/403/429 → `broken`. `401`/`403` → `auth-unknown` for known-private hosts (Linear, Confluence, GitHub private), else `broken` after the flake rule.
- Fragments on external URLs are not checked (too many JS-rendered pages).
- Polite: identify with a User-Agent naming the Librarian scan, at most 1 request/second per host.

### 4.3 GitHub targets (L4, L5, L6)

Resolved through the GitHub API (connector), never by unauthenticated HTTP, because the repos are private and return 404 to anonymous fetches.

| Target | Check | Verdicts |
| --- | --- | --- |
| Issue / PR `#N` in this repo | `get_issue` / `get_pull_request` | Missing → `broken`; the API returning it from a different repo → `moved` (transferred); referenced as open work but closed → `stale` only when the citing text says it is open/pending |
| Blob/tree at a **SHA** | `get_file_contents` at that ref | Missing → `broken` (SHA links are permanent, so this is serious) |
| Blob/tree at a **branch** (`main`) | `get_file_contents` at HEAD; if missing, search `list_commits` for the path to find a rename | Renamed → `moved` with the new path; deleted → `broken`; branch deleted → `broken` |
| Commit URL | `get_commit` | Missing → `broken` |
| Repo URL | `get_repository` | 404 → `auth-unknown` first (it may be an access gap), then `broken` only after confirming the org listing does not include it |
| Atlas path or concept | `get_git_tree` on the private Atlas repo `main` (recursive), plus the Atlas manifest (path from Atlas CONVENTIONS) for concept IDs | Not in tree / not registered → `broken`; registered stub only → `ok` with note |
| Atlas → safe-harness citations | Search Atlas for `safe-harness` `source_url`s and resolve each as above | Same verdicts; fixes go to Atlas as a PR that follows Atlas register-first rules |

### 4.4 Private-repo and auth handling

- A 404 from the API on a `bybren-llc/*` target is not proof of rot; it can mean the connected account lacks access. The scan records `auth-unknown`, re-checks once with a repository listing, and only then decides `broken`.
- An access gap is reported **once** to the Librarian's own chat for Scott/Kai to fix, never as a `link-rot` issue.
- Linear URLs (L8) are private. They are checked through the Linear connector (read-only) or, if it is unavailable, marked `auth-unknown`. Linear history must never be deleted (constitution/05); a Linear URL that stops resolving is `broken` and escalated to Kai.

### 4.5 Flake tolerance

- A target is **failing** in a scan only if its verdict is `broken`, `moved`, or `stale` after all in-scan retries.
- A `transient` verdict does not increment failure state and never opens a `link-rot` issue. It appears only in the weekly summary.
- A target with a failing verdict (`broken` / `moved` / `stale`) is **reported** only after it is failing in **two consecutive scans**. To avoid a one-week delay, a first-time failure triggers a **confirm re-check about 24 hours later**; that re-check counts as the second scan.
- Exception: `broken` verdicts on permanent references (SHA-pinned blobs, commits, deleted issues confirmed via API) are deterministic and may be reported after the confirm re-check even if the network was degraded.
- A reported target that passes **two consecutive scans** is marked recovered (§6.1).
- Scan state (last verdicts and failure counts) lives in the Librarian's box-local state file, not in the repo. Losing it only resets counters; it can never cause a false report.

## 5. Linear SAF map handling

### 5.1 Current state (2026-10-29)

[`linear-saf-map.csv`](linear-saf-map.csv) is **header-only** (`saf_id,linear_url,github_issue,pr,title,status`). Population is Delivery's job in migration Phase 2 and the final commit is a Phase 3 cutover action ([`../prove/wave-1/migration-plan.md`](../prove/wave-1/migration-plan.md)). Until then the map is not frozen and SAF findings are recorded as `pending-map`, never as `link-rot`.

### 5.2 Freeze and archive (after Phase 3)

**Depends on migration Phase 2 cutover.** The step that freezes and checksums the SAF map (this section, then B5) cannot run until Phase 2 has populated `trace/linear-saf-map.csv` and the Phase 3 cutover commit has landed the complete map ([`../prove/wave-1/migration-plan.md`](../prove/wave-1/migration-plan.md)).

When Delivery's cutover commit lands the complete map, the Librarian opens one PR (CODEOWNED under `trace/`) that:

1. Records `sha256` of the CSV exactly as committed, with the commit SHA it was taken at, in `trace/linear-saf-map.sha256` (format: `<sha256>  trace/linear-saf-map.csv` on line 1, `# frozen-at: <commit-sha> <ISO date>` on line 2).
2. Adds a "Frozen" note to [`schema.md`](schema.md) under "Linear SAF to GitHub Issue mapping": read-only, no edits after freeze; corrections are a new superseding file reviewed by Scott, never an in-place edit.
3. Validates every row before freezing: `saf_id` unique and `SAF-[0-9]+`; `linear_url` resolves (Linear connector); `github_issue` and `pr` exist via the API; `status` = `Archived`. Failures block the freeze PR itself, not other merges.

After freeze, `trace/linear-saf-map.csv` is immutable. In-place edits are not permitted. Corrections are a new superseding file `trace/linear-saf-map.vN.csv` (N = 1, 2, 3, …) with a matching `trace/linear-saf-map.vN.sha256`, CODEOWNED and reviewed by Scott.

**Active map (deterministic):** the `trace/linear-saf-map.vN.csv` with the highest N, if any exist; otherwise `trace/linear-saf-map.csv`. B5 and the weekly scan checksum and resolve against that file only.

### 5.3 Resolving SAF references

Each scan finds `SAF-[0-9]+` (bare, bracketed, or in a Linear URL) in this repo, in open issue/PR bodies, and in Atlas, then resolves it through the map:

| Result | Action |
| --- | --- |
| Mapped | Candidate for a rewrite PR (§5.4) |
| Not in map (after freeze) | `link-rot` issue: "Unmapped SAF reference" |
| Map row's issue/PR missing | `link-rot` issue against the map row (fix needs a superseding map, human-reviewed) |

### 5.4 Rewrite PRs

- **Never rewrite historical evidence.** Wave 0 evidence in `prove/` (bolt briefs, retro, decision packs), commit messages, and quoted reviews keep their SAF references and Linear URLs; constitution/05 says these URLs stay valid and cited. The scan only checks they resolve.
- In live docs (README, constitution, roles, templates, adapters, trace docs), the rewrite is **additive**: `SAF-3` becomes `SAF-3 (#3)` or gains the GitHub link beside the Linear one. Nothing is deleted.
- One rewrite PR per batch (per scan), never per reference; branch `<issue#>-saf-rewrite-<yyyymmdd>`; commit trailer `Refs #N`. Constitution files touched by a rewrite need Scott concur like any constitution change.
- Atlas rewrites go to the private Atlas repo as a separate PR following Atlas CONVENTIONS (latest-wins, register-first, citations carry `source_url`).

## 6. Reporting

### 6.1 One issue per broken target, with dedupe

- **Key:** normalised target (lower-case host, strip default ports, trailing slash, tracking query params, and fragment for external URLs) → `fingerprint = first 12 hex of sha256(normalised target)`.
- **Private vs public:** A target is **private** when the target repo is non-public, or the citation is an Atlas or vault citation. All other targets (public HTTP, public GitHub) are **public**. Personal-vault and NAS-private paths must never appear in an issue; they are a privacy finding to Kai and Scott only (§2) and are never quoted.
- **Title:** public targets use `[link-rot] <verdict>: <short target>`; private GitHub, Atlas, or vault-citation targets use `[link-rot] <verdict>: <target class>` (`private-github`, `atlas`, or `vault-citation`) — never the raw target. Body line 1 is always `link-rot-fingerprint: <fingerprint>`.
- **Body (public):** target, verdict, first-seen and last-seen dates (ET), HTTP/API evidence (status chain, final URL, or API response summary), every source location, and a proposed fix or `UNKNOWN`. Locators by source type:
  - In-repo file: `path:line` at the scanned safe-harness SHA (permalink to that SHA).
  - Issue or PR body: the issue or PR permalink plus the body line, or the comment permalink when the citation is in a comment.
  - Atlas citation (chat only; Atlas is private): the Atlas permalink at its commit SHA.
- **Body (private GitHub, Atlas, or vault citation):** fingerprint, target class, verdict, first-seen and last-seen dates (ET), and the source repo name only. Omit the raw target, private URLs, API details, and private citation locators; send those to Librarian · Signals' chat. Personal-vault paths never appear in an issue.
- **Dedupe:** before opening, search open issues for the fingerprint. If found, append new source locations or a verdict change as one comment (public targets) or a redacted class/date update (private targets); never open a second issue. If a closed issue matches and the target is failing again, reopen-by-reference: open a new issue that links the old one.
- **Recovery:** when a reported target passes two consecutive scans, comment "recovered" with evidence. Closing is done by the fix PR (`Fixes #N`) or a human; the Librarian does not close issues it cannot tie to a merged fix.
- **Label:** `link-rot`. It is documented in [`../.github/labels.yml`](../.github/labels.yml) but is not created through the API during Wave 1. Until a human creates it, the title prefix `[link-rot]` is the dedupe and search key.
- **Volume cap:** at most 10 new issues per scan; the rest go in the weekly summary as "queued", oldest-failing first.

### 6.2 Fix PRs

- Only for unambiguous fixes: `moved`/`redirect-ok` with a single verified new target, renamed in-repo path, mapped SAF rewrite. Anything needing judgment stays an issue.
- Branch `<issue#>-slug` off `main`; commits carry `Refs #N`; body says `Fixes #N` for each rot issue resolved and `Requirements:` per the repo convention (none until link-health REQs are placed).
- **Never self-merged.** Merge rights stay with Scott (HITL), Kai (GM, `hitl_delegate` at Low), and Release · RTE. Fixes touching `intent.md`, `spec.md`, `requirements/`, `constitution/`, or REQ IDs are human-reviewed via CODEOWNERS.

### 6.3 Weekly summary

Posted as one comment per week on a single long-lived tracking issue ("Link health — weekly summary"), and relayed to Scott in the Librarian's chat:

- scan SHA, start/end time (ET), targets checked per class (L1–L8)
- new reports, still-failing, recovered, queued, `auth-unknown`, `pending-map`, `transient`
- fix PRs opened and their state
- SAF map status (unfrozen / frozen + checksum OK)
- anything needing a human decision

## 7. Ownership

| Item | Owner |
| --- | --- |
| This spec, the weekly scan, `link-rot` issues, fix PRs, SAF freeze PR | Librarian · Signals |
| Populating `linear-saf-map.csv`, cutover | Delivery (Kai sets timing with Scott) |
| QAS of this spec and of fix PRs | Kai (COMMENT review with `QAS: APPROVE` / `QAS: CHANGES NEEDED`) |
| Merges | Scott, Kai, Release · RTE only |
| Blocking CI extensions (B1–B5) | Delivery implements; Kai decides tier at QAS (workflow edits are O2 `deploy-ci`) |
| Access gaps found by the scan | Scott (GitHub org / Cursor access) |

The Librarian runs from the Grok Bot box using the GitHub connector (and the Linear connector read-only for L8). It holds no credentials in this repository, adds no secrets to Actions, and makes no X writes.

## 8. Acceptance criteria and evidence

| # | Criterion | Evidence |
| --- | --- | --- |
| AC1 | Spec merged with QAS: APPROVE from Kai at exact head | QAS review link, merge commit SHA |
| AC2 | First weekly scan completes against `main` HEAD and posts a summary covering L1–L8 | Summary comment permalink; evidence row (below) |
| AC3 | Flake rule holds: no `link-rot` issue is opened for a target that failed only once | Scan state excerpt in the summary; zero single-failure issues |
| AC4 | Dedupe holds: a target failing in N locations produces exactly one issue | Issue search by fingerprint returns one open issue |
| AC5 | No scan run writes to `main`, comments on PRs, or fails a check run | Check runs on `main` unchanged; commit list shows only merged PRs |
| AC6 | Private targets resolve through the connector; no private target is reported as rot purely from an anonymous 404 | Summary shows `auth-unknown` count and their resolution |
| AC7 | After Phase 3, the SAF map is frozen with a recorded checksum and B5 (or an equivalent manual check until B5 lands) passes | `trace/linear-saf-map.sha256`, PR link |
| AC8 | Every SAF reference in live docs resolves through the map; historical evidence untouched | Rewrite PR diff limited to live docs |

Evidence rows follow constitution/05:

```yaml
evidence:
  - evidence_id: <grok-bot routine run id>
    runtime: grok-bot
    exact_head: <main SHA scanned>
    issue: "#<tracking issue>"
    actor: Librarian · Signals
    gate: Measure
    req_ids: []   # until link-health REQs are Placed
```

## 9. Proposed requirements (PROPOSED — not registered)

`spec.md` is human-owned and currently has no section these could cite, so no REQ ID is assigned. If Scott adds a spec anchor (for example a "Link health" section), Studio/Kai can derive real IDs. Until then:

| Proposed ID | Component | Source | Proposed text | Metric |
| --- | --- | --- | --- | --- |
| REQ-TRC-UNKNOWN-a | ARC-TRC | UNKNOWN (needs spec.md anchor) | Every in-repo relative link and anchor resolves; enforced by blocking CI with no network access. | M6 |
| REQ-TRC-UNKNOWN-b | ARC-TRC | UNKNOWN | Cross-system and external links are scanned weekly by a non-blocking job; rot is reported as one deduplicated `link-rot` issue per target after two consecutive failures. | M6 |
| REQ-TRC-UNKNOWN-c | ARC-TRC | UNKNOWN | `trace/linear-saf-map.csv` is frozen after cutover with a recorded checksum; every SAF reference resolves through it. | M3 |

## 10. Open questions

1. **Spec location.** Resolved (Kai): keep this file in `trace/` beside `schema.md` (ARC-TRC, CODEOWNED). A later move to `docs/specs/` would need the Wave 0 link scan extended to cover it.
2. **SAF map columns.** Resolved (Kai): the canonical map is the 6-column header (`saf_id,linear_url,github_issue,pr,title,status`) in `schema.md` and `linear-saf-map.csv`. `prove/wave-1/migration-plan.md` is aligned to that header in this PR.
3. **Cutover date** for the freeze: TBD per migration-plan.md.
4. **Atlas manifest path** is taken from Atlas CONVENTIONS; confirm before the first L6 run.
5. **Scan day/time.** Proposed Monday 07:00 ET with confirm re-check Tuesday 07:00 ET, so the summary is ready for the Monday roll-up. Adjust as needed.
6. **Who creates the `link-rot` label** in GitHub, and when (labels.yml says manual or approved automation after Scott concurrence). Keep the `[link-rot]` title prefix. A "create link-rot label" item is added to the labels follow-up; this PR documents the label only.

---

## Appendix A — Weekly scan procedure (Librarian routine)

**Inputs**

- `bybren-llc/safe-harness` at `main` HEAD (recursive tree + file contents via the GitHub connector), open issues and PRs
- `trace/trace-map.yaml`, `requirements/REQ-*.yaml`, `arch/components.yaml`, the active SAF map per §5.2 (+ its `.sha256` once frozen)
- the private Atlas repo at `main` HEAD (tree, manifest, files citing safe-harness)
- Box-local scan state from the previous run
- Open issues titled `[link-rot]` (for dedupe)

**Steps**

1. Record `main` HEAD SHA and start time (ET).
2. Extract links from all in-scope files and classify L1–L8; drop placeholders.
3. L1–L3: resolve against the tree at HEAD (cross-check of the blocking CI).
4. L4–L6: resolve through the GitHub connector per §4.3.
5. L7: HTTP per §4.2.
6. L8: resolve SAF references through the map (§5.3); `pending-map` while unfrozen.
7. If frozen: select the active map per §5.2, recompute its checksum, and compare.
8. Apply the flake rule (§4.5); schedule the confirm re-check for first-time failures.
9. For targets failing twice: dedupe by fingerprint, then open or update `link-rot` issues (cap 10).
10. For recovered targets: comment "recovered".
11. Batch unambiguous fixes into at most one fix PR per repo; never merge.
12. Post the weekly summary; save scan state.

**Outputs**

- `link-rot` issues (new or updated)
- At most one fix PR per repo per scan (safe-harness, private Atlas repo)
- One weekly summary comment + chat relay to Scott
- Updated box-local scan state
- Escalations: access gaps and privacy findings to Kai/Scott directly

## Appendix B — PROPOSED scheduled workflow (not added in this PR)

Adding a file under `.github/workflows/` is an O2 `deploy-ci` change (default High tier), so it is deliberately left out of this Low-tier docs PR. If wanted later, a non-blocking variant could look like this; it would use only the built-in `GITHUB_TOKEN` (read scopes), never fail a required check, and leave issue creation to the Librarian.

```yaml
name: Link Health (Scheduled, Non-blocking)
on:
  schedule:
    - cron: "0 11 * * 1"   # Mondays 11:00 UTC (07:00 ET during DST)
  workflow_dispatch:
permissions:
  contents: read
jobs:
  link-health:
    runs-on: ubuntu-latest
    continue-on-error: true
    steps:
      - uses: actions/checkout@v4
      - name: External link scan (report only)
        run: echo "PROPOSED - scanner TBD; writes a job summary, never fails"
```
