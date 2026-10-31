# 00 — North Star

## Dual spine (peer)

| Spine | Name | Owner lane | Optimizes |
| --- | --- | --- | --- |
| **(A)** | CD execute/deploy | Delivery | Evidence → gates → merge → release health |
| **(B)** | Think/plan | Studio | Multi-vault knowledge + non-code gates → handoff when knowledge becomes build |

Spines share Round Table principles, exit states, and ownership language. They differ in gates and storage. Overfitting to forge/CI alone is a fail.

## Success metrics

Define your success metrics here. Each requirement in `requirements/` should tie to a metric. See `examples/round-table/metrics.md` for an example.

## Empiricism

Techniques that win in controlled comparison replace prior defaults. See `06-empiricism.md`.

## Non-goals

Document your non-goals here:

- No personal-vault tooling in Delivery lane; personal vault **never** GitHub/remote forge.
- Freeze-the-train is exception, not default CD mode.

See `examples/round-table/decisions.md` for an example of instance-specific non-goals.
