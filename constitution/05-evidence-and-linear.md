# 05 — Evidence & Source of Truth

**Status:** Adopted 2026-10-29 (Scott concur)  
**Supersedes:** Wave 0 version (Linear as SoR)  
**Effective:** 2026-10-29

---

## AMENDMENT: Repository as sole source of truth

**Decision (2026-10-29):** The GitHub repository is the **sole source of truth** for intent, spec, plan, requirements, trace map, review findings, and evidence. Work tracking moves to GitHub Issues. Linear archive remains read-only.

**Linear is optional.** The preferred path is design, specs, and PRDs in GitHub. Adopting teams may keep Linear; this template does not require it. The archive map `trace/linear-saf-map.csv` stays frozen.

**Evidence canonical in repo:** Evidence for safe-harness is canonical in this repository. Vaults (personal, NAS) and Atlas cite evidence by link without duplicating it. Never copy repo evidence into private vaults.

### Human vs. agent ownership split

**Humans own and accept only design (intent + spec):**
- `intent.md` — Scott owns and accepts; agents may propose edits but **never merge**
- `spec.md` — Scott owns and accepts; agents may propose edits but **never merge**

**Agents own everything else end-to-end:**
- Plan, GitHub Issues, code, tests, PRs, evidence
- **Requirements registry** (`requirements/`) — agents author; human-reviewed PR required
- **Trace map** (`trace/`) — agents author; human-reviewed PR required
- **Constitution changes** — agents author; human-reviewed PR required

**CODEOWNERS review gates** (not ownership):

`.github/CODEOWNERS` requires @cheddarfox review for:
- `intent.md`, `intent/`, `spec.md` (human-owned design)
- `requirements/` (agent-authored, any REQ-ID add/change/removal needs human review)
- `constitution/` (agent-authored constitution changes need human review)
- `trace/` (agent-authored trace map needs human review)

Agents may open PRs touching these files but must not merge them, except Kai or Release · RTE may merge `constitution/` changes only under the conditions in `constitution/03-cd-and-hitl.md`, including Scott's recorded own-words concurrence at exact head. Use the `needs-scott-concur` label on PRs awaiting Scott's review.

**Distinction:** Humans own design (accept/reject intent and spec content). Agents own execution (author requirements, trace, constitution changes, code, tests), but CODEOWNERS enforces human review gates before merge.

### Studio's write path

Studio drafts `intent.md` and `spec.md` and hands them to Delivery. Delivery commits them in a PR. Scott approves via CODEOWNERS before merge.

### GitHub Issues for work tracking

Work items use GitHub Issues with structured templates:
- **Bolt / Unit of Work** (spine A: Delivery)
- **Requirement** (REQ-<CMP>-NNN state changes)
- **Decision** (Scott/Kai concurrence requests)

Branch naming: `<issue#>-slug` (e.g., `42-add-trace-check`)  
Commit trailers: `Refs #N` (references issue) + `Req: REQ-<CMP>-NNN` (satisfies requirement)  
PR body: `Requirements: REQ-<CMP>-NNN, REQ-<CMP>-MMM` line

Labels (documented in `.github/labels.yml`):
- Work types: `bolt`, `requirement`, `decision`, `needs-concur`, `needs-scott-concur`
- Risk tiers: `tier:low`, `tier:medium`, `tier:high`
- O2 items: `o2:pricing`, `o2:refunds`, `o2:auth`, `o2:deploy-ci`, `o2:secrets`, `o2:privacy`
- Exit states: `exit:qas`, `exit:rte`, `exit:hitl`, `exit:merged`, `exit:merged-delegated`, `exit:merged-rte`
- Gates: `gate:rnd`, `gate:plan`, `gate:concur`, `gate:execute`, `gate:measure`

**GitHub milestones:** One milestone per wave (e.g., "Wave 1", "Wave 2"). Document milestones; create them manually or via approved automation.

---

## Requirements = definition of success

