# safe-harness

A template for everyday, safe AI-assisted development.

**Status:** Wave 1 adopted. This README is the adopter-facing index. It is **not** a policy source. Binding rules live in [`constitution/`](constitution/).

---

## What safe-harness is and who it's for

**Safe-harness** is an AI-native software development lifecycle (SDLC) framework. Humans set direction and keep the safety gates. Agents execute the work and produce evidence.

**Who it's for:** Small engineering teams (about 1–10 people) working with AI coding agents who need structured governance, clear ownership, and evidence-based decisions.

**What problem it solves:** Agents can write code faster than humans can review it. Without a thin harness, requirements drift, decisions go unrecorded, ownership blurs, and merges become unsafe. Safe-harness is the minimum viable governance that keeps AI-assisted development **safe, traceable, and human-controlled**.

**Who adopts it:** A team that will name a **human owner (HITL/POPM)**, a **GM / lead architect**, and the standing seats below, then configure **dev / staging / prod** for their own environments.

Useful terms (definitions only; gates and merge authority are **not** restated here):

| Term | Meaning |
| --- | --- |
| **HITL / POPM** | Human In The Loop / Product Owner · Product Manager. The human approval seat. |
| **QAS** | Quality Assurance & Acceptance. Independent of the implementer. |
| **SecEng** | Security review. Independent of the implementer. |
| **Release · RTE** | Independent final release gate under continuous deployment (no trains). |
| **O2** | Named high-risk item class. Defaults and downgrade authority are in the constitution, not here. |
| **Bolt** | A small, bounded work package: brief, implementation, tests, evidence, gates. |
| **Spine A / Spine B** | Dual workflows. A = Delivery (CD execute/deploy). B = Studio (think/plan). |
| **AI-DLC** | Agent-first counterpart to a traditional SDLC: humans own intent and design; agents own plan-to-evidence execution. |

---

## Quickstart

### 1. Adopt the template

