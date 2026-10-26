# Separate Website Policies from Findings, Mini PRD

**TL;DR:**
Pull policy results out of the merchant scan findings table into their own section per URL.

<br>

## Problem and Goal

Policy findings are shown in the same table as other findings for each scanned URL, with no structural separation, even though policies are handled differently.

Goal: Each scanned URL shows policy findings in their own section, separate from the existing findings table.

<br>

## Feature Behavior

Figma: https://www.figma.com/design/kxzxm9iEiCqzo2ewSKAoWA/Unified-Platform-2026?node-id=4936-31749&t=VkV1WRy8ayC2dXLo-4

### Prerequisites

- None

### Requirements

1. The existing findings table for each scanned URL no longer lists policy findings. Its columns and "Finding" header are unchanged.
2. If the URL has at least one policy finding, a "Policies" labeled table renders directly below the existing findings table, with columns Finding, Original Risk, Final Risk, Assignee, and Resolution.
3. If the URL has no policy findings, the Policies table does not render for that URL.

**Empty state**
- A URL with no policy findings shows only its existing findings table; no placeholder or empty Policies section is shown.

<br>

## Finding Reference

Source: `website-policies-reverse-engineering.md` (MerchantView).

**Website**

| Finding | Definition |
| --- | --- |
| Contact Us Page | The merchant's website has a Contact Us page. |
| Privacy Policy Page | The website has a Privacy Policy page. |
| Terms and Conditions Page | The website has a Terms and Conditions page. |
| About Us Page | The website has an About Us page. |
| Shipping or Return Page | The website has a shipping or returns policy page. |
| Payment Page Internal | The website has its own payment page rather than routing to an external processor. Tracked separately from alcohol-related findings. |


**Insights**

| Finding | Definition |
| --- | --- |
| Missing About Us Page | No About Us page was found. Absence is itself a reportable finding, not an unset flag. |
| Missing Shipping and Return | No shipping or returns page was found. |
| Missing T&C | No Terms and Conditions page was found. |
| Missing Privacy Page | No Privacy Policy page was found. |
| Missing Contact Us | No Contact Us page was found. |

**Policies**

| Finding | Definition |
| --- | --- |
| NABP Not Recommended Pharmacies | The website is listed by NABP, the National Association of Boards of Pharmacy, as a not-recommended or unlicensed online pharmacy. |
| US Unlicensed Cannabis dispensaries | The merchant operates a US cannabis dispensary without the required license. |
| US Licensed Cannabis dispensaries | The merchant operates a licensed US cannabis dispensary. Reported as a flag regardless of license status, since cannabis remains federally restricted. |
| Age Verification | Checks whether the website enforces age verification where required. Inactive in production per the reverse-engineering doc. |
| Cancellation Link Not Present | No cancellation link or mechanism is present on the website. Inactive in production. |
| Cancellation Link Noncompliant | A cancellation link exists but doesn't meet compliance requirements. Inactive in production. |
| Business Phone Number not Present | No business phone number is present on the site. Inactive in production. |
| No Traffic Data | No traffic data is available for the site. |
| Policy Violation | A generic catch-all for a detected policy violation not covered by a more specific subtype. |
| Missing Address | No business address is present on the site. |
| Generic URL | The site uses a generic or non-distinctive URL, such as a shared or templated domain. |
| Trial Period Noncompliant | The site's free-trial terms don't meet compliance requirements. Inactive in production. |
| Licensed Pharmacy | The merchant operates a licensed online pharmacy. |
| Cyber Locker | The site functions as a cyberlocker, a file-sharing or hosting service associated with piracy risk. |

<br>

## Acceptance Criteria

**Scenario: URL has both other findings and policy findings**
- Given a scanned URL returned at least one non-policy finding and at least one policy finding
- When the reviewer opens the Findings tab for that merchant
- Then the URL shows the existing findings table, with its columns unchanged
- And a separate "Policies" labeled table renders directly below it, listing every policy finding for that URL
- And no policy finding appears in the existing findings table

**Scenario: URL has no policy findings**
- Given a scanned URL returned no policy findings
- When the reviewer opens the Findings tab for that merchant
- Then only the existing findings table renders for that URL, with no "Policies" heading or table shown
