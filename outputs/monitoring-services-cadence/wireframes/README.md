# Monitoring Products Cadence — Wireframes

**Date:** 2026-09-15

## What this shows

A low-fidelity mockup of the Merchant Details drawer, updated for phase 2 (UI)
of the monitoring-products-cadence feature. Based on the real component at
`marketview-portal/src/features/MerchantDetails/Drawer/tabs/MerchantDetails/MerchantDetails.tsx`.

Each business URL now shows one row per product (MCC, CC, Graph), each with
its own cadence and its own last-scanned date, plus a "Scan now" action per
product. This replaces today's behavior, where a URL has a single combined
last-scanned date shared across all products.

## Screens

- `index.html` — single screen, the Merchant Details drawer with two business
  URLs. The second URL shows a product with no cadence configured, to
  illustrate that state.

## Open questions this should help answer

- Does "Scan now" belong directly on this screen, or only in a separate
  admin/config surface? Shown here as inline per product for review.
- How should an unconfigured product display next to a configured one on the
  same URL?

## Assumptions

- ASSUMED: cadence is shown as a plain label next to the last-scanned date,
  not editable from this screen (editing stays out of scope per the mini-PRD).
