# Existing Merchant Management - Review and Decide - Mini PRD

**TL;DR:**
After a merchant is scanned, a user decides in each portfolio whether to work with it: approve, reject, or terminate. Each portfolio decides on its own. The org admin can terminate a merchant in several portfolios at once. Atlas emails every user with access to the portfolio where the decision was made.

<br>

## Definitions

- **Merchant**: a business in the client's organization, identified by its client merchant key. A merchant can be associated with one or more portfolios. Its status and monitoring are set separately in each portfolio.
- **Portfolio**: a group of the client's merchants. A client can have several portfolios.
- **Portfolio user**: a user with access to one or more of the organization's portfolios. They see and act only in those portfolios.
- **Org admin**: a user with access to every portfolio in the organization.
- **Merchant status**: the client's decision on a merchant in one portfolio. The statuses are To Review, Under Review, Approved, Rejected, and Terminated.
- **New risk finding**: a finding at Low, Medium, High, or Critical risk that the client has not seen before. The risk level decides this, not the severity. A finding that repeats on a later scan is not new.
- **Monitoring**: recurring scans of a merchant in one portfolio, run on the portfolio's schedule for each service. Each of these is a scheduled scan.
- **Service**: a scan type the merchant is registered for, such as Content Compliance.
- **Onboarding**: a G2 service that runs a one-time scan when a merchant is added to a portfolio. When adding a merchant to a portfolio, the user sends it to Onboarding or to Monitoring. The two include different services.
- **First scan**: a merchant's first scan ever. It is its Onboarding scan or, if the merchant was never scanned before, not even by Onboarding, its first monitoring scan.

<br>

## Problem and Goal

Clients cannot record a decision on a merchant based on its scan results. A merchant is monitored as soon as it is added, whether or not the client wants to work with it. Clients cannot see which merchants wait for review or who is reviewing them. When one portfolio stops working with a merchant, users of the client's other portfolios do not find out.

Goal: Users decide on each merchant in each portfolio, and every user with access to that portfolio learns about the decision.

**Why we need it:** Atlas replaces MerchantView. Clients need a decision step between a merchant's scan results and Monitoring.

**Value for the client:** Each portfolio decides for its own business. A client with portfolios per jurisdiction, vertical, or product line can terminate a merchant in one portfolio and keep it in another. The org admin can terminate a bad actor in every portfolio at once. Users see which merchants wait for review and who is reviewing them.

**Why now:** All MerchantView clients must migrate to Atlas.

<br>

## Feature Behavior

### Prerequisites

- The merchant is associated with one or more of the client's portfolios, with a status in each.

### Requirements

**Merchant status**

Each status applies to one portfolio. Changing it in one portfolio does not change the merchant's status or monitoring in its other portfolios. The exception is the org admin terminating it in several portfolios.

| Status | Meaning |
| --- | --- |
| To Review | Atlas sets it when the merchant is added to the portfolio, and when a scan in the portfolio finds a new risk finding. Users can also select it at any time. |
| Under Review | A user selects it to show others in the portfolio that someone is reviewing the merchant. Users can select it at any time. |
| Approved | The portfolio works with the merchant. |
| Rejected | The portfolio does not work with the merchant. This cannot be undone. |
| Terminated | The portfolio stopped working with a merchant it had approved. This cannot be undone. |

**Who can change a status**
- Risk analysts, risk managers, and the org admin can change a status.
- Risk analysts and risk managers change it in one portfolio at a time.
- The org admin can terminate a merchant in several portfolios at once.

**Status list**
- To Review, Under Review, and Approved are always in the list, unless the merchant is Rejected or Terminated in the current portfolio.
- Rejected is in the list until the merchant is first Approved in the current portfolio. From then on, Terminated replaces it.
- Rejected and Terminated never show together.
- When the merchant is Rejected or Terminated in the current portfolio, it has no status list there. To work with it again, a user adds it to the portfolio again through the add merchant flow, by single add or bulk upload. See Portfolio Assignment and Monitoring.

**Status after a scan**
- A scan that finds a new risk finding sets the status to To Review in the portfolio where it ran.
- After the first scan, the status is To Review, even if the scan found no risk. This way a user decides whether to work with the merchant.
- A later scan without a new risk finding leaves the status as it is. This includes scans with no findings, with No Risk findings only, or with findings seen before.
- A running scan does not change the status.
- A scan that finishes after the merchant was Rejected or Terminated in a portfolio does not change its status there.
- When a merchant is Rejected or Terminated in a portfolio, monitoring turns off there, and no scheduled scan runs there.

**Portfolio access**
- Users see only the portfolios they have access to, in every message, list, and email.

**Approve a merchant**
1. A user selects Approved.
2. Atlas asks to confirm and names the current portfolio. The buttons are Approve and Go back.
3. The user selects Approve.
4. The status changes to Approved in the current portfolio.
5. Atlas sends an email. See Notifications.
6. If monitoring is off in the current portfolio, Atlas asks whether to add the merchant to monitoring. If the user selects Add to monitoring, Atlas opens the monitoring modal, where the user selects the portfolios. Whatever the user does in either step, the merchant stays Approved. Both steps are described in Portfolio Assignment and Monitoring.
- If the user selects Go back in step 2, nothing changes.

