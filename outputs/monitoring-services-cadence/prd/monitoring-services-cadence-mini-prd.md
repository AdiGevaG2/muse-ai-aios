# Monitoring Services Cadence - Mini PRD

**TL;DR:**
UI: turn each service on or off and set its scan cadence and start day per portfolio from the portfolio's Monitoring Services screen, saved with the Save General Settings button; show each service's own last-scanned date on the merchant Findings screen. Manual scan is Phase 2.

<br>

## Definitions

- **Portfolio**: a grouping of merchants in the organization, used to manage them together under one set of settings. Each merchant is associated with a portfolio.
- **Product**: the offering a client has registered for a portfolio or merchant, either Onboarding or Monitoring.
- **Service**: one of the scan types a portfolio can run against its merchants. Onboarding Services offers three: Content Categories & Speciality MCC, Full MCC Detection, and Connected URLs (Graph). Monitoring Services offers two: Content Categories and Connected URLs (Graph).
- **Cadence**: how often a service scans a portfolio's merchants under Monitoring, expressed as one of five options: Daily, a scan every day; Weekly, a scan once a week on a chosen day; Biweekly, a scan once every two weeks on a chosen day; Monthly, a scan once a month on a chosen day; or Quarterly, a scan once every three months.
- **Start day**: the day within the cadence's interval a service's scan runs on, chosen by the risk manager or platform admin. For Weekly this is a day of the week; for Monthly this is a day of the month.
- **Monitoring G2 Analyst Review**: G2's internal review of one service's findings on a portfolio before they are released to the client, turned on per portfolio by a feature flag of the same name.
- **Manual scan**: an immediate scan of a service on a portfolio, run outside of and without changing that service's cadence. Phase 2.

<br>

## Problem and Goal

A portfolio can only have one active scan schedule today. If two services on the same portfolio need different cadences, for example Content Categories monthly and Connected URLs weekly, the second schedule overwrites the first.

Goal: each service on a portfolio has its own independent cadence and start day, set from the portfolio's Monitoring Services screen.

<br>

## Feature Behavior

