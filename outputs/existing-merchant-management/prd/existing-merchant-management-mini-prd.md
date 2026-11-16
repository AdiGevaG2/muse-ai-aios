# Existing Merchant Management - Mini PRD

**TL;DR:**
Clients review each merchant after its scans and approve, reject, or terminate it in each portfolio, while users of its other portfolios are notified and decide for themselves. The org admin can terminate or remove a merchant across portfolios. Clients add approved merchants to Monitoring per portfolio, see each merchant's next scheduled check, trigger manual scans, add a merchant to another portfolio, remove it from one portfolio, or permanently delete it.

<br>

## Definitions

- **Merchant**: an entity under the client's organization, identified by its client merchant key. One merchant can be associated with more than one portfolio. Its details, such as legal name and URL, are shared by all its portfolios. Its status and monitoring are held separately in each portfolio.
- **Portfolio**: a group of the client's merchants. A client can have more than one portfolio.
- **Portfolio user**: a user with access to one or more of the organization's portfolios. A portfolio user sees and acts only in the portfolios they have access to.
- **Org admin**: a user with access to every portfolio in the organization.
- **Onboarding**: a G2 service that runs as a merchant's first scan, only on a merchant that was never scanned before. When adding a merchant, the client chooses to send it to Onboarding or to Monitoring. Onboarding and Monitoring differ by the services each includes.
- **Monitoring**: the recurring scans that run on a merchant in one portfolio, on that portfolio's schedule for each service. Each of these is a scheduled scan.
- **First scan**: the first scan run on a merchant, from Onboarding or Monitoring, whichever the client chose when adding it.
- **Manual scan**: a one-off scan the client triggers outside the monitoring schedule.
- **Merchant status**: where the client's decision on whether to work with the merchant stands in one portfolio. Atlas uses five statuses: To Review, Under Review, Approved, Rejected, and Terminated.
- **New risk finding**: a finding the client sees for the first time, with a risk level of Low, Medium, High, or Critical. The finding's risk level decides this, not its severity. A finding found again on a later scan is not new.
- **Service**: a scan type the merchant is registered for, such as Transaction Laundering.

<br>

## Problem and Goal

In MerchantView, a merchant enters Monitoring the moment it is sent to Onboarding. The client has no step to accept or reject a merchant based on its scan results, and no way to see when the next scan will run. When one portfolio decides to stop working with a merchant, users of its other portfolios do not learn about it.

Goal: Clients decide on each merchant in each portfolio, users with access to the merchant's other portfolios learn about each decision, and clients control when a merchant enters Monitoring and when it is scanned.

**Why we need it:** Atlas replaces MerchantView, and clients need a decision point between a merchant's scan results and Monitoring to manage their portfolios there.

**Value for the client:** Each portfolio decides for its own business. A client that manages portfolios per jurisdiction, vertical, or product line can terminate a merchant in one portfolio and keep it in another, and the org admin can terminate a bad actor in every portfolio at once. Users see only the portfolios they have access to. The client sees which merchants wait for review, who is reviewing them, which are monitored, and when each is scanned next.

**Why now:** All MerchantView clients must migrate to Atlas.

<br>

## Feature Behavior

### Prerequisites

- The merchant exists in one or more of the client's portfolios. Atlas holds the merchant's status and monitoring status for each portfolio.

### Requirements

**Merchant status**

Every status applies to one portfolio. A status change in one portfolio does not change the merchant's status or monitoring in its other portfolios, except when the org admin terminates it across portfolios.

| Status | When the merchant has it in a portfolio |
| --- | --- |
| To Review | Atlas sets it when the merchant is added to the portfolio, and when a scan in the portfolio produces a new risk finding. A user can select it at any time. |
| Under Review | A user selects it to show other users of the portfolio that the merchant is being reviewed. A user can select it at any time. |
| Approved | A user approved the merchant, and the portfolio works with it. |
| Rejected | A user rejected the merchant, and the portfolio does not work with it. Rejected cannot be undone. |
| Terminated | A user terminated a merchant the portfolio approved. Terminated cannot be undone. |

**Status list**
- To Review, Under Review, and Approved are in the status list for every merchant that is not Rejected or Terminated in the current portfolio.
- Rejected is in the status list for a merchant that has never had Approved status in the current portfolio.
- Terminated is in the status list only for a merchant that has had Approved status in the current portfolio. Once it has, Terminated replaces Rejected.
- The status list never shows Rejected and Terminated together.
- A merchant Rejected or Terminated in the current portfolio has no status list there. To work with it there again, the client adds it to the portfolio through the add merchant flow.

