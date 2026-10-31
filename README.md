# safe-harness

<p align="center">
  <img src="https://img.shields.io/badge/version-v1.0.1-blue?style=flat-square" alt="Version">
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" alt="License">
  </a>
  <a href="docs/adapting.md">
    <img src="https://img.shields.io/badge/template-ready-brightgreen?style=flat-square" alt="Template Ready">
  </a>
  <a href="https://github.com/bybren-llc/safe-harness/actions/workflows/wave0-checks.yml">
    <img src="https://github.com/bybren-llc/safe-harness/actions/workflows/wave0-checks.yml/badge.svg" alt="Tests">
  </a>
  <a href="https://deepwiki.com/bybren-llc/safe-harness">
    <img src="https://img.shields.io/badge/DeepWiki-bybren--llc%2Fsafe--harness-blue?style=flat-square&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTQgMTloMTYiLz48cGF0aCBkPSJNNCAxNWg4Ii8+PHBhdGggZD0iTTQgMTFoMTIiLz48cGF0aCBkPSJNNCA3aDE2Ii8+PC9zdmc+" alt="DeepWiki">
  </a>
</p>
<p align="center">
  <a href="roles/">
    <img src="https://img.shields.io/badge/agents-12%20roles-red?style=flat-square" alt="Agents">
  </a>
  <a href="skills/">
    <img src="https://img.shields.io/badge/skills-38-purple?style=flat-square" alt="Skills">
  </a>
</p>

<p align="center">
  <strong>Supported AI Providers</strong><br>
  <a href="adapters/claude-code/">
    <img src="https://img.shields.io/badge/Claude_Code-Anthropic-orange?style=flat-square&logo=anthropic" alt="Claude Code">
  </a>
  <a href="adapters/cursor/">
    <img src="https://img.shields.io/badge/Cursor_IDE-Anysphere-00D084?style=flat-square" alt="Cursor IDE">
  </a>
</p>

A template for everyday, safe AI-assisted work: code on one spine, and stories and research on the other.

This README is the index for adopters. It is **not** a policy source. Binding rules live in [`constitution/`](constitution/). See [Adapting this template](docs/adapting.md).

---

## What safe-harness is and who it's for

**Safe-harness** is an AI-native work harness with two peer spines: **Delivery** (code: execute/deploy) and **Studio** (think/plan: stories and research). Humans set direction and keep the safety gates. Agents execute the work and produce evidence.

**Who it's for:** Small teams (about 1–10 people) working with AI agents who need structured governance, clear ownership, and evidence-based decisions. That includes engineering teams shipping code and teams producing non-code work such as stories and research.

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

## Two spines: code and story/research

Safe-harness runs on two peer spines with a shared shape. Per [`constitution/00-north-star.md`](constitution/00-north-star.md), the spines "share Round Table principles, exit states, and ownership language. They differ in gates and storage." This section is an index. The binding rules live in the linked files.

