# Decision Pack — Delegation map and #22 follow-ups

**PR:** [#27](https://github.com/bybren-llc/safe-harness/pull/27)  
**Branch:** `cursor/delegation-map-amendment-3907`  
**Issue:** follow-up from [PR #22](https://github.com/bybren-llc/safe-harness/pull/22) (originating #10). Dedicated Decision issue not opened in this PR.  
**Status:** PROPOSED — needs Scott concur  
**Owner:** Delivery · Lead  
**QAS:** Kai (independent; not the implementer)  
**Tier:** **High** (O2 auth-adjacent — who may act on security findings, X writes, prod-risk, and secrets ownership). No downgrade.  
**Reviewed head (SecEng + CodeRabbit):** `81efe31`

---

## Executive summary

Docs-only constitution amendment. Part A writes the 2026-10-29 delegation map into `constitution/07-roles-and-lanes.md` and adds `roles/dispatcher-board.md`. Part B records Scott's #22 answers from the squash [`d88c884`](https://github.com/bybren-llc/safe-harness/commit/d88c884c14c64aa2dbc244c89290818df423924e). Release · RTE merge rights are cited by file path, not restated. `trace/linear-saf-map.csv` is not edited. `main` branch protection stays an unanswered open question.

Delivery does not merge. Kai QAS APPROVE and Scott's own-words concur are required at the exact head.

---

## Constitution / 03 minimum

| Field | Value |
| --- | --- |
| GitHub Issue | Follow-up from #22 / `d88c884` (originating #10). Dedicated Decision issue not opened in this PR. |
| Exact-head SHA / PR | SecEng + CodeRabbit reviewed `81efe31` on [#27](https://github.com/bybren-llc/safe-harness/pull/27). This commit is the follow-up recording. Later commits must be SecEng delta-confirmed. |
| Evidence IDs | #22 squash `d88c884`; CodeRabbit review 5712012854; SecEng PASS at `81efe31`; this pack |
| Requirements | No REQ-IDs in spec.md yet |
| QAS | Pending Kai independent QAS at exact head |
| SecEng | SecEng (independent, non-author): PASS at 81efe31 vs d88c884. No merge/override widen; RTE still Kai QAS + own PASS, HOLD Kai/Scott only; Dispatcher cannot decide/post/merge; no agent X writes or security fix PRs without Scott; two-humans guidance does not drop QAS/SecEng/Scott concur/prod-risk; no secrets; branch protection unanswered. |
| Risk tier + O2 | **High / O2 auth-adjacent**. No downgrade |
| Ask | approve / change-request / escalate — **concur in your own words at the exact head. Do not answer the open question (branch protection).** |

---

## Tier ruling

**High (O2 auth-adjacent).** Lane ownership, scanner-not-fixer, X-write lock, secrets ownership, and prod-risk still needing Scott are permissions-adjacent. No downgrade. Constitution amendment, so no merge without Scott's own-words concur at the exact head. Delivery does not merge.

O2 checklist:

- [ ] Pricing — N/A
- [ ] Refunds — N/A
- [x] **Auth — YES** (who may act; scanner-not-fixer; X writes; secrets ownership)
- [ ] Deploy CI / workflows — N/A (no workflow files changed)
- [ ] Prod secrets — ownership recorded; no secret values
- [ ] Privacy-boundary — N/A (no vault-path change)

---

## File:line change map

### A — Delegation map (Scott approved 2026-10-29)

| Item | File:line |
| --- | --- |
| Canonical map | `constitution/07-roles-and-lanes.md:9-21` |
| Delivery · Lead owns projects end to end | `constitution/07-roles-and-lanes.md:13`, `roles/delivery-lead.md:5`, `constitution/01-round-table.md:13` |
| Ops · CoS runs digests and rolls | `constitution/07-roles-and-lanes.md:14`, `roles/ops-cos.md:5`, `constitution/01-round-table.md:11` |
| Kai handles only High-tier or cross-lane work | `constitution/07-roles-and-lanes.md:15`, `roles/kai-gm-architect.md:5`, `constitution/01-round-table.md:10`, `constitution/02-safe-ai-dlc.md:33` |
| Librarian · Signals: signals, X research, CVE scans | `constitution/07-roles-and-lanes.md:16`, `roles/librarian-signals.md:5` |
| Scout · Story Media: tool, model, and price calls | `constitution/07-roles-and-lanes.md:17`, `roles/scout-story-media.md:5` |
| Studio · Lead covers stories | `constitution/07-roles-and-lanes.md:18`, `roles/studio-lead.md:5` |
| Release · RTE cited, not restated (#22 files) | `constitution/07-roles-and-lanes.md:23-31` |
| Dispatcher · Board (new staff role) | `constitution/07-roles-and-lanes.md:33-39`, `roles/dispatcher-board.md:1-39`, `constitution/01-round-table.md:12` |
| Scanner, not fixer | `constitution/07-roles-and-lanes.md:41-43` |
| Nothing written to X except by Scott | `constitution/07-roles-and-lanes.md:45-47` |
| Prod-risk still needs Scott | `constitution/07-roles-and-lanes.md:49-51` |

### B1 — High-tier two distinct humans is guidance, not a gate

| File:line |
| --- |
| `constitution/03-cd-and-hitl.md:43` |
| `constitution/03-cd-and-hitl.md:127` |
| `constitution/03-cd-and-hitl.md:133` |
| `constitution/06-empiricism.md:32` |
| `roles/implementer.md:10` |
| `README.md:62` |
| `README.md:81` |
| `README.md:162` |
| `CONTRIBUTING.md:58` |
| `release/flow.md:86` |
| `release/flow.md:89` |
| `release/flow.md:118` |
| `release/flow.md:129` |
| `release/flow.md:140` |
| `.github/labels.yml:60` |

### B2 — Template; adopting teams configure their environments

| File:line |
| --- |
| `constitution/03-cd-and-hitl.md:99` |
| `constitution/03-cd-and-hitl.md:135` |
| `README.md:104` |

### B3 — Linear optional; GitHub preferred; CSV frozen (not edited)

| File:line |
| --- |
| `constitution/05-evidence-and-linear.md:13` |
| `constitution/03-cd-and-hitl.md:136` |
| `constitution/README.md:16` |
| `constitution/01-round-table.md:40` |
| `README.md:270` |
| `prove/README.md:20` |

`trace/linear-saf-map.csv` was not opened or edited.

### B4 — Secrets live in vaults; Scott owns GitHub secrets and the vault side

| File:line |
| --- |
| `constitution/04-privacy-and-vaults.md:5-7` |
| `constitution/03-cd-and-hitl.md:134` |
| `CONTRIBUTING.md:26` |

No secret value is included.

### B5 — `hitl_delegate` stays as written; ADR-style accountability added

| File:line |
| --- |
| `constitution/05-evidence-and-linear.md:178-198` (record fields kept; `delegated_what` / `delegated_at` added) |
| `constitution/03-cd-and-hitl.md:137` |
| `release/flow.md:102` |
| `release/flow.md:209` |

Standing record unchanged: `delegating_actor: Scott Graham`, `delegate_actor: Kai`, `authorization_url` (existing Linear SAF-1 comment already in this repo), `scope: low`.

### B6 — `main` branch protection stays OPEN (unanswered)

| File:line |
| --- |
| `constitution/03-cd-and-hitl.md:139-141` |
| `release/flow.md:203` |
| `release/flow.md:205` |
| `release/flow.md:215` |

No answer is written.

---

## Open question (unanswered)

**`main` branch protection.** Not configured yet. Enforcing who may merge in GitHub waits on Scott. Delivery does not answer this.

---

## SecEng / evidence

SecEng (independent, non-author): PASS at 81efe31 vs d88c884. No merge/override widen; RTE still Kai QAS + own PASS, HOLD Kai/Scott only; Dispatcher cannot decide/post/merge; no agent X writes or security fix PRs without Scott; two-humans guidance does not drop QAS/SecEng/Scott concur/prod-risk; no secrets; branch protection unanswered.

Later commits must be SecEng delta-confirmed as non-widening before merge; that confirmation is recorded in the QAS review on the merge head.

---

## Open decisions (CodeRabbit; not adopted)

Findings that would change authority or gates are recorded here for Kai and Scott. Not adopted. Branch protection stays unanswered.

- **G4 ordering** (review 5712012854, `release/flow.md:102`): whether Scott's recorded concur is a merge prerequisite rather than an RTE PASS prerequisite. Constitution/03 says RTE PASS runs in parallel with Scott concur. Not adopted in this commit.
- **Med RTE merge** (review 5712012854, `release/flow.md:128`): whether Scott's decision-pack concur is required for every Med RTE merge, or only for `constitution/`, High, and O2. Not adopted in this commit.
- **Dedicated Decision issue** (review 5712012854, this pack): whether this amendment needs its own GitHub Decision issue, or #22 / originating #10 is enough. Not opened in this PR.

---

## Evidence refs

- [PR #22](https://github.com/bybren-llc/safe-harness/pull/22) — Release · RTE merge-rights amendment
- [`d88c884`](https://github.com/bybren-llc/safe-harness/commit/d88c884c14c64aa2dbc244c89290818df423924e) — #22 squash; Scott's answers in the commit message
- [PR #27](https://github.com/bybren-llc/safe-harness/pull/27) — this amendment
- CodeRabbit review [5712012854](https://github.com/bybren-llc/safe-harness/pull/27#pullrequestreview-5712012854) at `81efe31`
- CodeRabbit review [5712116836](https://github.com/bybren-llc/safe-harness/pull/27#pullrequestreview-5712116836) at `bba95a2`
- Historical ask: [`prove/rte-merge-rights/decision-pack.md`](../rte-merge-rights/decision-pack.md) (not rewritten)

---

## MERGE HOLD

**Do not merge until:**

- [ ] Kai's independent QAS APPROVE on the exact head
- [x] SecEng (independent, non-author): PASS at 81efe31 vs d88c884. No merge/override widen; RTE still Kai QAS + own PASS, HOLD Kai/Scott only; Dispatcher cannot decide/post/merge; no agent X writes or security fix PRs without Scott; two-humans guidance does not drop QAS/SecEng/Scott concur/prod-risk; no secrets; branch protection unanswered.
- [ ] SecEng delta confirmation on the merge head is recorded as non-widening relative to 81efe31.
- [ ] CodeRabbit findings on the new head triaged (5712012854 at `81efe31` and 5712116836 at `bba95a2` triaged in this commit)
- [ ] Scott's recorded own-words concur at exact head
- [ ] Wave 0 checks green
- [ ] Delivery does not merge
