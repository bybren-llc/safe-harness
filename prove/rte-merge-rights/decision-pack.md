# Decision Pack — Release · RTE merge-rights amendment

**PR:** #22  
**Branch:** `cursor/rte-merge-rights-amendment-b214`  
**Issue:** #10  
**Status:** PROPOSED — needs Scott concur  
**Owner:** Delivery · Lead  
**QAS:** Kai (independent; not the implementer)  
**Tier:** **High** (O2 auth — merge authority is a permissions change). Kai QAS review 5702808926 confirmed High; no downgrade.

---

## Executive summary

Amend merge authority from a flat "agents never merge" rule to a **template default by risk tier and environment**, and make Release · RTE an independent (non-collapsible) final release gate under continuous deployment.

**safe-harness** is a docs repo with only `main` (the trunk case). Authorized agents (Kai, Release · RTE) may execute a trunk merge once checks are green and an independent QAS APPROVE is on the exact head; an RTE merge needs Kai's independent QAS APPROVE. `constitution/`, High, and O2 changes still need Scott's recorded own-words concur. Delivery and cloud agents never merge. Nobody merges their own authored change. An agent merge never counts as human approval.

Authority for the environment-promotion widening is Scott's verbatim 1:54 and 1:55 PM ET quotes below. No other source is cited.

---

## Scott quotes (verbatim)

### Scope widening (2026-10-29 ET) — quote in constitution/03 and this pack

**1:54 PM ET:**

> "we're definitely gonna be able to lend me agents merge man for sure especially in development ... let's imagine if we had a dev staging and PROD we would be able to handle things and testing throughout each"

**1:55 PM ET:**

> "we're trying to get things set up so that others can take our work and be able to run with it and take that template and use it so we don't wanna put these kind of restrictions that don't really make sense when we're trying to make things go faster by managing expectations through design and specifications"

### Earlier recorded delegation (2026-10-29 ET)

**1:05 PM ET:**

> "No agents that are working for us can't merge, but you and I release train engineer can"

**1:50 PM ET:**

> "RTE can go if you approve"

---

## Constitution / 03 minimum

| Field | Value |
| --- | --- |
| GitHub Issue | #10 |
| Exact-head SHA / PR | PR #22 head on `cursor/rte-merge-rights-amendment-b214` (refresh at QAS) |
| Evidence IDs | Kai QAS review 5702808926; CodeRabbit review 5702671974 |
| Requirements | Closes #10 (no REQ-IDs in spec.md yet) |
| QAS | CHANGES NEEDED at `bc94fe87` (review 5702808926); re-QAS required at new head |
| SecEng | SecEng (independent, non-author; cloud agent bc-ff5334e0): PASS at d8923a0. Findings 1-6 from e93e388 closed (content fixes through 6994b12; this head records that SHA). No new findings. Open question (b) unanswered. |
| Risk tier + O2 | **High / O2 auth**. Merge authority = permissions. No downgrade. |
| Ask | approve / change-request / escalate — **approve the template default; answer the open questions below in your own words** |

---

## Tier ruling

**High (O2 auth).** Merge authority is a permissions change. Kai confirmed in writing at QAS review 5702808926: "Risk tier: High (O2 auth; merge authority is a permissions change), confirmed in writing. No downgrade." Constitution amendment, so no merge without Scott's own-words concur at the exact head. Release · RTE does not merge this PR (it is the subject of the change).

O2 checklist:

- [ ] Pricing — N/A
- [ ] Refunds — N/A
- [x] **Auth — YES** (merge authority = who may merge)
- [ ] Prod secrets — N/A
- [ ] Privacy-boundary — N/A

---

## Template default (this amendment)

| Environment | Who may merge / promote | Gate |
| --- | --- | --- |
| **Dev or trunk** | Authorized agents (Kai, Release · RTE) | Checks green + independent QAS APPROVE on exact head; Scott's recorded own-words concur for constitution/, High, and O2 |
| **Staging** | Automatic promotion | Tests pass |
| **Prod** | Human gate: Scott's recorded own-words concur | Prod-risk items only: migrations, money/pricing/refunds, auth/permissions, deploy CI/workflows, prod secrets, privacy-boundary (O2). Deploy freeze during demos. Prod-risk is the prod-promotion gate, not a separate trunk gate. |