**Requirements** are REQ-<CMP>-NNN IDs derived from `spec.md`. Each requirement has:
- `source`: spec.md#anchor (or intent.md#anchor)
- `exit_criterion`: Concrete pass/fail condition
- `metric`: M1–M6 tie (from constitution/00) or named metric

See `requirements/README.md` for trace states (Placed / Deferred / Dropped / Missing) and format.

**Trace map path:** `trace/trace-map.yaml` (fixed). Schema: `trace/schema.md`.

### Deferred and Dropped requirements

**Deferred** requirements must include:
- `rationale`: Why deferred and conditions for revisiting
- `decided_by`: Decision owner (Scott, Kai, or "Scott + Kai")
- `decided_at`: ISO 8601 date (YYYY-MM-DD)
- `defer_to`: Target date or milestone reference (e.g., "2026-11-15" or "Wave 2")

**Dropped** requirements must include:
- `rationale`: Why permanently removed
- `decided_by`: Decision owner
- `decided_at`: ISO 8601 date

**Special rule:** Dropping a REQ whose `source` is `intent.md#*` requires Scott's sign-off. Record as `decided_by: Scott Graham` plus a link in `rationale`.

**Deferred dates:** `defer_to` and `decided_at` live in the trace map entry only, never in GitHub Issue fields.

---

## Evidence before HITL

Evidence lands before Ready for Review / HITL decision pack. Preserve SAW spirit:
- Evidence over assertion
- Bolt exits on evidence, not a date
- Four always-on evidence types + conditional (UI / RLS / perf / `#EXPORT_CRITICAL`) — map per Bolt

## Portable evidence IDs (updated schema)

Do not rely on Claude-only session IDs. Each runtime posts a portable ID:

| Field | Rule |
| --- | --- |
| `evidence_id` | Runtime-native unique ID (session, run, cloud agent id, local run uuid) |
| `runtime` | `claude-code` \| `cursor` \| `codex` \| `local` \| `grok-bot` \| … |
| `exact_head` | Commit SHA or PR head |
| `issue` | GitHub Issue reference `#N` (replaces `linear_issue`) |
| `actor` | Agent id or human handle |
| `gate` | Which gate this evidence satisfies |
| `req_ids` | List of REQ-<CMP>-NNN IDs this evidence addresses |

**Breaking change from Wave 0:** `linear_issue` → `issue` (GitHub Issue reference). Evidence rows must include `req_ids` list.

---

## Trace enforcement

The `.github/workflows/trace-check.yml` CI workflow validates:
1. Every **Placed** requirement has at least one evidence row with its ID in `req_ids`
2. No requirements in state **Missing** (CI fails)
3. **Deferred** and **Dropped** requirements have: `rationale`, `decided_by`, `decided_at`
4. **Deferred** requirements have: `defer_to`
5. Requirements with `source: intent.md#*` that are Dropped must have `decided_by: Scott Graham` (exactly)
6. Evidence rows must have required fields: `evidence_id`, `exact_head`, `actor`, `gate`

**Blocking activation gate:** Trace-check becomes blocking only after the first `spec.md` with REQ IDs lands **AND** a code-owner-reviewed PR adds the marker file `trace/.blocking`. The follow-up validations PR (first GitHub Issue in migration Phase 1) adds the marker after implementing the additional validations below. Until both conditions are met, trace-check remains warn-only.

**Additional validations (required before blocking activation; see migration Phase 1):**
- Spec REQ ↔ trace-map reconciliation
- Empty trace map in blocking mode enforcement
- `requirements/*.yaml` registry validation
- Issue + PR `Requirements:` linkage enforcement
- Evidence rows from bolt briefs/decision packs
- Source-anchor validation (intent.md or spec.md anchors exist)

### CI scope

**Blocking trace-check** (`.github/workflows/trace-check.yml`) covers repo-internal gaps only:
- REQ with no ARC component (from `arch/components.yaml`)
- REQ with no GitHub Issue reference
- PR with no REQ linkage (when required)
- Missing or unevidenced REQs
- Deferred/Dropped missing required fields

