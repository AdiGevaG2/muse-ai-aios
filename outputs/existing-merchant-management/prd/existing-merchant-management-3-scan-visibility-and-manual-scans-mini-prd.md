# Existing Merchant Management - Scan Visibility and Manual Scans - Mini PRD

**TL;DR:**
Users see when each service will scan a merchant next. They can scan a merchant now. The merchant page and list show what the latest scan found, including when it found no risk.

<br>

## Definitions

- **Merchant**: a business in the client's organization, identified by its client merchant key. A merchant can be associated with one or more portfolios. Its status and monitoring are set separately in each portfolio.
- **Portfolio**: a group of the client's merchants. A client can have several portfolios.
- **Org admin**: a user with access to every portfolio in the organization.
- **Merchant status**: the client's decision on a merchant in one portfolio. The statuses are To Review, Under Review, Approved, Rejected, and Terminated. See Review and Decide.
- **Monitoring**: recurring scans of a merchant in one portfolio, run on the portfolio's schedule for each service. Each of these is a scheduled scan.
- **Service**: a scan type the merchant is registered for, such as Content Compliance.
- **First scan**: a merchant's first scan ever. It is its Onboarding scan or, if the merchant was never scanned before, not even by Onboarding, its first monitoring scan.
- **Manual scan**: a one-off scan a user starts outside the schedule.

<br>

## Problem and Goal

Clients cannot see when a merchant will be scanned next. To scan a merchant outside the schedule, they ask support.

Goal: Users see when each merchant is scanned next, scan it when they need to, and see what the latest scan found.

**Why we need it:** Atlas replaces MerchantView. Clients need to know and control when their merchants are scanned.

**Value for the client:** Users know when each merchant is scanned next, can scan it outside the schedule, and see which services carry risk.

**Why now:** All MerchantView clients must migrate to Atlas.

<br>

## Feature Behavior

### Prerequisites

- The merchant is in one or more of the client's portfolios.
- Scheduled scans run only where monitoring is on. See Portfolio Assignment and Monitoring.
- When a merchant is Rejected or Terminated in a portfolio, monitoring turns off there, and no scheduled scan runs there. See Review and Decide.

### Requirements

**Portfolio access**
- Users see only the portfolios they have access to, in every message and list.

**Next scheduled scan**
- When monitoring is on, the merchant shows the date of the next scheduled scan for each service in the current portfolio.
- When monitoring is off, it shows no date.

**Manual scan**

A user can scan any merchant that is not Rejected or Terminated in the current portfolio.
1. The user starts a manual scan from the merchant page or row.
2. Atlas starts the scan and confirms that it started.
- Manual scans have no quota.

**Clean scan**
- When the latest scan found nothing at Low risk or above, the merchant page shows the merchant's URL and the scan date. Under the Findings header it shows: "Clean scan. No violations or risks were found in this scan."

**Services column**
- The Categories column in the merchant list is renamed Services.
- It lists the merchant's services that have a finding at Low risk or above, sorted by each service's highest risk level, Critical first.
- A service with no finding at Low risk or above does not show.

**Errors**
1. When any scan, manual or scheduled, is running on a merchant, a manual scan of it is blocked. Atlas shows "A scan is already running for this merchant."
<br>

## Acceptance Criteria

**Scenario: Next scheduled scan after monitoring turns on**
- Given monitoring turned on for a merchant in portfolio A
- When a user opens the merchant in portfolio A
- Then it shows the next scheduled scan date for each service in portfolio A

**Scenario: First scan with no risk**
- Given a merchant added to Atlas
- When its first scan finds nothing at Low risk or above
- Then the merchant page shows "Clean scan. No violations or risks were found in this scan."

**Scenario: Services column**
- Given a merchant with a High finding in one service, a Critical finding in a second, and only No Risk findings in a third
- When a user opens the merchant list
- Then the Services column shows the second service, then the first, and not the third

**Scenario: Manual scan of a merchant**
- Given a merchant that is To Review in portfolio A, with no scan running
- When a user in portfolio A starts a manual scan of it
- Then the scan starts
- And Atlas confirms that it started

**Scenario: No manual scan for a rejected merchant**
- Given a merchant Rejected in portfolio A
- When a user opens the merchant in portfolio A
- Then manual scan is unavailable

**Scenario: Manual scan blocked during a running scan**
- Given a merchant with a scheduled scan running
- When a user starts a manual scan of it
- Then no scan starts
- And Atlas shows "A scan is already running for this merchant."

<br>

## Data

Owner: @doron.muravnik@g2risksolutions.com

**Baseline**
- Number of support requests for on-demand rescans: TBD. Source: support tickets.
**Success measure**
- Decrease support requests for on-demand rescans: target set by BI.
**Recorded data**
- For each manual scan: the merchant, the portfolio, the user, and the date.

<br>

## Open Questions / Assumptions

- Decide which roles, other than the org admin, can start a manual scan.
- Check with Core whether the platform can show the next scheduled scan date for each service of each merchant.
