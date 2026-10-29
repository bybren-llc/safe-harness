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
| **PR ownership** | Kai / Delivery manage PR prep and fixes; Delivery never merges (merge execution follows merge authority below) |

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
| **Merge authority** | Template default by risk tier and environment (below). Delivery and cloud agents never merge. Nobody merges their own authored change. An agent merge never counts as human approval. |
| **PR management** | Kai / Delivery own PR prep and fixes. Delivery never merges. Merge execution follows the merge-authority template default. |

## Merge authority (template default — amendment 2026-10-29)

Merge authority is set by **risk tier and environment**, written here as a **TEMPLATE DEFAULT**. Each adopting repo declares its own environments and tiers (README or a constitution section). Authority for this widening is Scott's verbatim 1:54 and 1:55 PM ET quotes below. No other source is cited.

Scott (HITL), 2026-10-29, verbatim:

> **1:54 PM ET:** "we're definitely gonna be able to lend me agents merge man for sure especially in development ... let's imagine if we had a dev staging and PROD we would be able to handle things and testing throughout each"

> **1:55 PM ET:** "we're trying to get things set up so that others can take our work and be able to run with it and take that template and use it so we don't wanna put these kind of restrictions that don't really make sense when we're trying to make things go faster by managing expectations through design and specifications"

### Template default by environment

| Environment | Who may merge / promote | Gate |
| --- | --- | --- |
| **Dev or trunk** | Authorized agents (**Kai**, **Release · RTE**) | Required checks green + independent QAS APPROVE on the exact head; Scott's recorded own-words concur for constitution/, High, and O2 [^trunk-gate] |
| **Staging** | Automatic promotion | Tests pass |
| **Prod** | Human gate: Scott's recorded own-words concur | Prod-risk items only: migrations, money/pricing/refunds, auth/permissions, deploy CI/workflows, prod secrets, privacy-boundary (O2). Deploy freeze during demos. Prod-risk is the prod-promotion gate, not a separate trunk gate. |

[^trunk-gate]: This Gate cell applies to template adopters as well as safe-harness.

**safe-harness** is a docs repo with only `main`. It is the **trunk** case under Dev or trunk. Its `constitution/`, High, and O2 changes still need Scott's recorded own-words concur.

Scott may merge any change at any tier and environment.

### Invariants (do not collapse)

- QAS is never the implementer.
- Nobody merges their own authored change.
- An agent merge never counts as human approval.
- Delivery and cloud agents never merge.
- CODEOWNERS-gated paths other than `constitution/` (`intent.md`, `spec.md`, `requirements/`, `trace/`) stay **agents must not merge** (Scott/CODEOWNERS only), matching `constitution/05` and `CONTRIBUTING.md`.

### Who may execute a trunk merge (safe-harness)

1. **Scott (HITL)** — any change
2. **Kai (GM)** — authorized trunk agent: checks green + independent QAS APPROVE on exact head; at Med/High/O2, RTE PASS on the exact head, or a HOLD override from Kai or Scott recorded on the PR with its reason; Scott's recorded concur on `constitution/`, High, and O2
3. **Release · RTE** — authorized trunk agent: checks green + Kai's independent QAS APPROVE + its own RTE PASS on exact head; Scott's recorded concur on `constitution/`, High, and O2; never its own authored change

### RTE placement

Release · RTE is **required** at Med, High, and O2. At Low it is an async checklist (not blocking if the path is annotated). RTE PASS runs **in parallel** with Scott's concur where concur is required. An RTE merge needs RTE PASS plus the required concur.

### HOLD override

Only **Kai** or **Scott** may override an RTE HOLD. The override must be explicit, with the **reason recorded on the PR**. An override never waives QAS or SecEng, never substitutes for a required human approval, never lets a non-permitted agent merge, and never lets RTE merge a change it authored. RTE cannot override its own HOLD by merging; a HOLD stands until cleared on a new head or overridden by Kai or Scott.

### Human approval at High/O2

At High/O2, Scott's recorded own-words concur is **a** required human approval. An agent merge (by Kai or Release · RTE) never counts as a human approval.

### Needs Scott concur

Open questions (do not resolve in this amendment):

(a) **High-tier "two distinct humans"** (`constitution/03` tier table; README Key concepts): Scott is the only human today. Does High need two distinct humans when Scott is the only human, or does his recorded concur plus independent agent QAS satisfy it? Options live in the decision pack.
(b) **RTE rights over deploy workflows and secrets** — OPEN. What rights Release · RTE has over deploy CI/workflows and prod secrets. No answer is written here.
2. **`main` branch protection** — not configured yet. Enforcing who may merge in GitHub waits on Scott.
3. **D1 `hitl_delegate`** — Low-tier delegated HITL record (`constitution/05`). Still awaiting Scott on whether it stays as written.

### Scott's earlier recorded delegation (2026-10-29 ET)

> **1:05 PM ET:** "No agents that are working for us can't merge, but you and I release train engineer can"

> **1:50 PM ET:** "RTE can go if you approve"

The 1:54 / 1:55 quotes above replace the flat "agents never merge" rule with this template default. This amendment takes effect when it merges to main.

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
- QAS + SecEng status (Low: explicit N/A with rationale allowed; High/O2: never N/A). This PR: SecEng (independent, non-author; cloud agent bc-ff5334e0): PASS WITH CONDITIONS at e93e388 (Med findings 1-4, Low 5-6, no Critical or High). Conditions addressed at TIPSHA, and SecEng re-verification is pending.
- Risk tier + O2 checklist (note if Kai downgraded any O2 item)
- Ask: approve / change-request / escalate
