# Existing Merchant Management - Portfolio Assignment and Monitoring - Mini PRD

**TL;DR:**
A user can associate a merchant with other portfolios, or remove it from a portfolio it is associated with, whether or not it is monitored. When associating it, the user chooses to send it to Onboarding or Monitoring in the new portfolio. A user can turn on monitoring after approving a merchant or from the merchant page. The org admin can remove a merchant from several portfolios at once, or delete it permanently.

<br>

## Definitions

- **Merchant**: a business in the client's organization, identified by its client merchant key. A merchant can be associated with one or more portfolios. Its details, such as legal name and URL, are the same in every portfolio. Its status and monitoring are set separately in each portfolio.
- **Portfolio**: a group of the client's merchants. A client can have several portfolios.
- **Portfolio user**: a user with access to one or more of the organization's portfolios. They see and act only in those portfolios.
- **Org admin**: a user with access to every portfolio in the organization.
- **Merchant status**: the client's decision on a merchant in one portfolio. The statuses are To Review, Under Review, Approved, Rejected, and Terminated. See Review and Decide.
- **New risk finding**: a finding at Low, Medium, High, or Critical risk that the client has not seen before. The risk level decides this, not the severity. A finding that repeats on a later scan is not new.
- **Onboarding**: a G2 service that runs a one-time scan when a merchant is added to a portfolio. When adding a merchant to a portfolio, the user sends it to Onboarding or to Monitoring. The two include different services.
- **Monitoring**: recurring scans of a merchant in one portfolio, run on the portfolio's schedule for each service. Each of these is a scheduled scan.
- **Service**: a scan type the merchant is registered for, such as Content Compliance.

<br>

## Problem and Goal

Clients cannot choose whether a merchant is monitored, or in which of their portfolios. A merchant is monitored as soon as it is added. When a client adds a merchant that exists in another of its portfolios, the add is blocked.

Goal: Users associate a merchant with the portfolios they need, remove it from the ones they don't, and choose where it is monitored. Every user with access to a portfolio learns when a merchant is removed from it or deleted.

**Why we need it:** Atlas replaces MerchantView. Clients need to choose which portfolios a merchant is in and where it is monitored.

**Value for the client:** Each portfolio decides for its own business. A client with portfolios per jurisdiction, vertical, or product line can keep a merchant in several portfolios, and monitor it in one and not in another. Users see which merchants are monitored.

**Why now:** All MerchantView clients must migrate to Atlas.

<br>

## Feature Behavior

### Prerequisites

- The merchant is associated with one or more of the client's portfolios, with monitoring on or off in each.

### Requirements

**Onboarding, Monitoring and All Tabs**
- The merchant list has three tabs: All, Onboarding, and Monitoring. Each tab shows its merchant count.
- All lists every merchant in the current portfolio.
- Onboarding lists merchants never added to Monitoring in the current portfolio.
- Monitoring lists merchants added to Monitoring in the current portfolio.
- Every tab lists merchants in every status. A merchant stays on its tab when its status changes, including to Rejected or Terminated.

**Portfolio access**
- Users see only the portfolios they have access to, in every message, list, and email.

**Monitoring modal**

The modal opens after a user approves a merchant whose monitoring is off in the current portfolio, or selects the Turn On Monitoring link. Approval is described in Review and Decide. The modal does not change the merchant's status in the current portfolio. It shows:
- Heading: "Add [merchant name] to monitoring"
- Message: "Monitoring scans this merchant on a schedule and notifies you when a new risk finding appears."
- Every portfolio the user has access to, each with its services and each service's scan frequency.
- Portfolios where the merchant is Rejected or Terminated show in the list, but the user cannot select them.
- The current portfolio is selected. If it has no services with monitoring, the first portfolio in the list is selected instead. The user can select more than one.
- The buttons Add merchant to monitoring and Go back.

When the user selects portfolios and then Add merchant to monitoring:
1. If the merchant is not associated with a selected portfolio, Atlas associates it there as To Review. It stays in its other portfolios.
2. Monitoring turns on in each selected portfolio, and its schedule starts.
3. The merchant moves to the Monitoring tab of each selected portfolio.
4. The merchant page shows a Monitoring on label, and its row shows "Monitored".

