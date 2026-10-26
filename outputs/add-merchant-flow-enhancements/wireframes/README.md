# Add Merchant Flow - Enhancements — Wireframe

Low-fidelity, clickable prototype of the org-level Add Merchant flow described
in [../prd/add-merchant-flow-enhancements-prd.md](../prd/add-merchant-flow-enhancements-prd.md).
Built on the `lofi-wireframe` skill's interactive-prototype mode (`dc-runtime`,
hand-drawn house style) — `support.js` sits next to `index.html` and is required
for it to render.

Open `index.html` directly in a browser. Single-file SPA, no build step.

## Screens

1. Organization Home — Add Merchant entry point, org-level (AC-001).
2. Single vs. Bulk choice (AC-002).
3. Portfolio assignment (AC-003).
4. Onboarding vs. Monitoring choice, scoped to the selected portfolio's configured products (AC-003); Portfolio B (monitoring-only) skips straight to services, Portfolio C (no products) routes to a blocked screen (AC-004).
5. Services preview — editable/removable per-merchant in Onboarding (AC-005), read-only/locked in Monitoring (AC-006).
6. Merchant detail entry (reused fields from Add Single Merchant).
7. Creation confirmation.
8. Post-scan approval/rejection (AC-009).
9. Move-to-monitoring prompt — pre-selected when the onboarding portfolio has monitoring configured (AC-007), or required choice when it doesn't (AC-008, AC-011).
10. Manual portfolio move, available independent of onboarding/monitoring state (AC-012).
11. Portfolio Settings — auto-move-to-monitoring toggle (AC-010).

## Open questions this wireframe is meant to surface (not answer)

- Bulk-add mechanism (file format, validation) — flagged inline on the mode-select screen.
- Whether per-merchant service removal persists across future onboarding runs.
- Whether a manual portfolio move re-applies destination services or preserves the merchant's current set — flagged inline on the manual-move screen.
- Approval/manual-move role permissions — not modeled in this prototype (no permission gating shown).

## Date

2026-09-10
