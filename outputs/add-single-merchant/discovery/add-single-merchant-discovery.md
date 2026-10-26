# Discovery: Add Single Merchant

Document Name: add-single-merchant-discovery

Feature Name: Add Single Merchant
Owner: Adi Geva
Product: Atlas
Last Updated: 2026-09-03

## TL;DR

### Executive Takeaway

Users need a direct way to add one merchant to monitoring without adding it to onboarding. The feature reuses the existing **Add New Merchant** side panel for clients migrating with monitoring products only. The merchant inherits the current portfolio's monitoring configuration. At submission, the user chooses between an immediate scan and the next scheduled cycle.

## Problem

### Pain Points

- Users need a direct way to add one merchant for monitoring from the merchant list page.
- The current Add action adds the merchant to onboarding and monitoring; migrating clients need it to add the merchant to monitoring only because onboarding is later on the roadmap.
- Users need to see the current portfolio, monitoring cycle, and enabled products before they create the merchant.
- Users need a clear choice between scanning immediately and waiting for scheduled monitoring.

## Proposed Solution

### Feature Behavior

Keep the existing **Add** action and **Add New Merchant** side panel. Show all fields in one form. Do not use steps. (**Existing; reuse as-is.**)

#### Portfolio and Monitoring Summary

- Show the monitoring cycle and enabled products beside the existing portfolio name. (**Existing:** portfolio name. **To develop:** monitoring cycle and enabled-products summary.)
- Represent the monitoring cycle and enabled products configured in the current portfolio. (**Existing:** portfolio configuration. **To develop:** expose it in the side panel.)
- Keep this information read-only. (**To develop:** read-only presentation in the side panel.)
- Keep configuration changes under **Portfolio Settings**. (**Existing; retain as-is.**)

#### Merchant Details

- Use the current merchant fields and validation rules listed in **Assumptions**. (**Existing; reuse as-is.**)
- Show each validation error beside the affected field or URL row. (**To develop or verify:** error placement is not confirmed by current-state evidence.)
- Do not create or update a merchant when validation fails. (**Existing; retain as-is.**)

#### Create Merchant

- Provide **Create merchant and scan now** and **Create merchant and scan later** actions. (**To develop.**)
- Both actions create the merchant and start monitoring with the current portfolio settings. (**Existing:** merchant, portfolio, and product assignment. **To develop:** monitoring-only action handling.)
- Do not add the merchant to onboarding. (**To develop:** change the current onboarding-and-monitoring behavior.)
- **Scan now** requests an immediate monitoring scan and keeps the merchant in the next scheduled monitoring cycle. (**To develop.**)
- **Scan later** waits for the next monitoring cycle. (**To develop.**)
- Confirm the merchant, portfolio, monitoring cycle, and scan choice. (**To develop.**)
- If saving fails, show that the save failed and the reason; do not persist the merchant. (**Existing:** transactional no-persist behavior. **To develop or verify:** failure-reason presentation.)
- Any configured product that requires beneficial-owner data at creation must ask for it in this form rather than deferring collection. (**To develop or verify:** see Open Questions, no product currently confirmed to require it at creation.)

### User Journey

Figma: https://www.figma.com/design/kxzxm9iEiCqzo2ewSKAoWA/Unified-Platform-2026?node-id=1555-53728&t=LFnhDf9xq6gA55XS-4

1. The user clicks **Add** above the merchant list.
2. The existing **Add New Merchant** side panel slides in.
3. The system shows the current portfolio, its monitoring cycle, and its enabled products as read-only context.
4. The user enters the merchant identity details and at least one merchant URL.
5. The user may add more merchant URLs.
6. The system validates required fields, formats, and Unique ID uniqueness.
7. The user chooses **Create merchant and scan now** or **Create merchant and scan later**.
8. The system creates the merchant for monitoring only, associates it with the current portfolio, and applies its configured products.
9. If requested, the system starts an immediate monitoring scan and retains the next scheduled scan.
10. The system confirms the created merchant and its monitoring state.

### Assumptions

These current behaviors were verified in `marketview-portal`, `mlrc-bff-2.0`, and `mlrc-merchant`.

