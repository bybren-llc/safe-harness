# Release flow (continuous deployment)

**Status:** PROPOSED — needs Scott concur. Non-binding; constitution/03, constitution/05 and roles/release-rte.md govern wherever this file differs.
**Path:** `release/flow.md`
**Scope:** spine (A) delivery in `bybren-llc/safe-harness`.
**Owner:** RTE (once codified) · **Reader of record:** Ops · CoS (morning roll = read of the live queue)
**Time zone:** America/New_York (all times ET)
**Grounded in (main):** `constitution/01-round-table.md`, `constitution/02-safe-ai-dlc.md`, `constitution/03-cd-and-hitl.md`, `constitution/05-evidence-and-linear.md`, `roles/release-rte.md`, `roles/qas.md`, `roles/seceng.md`, `roles/kai-gm-architect.md`, `roles/delivery-lead.md`, `templates/delivery-bolt-brief.md`, `prove/wave-0-retro.md`, `.github/workflows/wave0-checks.yml`

Label key used in this file:
- **[main]** — already stated on `main`; quoted or paraphrased, path given.
- **[PENDING-CODIFY]** — RTE operating model from the RTE brief / Scott's direction (2026-10-29, relayed by Kai); must land via the RTE role card + `constitution/03` amendment (with Scott concur) before it is binding.
- **Decided — Scott 2026-10-29; effective on amendment merge** (relayed via Kai, 1:50 PM ET: "RTE can go if you approve") — Scott's merge rule; shortened inline as **Decided — Scott 2026-10-29 · merge rule**. **Not in force until** the follow-up PR (RTE role card + `constitution/03` amendment) merges; until then RTE takes no gate actions and never merges, and the repo text on `main` governs (§9).
- **Decided — Kai 2026-10-29** — operational call by Kai (GM & lead ARCHitect) on 2026-10-29; recorded for this draft, does not amend `constitution/`.
- **`PROPOSED — needs Kai/Scott concur`** — not specified anywhere in the repo and not yet decided; a default suggested here.

> Precedence: if anything here conflicts with `constitution/`, the constitution wins. `constitution/03` always governs merge authority. This file does not amend policy; it operationalizes it.

**Superseded sections:** §3, §5, §7, §8 and §9 are superseded by this amendment (`constitution/03`, `constitution/05`, `roles/release-rte.md`) wherever they differ. They are not reconciled in this PR. A follow-up issue will cover HITL-only MERGED, collapsible-at-Low, tag/Release publication, and Linear as the record.

---

## 1. Purpose

Each PR **ships as soon as its gates pass**. There is no release window, no batching, and no scheduled release day: one approved PR = one merge = one release.

This is what `main` already asks for [main]:
- "SDLC target = **continuous deployment**. Mainline stays releasable. Gates prove safety without long freeze windows." (`constitution/03-cd-and-hitl.md`)
- "**Default branch** — `main` is trunk; always releasable" and "**Releases** — Tag from `main` when ready; no separate release branches" (`constitution/03-cd-and-hitl.md`)
- "**Merge queue** — Prefer queue over freeze" (`constitution/03-cd-and-hitl.md`) — the queue orders PRs one at a time; it never holds approved PRs to release together.
- Bolts exit on **evidence, not a date** (`constitution/02-safe-ai-dlc.md`).
- The constitution's freeze gate (`Freeze-the-train`, quoted verbatim from `constitution/03-cd-and-hitl.md`) is "**Exception only** (critical SecEng / prod incident)" (`constitution/03-cd-and-hitl.md`; `constitution/00-north-star.md` non-goals).

**What "deploy" means for `safe-harness`:** it is a docs/policy repo with no runtime deployment target (Wave 0 CI is a thin skeleton with "No deploy secrets", `constitution/03-cd-and-hitl.md`). **Deploy = the tag + GitHub Release** created from `main` for that merge. [main] for "tag from `main`"; the tag-as-deploy framing is [PENDING-CODIFY].

Ops · CoS reads this file plus the live queue for the morning roll (§8). `constitution/03` is the policy; this file is the operating draft; the queue is the state.

## 2. Who owns what

