# Release flow (continuous deployment)

**Status:** PROPOSED — needs the owner concur. Non-binding; constitution/03, constitution/05 and roles/release-rte.md govern wherever this file differs.
**Path:** `release/flow.md`
**Scope:** spine (A) delivery in `bybren-llc/safe-harness`.
**Owner:** RTE (once codified) · **Reader of record:** Ops · CoS (morning roll = read of the live queue)
**Time zone:** America/New_York (all times ET)
**Grounded in (main):** `constitution/01-round-table.md`, `constitution/02-safe-ai-dlc.md`, `constitution/03-cd-and-hitl.md`, `constitution/05-evidence-and-traceability.md`, `roles/release-rte.md`, `roles/qas.md`, `roles/seceng.md`, `roles/gm-architect.md`, `roles/delivery-lead.md`, `templates/delivery-bolt-brief.md`, `prove/wave-0-retro.md`, `.github/workflows/wave0-checks.yml`

Label key used in this file:
- **[main]** — already stated on `main`; quoted or paraphrased, path given.
- **[PENDING-CODIFY]** — operating detail recorded here that is not yet restated in `constitution/` or the role card; this file stays non-binding until the owner concurs.
- **Decided — the owner 2026-10-29 · merge rule** — recorded on `main` in `constitution/03-cd-and-hitl.md` and `roles/release-rte.md` (#22 / `d88c884`, #27 / `132f890`). This file remains non-binding.
- **Decided — the GM 2026-10-29** — operational call by the GM (GM & lead ARCHitect) on 2026-10-29; recorded for this draft, does not amend `constitution/`.
- **`PROPOSED — needs Kai/Scott concur`** — not specified anywhere in the repo and not yet decided; a default suggested here.

> Precedence: if anything here conflicts with `constitution/`, the constitution wins. `constitution/03` always governs merge authority. This file does not amend policy; it operationalizes it.

---

## 1. Purpose

Each PR **ships as soon as its gates pass**. There is no release window, no batching, and no scheduled release day: one approved PR = one merge. Tag and GitHub Release publication is a separate O2 step or PR.

This is what `main` already asks for [main]:
- "SDLC target = **continuous deployment**. Mainline stays releasable. Gates prove safety without long freeze windows." (`constitution/03-cd-and-hitl.md`)
- "**Default branch** — `main` is trunk; always releasable" and "**Releases** — Tag from `main` when ready; no separate release branches" (`constitution/03-cd-and-hitl.md`)
- "**Merge queue** — Prefer queue over freeze" (`constitution/03-cd-and-hitl.md`) — the queue orders PRs one at a time; it never holds approved PRs to release together.
- Bolts exit on **evidence, not a date** (`constitution/02-safe-ai-dlc.md`).
- The constitution's freeze gate (`Freeze-the-train`, quoted verbatim from `constitution/03-cd-and-hitl.md`) is "**Exception only** (critical SecEng / prod incident)" (`constitution/03-cd-and-hitl.md`; `constitution/00-north-star.md` non-goals).

**What "deploy" means for `safe-harness`:** it is a docs/policy repo with no runtime deployment target (Wave 0 CI is a thin skeleton with "No deploy secrets", `constitution/03-cd-and-hitl.md`). Tag and GitHub Release publication is a separate O2 step or PR (`constitution/03-cd-and-hitl.md` O2 list; `roles/release-rte.md`). A merge does not publish the tag or GitHub Release.

Ops · CoS reads this file plus the live queue for the morning roll (§8). `constitution/03` is the policy; this file is the operating draft; the queue is the state.

## 2. Who owns what

| Seat | Owns (for this file's purposes) | Source |
| --- | --- | --- |
| **Release · RTE** | **Release flow** (the per-PR release check, RTE PASS/HOLD) and **release notes** (one per merge). Tag and GitHub Release publication is deferred to a future O2 PR (matching `roles/release-rte.md`). **May merge** once the GM's QAS APPROVE and its own RTE PASS are on the exact head and the owner's concur is recorded wherever the constitution requires it; never its own change; never High/O2 or `constitution/` changes without the owner's recorded concur **Decided — the owner 2026-10-29 · merge rule** | [main] `roles/release-rte.md`; release-flow + release-notes ownership is [PENDING-CODIFY] |
| **Ops · CoS** | Digests and rolls of the live queue; the Monday weekly trace/flow aggregate (Ops-owned; not defined here); the owner concurrence queue; org chart; escalations | [main] `constitution/07-roles-and-lanes.md`; `roles/ops-cos.md` |
| **Dispatcher · Board** | Tracking board; 4:30 AM ET read-only sweep. Surfaces only: never decides, posts, or merges | [main] `constitution/07-roles-and-lanes.md`; `roles/dispatcher-board.md` |
| **Delivery · Lead** | Bolt execution; fix routing; CodeRabbit triage; evidence and decision-pack authoring; sends RTE the **ready for release check** packet | [main] owns spine (A) delivery: Bolts, CD health (M6), adapters, prove D-P1 (paraphrase of `roles/delivery-lead.md` mission); packet handoff [PENDING-CODIFY] |
| **QAS** | Independence gate; "evidence sufficiency before RTE/HITL"; **never collapse** | [main] `roles/qas.md`, `constitution/02-safe-ai-dlc.md` |
| **SecEng** | Security / privacy-boundary / secrets; negative authority; **never collapse** | [main] `roles/seceng.md` |
| **the GM** | GM / lead ARCHitect; org locks; merges under the owner's HITL record (one of the three permitted mergers **Decided — the owner 2026-10-29 · merge rule**) | [main] `roles/gm-architect.md`; standing Wave 0 merge auth in `prove/wave-0-retro.md` §7 |
| **the owner** | HITL / POPM; "Final merge authority; decision packs; business-context gate"; may merge **Decided — the owner 2026-10-29 · merge rule** | [main] `constitution/01-round-table.md` |

**Who may merge** **Decided — the owner 2026-10-29 · merge rule**: only **the owner**, **the GM**, and **Release · RTE**. Every other agent — Delivery · Lead, implementers, cloud agents, specialists (the GM, SecEng, BSA-like, etc.) — **never merges**.

Escalation path [main]: Delivery · Lead escalates "via Ops · CoS or the GM — not Scott-direct unless the owner in-thread" (`roles/delivery-lead.md`).

### 2.1 "Ready for release check" packet (Delivery · Lead → RTE) [PENDING-CODIFY]

Posted on the PR (or linked GitHub Issue) only once QAS APPROVE and SecEng clearance (or a Low-tier N/A with rationale) are both on the exact head. **The RTE check fires immediately on packet arrival.**

- PR link + **head SHA** (exact-head — "Evidence and CI must refer to the exact commit/PR head under review", `constitution/03-cd-and-hitl.md`)
- GitHub Issue `#N` (source of truth; `constitution/05-evidence-and-traceability.md`)
- Risk tier (Low / Med / High) + O2 checklist
- Gate checklist (§4) with a link per row
- Decision pack link (`templates/delivery-bolt-brief.md` → "Decision pack (constitution/03 minimum)")
- Portable evidence rows (`evidence_id`, `runtime`, `exact_head`, `issue`, `actor`, `gate`, `req_ids`)
- `Requirements:` line / REQ IDs (see G5)

If the head SHA moves after the packet is sent, the packet and any RTE PASS are void; Delivery re-sends against the new head (exact-head rule).

## 3. Per-PR release flow

```
Implement → Ready for QAS
          → QAS APPROVE (the GM's independent COMMENT review, on exact head)
          → Approved for RTE ── Delivery sends ready packet ── RTE check fires immediately
          → ┌ RTE PASS (release check)                 ┐  in parallel
            └ the owner concur (HITL decision pack), where required ┘
          → Ready for HITL (gates present)
          → Merger = the GM, or Release · RTE, or Scott
            → MERGED (HITL only)           if the owner executed
            → MERGED (HITL-delegated)      if Low-tier D1 delegated HITL
            → MERGED (delegated Kai/RTE)   if the GM or Release · RTE executed
          → Tag and GitHub Release publication is a separate O2 step or PR
            (not part of this merge; see constitution/03 O2 list and roles/release-rte.md)
```

- Canonical exit-state labels are verbatim from `constitution/05-evidence-and-traceability.md`: "Ready for QAS", "Approved for RTE", "Ready for HITL", "MERGED (HITL only)", "MERGED (HITL-delegated)", "MERGED (delegated Kai/RTE)". Do not rename them (`prove/wave-0-retro.md` §4: prove docs cannot redefine constitution/05 labels). Record who executed the merge. A the GM or Release · RTE trunk merge uses **MERGED (delegated Kai/RTE)**, not **MERGED (HITL only)** (`constitution/01-round-table.md`, `constitution/05-evidence-and-traceability.md`).
- "Where required" for the owner's concur matches `constitution/03-cd-and-hitl.md`: `constitution/`, High, and O2 need the owner's recorded own-words concur. Med = one human decision pack. Low = auto when green (tests + evidence types met); human assignee still named. Low-tier delegated HITL uses the `constitution/05-evidence-and-traceability.md` D1 `hitl_delegate` record (kept as written). Two distinct humans at High is recommended guidance, not a gate.
- **Merger** [main] `constitution/03-cd-and-hitl.md` "Who may execute a trunk merge": only **the owner**, **the GM**, and **Release · RTE**. RTE merge conditions: (a) required checks green on the exact head, (b) the GM's independent QAS APPROVE on the exact head, (c) RTE's own PASS on that same head (any tier — an RTE-executed merge always needs RTE PASS on the exact head), (d) the owner's recorded own-words concur on `constitution/`, High, and O2, (e) RTE did not author the change, (f) never over a standing HOLD. A Low PR merged by the GM or the owner may use the annotated async checklist instead of a per-PR verdict. the GM "does not merge own Delivery PRs as HITL" (`roles/gm-architect.md`). Merge protection on `main` is not yet configured — branch protection is **pending Scott** (`constitution/03-cd-and-hitl.md` open question; §9).
- **High tier:** two distinct humans is recommended guidance, not a gate (`constitution/03-cd-and-hitl.md`). Many projects do not need it. the owner's recorded concur remains required. Agent ≠ human. An RTE merge never counts as a human approval.
- Tagging is not merging. Tag and GitHub Release publication is its own O2 step or PR (deploy CI / workflows → High unless downgraded in writing at QAS; `constitution/03-cd-and-hitl.md` O2 list; `roles/release-rte.md`). A tag never substitutes for any gate. RTE owns release-notes drafting now; it does not publish the tag/Release as part of this merge.
- RTE PASS runs **in parallel** with the owner's concur where concur is required (`constitution/03-cd-and-hitl.md` RTE placement; `constitution/01-round-table.md`). An RTE merge needs RTE PASS plus the required concur.

## 4. Gate checklist (RTE release check)

RTE checks each row against the **exact head SHA** in the packet. Any unchecked row = **HOLD** with the row named.

| # | Gate | PASS when | Source |
| --- | --- | --- | --- |
| G1 | **QAS verdict** | the GM's independent review exists on the exact head with "APPROVE" in the body (posted as a GitHub **COMMENT** review — author-account limitation means APPROVE/REQUEST_CHANGES states are unavailable); QAS actor ≠ implementer, distinguishable in GitHub | [main] `prove/wave-0-retro.md` §2, §4; `roles/qas.md`; `constitution/05-evidence-and-traceability.md` "Independence detectable" |
| G2 | **CodeRabbit** | Review complete on the exact head; every actionable finding triaged **Fix / Accept / Waive** with a one-line reason; Fix items verified fixed on head | CodeRabbit use [main] `prove/wave-0-retro.md` §3; Fix/Accept/Waive taxonomy [PENDING-CODIFY] |
| G3 | **CI green** | `Structure & Docs Validation` (`.github/workflows/wave0-checks.yml`, workflow "Wave 0 Sanity Checks") green on exact head | [main] `.github/workflows/wave0-checks.yml`; `constitution/03-cd-and-hitl.md` "Wave 0 CI/CD path" |
| G4 | **Decision pack + HITL record** | Decision pack has the constitution/03 minimum (GitHub Issue, exact-head SHA/PR, evidence IDs, QAS + SecEng status or Low-tier N/A with rationale, risk tier + O2 checklist, Ask). HITL record present: the owner's recorded concur, **or** (Low/D1 only) the standing `hitl_delegate` record (`docs/decisions/log.md` Relayed Wave 0 delegated-HITL merge authorization; D1 kept as written with ADR-style accountability). High/O2/`constitution/` need the owner's recorded concur; the standing Wave 0 delegation does not cover them. Open decision, see #28; unchanged here. | [main] `constitution/03-cd-and-hitl.md` "Decision pack minimum"; `constitution/05-evidence-and-traceability.md` D1; `templates/delivery-bolt-brief.md` |
| G5 | **Trace** | PR body has a `Requirements:` line listing REQ IDs, and the GitHub Issue `#N` | [main] `constitution/03-cd-and-hitl.md` PR body; `constitution/05-evidence-and-traceability.md`. REQ IDs are not yet in `spec.md` |
| G6 | **Risk tier correct** | Tier matches the O2 list (pricing, refunds, auth, deploy CI / workflows, prod secrets, privacy-boundary crosses = **High** unless Scott/Kai downgrade **in writing**); SecEng actor present if Med/High/O2 | [main] `constitution/03-cd-and-hitl.md` "O2 high-risk default"; `templates/delivery-bolt-brief.md` header |
| G7 | **Docs match structure** | `README.md` and repo structure match what docs describe (no stale paths, required paths present, relative links resolve) | Partly automated [main] by `wave0-checks.yml` (required paths + relative links); human check [PENDING-CODIFY] |
| G8 | **Exit state + evidence** | GitHub Issue/PR shows "Approved for RTE"; portable evidence rows present (`evidence_id`, `runtime`, `exact_head`, `issue`, `actor`, `gate`, `req_ids`) | [main] `constitution/05-evidence-and-traceability.md` |

RTE verdict is posted as a single PR comment: `RTE PASS @ <sha>` or `RTE HOLD @ <sha> — G<n>: <reason>`. **Decided — the GM 2026-10-29** (format).

## 5. Tier handling

Tier names are verbatim from `constitution/03-cd-and-hitl.md`: **Low**, **Med**, **High**, plus the **O2** high-risk default list. Release · RTE is **required** at Med, High, and O2. An RTE-executed merge always needs RTE PASS on the exact head (any tier). A Low PR merged by the GM or the owner may use the annotated async checklist instead of a per-PR verdict. RTE stays non-collapsible at Med+ (`constitution/03-cd-and-hitl.md` RTE placement; `constitution/02-safe-ai-dlc.md`; `roles/release-rte.md`). Every RTE check that needs a verdict **starts immediately when the packet arrives**; targets are measured packet → RTE verdict: **Low ≤5 min · Med ≤15 min · High/O2 ≤30 min** — **Decided — the GM 2026-10-29**.

| Tier | Constitution behavior [main] | RTE release check | Target (packet → verdict) |
| --- | --- | --- | --- |
| **Low** (incl. HITL-delegated) | "Auto when green (tests + evidence types met)"; human assignee still named. An annotated, non-blocking async RTE checklist is allowed when the GM or the owner merge (no per-PR verdict required). An RTE-executed Low merge still needs RTE PASS on the exact head (`roles/release-rte.md`) | **RTE PASS** if RTE executes. **Checklist-only async pass** if the GM or the owner merge and the annotated Low path is recorded | **≤5 min** when a verdict is required — Decided — the GM 2026-10-29 |
| **Med** | "One human decision pack" | **Required**, immediate | **≤15 min** — Decided — the GM 2026-10-29 |
| **High** | Two distinct humans is recommended guidance, not a gate; the owner's recorded concur required; agent ≠ human | **Required**, immediate; full independence gates (QAS + SecEng) still apply (`roles/release-rte.md` stop rules) | **≤30 min** — Decided — the GM 2026-10-29 |
| **O2** | Always High unless the GM downgrades in writing at QAS (`constitution/03-cd-and-hitl.md`) | **Required**, immediate; RTE confirms the written downgrade link if tier < High | **≤30 min** (as High) — Decided — the GM 2026-10-29 |

Targets are RTE's own clock. Human steps (the owner's concur) and the merge are tracked by the stall rule (§8), not by these targets.

**Merge by tier** [main] `constitution/03-cd-and-hitl.md` "Who may execute a trunk merge". Exit state is recorded per `constitution/05-evidence-and-traceability.md` (who executed).

| Tier | Who may merge | Precondition for an RTE merge |
| --- | --- | --- |
| **Low** (incl. HITL-delegated) | the GM, Release · RTE, or the owner | RTE-executed: the GM's QAS APPROVE + RTE PASS on exact head; RTE not the author. the GM or the owner merge at Low: annotated async checklist may replace the per-PR verdict. Exit: **MERGED (delegated Kai/RTE)** when the GM or RTE executed; **MERGED (HITL-delegated)** only with the `constitution/05` D1 `hitl_delegate` record (Low only; kept as written); **MERGED (HITL only)** when the owner executed |
| **Med** | the GM, Release · RTE, or the owner | the GM's QAS APPROVE + RTE PASS on exact head + the owner's decision-pack concur recorded; RTE not the author. Open decision, see #28; unchanged here. |
| **High** | the GM, Release · RTE, or the owner | As Med, plus **the owner's recorded concur** (required). Two distinct humans is recommended guidance, not a gate |
| **O2** | the GM, Release · RTE, or the owner | As High (O2 = High unless the GM downgrades in writing at QAS) |

Any PR touching `constitution/` needs the owner's recorded concur before an RTE merge, at any tier (`constitution/03-cd-and-hitl.md`).

RTE placement on `main` already requires the RTE check at Med, High, and O2 (`constitution/03-cd-and-hitl.md`). This file does not add a new collapse rule.

## 6. Overrides

- Only **the GM** or **the owner** may override an RTE HOLD, explicitly, with the **reason written on the PR**. [PENDING-CODIFY] — consistent with [main] "Scott/Kai downgrade in writing" (`constitution/03-cd-and-hitl.md`).
- An override never waives QAS or SecEng: both "**Never collapse**" (`constitution/02-safe-ai-dlc.md`), and SecEng's block is negative authority on that unit (`roles/seceng.md`).
- An override never substitutes for the owner's recorded concur at High. Two distinct humans is recommended guidance, not a gate.
- An override never lets a non-permitted agent merge, never lets RTE merge a change it authored, and never lets RTE merge High/O2 or `constitution/` changes without the owner's recorded concur **Decided — the owner 2026-10-29 · merge rule**.
- RTE cannot override its own HOLD by merging; a HOLD stands until cleared on a new head or overridden by the GM or the owner.
- The freeze gate (`Freeze-the-train`, verbatim from `constitution/03`) is not an RTE tool; it remains "Exception only (critical SecEng / prod incident)" (`constitution/03-cd-and-hitl.md`).

## 7. Tags and release notes (per merge)

[main] `constitution/03-cd-and-hitl.md`: "Tag from `main` when ready" and "Hotfixes — Branch from tag → fix → merge to `main` → re-tag".

[main] `roles/release-rte.md`: RTE owns release notes now. Tag format is `vYYYY.MM.DD-<shortsha>` (date in America/New_York, 7-char merge SHA). Tag and GitHub Release publication are future ownership pending their own O2 PR (deploy CI / workflows).

- **Publication is not a merge step.** Creating the tag and GitHub Release is its own O2 step or PR. It does not run as part of MERGED. This file does not set a publish SLA. Tagging/release automation is **deploy CI / workflows → O2 → High** unless the GM downgrades in writing at QAS (`constitution/03-cd-and-hitl.md`).
- **Tag scheme: `vYYYY.MM.DD-<shortsha>`** (date in America/New_York, 7-char merge SHA; e.g. `v2026.10.29-acd9f38`). No semver for this docs/process repo. [main] `roles/release-rte.md`
- **Hotfix** under CD: the fix merges to `main` like any PR and gets its own new tag ("re-tag"); tags never move or get rewritten (`constitution/03-cd-and-hitl.md`)
- **Release notes** are drafted by RTE from the decision pack, requirements, and evidence (`roles/release-rte.md`). When the O2 publication step or PR lands, each GitHub Release contains:
  - PR title + link
  - Merge SHA
  - Risk tier (+ O2 items / written downgrade link if any)
  - GitHub Issue `#N` + REQ IDs (`Requirements:` line)
  - Exit state (`MERGED (HITL only)` / `MERGED (HITL-delegated)` / `MERGED (delegated Kai/RTE)`) and `merged_by`
  - Links: QAS APPROVE review, RTE PASS comment, HITL record (Scott concur or `constitution/05` D1 `hitl_delegate`), and any override reason

## 8. Morning roll and stall rule

The morning roll is Ops · CoS reading the **live queue**, not a schedule. [PENDING-CODIFY]

The GitHub repository (Issues and PRs) is the source of truth (`constitution/05-evidence-and-traceability.md`). the issue tracker is optional archive; it is not the record.

| Queue | Shows | Source of truth |
| --- | --- | --- |
| Packets awaiting check | PRs with a ready packet and no RTE verdict on that head | PR comments |
| HOLDs | `RTE HOLD @ <sha> — G<n>` not yet cleared, and who owns the fix | PR comments + GitHub Issue |
| the owner concurrence queue | PRs requiring the owner's recorded concur (`constitution/` at any tier; High; O2) with RTE PASS waiting on the owner | Ops · CoS queue + GitHub Issue/PR |
| Awaiting merge | "Ready for HITL" with no merge | GitHub Issue/PR |
| Tag / Release publication (separate O2 work) | The future O2 step or PR that publishes the tag and GitHub Release — not a per-merge queue of this flow | GitHub Issue/PR for that O2 work |
| Stalls | Anything past the stall thresholds below | Derived |

**Stall rule — 2× the tier target, in minutes.** **Decided — the GM 2026-10-29**

Except for an annotated Low path with its §5 checklist recorded, a packet with **no RTE verdict** at 2× the tier target (measured from packet arrival) escalates **to Kai** via `SendToAgent` with `priority: true`. **Decided — the GM 2026-10-29**

| Tier | RTE target (§5) | Escalate to the GM at |
| --- | --- | --- |
| Low | ≤5 min when a verdict is required | **10 min** for paths that need an RTE verdict; no verdict timer for an annotated Low path with its checklist recorded |
| Med | ≤15 min | **30 min** |
| High / O2 | ≤30 min | **60 min** |

Every other stall point — same 2× rule, in minutes. **Decided — the GM 2026-10-29**:

| Stall point | Clock starts | Escalate at | To |
| --- | --- | --- | --- |
| HOLD unanswered (no new head and no written response) | `RTE HOLD` comment posted | 2× tier target: Low 10 / Med 30 / High·O2 60 min | the GM (`SendToAgent`, `priority: true`); Delivery · Lead copied |
| the owner concurrence pending (`constitution/` at any tier; High; O2) | RTE PASS posted | 2× tier target: Low 10 / Med 30 / High·O2 60 min | Ops · CoS surfaces in the the owner concurrence queue (Ops escalates per §2; never Scott-direct unless the owner in-thread) |
| "Ready for HITL" with no merge | Both RTE PASS and HITL record present | 2× tier target: Low 10 / Med 30 / High·O2 60 min | the GM (`SendToAgent`, `priority: true`) |

Tag and GitHub Release publication is its own O2 step or PR (`roles/release-rte.md`). It is not a per-merge stall of this flow. Track that work on its own GitHub Issue/PR when it exists.

- Every escalation is logged twice: a comment on the PR, plus one line in §10 Escalation log below. Ops · CoS rolls them up in its Monday aggregate. This is logging only and not part of the stall rule. Decided — the GM 2026-10-29
- Clocks run outside working hours; escalations still fire with `priority: true` (Wave 0 overnight stall fix, `prove/wave-0-retro.md` §4).

The weekly look back is **Ops · CoS's Monday aggregate** (Ops-owned; this file does not define it). Release flow feeds it data (cycle time, QAS/CodeRabbit rounds, stalls); it never gates or batches a release.

## 9. Dependencies not yet on `main`

Merge authority, RTE placement, HOLD override, and the High-tier two-humans guidance are on `main` in `constitution/03-cd-and-hitl.md` and `roles/release-rte.md` (#22 / `d88c884`, #27 / `132f890`). The `constitution/05-evidence-and-traceability.md` D1 `hitl_delegate` record stays as written. This file stays **PROPOSED — needs the owner concur** and non-binding.

> **Branch protection on `main` — pending the owner.** No branch protection / required-reviewer / merge-restriction settings are recorded on `main` yet (`constitution/03-cd-and-hitl.md` open question). Enforcing who may merge in GitHub waits on the owner.

Still open (not landed, or not binding, on `main`):

- Making this file binding (Scott concur on this operating draft).
- #28 (a) G4 ordering and (b) Med-tier the owner decision-pack concur — parked; unchanged here.
- `Requirements:` / REQ ID scheme in `spec.md` (the PR-body convention is in `constitution/03-cd-and-hitl.md`; no REQ IDs have landed yet).
- CodeRabbit Fix/Accept/Waive triage convention (and any `.coderabbit.yaml`).
- PR template carrying risk tier, O2 list, `Requirements:` line — landed in `.github/pull_request_template.md` (this PR).
- Tag and GitHub Release publication — its own O2 step or PR (`roles/release-rte.md`; deploy CI / workflows). Not in this PR.
- Event triggers for "packet arrived" and the 2× stall alerts to the GM via `SendToAgent` `priority: true` (Wave 0 PR-event routine was unreliable — `prove/wave-0-retro.md` §4, §6 item 1).
- Whether `wave0-checks.yml` should list `release/flow.md` as a required path (path itself decided — the GM 2026-10-29).
- `main` branch protection — pending the owner.

## 10. Escalation log

One line per escalation, newest last: `YYYY-MM-DD HH:MM ET · PR #<n> @ <shortsha> · <stall point / BLOCK> · escalated to <Kai|Scott> · <resolution>`. The matching PR comment is the record of truth; this log is the index Ops · CoS rolls up on Mondays.

_(no entries yet)_
