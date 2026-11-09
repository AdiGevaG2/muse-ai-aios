# Verify Merchant Details Against Website

**Domain:** atlas
**Stage:** Mini PRD published to Confluence
**Status:** Design pending approval by Dana Friedman; spec stage next
**Confluence:** [Mini PRD](https://g2rs.atlassian.net/wiki/spaces/UP/pages/4362764310/Verify+Merchant+Identity+Against+Website+-+Mini+PRD)

## Read first

- [Mini PRD](prd/verify-merchant-details-against-website-mini-prd.md)
- [Reverse engineering: Core's existing mismatch logic](current-state/verify-merchant-details-against-website-reverse-engineering.md)

## What this is

NAB requires checking merchant-submitted identity/contact data against what the merchant's website shows, to surface risk (for example, a merchant declaring U.S. operation while the website shows a sanctioned country). Built as a general Atlas capability; NAB is the driving client that sets the MVP bar, not a gated special case.

## Evidence and repositories

- `code-repos-git/core`, package `core/processor/.../workers/extractors/entityextractionmismatch/`: phone/email comparators run; the company name comparator exists but no caller was found; the address result is always skipped.
- Gating: `BankFlag.ADDRESS_MISSMATCH` / `BankFlag.COMPANY_NAME_MISSMATCH` are set by the MerchantView gateway, off by default, but Core was not seen reading them.
- A separate K9 address and company name service is reported live behind flags (Confluence PROD page 4031909534; K9-225, K9-166, K9-269); relation to this feature is open.

## Relevant domain context

- [[mcc-mismatch-for-global-onboarding]] — same pattern precedent: mismatch-style logic for Atlas clients lives in Core, not in MerchantView's legacy repos.

## Open decisions and blockers

- Output shape for the new address/postal code/country finding (no existing precedent to follow) — spec-stage decision.
- Identity verification is part of the Operational Risk service, a service separate from MCC, CC, and graph; on/off per portfolio is owned by the Operational Risk PRD. Core's per-field flags (`ADDRESS_MISSMATCH`, `COMPANY_NAME_MISSMATCH`) must be retired or defaulted on for Operational Risk clients; confirm with Core.
- DBA field not reaching company name comparator — unresolved, not addressed by this release.

## Last verified

2026-10-07. Core evidence source-verified by subagent reverse-engineering this session, two passes (first pass incorrectly concluded no mismatch logic existed in MV; PM correction redirected to the Core repo).