1. Copy or generate this repository as your template.
2. Configure **dev, staging, and prod** for *your* environments. This repo itself is trunk-only (`main`). How those environments are gated is in [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) — see that file; this README grants no authority.
3. Map seats (next section). Fill [`intent.md`](intent.md) and [`spec.md`](spec.md) as the human owner when you are ready. They stay human-owned placeholders until then.
4. Keep CODEOWNERS pointed at the human owner (or the owner's review account).

### 2. File a first issue

1. Open a GitHub Issue. Prefer [`.github/ISSUE_TEMPLATE/bolt.yml`](.github/ISSUE_TEMPLATE/bolt.yml) for Delivery work.
2. Add a work-type label (`bolt`, `decision`, or `requirement`).
3. Add a risk-tier label (`tier:low`, `tier:medium`, `tier:high`).
4. If an O2 item is in scope, add the matching `o2:*` label. The O2 list itself is in [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md).
5. Name a **human assignee**. An agent may be a delegate; it is never the assignee.

Other issue forms: [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/) (`requirement.yml`, `decision.yml`). Labels: [`.github/labels.yml`](.github/labels.yml).

### 3. Run a first bolt

1. Fill [`templates/delivery-bolt-brief.md`](templates/delivery-bolt-brief.md).
2. Branch `<issue#>-slug` off `main` (example: `42-add-auth-check`).
3. Implement, test, and record portable evidence.
4. Commit with trailers `Refs #N` and, when REQ IDs exist, `Req: REQ-<CMP>-NNN`. While `spec.md` has no REQ IDs, do not invent them.
5. Open a PR from [`.github/pull_request_template.md`](.github/pull_request_template.md). Include a `Requirements:` line (`REQ-<CMP>-NNN` or `N/A` during bootstrap).
6. Wait for CI, independent review (the GM, and SecEng when required), and Release · RTE as the constitution requires.
7. Merge only under [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) and [`roles/release-rte.md`](roles/release-rte.md).

Studio → Delivery handoffs use [`templates/studio-to-delivery-handoff.md`](templates/studio-to-delivery-handoff.md).

---

## Setting up an agent team with it

Safe-harness is **runtime-neutral**. Cursor, Claude Code, Grok Bot, and local agents are all valid runtimes. Adapters in [`adapters/`](adapters/) map the same constitution into a runtime. Grok Bot is one runtime: it does not auto-load `skills/`; import each skill as its own skill on the bot (see [`skills/README.md`](skills/README.md)).

### Seats

Name every standing seat before the first bolt. On-demand specialists (Implementer, the GM, SecEng, BSA-like, Release · RTE) sit when the bolt needs them. Do not keep idle seats warm for ceremony. Cards live in [`roles/`](roles/) (index: [`roles/README.md`](roles/README.md)).

### Lanes

- **Spine A — Delivery.** CD execute/deploy. Delivery · Lead owns projects end to end.
- **Spine B — Studio.** Think/plan. Studio · Lead owns stories and the handoff into Delivery.
- **Staff.** Ops · CoS (digests, concur queue), Dispatcher · Board (surfaces only), Librarian, Scout.
- **Cross-lane / High.** GM / lead architect. High-tier or cross-lane work only.

Lane ownership is in [`constitution/07-roles-and-lanes.md`](constitution/07-roles-and-lanes.md).

### Routines

Typical Delivery loop: issue → branch → implement + evidence → PR → CI + review → QAS (and SecEng when required) → Release · RTE → merge. After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

### Relayed agent messages are never approval

Working practice (not a constitution rule), described in `skills/hitl-concur-check/SKILL.md`: a consequential action needs the human owner's own words, verified. An agent relaying approval is never approval.

### This repo's seat assignments

Role and seat names only. Adopters copy this table and replace the right-hand column.

| Seat | Assignment in this repo |
| --- | --- |
| Human owner (HITL/POPM) | Human owner |
| GM / lead architect | GM |
| QAS | GM (never the implementer of the change under review) |
| Delivery · Lead | Delivery lead |
| Studio · Lead | Studio lead |
| Ops · CoS | Ops · CoS |
| Dispatcher · Board | Dispatcher · Board |
| Librarian | Librarian |
| Scout | Scout |
| Release · RTE | Release · RTE |
| SecEng | SecEng |
| Implementer / BSA-like | On demand |

---

## Roles, tiers, O2, and merge rules

**This README does not restate merge-rule text, risk-tier behavior, or the O2 list.** If a sentence here disagrees with the constitution, the constitution wins.

| Role | Card |
| --- | --- |
| GM / lead architect | [`roles/gm-architect.md`](roles/gm-architect.md) |
| Delivery · Lead | [`roles/delivery-lead.md`](roles/delivery-lead.md) |
| Studio · Lead | [`roles/studio-lead.md`](roles/studio-lead.md) |
| Ops · CoS | [`roles/ops-cos.md`](roles/ops-cos.md) |
| Dispatcher · Board | [`roles/dispatcher-board.md`](roles/dispatcher-board.md) |
| Librarian | [`roles/librarian.md`](roles/librarian.md) |
| Scout | [`roles/scout.md`](roles/scout.md) |
| QAS | [`roles/qas.md`](roles/qas.md) |
| SecEng | [`roles/seceng.md`](roles/seceng.md) |
| Implementer | [`roles/implementer.md`](roles/implementer.md) |
| BSA-like | [`roles/bsa-like.md`](roles/bsa-like.md) |
| Release · RTE | [`roles/release-rte.md`](roles/release-rte.md) |
| Model stack (O4 tiers) | [`roles/model-stack.md`](roles/model-stack.md) |
| Human owner (HITL/POPM) | Role card planned |

**Tiers, O2, and merge rules:** [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md). **Release · RTE:** [`roles/release-rte.md`](roles/release-rte.md). Seat map: [`constitution/01-round-table.md`](constitution/01-round-table.md). The HITL-concur label in this repo is `needs-scott-concur`.

---

## Skills, adapters, CI, ADRs

| Path | Purpose |
| --- | --- |
| [`skills/`](skills/README.md) | v1.0 skills library (index of 38 skills). Canonical path `skills/<slug>/SKILL.md`. |
| [`adapters/claude-code/`](adapters/claude-code/README.md) | Claude Code adapter (docs stub). |
| [`adapters/claude-code/AGENTS.md`](adapters/claude-code/AGENTS.md) | Claude Code agent entry point. |
| [`adapters/cursor/`](adapters/cursor/README.md) | Cursor adapter (docs stub). |
| [`adapters/cursor/AGENTS.md`](adapters/cursor/AGENTS.md) | Cursor agent entry point. |
| [`AGENTS.md`](AGENTS.md) | Root agent entry point (rules by link; local checks). |
| [`docs/decisions/`](docs/decisions/) | Architecture Decision Records (canonical home; numbered ADRs and [`log.md`](docs/decisions/log.md)). |
| [`docs/decisions/log.md`](docs/decisions/log.md) | Latest-wins decision log. |
| [`constitution/`](constitution/) | Binding governance. |
| [`roles/`](roles/) | Seat cards. |
| [`templates/`](templates/) | Bolt brief and Studio→Delivery handoff. |
| [`release/flow.md`](release/flow.md) | Continuous-deployment release flow. |
| [`prove/`](prove/) | Evidence and bolt records. |
| [`arch/`](arch/) | Component registry. |
| [`requirements/`](requirements/) | REQ registry (agent-authored; human review). |
| [`trace/`](trace/) | Trace map. Frozen archive map: `trace/linear-saf-map.csv` (do not edit). |
| [`intent.md`](intent.md) / `intent/` / [`spec.md`](spec.md) | Human-owned design. |
| [`.github/CODEOWNERS`](.github/CODEOWNERS) | Review gates (`intent.md`, `intent/`, `spec.md`, `constitution/`, `requirements/`, `trace/`, `arch/`, `AGENTS.md`, `adapters/**/AGENTS.md`, `skills/`, workflows). |
| [`.github/workflows/`](.github/workflows/) | CI (see below). |

CODEOWNERS coverage (review gate, not ownership): `intent.md`, `intent/`, `spec.md`, `constitution/`, `requirements/`, `trace/`, `arch/`, `AGENTS.md`, `adapters/**/AGENTS.md`, `skills/`, `.github/CODEOWNERS`, and `.github/workflows/`.

### CI checks (from `.github/workflows` on main)

| Workflow | Job | Blocks merge? |
| --- | --- | --- |
| [`wave0-checks.yml`](.github/workflows/wave0-checks.yml) | Structure & Docs Validation (required Wave 0 paths, relative links including `trace/`, fence parity) | **Yes** |
| [`wave0-checks.yml`](.github/workflows/wave0-checks.yml) | Skills frontmatter & link scan | **Warn-only** |
| [`trace-check.yml`](.github/workflows/trace-check.yml) | Requirements Trace Validation | **Warn-only** for validation findings until `spec.md` has REQ IDs **and** `trace/.blocking` exists. The yq preflight step still fails the required check if yq is missing. |
| [`api-contract.yml`](.github/workflows/api-contract.yml) | API Contract Checks (oasdiff + optional Schemathesis) | **Warn-only** (skips when no OpenAPI spec) |
| [`doc-drift.yml`](.github/workflows/doc-drift.yml) | Doc drift | **Warn-only** |

Local checks before a PR: relative-link scan over markdown, Wave 0 required paths, `python3 skills/check-frontmatter.py`, `python3 scripts/check-denylist.py`. Flip notes: [`docs/ci/skills-checks.md`](docs/ci/skills-checks.md), [`docs/ci/api-contract.md`](docs/ci/api-contract.md), [`docs/ci/doc-drift.md`](docs/ci/doc-drift.md). Branch-protection intent: [`docs/branch-protection.md`](docs/branch-protection.md).

CodeRabbit is a required review input on this repo's trunk protection. It is not a substitute for the GM, SecEng, or human approval.

---

> **Owner-owned placeholders.** [`intent.md`](intent.md), `intent/`, and [`spec.md`](spec.md) are **human-owned**. Agents may draft; they never merge those files. Trace-check stays **warn-only** until `spec.md` has REQ IDs (and a later, code-owner-reviewed PR adds `trace/.blocking`). Do not invent REQ IDs during bootstrap.

---

## Provenance

Recorded architecture decisions: [`docs/decisions/`](docs/decisions/). Latest-wins index: [`docs/decisions/log.md`](docs/decisions/log.md).

---

## Contributing and release

- Contribute: [`CONTRIBUTING.md`](CONTRIBUTING.md).
- Release notes: see **Releases**. `CHANGELOG.md` is not on main yet (separate PR).
- Tag format and RTE ownership of notes: [`roles/release-rte.md`](roles/release-rte.md), [`release/flow.md`](release/flow.md).

Metrics M1–M6: [`constitution/00-north-star.md`](constitution/00-north-star.md). Wave evidence: [`prove/README.md`](prove/README.md), [`prove/wave-1/decision-pack.md`](prove/wave-1/decision-pack.md).