| Spine element | Spine A — Delivery (code) | Spine B — Studio (stories and research) |
| --- | --- | --- |
| Owning seat | [Delivery · Lead](roles/delivery-lead.md) | [Studio · Lead](roles/studio-lead.md) (stories), with [Scout](roles/scout.md) (story media, research) and [Librarian](roles/librarian.md) (signals) |
| Work unit / brief | [`templates/delivery-bolt-brief.md`](templates/delivery-bolt-brief.md) | [`research-brief`](skills/research-brief/SKILL.md) skill (sources plus `UNKNOWN` markers). When knowledge becomes build: [`templates/studio-to-delivery-handoff.md`](templates/studio-to-delivery-handoff.md) |
| Flow | Issue → branch → implement + evidence → PR → CI + review → QAS (and SecEng when required) → Release · RTE → merge | Brief → Evidence (sources cited, no invented links) → Gate (privacy/PII/IP class) → Concur (the owner) → Ship/verify/log ([ADR 0005](docs/decisions/0005-studio-delivery-handoff-before-spine-a-build.md)) |
| Gates | CI, independent QAS, SecEng, Release · RTE ([`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md)) | Non-code gates: sources cited, plus privacy class via [`privacy-boundary`](skills/privacy-boundary/SKILL.md) ([`constitution/04-privacy-and-vaults.md`](constitution/04-privacy-and-vaults.md)) |
| Evidence | Portable evidence rows ([`portable-evidence`](skills/portable-evidence/SKILL.md)) at the exact head | The same portable evidence rows, plus cited sources in the brief |
| Storage | The forge (this repo) | Knowledge-base concepts and private-storage pins. Story IP is never committed to the repo ([`constitution/04-privacy-and-vaults.md`](constitution/04-privacy-and-vaults.md)) |
| Human in the loop | Decision pack + the owner's concur where [`constitution/03`](constitution/03-cd-and-hitl.md) requires it | The owner's concur before ship ([ADR 0005](docs/decisions/0005-studio-delivery-handoff-before-spine-a-build.md)) |
| Exit | Canonical exit states in [`constitution/05-evidence-and-traceability.md`](constitution/05-evidence-and-traceability.md) | Ship/verify/log, or a handoff that Delivery accepts with the checklist in [`studio-handoff`](skills/studio-handoff/SKILL.md) |

**Where they meet.** When Studio work becomes something to build, Studio emits the handoff and Delivery accepts it before a bolt starts ([ADR 0005](docs/decisions/0005-studio-delivery-handoff-before-spine-a-build.md), [`studio-handoff`](skills/studio-handoff/SKILL.md)). The [BSA-like](roles/bsa-like.md) seat shapes acceptance criteria across that bridge.

**Adapting to your kind of work.** Keep the seats, gates, and evidence. Rename what flows through them. See [Adapting this template](docs/adapting.md).

---

## Quickstart

### 1. Adopt the template

1. Copy or generate this repository as your template. See [Adapting this template](docs/adapting.md).
2. Configure **dev, staging, and prod** for *your* environments. This repo itself is trunk-only (`main`). How those environments are gated is in [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) — see that file; this README grants no authority.
3. Map seats (next section). Fill [`intent.md`](intent.md) and [`spec.md`](spec.md) as the human owner when you are ready. They stay human-owned placeholders until then.
4. Keep CODEOWNERS pointed at the human owner (or the owner's review account).
5. Keep `LICENSE` and `NOTICE`. MIT requires the original copyright and permission notice to stay with copies. Add your own copyright line under ours for your changes; do not replace ours.

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
6. Wait for CI, independent review (QAS, and SecEng when required), and Release · RTE as the constitution requires.
7. Merge only under [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) and [`roles/release-rte.md`](roles/release-rte.md).

Studio → Delivery handoffs use [`templates/studio-to-delivery-handoff.md`](templates/studio-to-delivery-handoff.md).

Non-code work (stories and research) starts on spine B with Studio · Lead. See [Two spines: code and story/research](#two-spines-code-and-storyresearch).

---

## Setting up an agent team with it

Safe-harness is **runtime-neutral**. Cursor, Claude Code, and other agents are valid runtimes. Adapters in [`adapters/`](adapters/) map the same constitution into a runtime. A runtime that does not auto-load `skills/` must import each skill as its own skill (see [`skills/README.md`](skills/README.md)).

### Seats

Name every standing seat before the first bolt. On-demand specialists (Implementer, QAS, SecEng, BSA-like, Release · RTE) sit when the bolt needs them. Do not keep idle seats warm for ceremony. Cards live in [`roles/`](roles/) (index: [`roles/README.md`](roles/README.md)).

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

**Tiers, O2, and merge rules:** [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md). **Release · RTE:** [`roles/release-rte.md`](roles/release-rte.md). Seat map: [`constitution/01-round-table.md`](constitution/01-round-table.md). The HITL-concur label in this repo is `needs-owner-concur`.

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
| [`docs/adapting.md`](docs/adapting.md) | Adapting this template. |
| [`docs/decisions/`](docs/decisions/) | Architecture Decision Records (canonical home; numbered ADRs and [`log.md`](docs/decisions/log.md)). |
| [`docs/decisions/log.md`](docs/decisions/log.md) | Latest-wins decision log. |
| [`constitution/`](constitution/) | Binding governance. |
| [`roles/`](roles/) | Seat cards. |
| [`templates/`](templates/) | Bolt brief and Studio→Delivery handoff. |
| [`release/flow.md`](release/flow.md) | Continuous-deployment release flow. |
| [`prove/`](prove/) | Evidence and bolt records. |
| [`arch/`](arch/) | Component registry. |
| [`requirements/`](requirements/) | REQ registry (agent-authored; human review). |
| [`trace/`](trace/) | Trace map and schema. |
| [`intent.md`](intent.md) / `intent/` / [`spec.md`](spec.md) | Human-owned design. |
| [`.github/CODEOWNERS`](.github/CODEOWNERS) | Review gates (`intent.md`, `intent/`, `spec.md`, `constitution/`, `requirements/`, `trace/`, `arch/`, `AGENTS.md`, `adapters/**/AGENTS.md`, `skills/`, workflows). |
| [`.github/workflows/`](.github/workflows/) | CI (see below). |

CODEOWNERS coverage (review gate, not ownership): `intent.md`, `intent/`, `spec.md`, `constitution/`, `requirements/`, `trace/`, `arch/`, `AGENTS.md`, `adapters/**/AGENTS.md`, `skills/`, `.github/CODEOWNERS`, and `.github/workflows/`.

### CI checks (from `.github/workflows` on main)

| Workflow | Job | Blocks merge? |
| --- | --- | --- |
| [`wave0-checks.yml`](.github/workflows/wave0-checks.yml) | Structure & Docs Validation (required paths, relative links including `trace/`, fence parity) | **Yes** |
| [`wave0-checks.yml`](.github/workflows/wave0-checks.yml) | Skills frontmatter & link scan | **Warn-only** |
| [`trace-check.yml`](.github/workflows/trace-check.yml) | Requirements Trace Validation | **Warn-only** for validation findings until `spec.md` has REQ IDs **and** `trace/.blocking` exists. The yq preflight step still fails the required check if yq is missing. |
| [`api-contract.yml`](.github/workflows/api-contract.yml) | API Contract Checks (oasdiff + optional Schemathesis) | **Warn-only** (skips when no OpenAPI spec) |
| [`doc-drift.yml`](.github/workflows/doc-drift.yml) | Doc drift | **Warn-only** |

Local checks before a PR: relative-link scan over markdown, required paths, `python3 skills/check-frontmatter.py`, `python3 scripts/check-denylist.py`. Flip notes: [`docs/ci/skills-checks.md`](docs/ci/skills-checks.md), [`docs/ci/api-contract.md`](docs/ci/api-contract.md), [`docs/ci/doc-drift.md`](docs/ci/doc-drift.md). Branch-protection intent: [`docs/branch-protection.md`](docs/branch-protection.md).

CodeRabbit is an optional review input. When it runs, its findings are triaged. It is not a required check.

---

> **Owner-owned placeholders.** [`intent.md`](intent.md), `intent/`, and [`spec.md`](spec.md) are **human-owned**. Agents may draft; they never merge those files. Trace-check stays **warn-only** until `spec.md` has REQ IDs (and a later, code-owner-reviewed PR adds `trace/.blocking`). Do not invent REQ IDs during bootstrap.

---

## Provenance

Recorded architecture decisions: [`docs/decisions/`](docs/decisions/). Latest-wins index: [`docs/decisions/log.md`](docs/decisions/log.md).

---

## License

MIT License. See [LICENSE](LICENSE) for details.

## Attribution

safe-harness is maintained by [ByBren, LLC](https://github.com/bybren-llc). It succeeds [SAW (SAFe Agentic Workflow)](https://github.com/bybren-llc/safe-agentic-workflow).

If you build on this harness, please keep [NOTICE](NOTICE) and credit "Built with safe-harness by ByBren, LLC". Third-party notices (AI-DLC, MADR, CI tools, SAFe® trademark) are in [NOTICE](NOTICE).

---

## Contributing and release

- Contribute: [`CONTRIBUTING.md`](CONTRIBUTING.md).
- Release notes: [`CHANGELOG.md`](CHANGELOG.md).
- Tag format and RTE ownership of notes: [`roles/release-rte.md`](roles/release-rte.md), [`release/flow.md`](release/flow.md).

Metrics M1–M6: [`constitution/00-north-star.md`](constitution/00-north-star.md). Evidence and bolt records: [`prove/README.md`](prove/README.md).