**Status after a scan**
- A scan that produces a new risk finding sets To Review in the portfolio where the scan ran.
- After the first scan, the merchant is To Review, including when the scan found no risk finding, so the client decides whether to work with it.
- A scan after the first scan with no new risk finding leaves the status unchanged. This includes a scan with no findings, findings at No Risk only, or findings found on an earlier scan.
- A scan does not change the status while it runs.
- A scan that finishes after the merchant is Rejected or Terminated in a portfolio does not change its status there.
- No scheduled scan runs on a merchant in a portfolio where it is Rejected or Terminated.

**Tabs**
- The merchant list has two tabs: Onboarding and Monitored.
- The Onboarding tab lists merchants never added to Monitoring in the current portfolio, in any status.
- The Monitored tab lists merchants added to Monitoring in the current portfolio, in any status.
- A merchant stays on its tab when its status changes, including when it is rejected or terminated.
- Each tab shows its merchant count.

**Portfolio access**
- Every message, list, and notification shows only the portfolios the user has access to.

**Approve a merchant**
1. The user selects Approved from the status list.
2. Atlas shows a message with two buttons, Approve and Go back. The message names the current portfolio.
3. The user selects Approve.
4. The merchant's status changes to Approved in the current portfolio.
5. Atlas sends the system notification described under Notifications.
6. If monitoring is off for the merchant in the current portfolio, Atlas shows a modal that invites the user to add the merchant to Monitoring:
   - Heading: "Add [merchant name] to monitoring"
   - Message: "Monitoring scans this merchant on a schedule and notifies you when a new risk finding appears."
   - A portfolio list showing every portfolio the user has access to. Each portfolio shows its services and each service's scan frequency.
   - The user can select more than one portfolio. The current portfolio is selected by default. If the current portfolio has no services with monitoring, the first portfolio in the list is selected.
   - Two buttons: Add merchant to monitoring and Go back.
7. The user selects one or more portfolios and selects Add merchant to monitoring.
8. For each selected portfolio the merchant is not associated with, Atlas associates the merchant with that portfolio with To Review status. The merchant stays associated with its existing portfolios.
9. Monitoring turns on for the merchant in each selected portfolio, its monitoring schedule starts, and it moves to the Monitored tab of each of those portfolios.
10. The merchant page shows a Monitoring on label, and the merchant's row in the merchant list shows "Monitored".
11. If the user selects Go back, the merchant stays Approved with monitoring off.

**Turn On Monitoring link**
- When monitoring is off and the merchant's status is To Review, Under Review, or Approved, the merchant page shows a "Turn On Monitoring" link next to the Monitoring off label.
- The link does not show when monitoring is on, or when the status is Rejected or Terminated.
- Selecting the link opens the monitoring modal.
- Turning on monitoring from the link does not change the merchant's status.

**Reject a merchant**
1. The user selects Rejected from the status list.
2. Atlas shows a warning with a free-text box named "Merchant rejection notes" and two buttons, Reject and Go back. The warning states:
   - The merchant is rejected in the current portfolio, which the warning names.
   - Monitoring turns off for the merchant in this portfolio, and no further scans run here.
   - Rejection cannot be undone in this portfolio.
   - Its status in its other portfolios does not change.
3. The user selects Reject. The notes are optional.
4. The merchant's status changes to Rejected, and monitoring turns off, in the current portfolio.
5. Atlas sends the system notification described under Notifications.

**Terminate a merchant**
1. The user selects Terminated from the status list.
2. Atlas shows a warning with a free-text box named "Merchant termination notes" and two buttons, Terminate merchant and Go back. The warning states:
   - The portfolios where the merchant is terminated. For a portfolio user, this is the current portfolio. For the org admin, the warning lists every portfolio the merchant is associated with, the current portfolio is selected, and the org admin can select any or all of them.
   - Monitoring turns off for the merchant in those portfolios, and no further scans run there.
   - Termination cannot be undone in those portfolios.
   - Its status in its other portfolios does not change.
3. The user selects Terminate merchant. The notes are optional.
4. The merchant's status changes to Terminated, and monitoring turns off, in each selected portfolio.
5. Atlas sends the system notification described under Notifications.

