# Cross-portfolio merchant decision scope

Should an Approved, Rejected, or Terminated decision on a merchant apply to every portfolio in the organization, or only where the reason for it applies? Open challenge to the existing-merchant-management PRD direction.

## The direction under challenge
- The existing-merchant-management mini PRD makes Approved, Rejected, and Terminated organization-level: one decision applies in every portfolio the merchant is associated with. [documented] `outputs/existing-merchant-management/prd/existing-merchant-management-mini-prd.md`
- Atlas code holds status per merchant and portfolio pair today. [documented] `outputs/existing-merchant-management/current-state/merchant-ownership-and-status-reverse-engineering.md`

## Cases the manager raised
- **Jurisdiction portfolios:** a client runs one portfolio per jurisdiction. A violation specific to California may justify terminating the merchant in CA but not in the US portfolio. [verbal] `source/2026-11-13-manager-challenge-cross-portfolio-merchant-status.md`
- **Vertical portfolios:** same geography, one portfolio per vertical, merchant operates in several verticals. A violation in one vertical may not apply to the others. [verbal] same source
- **Product-line portfolios (Intuit):** Intuit has a Billing portfolio and a Credit Karma portfolio, one per product line. Terminating a merchant in Credit Karma does not obviously mean terminating it in Billing. [verbal] same source, with PM clarification
- **Possible missing layer:** the manager asks whether an identity layer is missing, meaning a merchant identity separate from the merchant's relationship with each portfolio. [verbal] same source

## Synthesis
- The cases share one pattern: portfolios represent different business relationships with the same merchant, so a violation can be scoped to one relationship. [hunch]
- Merchant profile fields are shared across an organization's portfolios, while status is per portfolio. That split matches the identity-versus-relationship layer the manager describes. [documented] current-state doc; interpretation [hunch]
- The client merchant key is unique per organization, so one merchant record serves every portfolio. [documented] `MerchantEntity.java:135-136`

## Links
- [[merchantview]]
