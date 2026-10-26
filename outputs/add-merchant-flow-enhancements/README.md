# Add Merchant Flow - Enhancements

Domain: atlas

## Status

Stage: PRD
Status: Draft

## Artifacts

- PRD: [prd/add-merchant-flow-enhancements-prd.md](prd/add-merchant-flow-enhancements-prd.md)

## Evidence and Repos

- Supersedes entry point/scope of [../add-single-merchant/](../add-single-merchant/README.md) (Add Single Merchant PRD v1); that PRD's field/validation/save mechanics are reused, not contradicted.
- No Figma evidence yet for the org-level flow.
- No dedicated Mixpanel events yet; legacy proxies `add_merchant_solo` / `add_merchant_solo_upload` cited in Add Single Merchant PRD.

## Open Decisions

- Per-merchant onboarding service-removal persistence model.
- Approval and manual-move role permissions.
- Whether manual portfolio move re-applies destination services or preserves current set.
- Bulk-add mechanism.
- Whether Add Single Merchant v1 is retired/merged into this PRD.
- Figma evidence source for this flow.

## Blockers

None.

## Last Verification

PRD drafted 2026-09-10 from PM direction (this conversation). No brain feature note exists for merchant-add flow — grounding gap, recommend `/ingest` or `/retro` after close.
