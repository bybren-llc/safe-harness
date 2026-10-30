## Requirements

Requirements: N/A

<!-- REQ-<CMP>-NNN, REQ-<CMP>-MMM — or N/A / none yet (bootstrap) while spec.md has no REQ IDs -->

## Risk tier

- [ ] Low
- [ ] Medium
- [ ] High

### O2 checklist

Defaults to High unless Kai downgrades in writing at QAS (`constitution/03-cd-and-hitl.md`).

- [ ] Pricing
- [ ] Refunds
- [ ] Auth
- [ ] Deploy CI / workflows
- [ ] Prod secrets
- [ ] Privacy-boundary crosses
- [ ] None

## Evidence (`constitution/05` fields)

| evidence_id | runtime | exact_head | issue | actor | gate | req_ids |
| --- | --- | --- | --- | --- | --- | --- |
| | | | | | | |

## Exact head

SHA under review:

The final reviewed head is recorded in the QAS review and the squash-merge body.

## Refs

Refs #N

## needs-owner-concur — human owner's recorded own-words concur

- [ ] This PR needs the human owner's recorded own-words concur at the exact head (`constitution/`, High, or O2). Apply the `needs-owner-concur` label.

## Gate status

| Gate | Status | Notes |
| --- | --- | --- |
| QAS | pending | Independent; never the implementer. COMMENT review at exact head. |
| SecEng | pending / N/A (Low only; rationale required) | High/O2: never N/A and cannot be waived. |
| RTE | pending | Per `roles/release-rte.md`. PASS on the exact head when RTE executes. |

After QAS APPROVE, head is frozen: no commits, pushes, or title or body edits unless the reviewing seat explicitly asks.