**Add a merchant that exists in the organization**
- When a client adds a merchant to a portfolio, by a single add or a bulk upload, and its client merchant key belongs to a merchant in the organization, Atlas adds that merchant to the portfolio instead of blocking the add.
- Its status in that portfolio is To Review. This applies when the merchant is Rejected or Terminated in that portfolio or in other portfolios.
- Details entered in the add update the merchant's shared details, in every portfolio it is associated with.

**Add a merchant to another portfolio**
1. The user selects Add to portfolio on the merchant's page or row.
2. Atlas shows a list of the portfolios the user has access to that the merchant is not associated with, and two buttons, Add to portfolio and Go back. The user can select more than one portfolio.
3. The user selects one or more portfolios and selects Add to portfolio.
4. Atlas associates the merchant with each selected portfolio with To Review status. The merchant shows on the Onboarding tab of each of those portfolios, with monitoring off. No Onboarding scan runs. Its status and monitoring in its existing portfolios do not change.
- Add to portfolio is available in every status, and unavailable when the merchant is associated with every portfolio the user has access to.

**Remove from portfolio and Permanently delete**
- The merchant's page and row show Remove from portfolio when the merchant is associated with more than one portfolio. It is available in every status.
- Permanently delete shows for the org admin only, next to Remove from portfolio. It is available in every status.

**Remove from portfolio**
1. The user selects Remove from portfolio.
2. Atlas shows a message with two buttons, Remove from portfolio and Go back. The message states the portfolios the merchant is removed from:
   - For a portfolio user, the current portfolio.
   - For the org admin, a list of every portfolio the merchant is associated with, with the current portfolio selected. The org admin can select more than one, and must leave at least one unselected. To remove the merchant from every portfolio, the org admin uses Permanently delete.
3. The user selects Remove from portfolio.
4. The merchant is no longer associated with the selected portfolios. It does not show on either tab there, and no scans run for it there.
5. Its status and monitoring in its other portfolios do not change.
6. Atlas sends the system notification described under Notifications.

**Permanently delete**
1. The org admin selects Permanently delete.
2. Atlas shows a warning with two buttons, Permanently delete and Go back. The warning states:
   - The merchant is deleted from every portfolio it is associated with. The warning lists each of those portfolios by name.
   - Monitoring turns off for the merchant, and no further scans run.
   - Deletion cannot be undone.
   - To work with the merchant again, the client must add it to Atlas as a new merchant.
3. The org admin selects Permanently delete.
4. The merchant is no longer associated with any portfolio. It does not show on any tab, and no scans run for it.
5. Atlas sends the system notification described under Notifications.

**Notifications**
- Atlas sends a system notification when the merchant's status changes to Approved, Rejected, or Terminated, when it is removed from a portfolio, and when it is permanently deleted.
- The notification goes to:
  - Users of the portfolio where the change was made.
  - Users of the merchant's other portfolios who also have access to the portfolio where the change was made.
  - The org admin.
- The notification states the merchant, the portfolio, the new status or the action, the date, the user who made the change, and the rejection or termination notes when the user entered them.

**Next scheduled check**
- A merchant with monitoring on shows the date of its next scheduled scan for each service in the current portfolio.
- A merchant with monitoring off shows no next scheduled scan date.

**Clean scan**
- When the merchant's latest scan found no finding with a risk level of Low, Medium, High, or Critical, the merchant page shows the merchant's URL and the latest scan date, and under the Findings header shows: "Clean scan. No violations or risks were found in this scan."

**Services column**
- The merchant list column named Categories is renamed Services.
- It shows the names of the merchant's services that have a finding with a risk level of Critical, High, Medium, or Low, ordered by each service's highest risk level, Critical first.
- A service with no finding at Low or above does not show.

**Manual scan**
1. The user selects a scope for any merchant that is not Rejected or Terminated in the current portfolio:
   - One merchant: from the merchant's page or row.
   - Portfolio: all merchants in one portfolio the user picks, except merchants Rejected or Terminated in that portfolio.
   - Service: one service, for one merchant or for one portfolio.
2. For a scope with more than one merchant, Atlas shows the number of merchants included and asks for confirmation.
3. The user confirms.
4. Atlas starts the scan.
5. A confirmation message states how many merchants are being scanned.
- Manual scans have no quota.

