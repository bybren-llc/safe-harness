# 03 — Continuous Deployment & HITL

**Status:** Adopted 2026-10-29 (Scott concur)

SDLC target = **continuous deployment**. Mainline stays releasable. Gates prove safety without long freeze windows.

**CI/CD is a first-class product of safe-harness**, not optional theater. Risk-tier CD path = core deliverable.

## Trunk-based delivery (enterprise practice)

**Trunk = `main`**. Short-lived feature branches → PR → `main`. No long-lived `release/*` Gitflow branches.

| Practice | Rule |
| --- | --- |
| **Default branch** | `main` is trunk; always releasable |
| **Feature branches** | Short-lived `<issue#>-slug` (e.g., `42-add-trace-check`); merge via PR |
| **Releases** | Tag from `main` when ready; no separate release branches |
| **Hotfixes** | Branch from tag → fix → merge to `main` → re-tag |
| **PR ownership** | Kai / Delivery manage PRs (HITL / risk-tier still applies per O2) |

No Gitflow. Trunk-based development with feature flags for incomplete work.

### GitHub conventions (Wave 1)

**Branch naming:** `<issue#>-slug` (e.g., `42-add-trace-check`) — replaces `SAF-N-slug` Linear convention

**Commit conventions:**
- Subject: Reference the issue number (e.g., `Add trace-check CI (#42)`) or natural subject with issue context
- Trailer: `Refs #N` — references GitHub Issue
- Trailer: `Req: REQ-<CMP>-NNN` — satisfies requirement (trace linkage)
- Linear conventions (SAF-N branches, [SAF-N] prefixes) remain valid until cutover; GitHub conventions take over at cutover date

**PR body:** Include `Requirements: REQ-<CMP>-NNN, REQ-<CMP>-MMM` line listing all requirements addressed.

**Labels:** See `.github/labels.yml` for work types, risk tiers, O2 items, exit states, and gate labels.

## Risk tiers

| Tier | Behavior | Human requirement |
| --- | --- | --- |
| **Low** | Auto when green (tests + evidence types met) | Agent may flow; human assignee still named |
| **Med** | One human decision pack | Approve / change-request on that unit only |
| **High** | Two humans | Two distinct humans; agent ≠ human |

## O2 high-risk default (always High unless downgraded in writing at QAS)

**Downgrade authority:** Kai may downgrade O2 items from High to Med/Low in writing at QAS, with rationale recorded in the decision pack or QAS verdict. Delivery may propose a downgrade rationale in the decision pack; Kai decides at QAS.

O2 items (default High):
- Pricing
- Refunds
- Auth
- Deploy CI / workflows
- Prod secrets
- Privacy-boundary crosses (vault routing, PII, personal→remote attempts)

## Gate types

| Gate | Behavior | Blocks whole train? |
| --- | --- | --- |
| **Decision pack** (POPM/HITL) | Async review of evidence + AC | Only that change unit |
| **Independence** (QAS / SecEng) | Separate actor; bounce / stop-the-line | That unit until cleared |
| **Business-context HITL** | Before construction on policy/secrets/risk | That Bolt’s construction start |
| **Freeze-the-train** | Org-wide halt | **Exception only** (critical SecEng / prod incident) |

Default = decision packs + independence. Freeze is rare and named.

## CD mechanics (spine A)

| Practice | Rule |
| --- | --- |
| **Exact-head** | Evidence and CI must refer to the exact commit/PR head under review |
| **Merge queue** | Prefer queue over freeze; policy input from SAW Dark Factory merge-queue docs (tmux not required) |
| **Flags** | Prefer feature flags for incomplete work over long-lived freeze branches |
| **Rollback** | First-class; rehearse path before high-risk deploys |
| **Merge authority** | Merge authority belongs only to Scott (HITL), Kai (GM, delegated authority, recorded as `hitl_delegate` at Low or written Scott concur at Med/High), and Release · RTE (under conditions below). No other agent merges, including Delivery and cloud agents. Nobody merges their own authored change. |
| **PR management** | Kai / Delivery own PR review / merge decisions (not agents) |

## Merge authority (amendment effective 2026-10-29)

Merge authority belongs only to:

1. **Scott (HITL)** — may merge any change at any risk tier
2. **Kai (GM, delegated)** — may merge with:
   - `hitl_delegate` record at Low tier, OR
   - Written Scott concurrence at Medium/High tier
3. **Release · RTE** — may merge when ALL of the following conditions are met:
   - Kai's QAS APPROVE is present at exact head
   - RTE's own RTE PASS is present at exact head
   - Scott's recorded concur is present wherever the constitution requires it (Medium/High risk tier, or any constitution/ change)

**Release · RTE NEVER merges:**
- Its own authored change (RTE does not author changes)
- High/O2 changes without Scott's recorded own-words concur at exact head
- Constitution/ changes without Scott's recorded own-words concur at exact head

**No other agent merges**, including Delivery and cloud agents. **Nobody merges their own authored change.**

### RTE placement

Release · RTE is **required** at Med, High, and O2. At Low it is an async checklist (not blocking if the path is annotated). RTE PASS runs **in parallel** with Scott's concur where concur is required.

### HOLD override

Only **Kai** or **Scott** may override an RTE HOLD. The override must be explicit, with the **reason recorded on the PR**. An override never waives QAS or SecEng, never substitutes for a required human approval, never lets a non-permitted agent merge, and never lets RTE merge a change it authored. RTE cannot override its own HOLD by merging; a HOLD stands until cleared on a new head or overridden by Kai or Scott.

### Human approval at High/O2

At High/O2, Scott's recorded own-words concur is **a** required human approval. An agent merge (by Kai or Release · RTE) never counts as a human approval.

**OPEN QUESTION for Scott — Needs Scott concur:** how the High-tier "Two distinct humans; agent ≠ human" rule (tier table above) is met when Scott is the only human today. This section does not resolve that question. Options live in the decision pack.

### Scott's recorded delegation (2026-10-29 ET)

Scott's verbatim statements establishing Release · RTE merge authority:

> **2026-10-29 1:05 PM ET:** "No agents that are working for us can't merge, but you and I release train engineer can"

> **2026-10-29 1:50 PM ET:** "RTE can go if you approve"

This amendment takes effect when it merges to main.

## Wave 0 CI/CD path

Wave 0 ships **thin CI skeleton** (`.github/workflows/wave0-checks.yml`) proving gates exist:
- Structure validation (required paths)
- Markdown sanity (link checks, syntax)
- No deploy secrets / full risk-tier automation yet

**Full risk-tier CD path = M6 first-class deliverable**, not optional. Includes:
- Risk-tier gates (Low/Med/High automation)
- Deploy pipelines (staging → prod)
- Feature flag integration
- Rollback automation
- Merge queue mechanics

Thin skeleton → full path is intentional scaffolding, not final state.

## Decision pack minimum

- Link to GitHub Issue (SoR)
- Exact-head SHA / PR
- Evidence IDs (portable — see `05-evidence-and-linear.md`)
- Requirements addressed (REQ-<CMP>-NNN list)
- QAS + SecEng status (or explicit N/A with rationale for low tier only)
- Risk tier + O2 checklist (note if Kai downgraded any O2 item)
- Ask: approve / change-request / escalate