When the user selects Go back, nothing changes. After an approval, the merchant stays Approved with monitoring off.

**Turn On Monitoring link**
- When monitoring is off and the status is To Review, Under Review, or Approved, the merchant page shows a Turn On Monitoring link next to the Monitoring off label.
- The link does not show when monitoring is on, or when the status is Rejected or Terminated.
- The link opens the monitoring modal.
- Turning on monitoring from the link does not change the status.

**Add a merchant that exists in the organization**
- When a user adds a merchant by single add or bulk upload, and its client merchant key matches a merchant in the organization, Atlas associates that merchant with the portfolio. It does not block the add.
- The user chooses to send it to Onboarding or Monitoring in that portfolio.
- The merchant is To Review in that portfolio, even if it was Rejected or Terminated in that portfolio or another one.
- Its status and monitoring in its other portfolios do not change.
- Details entered in the add update the merchant's details in every portfolio.

**Add a merchant to another portfolio**
1. On the merchant details page, the user opens the three-dot menu and selects Add to another portfolio.
2. Atlas opens a modal that lists the portfolios the user has access to that the merchant is not associated with. Each portfolio shows its services and each service's scan frequency. The user can select more than one.
3. The user chooses to send the merchant to Onboarding or to Monitoring in the selected portfolios. The buttons are Add to portfolio and Go back.
4. The user selects Add to portfolio.
5. In each selected portfolio, the merchant is To Review, and a scan starts now with that portfolio's services.
6. With Onboarding, the merchant shows on the Onboarding tab. With Monitoring, monitoring turns on, scans continue on the portfolio's schedule, and the merchant shows on the Monitoring tab.
7. Its status and monitoring in its other portfolios do not change.
- If the user selects Go back, nothing changes.
- Add to another portfolio is unavailable when the merchant is associated with every portfolio the user has access to.

**Remove from portfolio and Permanently delete**
- Remove from portfolio shows on the merchant page and row when the merchant is associated with more than one portfolio. It is available in every status.
- Permanently delete shows to the org admin only, next to Remove from portfolio. It is available in every status.

**Remove from portfolio**
1. A user selects Remove from portfolio.
2. Atlas asks to confirm, with the buttons Remove from portfolio and Go back. It names the portfolios the merchant will be removed from:
   - A portfolio user removes it from the current portfolio only.
   - The org admin sees every portfolio the merchant is associated with, with the current one selected. The org admin can select several, but must leave at least one unselected. To remove the merchant from every portfolio, the org admin uses Permanently delete.
3. The user selects Remove from portfolio.
4. The merchant leaves the selected portfolios. If monitoring was on there, it turns off. The merchant no longer shows on their tabs, and no scans run for it there.
5. Its status and monitoring in its other portfolios do not change.
6. Atlas sends an email. See Notifications.
- If the user selects Go back, nothing changes.

**Permanently delete**
1. The org admin selects Permanently delete.
2. Atlas shows a warning with the buttons Permanently delete and Go back. The warning says:
   - The merchant will be deleted from every portfolio it is associated with. The warning names each one.
   - Monitoring turns off, and no more scans run.
   - This cannot be undone.
   - To work with the merchant again, a user must add it to Atlas as a new merchant.
3. The org admin selects Permanently delete.
4. The merchant leaves every portfolio. It no longer shows on any tab, and no scans run for it.
5. Atlas sends an email. See Notifications.
- If the org admin selects Go back, nothing changes.

**Notifications**
- In this phase, notifications are emails.
- Atlas sends an email when a merchant is removed from a portfolio or permanently deleted.
- It goes to every user with access to the portfolio where the change was made, including the org admin.
- When one action covers several portfolios, each user gets one email. It names only the portfolios that user has access to.
- Email content when a merchant is removed:
  - Subject: "[Merchant name] was removed from [portfolio name]"
  - Body:
    - "[Merchant name] was removed from [portfolio name]."
    - "Removed by: [user name]"
    - "Date: [date]"
- Email content when a merchant is permanently deleted:
  - Subject: "[Merchant name] was permanently deleted"
  - Body:
    - "[Merchant name] was permanently deleted from [portfolio names]."
    - "Deleted by: [user name]"
    - "Date: [date]"

<br>