| Assumption | Current behavior or evidence | Caveat or validation needed |
|---|---|---|
| A user can add one merchant from the merchant list. | **Add** above a specific portfolio's merchant list opens the existing **Add New Merchant** side panel. | The current action adds the merchant to onboarding and monitoring; the proposed behavior must add it to monitoring only. |
| The active portfolio is fixed during creation. | The side panel shows its name and has no portfolio selector. | None. |
| The merchant is assigned to the active portfolio. | Creation includes the active portfolio, its monitoring cycle, and its enabled products. | None. |
| Ineligible portfolios are blocked. | The UI and backend block inactive portfolios and portfolios without enabled products, showing: "This portfolio has no active products. Merchant uploads and scans will be unavailable until an admin enables at least one product in Settings." | Retain the existing behavior and message. |
| Required merchant data is already validated. | Legal Name, Unique ID, and at least one Merchant URL are required; DBA, MID, and extra URLs are supported. | Reuse the existing validation. |
| Unique ID is unique within the customer's organization account. | The backend rejects a duplicate with `409 Conflict` and does not update the existing merchant. | The UI checks only the active portfolio before submission. |
| Multiple URLs are supported. | Users can add up to ten URLs and remove all but the first row. | URLs without a scheme become `https://` URLs. |
| Merchant and portfolio assignment are created together. | One transaction saves the merchant and its portfolio and product assignments. | If saving fails, no merchant may be persisted. |

## Scope

### In Scope

- Reuse of the existing **Add New Merchant** side panel opened from the Add action above the merchant list.
- Adding one new merchant for ongoing monitoring only.
- Automatic association with the portfolio from which the side panel was opened.
- Blocking behavior and explanation when the current portfolio is inactive or has no enabled products.
- Read-only visibility of the current portfolio, monitoring cycle, and enabled products at the top of the side panel.
- Required Legal Name, Unique ID, and at least one Merchant URL.
- Optional DBA and MID.
- Adding and removing additional Merchant URLs.
- Required-field, URL-format, and Unique ID uniqueness validation.
- Merchant creation, portfolio assignment, product assignment, and monitoring activation without onboarding activation.
- Create-and-scan-now and create-and-scan-later actions.
- A save failure message with the reason and no persisted merchant.

### Out of Scope

- Bulk merchant upload, editing, removal, or migration.
- Onboarding, Quick Insights, Web ID, or on-demand rescreening flows.
- API-based merchant creation in this discovery scope.
- Selecting or changing the merchant's portfolio in the side panel.
- Selecting or overriding products per merchant.
- Changing the monitoring cycle in the side panel.
- Creating, activating, or configuring portfolios in the side panel.

## Success Signals

- Users can identify the current portfolio, monitoring cycle, and enabled products before creation.
- Merchant creation is blocked when the current portfolio is inactive or has no enabled products.
- Invalid or duplicate merchant data is blocked before creation.
- Every successfully created merchant is associated with the portfolio from which the side panel was opened and starts monitoring with that portfolio's configuration.
- No merchant is added to onboarding through this flow.
- **Scan now** requests an immediate monitoring scan and retains the next scheduled scan; **scan later** waits for that scheduled scan.
- A failed save shows the reason and does not persist the merchant.
- Completion, validation failure, portfolio-block, immediate-scan, save-failure, and abandonment rates can be measured.

## Open Questions

- Which roles may add a merchant from a portfolio?
- If the portfolio's monitoring cycle or enabled products change while the side panel is open, should submission refresh and require review, or use the configuration that was previewed?
- Which URL formats are accepted, and should the system normalize a URL without a scheme such as `www.example.com`?
- Do any configured products require beneficial-owner data at creation, or is that data collected later? If a product does require it, the form must ask for it rather than deferring. See Feature Behavior.

## Appendix

### Confluence Review Comments

