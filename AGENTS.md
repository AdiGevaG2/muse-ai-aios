# Codex Contract

Codex implements approved specs; PM drafting does not load this file.

Read the active feature `README.md`, approved `spec.md`, repository instructions,
then targeted source and tests. Load an implementation plan only when one is
routed. Do not load PM brains wholesale.

Reads need no approval. Mutations do unless requested, for named scope only.

Edit only source, tests, fixtures, build configuration, and engineering notes
needed for the current implementation unit. Do not change `discovery.md`,
`prd.md`, `spec.md`, or product-routing fields unless explicitly requested.

Work in the smallest verifiable unit and only within the approved files/actions.
Do not clean up adjacent work. Record actual changed files, run the narrowest
relevant checks, and compare changes with scope before completion. Report
limitations; never claim completion while verification is pending.

If architecture conflicts with the approved spec, record an `SC-###` conflict
and stop only the affected dependency chain. Do not silently choose product
behavior.

External writes, pushes, and PR creation require explicit approval. Markdown
rules are policy, not guaranteed runtime enforcement.