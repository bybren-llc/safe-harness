# Specification — safe-harness

**Ownership:** HUMAN-OWNED (Scott only)  
**Status:** Draft  
**Last updated:** 2026-10-29

---

## Personal boundary rule

**NEVER include personal-vault content, story IP, or private-storage facts in this file or the repository.**

Prohibited: personal vault paths/excerpts, story IP (character names, plot details), private-storage facts (LAN IPs, tokens, `/home` paths).

**How to reference:** Cite by concept name only. Never paste actual IPs, tokens, paths, or personal details.

---

## Overview

*(Human-authored specification. Agents do not modify this file.)*

## Requirements

Requirements are derived from this spec and tracked as REQ-<CMP>-NNN IDs in `requirements/`. Each requirement references a spec anchor as its `source`.

See `trace/trace-map.yaml` for requirement states and evidence linkage.

## Architecture

*(High-level architecture and component relationships. Component registry: `arch/components.yaml`)*

## Interfaces

*(Key interfaces, APIs, and contracts.)*

## Metrics

Success metrics M1–M6 are defined in `constitution/00-north-star.md`:
- **M1**: Multi-runtime template ships
- **M2**: tmux not required
- **M3**: SAFe + AI-DLC spine retained
- **M4**: Round Table seats map
- **M5**: Time-to-first owned ticket
- **M6**: Deploy/release flow health

Each requirement must tie to a metric (M1–M6 or custom named metric).

---

**Note:** This file is human-owned under constitution/05. Agents own plan, issues, code, tests, PRs, and evidence. Design (intent.md + spec.md) remains human responsibility. See CODEOWNERS for review requirements.