## Acceptance Criteria

**Scenario: Monitoring modal after approval**
- Given a merchant with monitoring off in portfolio A, and a user with access to portfolios A, B, and C
- When the user approves the merchant in portfolio A
- Then the modal lists portfolios A, B, and C, each with its services and scan frequencies
- And portfolio A is selected
- And after the user selects Add merchant to monitoring, monitoring is on in portfolio A and the merchant is on the Monitoring tab there

**Scenario: Monitoring in a new portfolio**
- Given a merchant associated with portfolio A only, and a user with access to portfolios A, B, and C
- When the user approves it, selects portfolios A and C in the modal, and selects Add merchant to monitoring
- Then it is Approved in portfolio A and To Review in portfolio C
- And monitoring is on in portfolios A and C
- And it is not associated with portfolio B

**Scenario: Rejected or Terminated portfolio in the monitoring modal**
- Given a merchant Approved in portfolio A and Terminated in portfolio B, and a user with access to both
- When the monitoring modal opens
- Then portfolio B shows in the list
- And the user cannot select portfolio B

**Scenario: Current portfolio has no monitoring services**
- Given portfolio A has no services with monitoring, and portfolio B is first in the list
- When a user in portfolio A approves a merchant
- Then the modal selects portfolio B

**Scenario: Go back from the monitoring modal**
- Given the monitoring modal is open after an approval
- When the user selects Go back
- Then the merchant is Approved with monitoring off
- And the merchant page shows the Turn On Monitoring link next to the Monitoring off label

**Scenario: Turn on monitoring from the link**
- Given a To Review merchant with monitoring off
- When the user selects Turn On Monitoring, selects a portfolio, and selects Add merchant to monitoring
- Then monitoring is on in that portfolio
- And the merchant stays To Review

**Scenario: Add a merchant terminated in another portfolio**
- Given merchant Z is Terminated in portfolio A
- When a user adds a merchant with merchant Z's client merchant key to portfolio B, by single add or bulk upload, and sends it to Onboarding
- Then merchant Z is To Review in portfolio B, on the Onboarding tab, and stays Terminated in portfolio A
- And when a user later adds it to portfolio A through the add merchant flow, by single add or bulk upload, it is To Review in portfolio A

**Scenario: Add a merchant to another portfolio**
- Given a merchant Approved and monitored in portfolio A
- When a user opens the three-dot menu on the merchant details page, selects Add to another portfolio, selects portfolio B, chooses Monitoring, and selects Add to portfolio
- Then it is To Review in portfolio B, monitoring is on there, a scan starts with portfolio B's services, and it shows on the Monitoring tab of portfolio B
- And its status and monitoring in portfolio A do not change

**Scenario: Portfolio user removes a merchant from one portfolio**
- Given a merchant monitored in portfolios A and B, and a portfolio user in portfolio A
- When the user selects Remove from portfolio and confirms
- Then monitoring is off in portfolio A, the merchant does not show on any tab there, and no scans run for it there
- And its status and monitoring in portfolio B do not change

**Scenario: Merchant in one portfolio only**
- Given a merchant associated with portfolio A only
- When a portfolio user opens the merchant page
- Then Remove from portfolio and Permanently delete do not show

**Scenario: Permanently delete a merchant**
- Given a merchant associated with portfolios A, B, and C
- When the org admin selects Permanently delete
- Then the warning names portfolios A, B, and C, says this cannot be undone, and shows Permanently delete and Go back
- And after the org admin selects Permanently delete, the merchant does not show on any tab of portfolios A, B, or C, and no scans run for it

<br>

## Data

Owner: @doron.muravnik@g2risksolutions.com

**Recorded data**
- The user who added each merchant to Monitoring.
- For each addition to a portfolio, removal from a portfolio, and permanent deletion: the portfolios, the user, and the date.

<br>

## Open Questions / Assumptions

- Decide the success measure and its baseline for this PRD. Owner: @doron.muravnik@g2risksolutions.com
- Decide whether a user can turn monitoring off for an Approved merchant.
- Decide which roles, other than the org admin, can manage Monitoring and add or remove merchants.
- Check with Franz and CompOps whether a merchant can have different MIDs in different portfolios, and whether users of one portfolio may see MIDs from another.