**Figma**
- [Settings - Atlas](https://www.figma.com/design/xX0m6rHUVqimK3G9iv0LHC/Settings---Unified-Platform?node-id=6148-11282&t=wAbvlAzgDvOcl8jK-4), embedded on the Confluence page.

### Prerequisites

- The portfolio has Monitoring enabled.
- Cadence and start day are set by a risk manager or platform admin.

### Requirements

**Set cadence and start day (UI)**
1. Monitoring Services has two services: Content Categories and Connected URLs (Graph). MCC is not one of them; its cadence is set under Onboarding Services instead.
2. Each service has its own Cadence dropdown: Daily, Weekly, Biweekly, Monthly, or Quarterly.
3. Each service has an "On every" dropdown for the start day. It shows days of the week for Weekly and Biweekly, and days of the month for Monthly. When a Monthly start day does not exist in a month, that month's scan runs on its last day. When the cadence is Monthly or Quarterly, a note under the dropdowns reads: "If the selected day doesn't exist in a given month, the scan runs on the last day of that month."
4. Cadence, start day, and service on/off changes save only when the risk manager or platform admin selects Save General Settings. No change on the screen saves on its own. Leaving the screen with unsaved changes, by Cancel, the close button, or navigating away, opens a prompt: "You have unsaved changes. Save them before leaving, or your changes will not apply." The prompt offers Save Changes, which saves and closes, and Leave Without Saving, which discards the changes and closes. If Save Changes fails, the prompt closes, the screen stays open, and the save-failure toast shows.
5. Each service keeps its own cadence and start day. Changing one service never changes another.
6. A saved change to cadence or start day applies from the next scan that has not started. A scan in progress at the time of saving runs to completion. A scheduled scan that has not started does not run on the old dates; the next scan follows the new cadence and start day.
7. Biweekly runs every second occurrence of the chosen weekday.
8. Daily and Quarterly have no "On every" value.
9. When a service's cadence is Daily, Weekly, or Biweekly, a note under that service's Cadence dropdown reads: "Monitoring G2 Analyst Review is available only for a Monthly or Quarterly cadence." When the cadence is Monthly or Quarterly, no Monitoring G2 Analyst Review note shows. The note follows the cadence shown in the dropdown, including when the screen opens and after a failed save. A Daily, Weekly, or Biweekly cadence does not turn off Monitoring G2 Analyst Review for the portfolio, but findings from that service's scans do not go through Monitoring G2 Analyst Review.
10. Each service has an on/off toggle. A service turned off and saved stops scanning from its next scan. A scan of that service in progress at the time of saving runs to completion; a scheduled scan that has not started does not run. While a service's toggle is off, its Cadence and "On every" dropdowns are disabled and the month-end note and the Monitoring G2 Analyst Review note do not show. From turning the toggle off until Save General Settings, a note under the dropdowns reads: "This service stops from the next scan cycle. A scan in progress will complete." The note does not show once the change is saved.
11. Turning a service back on does not restore its previous cadence and start day. Its Cadence resets to Monthly and its "On every" to the 1st, the same values a service receives when it is turned on for the first time.

**Show last-scanned date per service (UI)**
1. A merchant's Findings screen groups findings under one header per service: Content Categories, Connected URLs (Graph), and MCC.
2. Each header shows when that service last scanned the merchant, separate from the others.

**Errors**
1. Saving fails: the Cadence and "On every" dropdowns and the on/off toggles keep the unsaved values on screen for a retry and an error toast reads: "Changes not saved. Try again."

**API**
- Each cadence schedule is identified by portfolio and service together. Setting a schedule for one service must never overwrite or disable another service's schedule on the same portfolio.
- The accepted cadence values are Daily, Weekly, Biweekly, Monthly, and Quarterly for every service.
- Each schedule carries an on/off state. Turning a service on creates its schedule with Monthly on the 1st; no earlier cadence or start day is reused.
<br>

## Acceptance Criteria

**Scenario: Each service gets its own cadence on a portfolio**
- Given a portfolio has Monitoring enabled
- And the portfolio has no cadence set for Content Categories
- When a cadence is set for Content Categories on that portfolio
- Then Content Categories scans on that cadence
- And Connected URLs (Graph)'s cadence on that portfolio does not change

**Scenario: A second service's cadence does not overwrite the first**
- Given a portfolio has a cadence set for Content Categories
- When a cadence is set for Connected URLs (Graph) on the same portfolio
- Then Content Categories and Connected URLs (Graph) each run on their own cadence
- And Content Categories' schedule stays the same

**Scenario: Each service's findings show its own last-scanned date**
- Given a merchant has findings from more than one service
- When the merchant's Findings screen is viewed
- Then each service's findings appear under that service's own header
- And each header shows that service's own last-scanned date

**Scenario: Cadence, start day, and on/off changes save only with Save General Settings**
- Given the portfolio's Monitoring Services screen is open
- When the risk manager or platform admin selects a new value in a service's Cadence dropdown or "On every" dropdown, or turns a service's toggle on or off
- Then the change is not saved yet
- And when the risk manager or platform admin selects Save General Settings, the value is saved to the portfolio

**Scenario: Leaving with unsaved changes asks before discarding them**
- Given the risk manager or platform admin changed a service's Cadence and has not selected Save General Settings
- When the risk manager or platform admin selects Cancel or the close button
- Then a prompt reads "You have unsaved changes. Save them before leaving, or your changes will not apply."
- And Save Changes saves the change and closes the screen
- And Leave Without Saving discards the change and closes the screen

**Scenario: A Monthly start day missing from a month runs on the month's last day**
- Given a service's Cadence is Monthly with "On every" set to 31st
- When a month has 30 days
- Then that month's scan runs on the 30th
- And the month-end note shows under the dropdowns whenever the Cadence is Monthly or Quarterly

**Scenario: Start day options match the selected cadence**
- Given a service under Monitoring Services has its Cadence set to Weekly
- When the risk manager or platform admin opens that service's "On every" dropdown
- Then the options shown are days of the week
- And selecting a cadence of Biweekly keeps the "On every" options as days of the week
- And selecting a cadence of Monthly instead changes the "On every" options to days of the month

**Scenario: A cadence or start day change takes effect from the next scan that has not started**
- Given a service on a portfolio has a scan in progress and a next scan scheduled on its current cadence and start day
- When that cadence or start day is changed and saved
- Then the scan in progress runs to completion
- And the next scan runs on the new cadence and start day, not on the previously scheduled date

**Scenario: A cadence shorter than Monthly shows the Monitoring G2 Analyst Review note**
- Given the portfolio's Monitoring Services screen is open
- When the risk manager or platform admin sets a service's Cadence to Daily, Weekly, or Biweekly
- Then the note "Monitoring G2 Analyst Review is available only for a Monthly or Quarterly cadence." shows under that service's Cadence dropdown
- And after saving, Monitoring G2 Analyst Review stays on for the portfolio
- And findings from that service's scans do not go through Monitoring G2 Analyst Review

**Scenario: A Monthly or Quarterly cadence shows no Monitoring G2 Analyst Review note**
- Given a service's Cadence is Weekly and the Monitoring G2 Analyst Review note shows under it
- When the risk manager or platform admin sets that service's Cadence to Monthly or Quarterly
- Then the note no longer shows under that service's Cadence dropdown

**Scenario: Turning a service off stops it from the next scan**
- Given a service on a portfolio is on and a scan of that service is in progress
- When the risk manager or platform admin turns that service's toggle off
- Then the note "This service stops from the next scan cycle. A scan in progress will complete." shows under that service's dropdowns
- And after Save General Settings, the scan in progress completes
- And no further scan of that service runs

**Scenario: Turning a service back on resets it to Monthly on the 1st**
- Given a service was saved as off, and before that its Cadence was Weekly with "On every" set to Tuesday
- When the risk manager or platform admin turns that service's toggle on
- Then its Cadence shows Monthly and its "On every" shows 1st
- And after Save General Settings, the service scans Monthly on the 1st

<br>

## Data

**Baseline**
- Portfolios with both Content Categories and Connected URLs (Graph) enabled under Monitoring: TBD. Source: Atlas portfolio settings in Snowflake.
- Of those portfolios, the number whose first service's schedule was overwritten by the second service's schedule: TBD. Source: Atlas monitoring scheduler records.
- Portfolios with the two services on different cadences: 0. Today a portfolio holds one schedule, so two cadences cannot coexist.

**Success measure**
1. Primary: every service that is on has its scheduled scans run on that service's own cadence and start day, and no portfolio has a service schedule overwritten by another service's schedule. Measured per portfolio and service for 60 days after release.
2. Secondary: the number of portfolios with Content Categories and Connected URLs (Graph) on different cadences, 60 days after release.

**Recorded data**
- Per portfolio and service: on/off state, cadence, and start day.
- Per merchant and service: the date that service last scanned the merchant.

<br>

## Open Questions / Assumptions

- Open decision: today's schedule is keyed by portfolio only, which is why one service's schedule overwrites another's. The spec must key it by portfolio and service together.
- Open question: who or what is allowed to call these endpoints is not yet defined. Confirm during spec.
- Open question: whether per-service cadence is achievable from the Core side is unconfirmed. Check with Core team.
<br>

## Out of Scope

- MCC cadence under Monitoring Services. MCC has no cadence control on this screen; it is configured only under Onboarding Services.
- Manual scan (triggering an immediate scan for a service on a portfolio, independent of its cadence). Deferred to Phase 2.

<br>

## Comment History

| Commenter | Comment | Reply | Sentence it was on |
|---|---|---|---|
| Sara Craven (2026-09-15) | We should consider letting the user configure a start date (or day of the week for weekly) for each cadence separately. E.g. if I set up Graph for weekly, I want it to run on Tuesdays. If I set up MCC for monthly, I want it to run on X date. | Added a per-service "On every" start day dropdown (day of week for Weekly, day of month for Monthly), saved separately per service. | The start day keeps today's behavior: the first scan runs on whatever calendar day the cadence was set, and every following scan repeats on that same day at the cadence's interval. It does not wait for the start of the next month, and it does not run immediately. |
| Sara Craven (2026-09-15) | QQ here - what if the client only has Monitoring, and not Onboarding? | No reply yet. | Monitoring: the ongoing, recurring scanning of merchants that already passed their first scan. Monitoring never runs a merchant's first scan. |
| Sara Craven (2026-09-15) | I think we should be able to run one without it - I could see us running one-time scans for POCs for example without setting up an actual cadence. | Alex Gershun: I think once product is enabled (by toggling on at least one of the services) we would need a default cadence in place. | ASSUMED: a product needs a cadence already set before a manual scan can run on it. Confirm whether manual scan should work without one. |
| Alex Gershun (alex.gershun@g2risksolutions.com, 2026-09-16) | Wouldn't it be a low hanging fruit to add the option in portfolio/product config, a simple drop-down + "scan now" option. | Adi Geva: depends on Dana Fridman's availability, I don't want it to delay dev. Then: scope updated to Backend and UI, with cadence as a dropdown per service, saved with the Save General Settings button. Manual scan itself has since moved to Phase 2 / Out of Scope, per Figma evidence showing no manual-scan control on the Monitoring Services screen. | Backend only |
| Alex Gershun (alex.gershun@g2risksolutions.com, 2026-09-16) | Agree with Sarah, we might want to drop this part. | No reply yet. | that already passed their first scan. |

Two of these threads (the start-day comment and the "Backend only" comment) were anchored to sentences since replaced in the document body; their highlights no longer show inline in Confluence, so they are captured here for record.