| Previous section | Commented text | Comment | Response |
|---|---|---|---|
| Problem > Pain Points | Users need a direct way to add one merchant for monitoring from the merchant list page | We have this functionality in UP | Agree; changed the requirement so Add creates a monitoring merchant only. |
| Problem > Pain Points | A merchant must not be added from an inactive portfolio | We have this already, user will see "This portfolio has no active products. Merchant uploads and scans will be unavailable until an admin enables at least one product in Settings." when choosing portfolio | Agree; moved the existing block and message to Assumptions. |
| Problem > Pain Points | Required merchant data and duplicate Unique IDs must be validated before creation | We already have this | Agree; moved the existing validation to Assumptions. |
| Proposed Solution > Feature Behavior > Portfolio and Monitoring Summary | Add the monitoring cycle and included components beside the existing portfolio name. | Can this be configured under portfolio settings? If yes - we could have multiple options, not only these specified, minimum one? | Agree; clarified that this only represents the portfolio's existing configuration. |
| Proposed Solution > Feature Behavior > Portfolio and Monitoring Summary | Use the component names from the current portfolio. | There is no definition of "services" in portfolio, but "products" | Agree; changed the document to **enabled products**. |
| Proposed Solution > Feature Behavior > Create Merchant | Scan now | Is this besides the monitoring frequency described in the doc earlier? | Agree; clarified that it scans now and again at the next monitoring cycle. |
| Proposed Solution > Feature Behavior > Create Merchant | Scan later | We would need to clarify what scan now/later means - are we going for "onboarding" (fast, instant scans) or standard "monitoring" option, based on what we have in UP. Both "products" have different configuration | Agree; clarified that both actions are monitoring-only and use the portfolio configuration. |
| Proposed Solution > Feature Behavior > Create Merchant | If any action fails, show the merchant's actual state and a next step. | Need clarification on this. Are we going to extend merchant states, something like CREATED_NOT_SCANNED etc. | Agree; changed it to show the save failure reason and persist nothing. |
| Proposed Solution > Assumptions | These capabilities | We would need a definition of this | Agree; changed **capabilities** to **current behaviors**. |
| Proposed Solution > Assumptions | The active portfolio is fixed during creation. | The merchant list lives within the portfolio, need a clarification here - where we can add merchant action before choosing portfolio, what level? | Agree; clarified that Add appears above a specific portfolio's merchant list. |
| Proposed Solution > Assumptions | The merchant is assigned to the active portfolio. | See above, the portfolio selection question | Agree; automatic assignment to that portfolio remains reflected. |
| Proposed Solution > Assumptions | Core merchant fields already exist. | We have this in UP | Agree; existing fields remain in Assumptions. |
| Proposed Solution > Assumptions | Reported MCC is optional and merchant-level. | Are we sure about this. One of our product configuration is MCC, meaning customer might opt out this option and MCC on merchant becomes irrelevant. In this case needs to be optional | Agree; removed Reported MCC from the requirements. |
| Scope > Out of Scope | Building the underlying screening services or resolving their findings. | None of the services in the list currently supported, probably separate PRDs | Agree; removed this item from the document. |

### Persona / Target Audience

**Primary user:**
Monitoring or compliance operator adding one merchant to ongoing monitoring.

**Secondary audience:**
Portfolio managers, risk administrators, support teams, and auditors.

**Job to be done:**
Add one merchant to the current monitoring portfolio, understand its configuration, and decide whether to scan now.

### Data

- Number of users affected: 108 unique users opened the MV Add Single Merchant flow in the 90-day Mixpanel window. This figure includes all accounts and may include internal or test users.
- Current usage: MV recorded 3,664 `add_merchant_solo` events and 3,414 `add_merchant_solo_upload` events from 2026-04-30 through 2026-07-28.
- CS tickets: TBD - no support-ticket source was provided.
- Main data: unique ID, legal name, optional DBA, MID, merchant URLs, portfolio, monitoring cycle, and enabled products.
- Migration context: source merchant ID, legacy request type, and known data exceptions.

#### Legacy EverC Mixpanel Analytics

| Signal | Legacy EverC evidence | Discovery implication |
|---|---|---|
| Coverage | MV tracks `add_merchant_solo` and `add_merchant_solo_upload`; 95 and 72 distinct `account_id` values appeared in the 90-day window. | Instrument the equivalent target flow and preserve account-level segmentation. |
| Usage | 3,664 flow opens from 108 unique users; 3,414 upload actions from 85 unique users. | The flow has measurable legacy usage, but event counts are not confirmed successful merchant creations. |
| Key clients | TBD - Mixpanel exposes account IDs, but Looker enrichment was not run to resolve client names or exclude internal/test accounts. | Resolve account names and customer-only totals before choosing pilots or setting a migration baseline. |

> Analytics source: EverC Mixpanel organization; `MerchantView Production` project `2040581`; `All Project Data` workspace `187351`; 2026-04-30 through 2026-07-28. Retrieved through Mixpanel MCP from `add_merchant_solo` and `add_merchant_solo_upload`. [Open saved Mixpanel report](https://mixpanel.com/project/2040581/view/187351/app/insights#Q4qonzFFak5m). Figures include all accounts. Customer-only totals and client names remain TBD pending Looker enrichment.

### Future Considerations

- Reuse the same validation and assignment rules for API and bulk creation.
- Add more merchant, address, identifier, and beneficial-owner details when required by configured products.
- Provide a retry path after a failed save without persisting a partial merchant.

### Brain Grounding

- `domains/atlas/second-brain/context/features/` has no existing note for this feature.
- `domains/atlas/second-brain/hypotheses/` has no entries for merchant add/onboarding/monitoring split.
- `domains/atlas/second-brain/glossary/` has no defined entries for "portfolio," "monitoring cycle," "enabled products," or "onboarding" beyond the README stub.
- Gap: this discovery rests on the PM's direct evidence from `marketview-portal`, `mlrc-bff-2.0`, and `mlrc-merchant`, and the Confluence review trail, not on prior brain knowledge. Recommend an `/ingest` or `/retro` pass after this feature closes to seed the feature note, glossary terms, and the onboarding-vs-monitoring split as a domain decision.
