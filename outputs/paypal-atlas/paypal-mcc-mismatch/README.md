# PayPal MCC Mismatch

- **Domain:** Atlas
- **Current stage:** Discovery
- **Status:** Draft ready for PM review
- **Last verified:** 2026-08-30

## Read first

- [Knowledge doc](knowledge/paypal-mcc-mismatch-knowledge.md) — shareable explanation, 2026-09-01
- [Discovery](discovery/paypal-mcc-mismatch-discovery.md)
- [Reverse-engineering report](current-state/paypal-mcc-mismatch-reverse-engineering.md)

## Requirement

PayPal requires MCC mismatch. Sources: MV, MLRC/CMP, SP/GO, WS. Target: UP.

## Evidence

Stakeholder email summary and targeted MV, SP/GO, and UP source. Exact repos,
commits, and freshness are in the report.

## Open decisions

Comparison and ownership semantics; multiple MCCs; result states; delivery;
enablement.

## Blockers and evidence gaps

- WebShield source is unavailable locally and is `NOT VERIFIED`.
- Core comparison is `UNKNOWN`; source is unavailable locally.
- Email attachments were not independently opened.
- Several UP clones are stale; target conclusions are qualified in the report.

## Verification state

Strict verification covered MV behavior, UP ingestion through portal, and
SP/GO verification. Source repos were not changed.
