# Reverse Engineering: Merchant Ownership and Merchant Status in Atlas

Scope: Atlas only, current code. Quick run. Source: `evercompliant/mlrc-merchant`, default branch, commit `71ffe7d` (shallow clone, 2026-11-09).

## Executive Summary

- A merchant record belongs to one organization. The record's key is the organization ID plus a hash of the merchant's unique ID, so the same merchant in two organizations is two separate records with no shared fields.
- A merchant is linked to portfolios through a separate assignment record, one per merchant and portfolio pair.
- Merchant status lives on the assignment record, not on the merchant. Each portfolio holds its own status for the merchant.
- Changing status to Approved, To Review, or Terminated updates one merchant in one portfolio. Other portfolios and other organizations do not change.
- Monitoring status also lives on the assignment record, so it is per portfolio too.

## Current Behavior

### Where the merchant is stored
- The merchant record carries one organization ID. Code comment: "Always a single account id per merchant". Source: `shared-spring/.../entity/MerchantEntity.java:28-43`.
- The record key is `accountId#hash(uniqueId)`. Source: `MerchantEntity.java:30`.
- Fields on the merchant record, shared by every portfolio inside that organization: legal name, unique ID, DBAs, MIDs, MCCs, contacts, store count, latest store URL, risk severity, products and services description, Mastercard ICA, Visa BIN, billing descriptor, boarding and created dates. Source: `MerchantEntity.java:43-130`.
- No field links a merchant record to another organization. The code calls the organization an account.

### How the merchant links to a portfolio
- One assignment record per merchant and portfolio pair, keyed by merchant ID and `MP#{portfolioId}`. It holds organization ID, portfolio ID, monitoring status, and merchant status. Source: `shared-spring/.../entity/MerchantPortfolioAssignmentEntity.java:29-78`.
- The merchant list search index has one row per merchant and portfolio pair, and reads merchant status from the assignment. Source: `api/.../search/document/MerchantPortfolioSearchDocument.java:19-24, 183-195`.

### How status changes
- A status change takes organization ID, portfolio ID, and merchant ID, loads that one assignment, and writes only that assignment's status. Source: `api/.../service/MerchantStatusService.java:30-46, 79-89`.
- A merchant with no stored status is treated as To Review. Source: `MerchantStatusService.java:74-77`.
- Setting the status a merchant has returns a conflict error. Source: `MerchantStatusService.java:35-38`.
- A Terminated merchant leaves Terminated only through Reactivate, which sets To Review. Source: `MerchantStatusService.java:40-44, 53-64`.
- Setting Terminated clears the merchant's snoozes in that portfolio only. Source: `MerchantStatusService.java:48-50, 104-111`.
- Each change writes an audit log line with actor, previous status, and new status. Source: `MerchantStatusService.java:93-101`.

## Answers to the PM Questions

| Question | Answer |
|---|---|
| Is the merchant stored under portfolio or organization? | Under the organization. Portfolios link to it through assignment records. |
| Does the merchant have fields shared across organizations? | No. Each organization has its own merchant record. Fields are shared across portfolios inside one organization. |
| Is status the same across organizations? | No. Status is per portfolio, so it is also per organization. |
| Does changing to Approved or To Review affect all? | No. It changes one merchant in one portfolio. |
| Can a merchant be Approved in portfolio X and To Review in portfolio B? | Yes. The data model allows it, and each status change targets one portfolio. |

## Business Rules to Preserve

1. A merchant record belongs to one organization.
2. Merchant profile fields are shared by every portfolio in that organization.
3. Merchant status and monitoring status are held per portfolio.
4. No stored status means To Review.
5. Terminated is left only through Reactivate, which returns the merchant to To Review.
6. Terminating clears snoozes in that portfolio only.
7. Every status change is audit-logged with actor, previous, and new status.

## Gaps

- No action exists today to change a merchant's status in all its portfolios at once.

## Conflicts / Product Decisions

- Whether status should stay per portfolio or become one value per merchant inside an organization. The code supports per portfolio today; the mini PRD for this feature was not checked against this.

## Evidence Gaps

- UNKNOWN: whether the portal UI shows the status per portfolio or allows changing it for several portfolios in one action. Portal code (`marketview-portal`) not read.
- Status values: Approved, To Review, and Terminated are confirmed in code. In Process is confirmed in Confluence, "HLD: Reopen Merchant Review on New Risk-Increasing Finding", RT-1657, which also confirms status is stored per merchant and portfolio. UNKNOWN: whether other values exist; the list lives in a shared library outside this repo.