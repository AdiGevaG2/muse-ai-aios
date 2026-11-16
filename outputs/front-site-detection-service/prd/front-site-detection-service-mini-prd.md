# Front Site Detection Service - Mini PRD

**TL;DR:**
Show a positive Front Site Detection result as a Critical finding on the merchant screen, so client analysts review the merchant before activation or continuation.

<br>

## Prototype

[Open prototype](https://github.com/evercompliant/g2rs-design-system/blob/master/design-system/pm-prototypes/front-site-detection-service-2026-11-16.html) in the G2RS design system repo. Download the file and open it in a browser.

<br>

## Definitions

- **Front Site Detection (FSD)**: A service that checks whether the website a merchant declares shows its real business, or is a cover for a different business. For example, a merchant declares a handbag store, but the store is a cover for processing payments for a pharmaceutical business the merchant did not disclose.
- **Suspected Front Site**: The finding the application shows on a merchant when FSD identifies the merchant's website as a cover.
- **Onboarding**: A scan of a merchant before activation.
- **Monitoring**: Recurring scans of an active merchant in the client's portfolio.

<br>

## Problem and Goal

FSD returns a true or false result and a written explanation for each scanned site. The application does not show this result, so a client analyst cannot see that a merchant is a suspected front.

Goal: A true FSD result appears on the merchant as a Critical finding with its reasoning and evidence, using the existing findings model.

**Why we need it:** FSD is sold as a scan add-on, and the result has no place in the application today.

**Value for the client:** The analyst sees which merchants are suspected fronts, reads why, and reviews them before activation or continuation.

<br>

## Feature Behavior

### Prerequisites

- FSD is enabled in the portfolio settings for the merchant's scan stage. The UI names this service "Front Site Detection".
- The merchant is scanned at Onboarding or is under Monitoring.

### Portfolio Settings

1. Portfolio settings list "Front Site Detection" under Onboarding Services and under Monitoring Services, like every other service.
2. Each listing has its own on/off toggle, so FSD is enabled for Onboarding and for Monitoring separately.
3. Under Monitoring Services, FSD has its own cadence, with the same frequency and day options as every other monitoring service.
4. When FSD is off for a stage, scans at that stage do not run FSD and create no Suspected Front Site finding.

### Requirements

1. A scan completes and Core returns FSD true for the merchant's site.
2. The merchant screen shows a separate section titled "FSD".
3. The application adds the finding as an entry under the FSD section.
4. The finding entry shows only these fields:
   - Name: "Suspected Front Site".
   - Evidence icon, shown only when Core returns evidence, such as a screenshot.
   - Severity: Critical.
   - Risk.
   - Decision.
5. The merchant's overall risk is calculated from all its findings, the same way as for every other finding.
6. In the merchants list, the categories column shows "FSD" for the merchant, as a standalone service.
7. The analyst clicks the finding entry or its evidence icon.
8. The application opens the evidence view, which shows:
   - The analyzed URL.
   - A screenshot of the full page of the site.
   - The FSD explanation Core returns in `evidence_text`, as the headline of the side panel. An explanation of more than one sentence shows as bullet points.
   - "About this check" as a footnote at the bottom of the side panel, below a divider: fixed text, the same on every Suspected Front Site finding: "Checks whether the website a merchant declares shows its real business, or is a cover for a different business."
9. The analyst takes the same actions on the finding that exist for every other finding.

**What is not shown**
- An FSD false result does not create a finding.
- The finding entry does not show the explanation. The explanation appears only in the evidence view.
- If Core returns no evidence, the finding entry shows no evidence icon, and the evidence view shows the explanation without a screenshot.
- The application does not show an "FSD: clear" or "verified" state. No finding can mean the site was skipped, data was missing, or processing failed.

**Permissions**
- Users who can see a merchant's findings see the Suspected Front Site finding. No FSD-specific permission exists.

**API**
- Core runs FSD only on scans where FSD is turned on. It is off by default.
- Core returns FSD as true or false, with the explanation and the analyzed URL.
- The finding arrives in the scan's findings, after the other findings. Core keeps the other findings unchanged.
- FSD true is a finding with sub-type 389. Every other FSD result arrives as sub-type 1012 and is FSD false. This includes results where the page was empty, the domain failed validation, or processing failed.
- Each FSD finding carries a `score` field. It is Core's internal outcome code, for example 80 for a suspected front site, 1 for a processing error, 0 for a neutral result. It has no meaning for the client. The application does not read, store, or show it.

<br>

## Acceptance Criteria

**Scenario: FSD true shows as a Critical finding**
- Given FSD is enabled in the portfolio settings for the merchant's scan stage
- And the merchant is scanned at Onboarding or is under Monitoring
- And Core returns FSD true
- When the analyst opens the merchant screen
- Then the merchant screen shows a separate section titled "FSD"
- And the FSD section shows one entry with only these fields: name "Suspected Front Site", evidence icon, severity Critical, risk, and decision
- And the merchants list shows "FSD" in the merchant's categories column
- And no "Signals" category appears for the finding
- And the explanation does not appear on the finding entry

**Scenario: Analyst opens the FSD evidence**
- Given a merchant has a Suspected Front Site finding
- And Core returned evidence for the finding
- When the analyst clicks the evidence icon on the finding entry
- Then the evidence view shows the analyzed URL and a screenshot of the full page of the site
- And the side panel shows the FSD explanation from Core as its headline
- And the bottom of the side panel shows "About this check" with the fixed FSD description

**Scenario: No evidence from Core hides the evidence icon**
- Given a merchant has a Suspected Front Site finding
- And Core returned no evidence for the finding
- When the analyst opens the merchant screen
- Then the finding entry shows no evidence icon
- And the entry shows the name, severity, risk, and decision
- When the analyst clicks the finding entry
- Then the evidence view shows the explanation as bullet points and no screenshot

**Scenario: FSD false shows nothing**
- Given FSD is enabled in the portfolio settings for the merchant's scan stage
- And Core returns FSD false
- When the analyst opens the merchant screen
- Then no Suspected Front Site finding appears
- And no "FSD: clear" or "verified" state appears

**Scenario: FSD is a service in portfolio settings**
- Given a G2RS internal user opens the portfolio settings
- Then Onboarding Services and Monitoring Services each list "Front Site Detection" with an on/off toggle
- And Monitoring Services shows a cadence for Front Site Detection
- When the internal user turns Front Site Detection off under Monitoring Services
- Then the Front Site Detection cadence is disabled
- And Monitoring scans for the portfolio create no Suspected Front Site finding

<br>

## Data

**Baseline**
- Share of scanned sites flagged by FSD: TBD; not measured for the application. Expected about 0.5% of a portfolio per the GTM Brief. Reported at about 0.05%, 5 per 10,000 sites, on the legacy pipeline since late September 2026, per the detection-logic page. Source: Core FSD results for FSD-enabled scans.

**Success measure**
- Increase precision of released FSD findings: 85% or higher.
- Keep flag volume: 0.5% of a portfolio, up to 1% when new fraud networks emerge. Spikes above that are investigated.

**Recorded data**
- The Suspected Front Site finding on the merchant: name, category, severity, risk, decision, explanation, analyzed URL, and screenshot when Core returns one.
- The portfolio's Front Site Detection settings: on or off for Onboarding, on or off for Monitoring, and the Monitoring cadence.

<br>

## Open Questions / Assumptions

- Confirm with Core that FSD results are delivered for Monitoring scans. The Phase 1 guide and the detection-logic page document only the onboarding topics.
- Confirm with Yonatan Eisenberg how the application gets a full-page screenshot of the site for the evidence view. The FSD output in the detection-logic page has no screenshot field.
- Confirm with Core that it returns the explanation as separate points the application can show as bullet points. The Phase 1 guide shows it as one paragraph.
- Confirm with Gal Sahar the cause of the drop in FSD findings from 0.5% to 0.05% since late September 2026, before setting the flag-volume baseline.
- Decide whether the FSD section appears on the merchant screen when FSD returns false.
- Decide the risk value shown on the Suspected Front Site entry.
- Decide which alert fires for a Suspected Front Site finding, and who receives it.
- Confirm the maximum length of the FSD explanation to design for.
- Confirm with Gal Sahar whether the threshold that releases Critical findings changes to match the 85% precision target. The GTM Brief and the Phase 1 guide state above 90%.
- Run an end-to-end test that traces an FSD result from Core into the merchant screen.
- Add the trigger for doing this now.
- Decide whether Front Site Detection is on or off by default in a new portfolio.