**Reject a merchant**
- Rejected shows only for a merchant that was never Approved in the current portfolio.
1. A user selects Rejected.
2. Atlas shows a warning with an optional text box named "Merchant rejection notes" and the buttons Reject and Go back. The warning says:
   - The merchant will be rejected in the current portfolio, named in the warning.
   - Monitoring turns off in this portfolio, and no more scans run here.
   - This cannot be undone in this portfolio.
   - The merchant's status in its other portfolios does not change.
3. The user selects Reject.
4. The status changes to Rejected, and monitoring turns off, in the current portfolio.
5. Atlas sends an email. See Notifications.
- If the user selects Go back, nothing changes.

**Terminate a merchant**
- Terminated shows only for a merchant that was Approved before in the current portfolio.
1. A user selects Terminated.
2. Atlas shows a warning with an optional text box named "Merchant termination notes" and the buttons Terminate merchant and Go back. The warning says:
   - Where the merchant will be terminated. A portfolio user terminates it in the current portfolio only. The org admin sees every portfolio the merchant is associated with, with the current one selected, and can select any or all of them.
   - Monitoring turns off in those portfolios, and no more scans run there.
   - This cannot be undone in those portfolios.
   - The merchant's status in its other portfolios does not change.
3. The user selects Terminate merchant.
4. The status changes to Terminated, and monitoring turns off, in each selected portfolio.
5. Atlas sends an email. See Notifications.
- If the user selects Go back, nothing changes.

**Notifications**
- In this phase, notifications are emails.
- Atlas sends an email when a merchant is Approved, Rejected, or Terminated.
- It goes to every user with access to the portfolio where the change was made, including the org admin.
- When one action covers several portfolios, each user gets one email. It names only the portfolios that user has access to.
- Email content:
  - Subject: "[Merchant name] was [approved / rejected / terminated] in [portfolio name]"
  - Body:
    - "[Merchant name] was [approved / rejected / terminated] in [portfolio name]."
    - "Status: [new status]"
    - "Changed by: [user name]"
    - "Date: [date]"
    - "Notes: [notes]". This line shows only when the user entered notes.

<br>

## Acceptance Criteria

**Scenario: New merchant added**
- Given a merchant added to Atlas in portfolios A and B
- When it is added
- Then its status is To Review in portfolios A and B

**Scenario: Under Review stays in one portfolio**
- Given a merchant that is To Review in portfolios A and B
- When a user in portfolio A selects Under Review
- Then it is Under Review in portfolio A and To Review in portfolio B

**Scenario: Approve a merchant in one portfolio**
- Given a merchant that is Under Review in portfolio A and To Review in portfolio B
- When a user in portfolio A selects Approved
- Then Atlas asks to confirm, names portfolio A, and shows Approve and Go back
- And after the user selects Approve, it is Approved in portfolio A and To Review in portfolio B

**Scenario: Approval asks about monitoring**
- Given a merchant with monitoring off in portfolio A
- When a user in portfolio A approves it
- Then it is Approved in portfolio A
- And Atlas asks whether to add it to monitoring

**Scenario: Email respects portfolio access**
- Given a merchant in portfolios A and B, user X with access to A and B, and user Y with access to B only
- When a user in portfolio A terminates the merchant
- Then user X and the org admin get an email with the merchant, portfolio A, Terminated, the date, and the user
- And user Y gets no email

**Scenario: New risk finding in one portfolio**
- Given a merchant Approved in portfolios A and B
- When a scan in portfolio A finds a new finding at Low risk
- Then it is To Review in portfolio A and Approved in portfolio B

**Scenario: No new risk finding**
- Given an Approved merchant with a High risk finding
- When a scan finds the same finding again, plus new findings at No Risk only
- Then it stays Approved

**Scenario: First scan with no risk**
- Given a merchant added to Atlas
- When its first scan finds nothing at Low risk or above
- Then its status is To Review

**Scenario: Reject a merchant in one portfolio**
- Given a merchant that is To Review in portfolios A and B and was never approved
- When a user in portfolio A selects Rejected
- Then the warning names portfolio A and says that monitoring turns off there, that this cannot be undone in this portfolio, and that its status in other portfolios does not change
- And after the user selects Reject, it is Rejected with monitoring off in portfolio A, and To Review in portfolio B
- And in portfolio A it has no status list

**Scenario: Terminated replaces Rejected**
- Given a merchant that was Approved in portfolio A and is now To Review there
- When a user in portfolio A opens the status list
- Then the list shows Terminated and not Rejected

**Scenario: Portfolio user terminates in one portfolio**
- Given a monitored merchant Approved in portfolios A, B, and C, and a portfolio user in portfolio A
- When the user selects Terminated and then Terminate merchant
- Then it is Terminated with monitoring off in portfolio A
- And it stays Approved and monitored in portfolios B and C

**Scenario: Org admin terminates in several portfolios**
- Given a merchant Approved in portfolios A, B, and C
- When the org admin selects Terminated in portfolio A, selects portfolios A, B, and C, and selects Terminate merchant
- Then it is Terminated with monitoring off in portfolios A, B, and C

<br>

## Data

Owner: @doron.muravnik@g2risksolutions.com

**Baseline**
- Time from To Review to an Approved, Rejected, or Terminated decision: TBD, measured in the first month after Atlas launch. Source: Atlas status change records.

**Success measure**
- Decrease the time from To Review to an Approved, Rejected, or Terminated decision: target set by BI.

**Recorded data**
- The merchant's status in each portfolio, and the date of each change.
- The user who set each status.
- For each approval, rejection, and termination: the portfolios, the notes, and the users emailed.

<br>

## Open Questions / Assumptions

None.
