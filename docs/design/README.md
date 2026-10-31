# Design docs

A design doc records how one subsystem or topic is built. It is not an ADR and it is not a requirement.

Use a design doc when the shape of a change needs more than a PRD row and less than a constitution amendment: loaders, handoffs, evidence paths, adapter wiring, and similar.

## One doc per subsystem or topic

Write one file per subsystem or topic. Do not combine unrelated topics in one file. If two topics share a decision, link both docs to the same ADR.

## Naming

Files live in this directory as `<topic-slug>.md`. Examples of slugs: `runtime-loaders`, `studio-handoff`, `evidence-rows`.

Start a new file from [`DESIGN-TEMPLATE.md`](DESIGN-TEMPLATE.md). Leave the template blank.

## How a design doc links to ADRs and REQs

- **ADRs** record a choice. Link the design doc to every ADR that constrains it. If the design changes a recorded choice, add or amend an ADR and update Current shape in [`../decisions/log.md`](../decisions/log.md) in the same PR.
- **REQs** record success. Link the design doc to the `REQ-<CMP>-NNN` IDs it implements. Do not invent IDs. While `spec.md` has no REQ IDs, write `none yet`.
- **PRD** (optional) holds longer product context. A design doc may cite `FR-` / `NFR-` codes from a PRD. Those codes are not registry IDs.

## What this directory is not

- Not the decision log. Decisions live under [`../decisions/`](../decisions/).
- Not the requirements registry. IDs live under [`../../requirements/`](../../requirements/).
- Not a place for instance history. History stays in `CHANGELOG.md` and `prove/`.