**Errors**
1. A manual scan of a merchant with any scan in progress, manual or scheduled, is blocked, and Atlas shows "A scan is already running for this merchant."
2. In a portfolio or service scan, merchants with any scan in progress are skipped, and the confirmation message states how many were skipped.
3. The monitoring modal shows only after a user approves a merchant or selects the Turn On Monitoring link.
4. For a merchant Rejected or Terminated in the current portfolio, the status list and manual scan are unavailable there.
5. If the user selects Go back in the Approve, Reject, Terminate, Add to portfolio, Remove from portfolio, or Permanently delete message, nothing changes.

<br>

## Acceptance Criteria

**Scenario: New merchant added**
- Given a merchant added to Atlas in portfolios A and B
- When it is added
- Then its status is To Review in portfolios A and B

**Scenario: Under Review stays in one portfolio**
- Given a merchant in To Review status in portfolios A and B
- When a user in portfolio A selects Under Review
- Then its status is Under Review in portfolio A and To Review in portfolio B

**Scenario: Approve a merchant in one portfolio**
- Given a merchant in Under Review status in portfolio A and To Review status in portfolio B
- When a user in portfolio A selects Approved
- Then a message names portfolio A and shows the buttons Approve and Go back
- And after the user selects Approve, its status is Approved in portfolio A and To Review in portfolio B

**Scenario: Notification respects portfolio access**
- Given a merchant in portfolios A and B, user X with access to A and B, and user Y with access to B only
- When a user in portfolio A terminates the merchant
- Then user X and the org admin receive a notification with the merchant, portfolio A, Terminated, the date, and the user
- And user Y receives no notification

**Scenario: Monitoring modal after approval**
- Given a merchant with monitoring off in portfolio A, and a user with access to portfolios A, B, and C
- When the user approves the merchant in portfolio A
- Then a modal lists portfolios A, B, and C, each with its services and scan frequencies
- And portfolio A is selected
- And after the user selects Add merchant to monitoring, monitoring is on in portfolio A and the merchant is on the Monitored tab there
- And it shows a next scheduled check date for each service in portfolio A

**Scenario: Add to monitoring in a new portfolio**
- Given a merchant associated with portfolio A only, and a user with access to portfolios A, B, and C
- When the user approves it, selects portfolios A and C in the monitoring modal, and selects Add merchant to monitoring
- Then its status is Approved in portfolio A and To Review in portfolio C
- And monitoring is on in portfolios A and C
- And it is not associated with portfolio B

**Scenario: Default portfolio without monitoring services**
- Given portfolio A has no services with monitoring, and portfolio B is first in the portfolio list
- When a user in portfolio A approves a merchant
- Then the monitoring modal selects portfolio B

**Scenario: Go back from the monitoring modal**
- Given the monitoring modal is open after approval
- When the user selects Go back
- Then the merchant is Approved with monitoring off
- And the merchant page shows the Turn On Monitoring link next to the Monitoring off label

**Scenario: Turn on monitoring from the link**
- Given a To Review merchant with monitoring off
- When the user selects Turn On Monitoring, selects a portfolio, and selects Add merchant to monitoring
- Then monitoring turns on in that portfolio
- And the merchant's status stays To Review

**Scenario: Scan with a new risk finding in one portfolio**
- Given a merchant Approved in portfolios A and B
- When a scan in portfolio A produces a new finding with a risk level of Low
- Then its status is To Review in portfolio A and Approved in portfolio B

**Scenario: Scan with no new risk finding**
- Given an Approved merchant with an existing finding at a risk level of High
- When a scan finds the same finding again and new findings at No Risk only
- Then its status is Approved

**Scenario: First scan with no risk**
- Given a merchant added to Atlas
- When its first scan finds no finding at Low or above
- Then its status is To Review and the merchant page shows "Clean scan. No violations or risks were found in this scan."

**Scenario: Services column**
- Given a merchant with a High finding in one service, a Critical finding in a second, and only No Risk findings in a third
- Then the Services column shows the second service, then the first, and not the third

**Scenario: Reject a merchant in one portfolio**
- Given a merchant in To Review status in portfolios A and B, never approved
- When a user in portfolio A selects Rejected
- Then a warning names portfolio A, states that monitoring turns off there, that rejection cannot be undone in this portfolio, and that its status in its other portfolios does not change
- And after the user selects Reject, its status is Rejected and monitoring is off in portfolio A, and its status is To Review in portfolio B
- And in portfolio A it shows no status list and no manual scan

