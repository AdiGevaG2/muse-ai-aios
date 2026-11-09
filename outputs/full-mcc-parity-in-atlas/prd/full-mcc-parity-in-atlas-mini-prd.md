# Full MCC Parity in Atlas, Mini PRD

**TL;DR:**
Show the MCC result as a finding in a new MCC table on the store record, matching the comparison MerchantView makes today instead of only sending a match/mismatch result to PayPal. Each store is compared against its own reported code using MerchantView's MCC group list. Each table row shows the predicted code, the reported code, Match or Mismatch when a reported code exists, and the finding's severity, risk, and decision. The predicted code's category sets the finding's severity. Risk is derived from severity, then adjusted by the risk matrix and the analyst's decision. A store holds one MCC result, from its latest scan. The merchant list gains MCC and Components ran filters, and a merchant with more than one store shows its stores' reported codes in the merchant header.

<br>

## Definitions

- **MCC**: this document uses MCC to mean merchant category code, a 4-digit code describing what a business sells.
- **Reported code**: the code reported for a store. Each store carries its own reported code, as each scanned URL does in MerchantView.
- **Predicted code**: the code a scan of the merchant's site concludes they sell.
- **MCC group**: one entry in the MCC group list MerchantView uses today. Two codes in the same group count as the same business for comparison purposes. Atlas uses this list unchanged.
- **Store**: a merchant site or URL that Atlas scans and attaches findings to.
- **Portfolio**: a grouping of merchants in Atlas. The MCC service is turned on per portfolio.

<br>

## How MCC Works in Atlas

MCC belongs to a store, never to a merchant. No business use case holds an MCC at the merchant level, so Atlas stores and shows an MCC only against one of the merchant's stores.

- A merchant with no stores has no MCC.
- When WebID runs and finds a store for the merchant, Atlas predicts an MCC for that store and attaches the predicted code to it.

<br>

## Problem and Goal

An analyst reviewing a store in Atlas cannot see the predicted code or whether it disagrees with the reported code. That comparison exists for PayPal's integration, but only as a field in the result Atlas sends to PayPal; there is no finding in the product that shows it, and the result does not affect the risk or severity of any finding. A reported code is an optional field under each store when a merchant is created, so Atlas also needs a result for when a scan predicts a code with nothing reported to compare against.

Goal: an analyst sees the MCC result for a store in its own MCC table, with the same comparison MerchantView makes today, with severity set by the predicted code's category and risk derived from that severity. The primary user is the underwriting/risk analyst.

Scope: this feature is a lift and shift of MerchantView's comparison. The MCC risk vision in Gal Sahar's briefs, with verdicts, tiers, client configuration, and a finalize step, is a later phase.

<br>

## Feature Behavior

### Prerequisites

- A store's latest scan produced a predicted code. A reported code is not required; MCC is an optional field under each store when a merchant is added for onboarding or monitoring.

### Requirements

**MCC table on the store record**

1. Analyst opens the Findings tab for a store in Atlas.
2. If the store has a predicted code, a section titled "MCC" appears, separate from the existing findings table, holding the MCC table.
3. The MCC table holds one row per store: the MCC finding from the store's latest scan. A store has one MCC result per scan, and the table does not show results from earlier scans.
4. The row shows six columns:

| Predicted MCC | Reported MCC | Match | Severity | Risk | Decision |
|---|---|---|---|---|---|
| {code} - {category name} | {code} - {category name} | Match | from the finding | from the finding | from the finding |
| {code} - {category name} | {code} - {category name} | Mismatch | from the finding | from the finding | from the finding |
| {code} - {category name} | *None* | | from the finding | from the finding | from the finding |

5. Predicted MCC and Reported MCC show the 4-digit code followed by the category name, for example "5661 - Shoe Stores".
6. Match shows "Match" when the two codes are in the same group and "Mismatch" when they are in different groups. Match holds no other value. Both values display as plain text, with no color.
7. Severity, Risk, and Decision show the finding's values, in the same form the existing findings table shows them for other findings.
8. If the store has no reported code, Reported MCC shows "None" in italics and the Match cell is empty. Severity is set by the predicted code's category.
9. Selecting the row opens the finding's evidence in the evidence modal other findings use. The modal shows both codes, both groups, and the other codes in each group, as MerchantView's evidence view does, next to the finding's Match result, severity, risk, decision, scan date, and URL.

**Agreement rule**
- Same group: Match.
- Different group: Mismatch.
- Different codes within the same group: Match, not Mismatch.
- Each store is compared against its own reported code only.
- Match and Mismatch are result states RT-1491 sends to PayPal today. Atlas uses the same labels in the MCC table.

**Severity and risk**
- Severity is set by the category of the predicted code, whether the result is Match, Mismatch, or the store has no reported code.
- Risk is derived from severity, then adjusted by the risk matrix and the analyst's decision in the UI.
- The Severity column header carries an information icon. Its text reads: "Severity shown is set by the category of the predicted MCC. Set by G2 scanning. Cannot be edited."
- The finding's severity and risk feed the store's overall risk in the same way as any other finding's.

**Reported MCC on a merchant with more than one store**
- The merchant header shows Reported MCC as the code followed by the category name.
- When the merchant's stores carry more than one distinct reported code, the header shows the first code followed by a "+N" badge, where N is the number of other distinct reported codes.
- Hovering over the badge shows a tooltip titled "Reported MCC by store", listing each store's URL next to its reported code.
- When no store has a reported code, the header shows "—".

**Merchant list filters**

The merchant list filter panel adds two filters. Each is multi-select and shows as a removable chip when applied, in the same way as the other filters in the panel.