**Non-blocking scheduled check** (separate workflow, read-only):
- Cross-system link validation (Linear archive, external URLs)
- spec.md anchor existence validation
- Evidence URL reachability

External link checks remain non-blocking to avoid failing builds on transient network issues.

---

## Independence detectable

QAS and SecEng actors must be distinguishable from implementer in GitHub (assignee/reviewer labels or explicit fields). Prose-only "we were careful" is insufficient for High tier.

---

## Exit states (canonical names)

Use consistent labels across runtimes. Human approval is distinct from merge execution; record who executed the merge.

1. Ready for QAS  
2. Approved for RTE  
3. Ready for HITL  
4. **MERGED (HITL only)** — Scott executed the merge (human approval + execution)
5. **MERGED (HITL-delegated)** — Low tier only; delegated HITL (D1)
6. **MERGED (delegated Kai/RTE)** — Kai or Release · RTE executed a trunk merge under `constitution/03`. Record `merged_by` (Kai | Release · RTE), exact-head SHA, independent QAS APPROVE (Kai's independent QAS APPROVE when RTE executed), RTE PASS when RTE executed, and Scott's recorded concur on constitution/, High, and O2 where required. This is not a HITL merge.

### D1: Delegated HITL (Low tier only)

At **Low tier** only, HITL may be delegated with a structured `hitl_delegate` record. Scott's #22 concur (2026-10-30, recorded on [`d88c884`](https://github.com/bybren-llc/safe-harness/commit/d88c884c14c64aa2dbc244c89290818df423924e)) keeps this Low-tier record **as written**. ADR-style accountability is required: who delegated, what was delegated, when, and a link to the record.

```yaml
hitl_delegate:
  delegating_actor: Scott Graham
  delegate_actor: Kai
  authorization_url: https://linear.app/cheddarfox/issue/SAF-1#comment-54d37e98
  scope: low  # Must be "low" only
  delegated_what: Low-tier HITL merge execution (standing Wave 0 authorization)
  delegated_at: 2026-10-28
```

Accountability fields (required on every new `hitl_delegate` row). The standing record keeps `delegating_actor`, `delegate_actor`, `authorization_url`, and `scope` as written, and adds `delegated_what` and `delegated_at`:

| Field | ADR question |
| --- | --- |
| `delegating_actor` | Who delegated |
| `delegated_what` | What was delegated |
| `delegated_at` | When |
| `authorization_url` | Link to the record |

Exit label: `MERGED (HITL-delegated)` (distinct from `MERGED (HITL only)`).

**Restrictions:**
- **Low tier only** — delegated HITL not allowed at Med/High
- Delegation must be explicit, recorded, and scoped
- Delegate may not further delegate

---

## Cycle time (metrics)

**Primary measure:** First PR opened to merge (PR lifecycle)  
**Secondary measure:** Issue opened to closed (issue lifecycle)

Report cycle time per Bolt in prove/ records. Track blocking gates separately (QAS turnaround, HITL turnaround).

---

## Linear archive (Wave 1 migration)

Linear issues SAF-1 through SAF-5 remain accessible as read-only archive. **Never delete Linear history.** Every existing Linear evidence URL must remain resolvable.

Migration plan (`prove/wave-1/migration-plan.md`) includes:
- SAF-n to GitHub Issue mapping table (`trace/linear-saf-map.csv`)
- Evidence URL preservation strategy (Linear URLs remain valid; cite them by link)
- Archive access instructions
- Cutover date: TBD (set after Scott concurrence)
- Scope: safe-harness only (other Linear teams like STO are untouched)

**Delivery owns migration and closeout.** Kai coordinates with Scott on cutover timing.

---

## Wave 1 GitHub writes

After Scott concurrence on this amendment, agents may create GitHub Issues using the structured templates. Constitution changes require explicit Scott concur before merge.
