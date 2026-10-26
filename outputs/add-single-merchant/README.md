# Add Single Merchant

Domain: atlas

## Status

Stage: Spec
Status: Draft, ready for PM review

## Artifacts

- Discovery: [discovery/add-single-merchant-discovery.md](discovery/add-single-merchant-discovery.md)
- PRD: [prd/add-single-merchant-prd.md](prd/add-single-merchant-prd.md)
- Spec: [spec/add-single-merchant-spec.md](spec/add-single-merchant-spec.md)

## Evidence and Repos

- `marketview-portal`, `mlrc-bff-2.0`, `mlrc-merchant`: current Add New Merchant side panel and validation behavior.
- Figma: https://www.figma.com/design/kxzxm9iEiCqzo2ewSKAoWA/Unified-Platform-2026?node-id=1555-53728&t=LFnhDf9xq6gA55XS-4
- Mixpanel: EverC `MerchantView Production` project 2040581, `add_merchant_solo` / `add_merchant_solo_upload`, 2026-04-30 to 2026-07-28.

## Open Decisions

- Behavior when portfolio config changes while the side panel is open.
- Accepted URL formats and scheme normalization.
- Where "Create merchant and scan now"/"scan later" actions land on Step 2; not yet reflected in Figma (needs design update).
- Whether per-URL MCC and Step 2 (Additional Merchant Details, Principal Details) are confirmed in scope - added from Figma, not originally specified.

## Blockers

None.

## Last Verification

Discovery drafted 2026-09-03. Spec drafted and reconciled against Figma (node 1555:53728) 2026-09-10: surfaced a two-step flow not in the original PRD (PRD amended same day, PM confirmed), plus two new fields (per-URL MCC, optional Step 2 details) added as ASSUMED pending PM confirmation. No brain notes existed for this feature at PRD stage; recommend `/ingest` or `/retro` after close.