| Filter | Options | A merchant is shown when |
|---|---|---|
| Components ran | Graph, MCC | the selected component ran on the merchant |
| MCC | Match, Mismatch, Has predicted, Has reported | Match: the MCC result is Match. Mismatch: the MCC result is Mismatch. Has predicted: a predicted code exists. Has reported: a reported code exists. |

**Empty state**
- No predicted code: no MCC section appears for that store. No placeholder or empty section is shown.

**Permissions**
- Any role that can view a store record's Findings tab can see the MCC section. Any role that can view the merchant list can use its filters. No new permission is introduced.

<br>

## Acceptance Criteria

**Scenario: Reported and predicted codes are in the same group**
- Given a store has reported code 5661 and predicted code 5691, both in the same group
- When the analyst opens the Findings tab for that store
- Then the MCC table shows one row with Predicted MCC "5691 - Men's and Women's Clothing Stores", Reported MCC "5661 - Shoe Stores", and Match "Match"
- And Severity, Risk, and Decision show the finding's values

**Scenario: Reported and predicted codes are in different groups**
- Given a store has reported code 5661 and predicted code 7995, in different groups
- When the analyst opens the Findings tab for that store
- Then the MCC table shows one row with Match "Mismatch" as plain text
- And Severity shows the severity of predicted code 7995's category
- And the Severity column header's information icon reads "Severity shown is set by the category of the predicted MCC. Set by G2 scanning. Cannot be edited."

**Scenario: Two stores of one merchant with different reported codes**
- Given a merchant has store A with reported code 5661 and store B with reported code 7995
- And both stores have predicted code 7995
- When the analyst opens the Findings tab for each store
- Then store A's row shows "Mismatch" and store B's row shows "Match"

**Scenario: Merchant header with more than one reported code**
- Given a merchant has store A with reported code 5661 and store B with reported code 7995
- When the analyst opens the merchant
- Then the header shows Reported MCC "5661 - Shoe Stores" followed by a "+1" badge
- And hovering over the badge shows "Reported MCC by store" listing store A's URL with 5661 and store B's URL with 7995

**Scenario: No reported code on file**
- Given a store has no reported code
- And the store has a predicted code
- When the analyst opens the Findings tab for that store
- Then the MCC table shows one row with Reported MCC "None" in italics and an empty Match cell
- And Severity shows the severity of the predicted code's category

**Scenario: Store scanned more than once**
- Given a store has been scanned twice, and each scan produced a predicted code
- When the analyst opens the Findings tab for that store
- Then the MCC table shows one row, with the latest scan's result

**Scenario: Analyst opens a row's evidence**
- Given the MCC table shows a row with a reported code and a predicted code
- When the analyst selects the row
- Then the evidence modal opens and shows both codes, both groups, and the other codes in each group

**Scenario: Analyst filters the merchant list by MCC result**
- Given the merchant list holds merchants with Match and Mismatch results
- When the analyst applies the MCC filter with "Mismatch" selected
- Then the list shows merchants with a Mismatch result
- And a chip reading "MCC: Mismatch" appears, and removing it clears the filter

**Scenario: Analyst filters the merchant list by component**
- When the analyst applies the Components ran filter with "MCC" selected
- Then the list shows merchants on which the MCC component ran

**Scenario: No predicted code**
- Given a store's scan has not returned a predicted code
- When the analyst opens the Findings tab for that store
- Then no MCC section appears for that store

<br>

## Data

**Baseline**
- MerchantView, 2026-04-12 to 2026-10-12: the RM_MCC event fired 88 times, by 27 unique users. Source: Mixpanel, MerchantView Production project 2040581. The event has no description in Mixpanel, so the MCC action it records is unconfirmed.
- Atlas: Mixpanel's Unified Platform Production project 3482888 holds no MCC events or reports. There is no Atlas MCC usage to measure today.
- Number of stores with a predicted code, the Match and Mismatch split sent to PayPal, and number of stores with no reported code: TBD. These figures are not in Mixpanel. Pulling them needs Looker, which is not connected.

**Success measure**
1. Adoption: the share of all portfolios that have the MCC service turned on.
2. Analyst decisions on MCC findings, each counted separately:
   - Atlas set the finding's severity to critical, high, or medium, and the analyst changed the decision to No risk.
   - Atlas set the finding's severity to low or no risk, and the analyst set the decision to No risk.
   - The analyst snoozed the finding.
   - The finding showed Mismatch, and the store's reported code was then changed to the predicted code by the user.

**Recorded data**
- The finding records the predicted code, the reported code, both MCC groups, the Match or Mismatch result, severity, and risk as separate values. The table is produced from these values.
- MerchantView records the same result as up to three separate findings: one for the predicted code, one for the reported code, and one for the mismatch. Atlas records and presents it as one finding per row.

<br>

## Open Questions / Assumptions

- OPEN: how a store gets its reported code in Atlas. Atlas holds the reported code on the merchant today, not on the store. Whether a new store takes the merchant's code by default or has its code entered per store needs a decision.
- OPEN: MerchantView shows the predicted code only to clients enabled for MCC, except high-risk codes, which it shows to every client, and creates a mismatch only for enabled clients. How enablement maps to Atlas is not specified here.
- OPEN: for a merchant with more than one store, whether the MCC filter shows the merchant when any one of its stores meets the selected option, or only when all do.
- ASSUMED: this is a read-only view. No edit-the-reported-code flow is specified here; confirm during spec if editing is in scope.
- ASSUMED: RT-1575, where the result sent to PayPal drops the predicted code on non-Mismatch states, and RT-1564, a finding status mismatch, are tracked and fixed independently of this work, not blocking it. Confirm with engineering during spec.