| Seat | Owns (for this file's purposes) | Source |
| --- | --- | --- |
| **Release · RTE** | **Release flow** (the per-PR release check, RTE PASS/HOLD) and **release notes** (one per merge). Tag and GitHub Release publication is deferred to a future O2 PR (matching `roles/release-rte.md`). **May merge** once Kai's QAS APPROVE and its own RTE PASS are on the exact head and Scott's concur is recorded wherever the constitution requires it; never its own change; never High/O2 or `constitution/` changes without Scott's recorded concur **Decided — Scott 2026-10-29 · merge rule** | [main] `roles/release-rte.md`; release-flow + release-notes ownership is [PENDING-CODIFY] |
| **Ops · CoS** | Morning roll of the live queue; the Monday weekly trace/flow aggregate (Ops-owned; not defined here); Scott concurrence queue; org chart; escalations | [main] "Escalation path; coordination" (`constitution/01-round-table.md`); the rest [PENDING-CODIFY] |
| **Delivery · Lead** | Bolt execution; fix routing; CodeRabbit triage; evidence and decision-pack authoring; sends RTE the **ready for release check** packet | [main] owns spine (A) delivery: Bolts, CD health (M6), adapters, prove D-P1 (paraphrase of `roles/delivery-lead.md` mission); packet handoff [PENDING-CODIFY] |
| **QAS** | Independence gate; "evidence sufficiency before RTE/HITL"; **never collapse** | [main] `roles/qas.md`, `constitution/02-safe-ai-dlc.md` |
| **SecEng** | Security / privacy-boundary / secrets; negative authority; **never collapse** | [main] `roles/seceng.md` |
| **Kai** | GM / lead ARCHitect; org locks; merges under Scott's HITL record (one of the three permitted mergers **Decided — Scott 2026-10-29 · merge rule**) | [main] `roles/kai-gm-architect.md`; standing Wave 0 merge auth in `prove/wave-0-retro.md` §7 |
| **Scott** | HITL / POPM; "Final merge authority; decision packs; business-context gate"; may merge **Decided — Scott 2026-10-29 · merge rule** | [main] `constitution/01-round-table.md` |

**Who may merge** **Decided — Scott 2026-10-29 · merge rule**: only **Scott**, **Kai**, and **Release · RTE**. Every other agent — Delivery · Lead, implementers, cloud agents, specialists (QAS, SecEng, BSA-like, etc.) — **never merges**.

Escalation path [main]: Delivery · Lead escalates "via Ops · CoS or Kai — not Scott-direct unless Scott in-thread" (`roles/delivery-lead.md`).

### 2.1 "Ready for release check" packet (Delivery · Lead → RTE) [PENDING-CODIFY]

Posted on the PR (or linked Linear issue) as soon as QAS has posted APPROVE on the current head. **The RTE check fires immediately on packet arrival.**

- PR link + **head SHA** (exact-head — "Evidence and CI must refer to the exact commit/PR head under review", `constitution/03-cd-and-hitl.md`)
- Linear issue key [LEGACY, non-authoritative; GitHub Issue/PR + exact head is the record, see constitution/05 and #26] (SoR; `constitution/05-evidence-and-linear.md`)
- Risk tier (Low / Med / High) + O2 checklist
- Gate checklist (§4) with a link per row
- Decision pack link (`templates/delivery-bolt-brief.md` → "Decision pack (constitution/03 minimum)")
- Portable evidence rows (`evidence_id`, `runtime`, `exact_head`, `linear_issue` [LEGACY, non-authoritative; GitHub Issue/PR + exact head is the record, see constitution/05 and #26], `actor`, `gate`)
- `Requirements:` line / REQ IDs (see G5)

If the head SHA moves after the packet is sent, the packet and any RTE PASS are void; Delivery re-sends against the new head (exact-head rule).

## 3. Per-PR release flow [PENDING-CODIFY, mapped to main exit states]

```
Implement → Ready for QAS
          → QAS APPROVE (Kai's independent COMMENT review, on exact head)
          → Approved for RTE ── Delivery sends ready packet ── RTE check fires immediately
          → ┌ RTE PASS (release check)                 ┐  in parallel
            └ Scott concur (HITL decision pack), where required ┘
          → Ready for HITL (both present)
          → Merger = Kai, or Release · RTE, or Scott → MERGED (HITL only)  [SUPERSEDED, see constitution/03 and #26]
            (RTE merge only with Kai's QAS APPROVE + its own PASS on the exact head
             + Scott's concur wherever required; never its own change;
             never High/O2 or constitution/ changes without Scott's recorded concur)
          → RTE tags the merge commit + publishes the GitHub Release (= deploy)  [SUPERSEDED, see constitution/03 and #26]
```

- Canonical exit-state labels are verbatim from `constitution/05-evidence-and-linear.md`: "Ready for QAS", "Approved for RTE (or collapsed-RTE path annotated)", "Ready for HITL", "MERGED (HITL only)". Do not rename them here (`prove/wave-0-retro.md` §4: prove docs cannot redefine constitution/05 labels).
- "Where required" for Scott's concur: Med = one human decision pack; High = two distinct humans; Low = auto when green, today under Scott's standing Wave 0 merge authorization (Linear SAF-1 comment `54d37e98`, `prove/wave-0-retro.md` §7). [main] `constitution/03-cd-and-hitl.md` risk tiers.
- **Merger** **Decided — Scott 2026-10-29 · merge rule**: Kai, Release · RTE, or Scott — no other agent. RTE merge conditions: (a) Kai's QAS APPROVE on the exact head, (b) RTE's own PASS on that same head, (c) Scott's concur recorded wherever the constitution requires it, (d) RTE did not author the change, (e) High/O2 and any `constitution/` change only with Scott's recorded concur ([main] grounding for (e): constitution updates require HITL concur — `constitution/06-empiricism.md` step 6, `roles/model-stack.md` stop rules). Merge protection on `main` is not yet configured — branch protection is **pending Scott** (§9).
- [main] "Humans merge; agents never self-merge" and RTE "never merges" (`constitution/03-cd-and-hitl.md`, `roles/release-rte.md`). Kai "does not merge own Delivery PRs as HITL" (`roles/kai-gm-architect.md`). These [main] lines still conflict with the merge rule above; the follow-up amendment must update them — see §9.
- **High tier:** "Two distinct humans; agent ≠ human" (`constitution/03-cd-and-hitl.md`) — RTE PASS does not count as one of the two. **Open question for Scott** (§9): how "two distinct humans" is met.
- Tagging is not merging: RTE creates the tag/Release on the merge commit after `MERGED (HITL only)`; a tag never substitutes for any gate. Tagging/release automation counts as **deploy CI / workflows → O2 → High** (`constitution/03-cd-and-hitl.md` O2 list). **Decided — Kai 2026-10-29**
- Note: `constitution/01-round-table.md` writes the flow sequentially (`… → RTE/collapsed PR → Ready for HITL → HITL MERGED`). Running RTE PASS **in parallel** with Scott's concur must be stated in the `constitution/03` amendment so it does not read as a deviation.

## 4. Gate checklist (RTE release check)

RTE checks each row against the **exact head SHA** in the packet. Any unchecked row = **HOLD** with the row named.

| # | Gate | PASS when | Source |
| --- | --- | --- | --- |
| G1 | **QAS verdict** | Kai's independent review exists on the exact head with "APPROVE" in the body (posted as a GitHub **COMMENT** review — author-account limitation means APPROVE/REQUEST_CHANGES states are unavailable); QAS actor ≠ implementer, detectable in Linear | [main] `prove/wave-0-retro.md` §2, §4; `roles/qas.md`; `constitution/05-evidence-and-linear.md` "Independence detectable" |
| G2 | **CodeRabbit** | Review complete on the exact head; every actionable finding triaged **Fix / Accept / Waive** with a one-line reason; Fix items verified fixed on head | CodeRabbit use [main] `prove/wave-0-retro.md` §3; Fix/Accept/Waive taxonomy [PENDING-CODIFY] |
| G3 | **CI green** | `Structure & Docs Validation` (`.github/workflows/wave0-checks.yml`, workflow "Wave 0 Sanity Checks") green on exact head | [main] `.github/workflows/wave0-checks.yml`; `constitution/03-cd-and-hitl.md` "Wave 0 CI/CD path" |
| G4 | **Decision pack + HITL record** | Decision pack has the constitution/03 minimum (Linear issue, exact-head SHA/PR, evidence IDs, QAS + SecEng status or Low-tier N/A with rationale, risk tier + O2 checklist, Ask). HITL record present: Scott's recorded concur, **or** (Low/D1 only) the standing delegation link (Linear SAF-1 comment `54d37e98`, recorded per `hitl_delegate` if D1 Option A lands). High/O2/`constitution/` need Scott's recorded concur; the SAF-1 standing delegation does not cover them | [main] `constitution/03-cd-and-hitl.md` "Decision pack minimum"; `templates/delivery-bolt-brief.md`; `hitl_delegate` is **proposed only** (`prove/wave-0-retro.md` §6–7, D1 awaiting Scott) |
| G5 | **Trace** | PR body has a `Requirements:` line listing REQ IDs, and the Linear issue key | [PENDING-CODIFY] — no `Requirements:` line or REQ ID scheme exists on `main` |
| G6 | **Risk tier correct** | Tier matches the O2 list (pricing, refunds, auth, deploy CI / workflows, prod secrets, privacy-boundary crosses = **High** unless Scott/Kai downgrade **in writing**); SecEng actor present if Med/High/O2 | [main] `constitution/03-cd-and-hitl.md` "O2 high-risk default"; `templates/delivery-bolt-brief.md` header |
| G7 | **Docs match structure** | `README.md` and repo structure match what docs describe (no stale paths, required paths present, relative links resolve) | Partly automated [main] by `wave0-checks.yml` (required paths + relative links); human check [PENDING-CODIFY] |
| G8 | **Exit state + evidence** | Linear shows "Approved for RTE"; portable evidence rows present (`evidence_id`, `runtime`, `exact_head`, `linear_issue`, `actor`, `gate`) | [main] `constitution/05-evidence-and-linear.md` |

RTE verdict is posted as a single PR comment: `RTE PASS @ <sha>` or `RTE HOLD @ <sha> — G<n>: <reason>`. **Decided — Kai 2026-10-29** (format).

## 5. Tier handling

Tier names are verbatim from `constitution/03-cd-and-hitl.md`: **Low**, **Med**, **High**, plus the **O2** high-risk default list. Every RTE check **starts immediately when the packet arrives**; targets are measured packet → RTE verdict: **Low ≤5 min · Med ≤15 min · High/O2 ≤30 min** — **Decided — Kai 2026-10-29**.

| Tier | Constitution behavior [main] | RTE release check [PENDING-CODIFY] | Target (packet → verdict) |
| --- | --- | --- | --- |
| **Low** (incl. HITL-delegated) | "Auto when green (tests + evidence types met)"; human assignee still named. RTE may collapse (`roles/release-rte.md`) — annotate collapsed path | **Checklist-only async pass, immediate.** Not blocking if the collapsed-RTE path is annotated per `constitution/05` | **≤5 min** — Decided — Kai 2026-10-29 |
| **Med** | "One human decision pack" | **Required**, immediate | **≤15 min** — Decided — Kai 2026-10-29 |
| **High** | "Two humans" — two distinct humans; agent ≠ human | **Required**, immediate; full independence gates (QAS + SecEng) still apply (`roles/release-rte.md` stop rules) | **≤30 min** — Decided — Kai 2026-10-29 |
| **O2** | Always High unless Scott/Kai downgrade in writing | **Required**, immediate; RTE confirms the written downgrade link if tier < High | **≤30 min** (as High) — Decided — Kai 2026-10-29 |

Targets are RTE's own clock. Human steps (Scott's concur, second human at High) and the merge are tracked by the stall rule (§8), not by these targets.

**Merge by tier** **Decided — Scott 2026-10-29 · merge rule**:

| Tier | Who may merge | Precondition for an RTE merge |
| --- | --- | --- |
| **Low** (incl. HITL-delegated) | Kai, Release · RTE, or Scott | Kai's QAS APPROVE + RTE PASS on exact head; HITL record = standing delegation link (Linear SAF-1 comment `54d37e98`) or `hitl_delegate` if D1 lands; RTE not the author |
| **Med** | Kai, Release · RTE, or Scott | Kai's QAS APPROVE + RTE PASS on exact head + Scott's decision-pack concur recorded; RTE not the author |
| **High** | Kai, Release · RTE, or Scott | As Med, plus **Scott's recorded concur** (required). How the two-distinct-humans gate is met is open for Scott |
| **O2** | Kai, Release · RTE, or Scott | As High (O2 = High unless Scott/Kai downgrade in writing) |

Any PR touching `constitution/` needs Scott's recorded concur before an RTE merge, at any tier **Decided — Scott 2026-10-29 · merge rule**.

Note: `constitution/01-round-table.md` and `02-safe-ai-dlc.md` make RTE collapsible "when simple / single-agent / fast iteration" without tier limits. Making the RTE check **required** at Med, High, O2 is new policy and must land in the `constitution/03` amendment.

## 6. Overrides

- Only **Kai** or **Scott** may override an RTE HOLD, explicitly, with the **reason written on the PR**. [PENDING-CODIFY] — consistent with [main] "Scott/Kai downgrade in writing" (`constitution/03-cd-and-hitl.md`).
- An override never waives QAS or SecEng: both "**Never collapse**" (`constitution/02-safe-ai-dlc.md`), and SecEng's block is negative authority on that unit (`roles/seceng.md`).
- An override never substitutes for the two-human requirement at High.
- An override never lets a non-permitted agent merge, never lets RTE merge a change it authored, and never lets RTE merge High/O2 or `constitution/` changes without Scott's recorded concur **Decided — Scott 2026-10-29 · merge rule**.
- RTE cannot override its own HOLD by merging; a HOLD stands until cleared on a new head or overridden by Kai or Scott.
- The freeze gate (`Freeze-the-train`, verbatim from `constitution/03`) is not an RTE tool; it remains "Exception only (critical SecEng / prod incident)" (`constitution/03-cd-and-hitl.md`).

## 7. Tags and release notes (per merge)

Nothing on `main` defines a tag scheme or release-notes format. [main] only: "Tag from `main` when ready" and "Hotfixes — Branch from tag → fix → merge to `main` → re-tag" (`constitution/03-cd-and-hitl.md`).

- **One tag per merge**, on the merge commit, created right after `MERGED (HITL only)`. [PENDING-CODIFY]
- **Tag scheme: `vYYYY.MM.DD-<shortsha>`** (date in America/New_York, 7-char merge SHA; e.g. `v2026.10.29-acd9f38`). No semver for this docs/process repo. **Decided — Kai 2026-10-29**
- **Hotfix** under CD: the fix merges to `main` like any PR and gets its own new tag ("re-tag"); tags never move or get rewritten. **Decided — Kai 2026-10-29**
- **Release notes live in the GitHub Release on that tag.** **Decided — Kai 2026-10-29**. Each contains:
  - PR title + link
  - Merge SHA
  - Risk tier (+ O2 items / written downgrade link if any)
  - Linear issue key + REQ IDs (`Requirements:` line)
  - Links: QAS APPROVE review, RTE PASS comment, HITL record (Scott concur or `hitl_delegate` / standing-auth link), and any override reason
- ~~RTE publishes the GitHub Release within **≤5 min of merge**. **Decided — Kai 2026-10-29**~~ [SUPERSEDED, see constitution/03 and #26]

## 8. Morning roll and stall rule

The morning roll is Ops · CoS reading the **live queue**, not a schedule. [PENDING-CODIFY]

| Queue | Shows | Source of truth |
| --- | --- | --- |
| Packets awaiting check | PRs with a ready packet and no RTE verdict on that head | PR comments |
| HOLDs | `RTE HOLD @ <sha> — G<n>` not yet cleared, and who owns the fix | PR comments + Linear |
| Scott concurrence queue | Med/High PRs with RTE PASS waiting on Scott (or a second human at High) | Ops · CoS queue + Linear |
| Awaiting merge / tag | "Ready for HITL" with no merge; merged with no tag/Release | GitHub + Linear |
| Stalls | Anything past the stall thresholds below | Derived |

**Stall rule — 2× the tier target, in minutes.** **Decided — Kai 2026-10-29**

A packet with **no RTE verdict** at 2× the tier target (measured from packet arrival) escalates **to Kai** via `SendToAgent` with `priority: true`. **Decided — Kai 2026-10-29**

| Tier | RTE target (§5) | Escalate to Kai at |
| --- | --- | --- |
| Low | ≤5 min | **10 min** |
| Med | ≤15 min | **30 min** |
| High / O2 | ≤30 min | **60 min** |

Every other stall point — same 2× rule, in minutes. **Decided — Kai 2026-10-29**:

| Stall point | Clock starts | Escalate at | To |
| --- | --- | --- | --- |
| HOLD unanswered (no new head and no written response) | `RTE HOLD` comment posted | 2× tier target: Low 10 / Med 30 / High·O2 60 min | Kai (`SendToAgent`, `priority: true`); Delivery · Lead copied |
| Scott concurrence pending (Med/High/O2) | RTE PASS posted | 2× tier target: Med 30 / High·O2 60 min | Ops · CoS surfaces in the Scott concurrence queue (Ops escalates per §2; never Scott-direct unless Scott in-thread) |
| "Ready for HITL" with no merge | Both RTE PASS and HITL record present | 2× tier target: Low 10 / Med 30 / High·O2 60 min | Kai (`SendToAgent`, `priority: true`) |
| Merged with no tag / GitHub Release | `MERGED (HITL only)` | 2× the 5-min publish target = **10 min** | Kai (`SendToAgent`, `priority: true`) |

- Every escalation is logged twice: a comment on the PR, plus one line in §10 Escalation log below. Ops · CoS rolls them up in its Monday aggregate. This is logging only and not part of the stall rule. Decided — Kai 2026-10-29
- Clocks run outside working hours; escalations still fire with `priority: true` (Wave 0 overnight stall fix, `prove/wave-0-retro.md` §4).

The weekly look back is **Ops · CoS's Monday aggregate** (Ops-owned; this file does not define it). Release flow feeds it data (cycle time, QAS/CodeRabbit rounds, stalls); it never gates or batches a release.

## 9. Dependencies not yet on `main`

> **Conflict note — merge rule vs repo text on `main`** — **Decided — Scott 2026-10-29 · merge rule**
> Scott decided the merge rule (relayed via Kai, 1:50 PM ET: "RTE can go if you approve"): only Scott, Kai and Release · RTE merge; RTE may merge per §3. The repo text on `main` still conflicts, and the follow-up amendment must update it:
> - `constitution/03-cd-and-hitl.md`: "Humans merge; agents never self-merge" (CD mechanics → HITL merge) and High = "Two distinct humans; agent ≠ human".
> - `roles/rte-collapsible.md` (replaced by `roles/release-rte.md` in the amendment PR): RTE "never merges" (mission) and "Never HITL merge" (stop rules).
> - `constitution/01-round-table.md` and `constitution/02-safe-ai-dlc.md`: RTE "never merges".
>
> **Open question for Scott — High tier "two distinct humans":** how is it met when the merger may be an agent?
> The amendment should record Scott's answer and reword the [main] lines above to match.

> **Branch protection on `main` — pending Scott.** No branch protection / required-reviewer / merge-restriction settings are recorded on `main` yet. Enforcing "only Scott, Kai, Release · RTE merge" in GitHub (and that tagging/release automation is O2/High, Decided — Kai 2026-10-29) waits on Scott.

- RTE role card (`Release · RTE`) with release-flow + release-notes scope and the merge right (Decided — Scott 2026-10-29) (today only `roles/rte-collapsible.md` (replaced by `roles/release-rte.md` in the amendment PR): collapsible PR shepherd, Light tier).
- `constitution/03-cd-and-hitl.md` amendment: per-PR release flow, RTE required at Med/High/O2, RTE in parallel with Scott concur, override rule, tag = deploy for this repo, the merge rule wording, and Scott's answer on High-tier "two distinct humans". (Targets, stall rule, tag scheme, verdict format already decided — Kai; they only need writing in.)
- `constitution/05-evidence-and-linear.md` `hitl_delegate` field (decision pack D1, awaiting Scott — `prove/wave-0-retro.md` §7).
- `Requirements:` line / REQ ID scheme.
- CodeRabbit Fix/Accept/Waive triage convention (and any `.coderabbit.yaml`).
- PR template carrying risk tier, O2 list, decision-pack link, `Requirements:` line (intent only in `adapters/cursor/README.md`).
- Release-notes template on `main`; tag scheme (decided — Kai) not yet written into `constitution/03`; any tag/Release automation workflow (O2 → High, decided — Kai).
- Ops · CoS role card (live-queue roll, concurrence queue, Monday aggregate, org chart).
- `main` branch protection — pending Scott.
- Event triggers for "packet arrived" and the 2× stall alerts to Kai via `SendToAgent` `priority: true` (Wave 0 PR-event routine was unreliable — `prove/wave-0-retro.md` §4, §6 item 1).
- Whether `wave0-checks.yml` should list `release/flow.md` as a required path (path itself decided — Kai 2026-10-29).

## 10. Escalation log

One line per escalation, newest last: `YYYY-MM-DD HH:MM ET · PR #<n> @ <shortsha> · <stall point / BLOCK> · escalated to <Kai|Scott> · <resolution>`. The matching PR comment is the record of truth; this log is the index Ops · CoS rolls up on Mondays.

_(no entries yet)_