The Dev/trunk Gate cell applies to template adopters as well as safe-harness.

Each repo declares its own environments and tiers. safe-harness = trunk only; `constitution/`, High, and O2 still need Scott's concur.

**Invariants:** QAS is never the implementer; nobody merges their own authored change; an agent merge never counts as human approval; Delivery and cloud agents never merge.

---

## Needs Scott concur — open questions

Do not resolve these in the amendment text. Answer in your own words on this PR.

### 1. High-tier "two distinct humans"

`constitution/03` risk-tier table and README Key concepts still say High = "Two distinct humans; agent ≠ human." Scott is the only human today.

- **(a)** Keep the rule as written and block High merges until a second human exists.
- **(b)** Scott's recorded concur + independent agent QAS (Kai) satisfies High.
- **(c)** Other (name it): for example, Scott's recorded concur is one required human and a second named human must be added later.

This pack does **not** pick (a), (b), or (c). An agent merge never counts as a human approval regardless of the answer.

### (b) RTE rights over deploy workflows and secrets — OPEN

What rights Release · RTE has over deploy CI/workflows and prod secrets. No answer is written here.

### 2. Merge scope by environment

This amendment writes the environment-promotion template default (dev/trunk, staging, prod). Confirm:

- Dev or trunk: authorized agents (Kai, Release · RTE) may merge once checks are green and independent QAS APPROVE is on the exact head.
- Staging: automatic promotion when tests pass.
- Prod: Scott's recorded own-words concur only for prod-risk / O2 items, plus a deploy freeze during demos.
- Each adopting repo declares its own environments and tiers.
- safe-harness `constitution/`, High, and O2 still need Scott's concur.

### 3. `main` branch protection

No branch protection / required-reviewer / merge-restriction settings are recorded on `main` yet. Enforcing "who may merge" in GitHub waits on Scott.

### 4. D1 `hitl_delegate`

Low-tier delegated HITL record in `constitution/05` (`hitl_delegate`, exit `MERGED (HITL-delegated)`). Still awaiting Scott on whether it stays as written alongside the new trunk template default.

---

## Out of scope

Tag automation (`vYYYY.MM.DD-<shortsha>`, one per merge) and GitHub Release publication = deploy CI = O2/High → their **own O2 PR with its own decision pack**. This PR documents the tag format only. RTE owns release notes now.

---

## Files in this amendment

- `release/flow.md` — RTE's continuous-deployment release flow (as written)
- `constitution/03-cd-and-hitl.md` — template-default merge authority; RTE placement; HOLD override; open questions
- `constitution/01-round-table.md`, `constitution/02-safe-ai-dlc.md`, `constitution/05-evidence-and-linear.md`
- `roles/release-rte.md`
- `README.md`, `CONTRIBUTING.md`
- `adapters/claude-code/README.md`, `adapters/cursor/README.md`
- `.github/labels.yml` — `exit:merged` / `exit:merged-rte`; repo label sync is a post-merge step
- this decision pack

---

## SecEng findings-to-fix map

Independent SecEng (cloud agent bc-ff5334e0), PASS at `d8923a0`. Findings 1-6 from `e93e388` closed. No new findings.

| # | Severity | Finding | Status at d8923a0 |
| --- | --- | --- | --- |
| 1 | Med | Dev/trunk Gate listed only checks + QAS | Closed |
| 2 | Med | Kai trunk-merge conditions omitted RTE at Med+ | Closed |
| 3 | Med | CODEOWNERS-gated paths other than constitution/ | Closed |
| 4 | Med | flow.md precedence carve-out, policy claim, binding Kai calls, present-tense tag/Release, G4 standing delegation, unmarked superseded lines | Closed |
| 5 | Low | README mermaid Kai edge | Closed |
| 6 | Low | Bolt-brief RTE collapse / MERGED by human | Closed |

## MERGE HOLD

**Do not merge until:**

- [x] SecEng PASS at d8923a0
- [ ] Kai's independent QAS APPROVE on the final head
- [ ] Scott's recorded own-words concur (High/O2/constitution/)
- [ ] Scott answers the open questions (or explicitly defers them)
- [ ] CodeRabbit findings on the new head triaged
- [ ] Wave 0 checks green
- [ ] RTE does not merge this PR