**Scenario: Terminated replaces Rejected**
- Given a merchant that had Approved status in portfolio A and is now in To Review status there
- When the user in portfolio A opens the status list
- Then it shows Terminated and does not show Rejected

**Scenario: Portfolio user terminates in one portfolio**
- Given a monitored merchant Approved in portfolios A, B, and C, and a portfolio user in portfolio A
- When the user selects Terminated and selects Terminate merchant
- Then its status is Terminated and monitoring is off in portfolio A
- And it stays Approved and monitored in portfolios B and C

**Scenario: Org admin terminates across portfolios**
- Given a merchant Approved in portfolios A, B, and C
- When the org admin selects Terminated in portfolio A, selects portfolios A, B, and C, and selects Terminate merchant
- Then its status is Terminated and monitoring is off in portfolios A, B, and C

**Scenario: Add a merchant terminated in a portfolio**
- Given merchant Z is Terminated in portfolio A
- When a user adds a merchant with merchant Z's client merchant key to portfolio B, by a single add or a bulk upload
- Then merchant Z is associated with portfolio B with To Review status, and stays Terminated in portfolio A
- And when a user later adds it to portfolio A through the add merchant flow, its status in portfolio A is To Review

**Scenario: Add a merchant to another portfolio**
- Given a merchant Approved and monitored in portfolio A
- When a user selects Add to portfolio, selects portfolio B, and selects Add to portfolio
- Then its status is To Review in portfolio B, with monitoring off, on the Onboarding tab of portfolio B
- And its status and monitoring in portfolio A do not change

**Scenario: Portfolio user removes a merchant from one portfolio**
- Given a merchant monitored in portfolios A and B, and a portfolio user in portfolio A
- When the user selects Remove from portfolio and confirms
- Then the merchant does not show on either tab of portfolio A and no scans run for it there
- And its status and monitoring in portfolio B do not change

**Scenario: Remove from portfolio hidden for one portfolio**
- Given a merchant associated with portfolio A only
- When a portfolio user opens the merchant's page
- Then Remove from portfolio and Permanently delete do not show

**Scenario: Permanently delete a merchant**
- Given a merchant in portfolios A, B, and C
- When the org admin selects Permanently delete
- Then a warning lists portfolios A, B, and C, states that deletion cannot be undone, and shows the buttons Permanently delete and Go back
- And after the org admin selects Permanently delete, the merchant does not show on any tab of portfolios A, B, or C, and no scans run for it

**Scenario: Manual scan of a portfolio**
- Given a portfolio with 50 merchants that are not Rejected or Terminated in it, and 3 that are
- And 2 of the 50 have a scheduled scan running
- When the user triggers a manual scan of the portfolio
- Then Atlas shows that 50 merchants are included and asks for confirmation
- And after the user confirms, scans start for 48 merchants
- And the confirmation message states that 2 merchants were skipped

**Scenario: Manual scan blocked during a running scan**
- Given a merchant with a scheduled scan running
- When the user triggers a manual scan for it
- Then no scan starts
- And Atlas shows "A scan is already running for this merchant."

<br>

## Data

**Baseline**
- Time from a merchant reaching To Review to an Approved, Rejected, or Terminated decision: TBD, first month after Atlas launch. Source: Atlas status change records.
- Number of support requests for on-demand rescans: TBD. Source: support tickets.

**Success measure**
- Decrease the time from a merchant reaching To Review to an Approved, Rejected, or Terminated decision: target set by BI.
- Decrease support requests for on-demand rescans: target set by BI.

**Recorded data**
- Merchant status per portfolio and the date of each status change.
- The user who set each status or added each merchant to Monitoring.
- Each approval, rejection, and termination: the portfolios it applied to, the notes, and the users notified.
- Each manual scan: scope, service, user, and date.
- Each addition to a portfolio, removal from a portfolio, and permanent deletion: the portfolios it applied to, the user, and the date.

<br>

## Open Questions / Assumptions

- Decide whether a user can turn monitoring off for an Approved merchant.
- Decide which roles, other than the org admin, can change a status, manage Monitoring, scan, and add or remove merchants.
- Check with Franz and CompOps whether a merchant can have different MIDs per portfolio, and whether users of one portfolio may see MIDs from another.
- Check with Core whether the platform shows the next scheduled scan date per service for each merchant.
- Decide whether to amend the Atlas PRD that RT-1657 names as describing the old rule, where every non-Terminated merchant goes to To Review after every scan.
