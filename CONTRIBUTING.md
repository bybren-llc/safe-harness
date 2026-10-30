# Contributing to safe-harness

This is a template repository. Use role names, not personal names. Binding rules live in [`constitution/`](constitution/). This guide is not a policy source.

---

## Personal boundary rule

**Never include personal-store content, story IP, or private-store facts in this repository.**

Prohibited content:

- Personal-store paths, file names, or excerpts
- Story IP (character names, plot details, worldbuilding specifics)
- Private-store facts: LAN IPs, tokens, home paths, device identifiers, hostnames, machine names
- Personal context that violates privacy boundaries ([`constitution/04-privacy-and-vaults.md`](constitution/04-privacy-and-vaults.md))

**How to reference:**

- **Cite by concept name only**: "See the personal-store entry for the authentication flow"
- **Generic examples**: "Example: a media server at 192.0.2.1 (documentation range)"
- **Never paste**: actual IPs, tokens, paths, or personal details

When referencing a personal store, private store, or private context, **describe the pattern** without exposing the instance.

**Local denylist:** copy `scripts/denylist.example` to `.denylist.local` at the repo root (gitignored), replace the fake terms, then run `python3 scripts/check-denylist.py` before opening a PR. It compares tracked files case-insensitively against the local plain terms and prints `file:line` plus a generic category only. If `.denylist.local` is missing, the script exits 0 (`no local denylist, skipped`). This is not yet wired into CI. A CI version using a repo secret is planned for v1.1. See [`scripts/README.md`](scripts/README.md).

Secrets live in vaults. The human owner (HITL/POPM) owns both the forge secrets and the vault side. Never include a secret value in this repository.

---

## Constitution-gated files (CODEOWNERS)

Contributors request review from the CODEOWNERS owners for these paths. See [`.github/CODEOWNERS`](.github/CODEOWNERS).

- `intent.md` and `intent/` — human-owned design intent
- `spec.md` — human-owned specification
- `requirements/` — agent-authored REQ-<CMP>-NNN registry (human review gate)
- `constitution/` — agent-authored governance changes (human review gate)
- `trace/` — agent-authored trace map (human review gate)
- `arch/` — component registry (human review gate)
- `AGENTS.md` and `adapters/**/AGENTS.md` — agent entry points (human review gate)
- `skills/` — skills library (human review gate)
- `.github/CODEOWNERS` and `.github/workflows/` — review-gate and CI controls

**Ownership distinction:** Humans own and accept only design (`intent.md`, `intent/`, `spec.md`). Agents own and author everything else (plan, issues, code, tests, PRs, evidence, requirements, trace, constitution changes). CODEOWNERS is a review gate, not ownership.

Merge rules: see [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md).

---

## How a change flows

1. **Issue:** Create a GitHub Issue with work type, risk tier, and O2 labels.
2. **Branch:** `<issue#>-slug` off `main` (example: `42-add-trace-check`).
3. **Implement:** Write code, tests, gather evidence. Fill [`templates/delivery-bolt-brief.md`](templates/delivery-bolt-brief.md) for a bolt.
4. **Commit:** `Refs #N` and, when REQ IDs exist, `Req: REQ-<CMP>-NNN`. Do not invent REQ IDs during bootstrap.
5. **PR:** Open from [`.github/pull_request_template.md`](.github/pull_request_template.md) with a `Requirements:` line (`REQ-<CMP>-NNN` or `N/A`).
6. **CI:** Structure & Docs Validation runs blocking. Requirements Trace Validation, skills checks, and API contract checks are warn-only (see [`README.md`](README.md#ci-checks-from-githubworkflows-on-main)).
7. **Review:** Automated review (CodeRabbit on this repo) plus independent QAS at the exact head. QAS is posted as a COMMENT review with an explicit `QAS: APPROVE` / `QAS: CHANGES NEEDED` line when the reviewer account is also the PR author (the forge does not let an author APPROVE their own PR).
8. **Decision pack:** If Medium or High tier, attach a decision pack.
9. **Merge:** See [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) and [`roles/release-rte.md`](roles/release-rte.md). This guide does not restate merge-rule text.

**Key constraint:** Working practice (not a constitution rule), described in `skills/hitl-concur-check/SKILL.md`: a consequential action needs the human owner's own words, verified. An agent relaying approval is never approval.

After `QAS: APPROVE` the implementer head is frozen: no commits, no pushes, and no title or body edits unless Delivery explicitly asks.

---

## Risk tiers

See [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) for Low / Med / High and O2 high-risk defaults. This guide does not restate them.

---

## Evidence

Portable evidence ([`constitution/05-evidence-and-traceability.md`](constitution/05-evidence-and-traceability.md)) must include:

- `evidence_id` (runtime-native unique ID)
- `runtime` (cursor / claude-code / grok-bot / local / etc.)
- `exact_head` (commit SHA or PR head)
- `issue` (GitHub Issue `#N`)
- `actor` (agent or human handle)
- `gate` (which gate this evidence satisfies)
- `req_ids` (list of REQ-<CMP>-NNN IDs, or none yet during bootstrap)

---

## Human vs. agent ownership

**Humans own and accept only design:**

- `intent.md`, `intent/`, `spec.md` — the human owner (HITL/POPM) owns and accepts; agents may propose but **never merge**

**Agents own everything else end-to-end:**

- Plan, GitHub Issues, code, tests, PRs, evidence
- Requirements registry (`requirements/`) — agents author; human-reviewed PR required (CODEOWNERS)
- Trace map (`trace/`) — agents author; human-reviewed PR required (CODEOWNERS)
- Constitution changes — agents author; human-reviewed PR required (CODEOWNERS)

**CODEOWNERS = review gate, not ownership.**

---

## Studio handoff (spine B → A)

Studio drafts `intent.md` and `spec.md` and hands them to Delivery via [`templates/studio-to-delivery-handoff.md`](templates/studio-to-delivery-handoff.md). Delivery commits them in a PR. The human owner approves the PR after the CODEOWNERS review request.

---

## Skills and local checks

Skills index: [`skills/README.md`](skills/README.md). From the repo root:

```text
python3 skills/check-frontmatter.py
python3 scripts/check-denylist.py
python3 scripts/test_check_denylist.py
```

---

## Release

See **Releases**. `CHANGELOG.md` is not on main yet (separate PR). RTE notes and tag format: [`roles/release-rte.md`](roles/release-rte.md), [`release/flow.md`](release/flow.md).

---

## Questions?

See [`constitution/README.md`](constitution/README.md) for the governance index and [`prove/README.md`](prove/README.md) for examples. Adopter-facing overview: [`README.md`](README.md).
