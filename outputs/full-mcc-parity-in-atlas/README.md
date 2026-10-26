# Full MCC Parity in Atlas

Domain: atlas
Stage: Mini PRD
Status: Draft, pending PM review before Confluence republish

## Read First

- [Mini PRD](prd/full-mcc-parity-in-atlas-mini-prd.md)
- [Discovery](discovery/full-mcc-parity-in-atlas-discovery.md)

## Relevant Evidence and Repositories

- [paypal-mcc-mismatch reverse-engineering](../paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md), verified 2026-08-30, Strict mode
- `merchant-view-legacy-ec/mvnextgen`, `mvserver`, `merchantviewui`, Merchant View source
- `unified-platform-new/mlrc-merchant`, `mlrc-analysis`, `mlrc-finding`, `mlrc-bff-2.0`, `marketview-portal`, Atlas target

## Relevant Domain Context

- Feature note: `domains/atlas/second-brain/context/features/mcc-mismatch.md`
- Hypothesis file: `domains/atlas/second-brain/hypotheses/mcc-mismatch-phase-1.md`

## Open Decisions and Blockers

- How a store gets its own reported code in Atlas (reported code lives on the merchant today).
- Severity and risk values per MCC result.
- Merchant-level multi-code list: build out or keep single-code.
- Two open production bugs on the existing slice: RT-1575, RT-1564.
- Whether this is a read-only view or also carries an edit-the-reported-code flow.

## Decided

- Primary user: underwriting/risk analyst.
- Lift and shift of MerchantView's comparison; Gal Sahar's MCC risk vision is a later phase (2026-10-08).
- Each store compares against its own reported code, using MerchantView's group list (2026-10-08).
- One finding per row in an MCC table; the MCC result sets the finding's severity and risk (2026-10-08).
- Result-state model: reuses RT-1491's 5 states (Match, Mismatch, No Reported Code, No Detected Code, Processing Failure), not Core's seven-verdict model.

## Last Verified

- Discovery written: 2026-10-07.
- Underlying reverse-engineering evidence: 2026-08-30 (local repo clones unchanged since, confirmed 2026-10-07).
- RT-1491 shipped scope confirmed via Rovo search, 2026-10-07.
