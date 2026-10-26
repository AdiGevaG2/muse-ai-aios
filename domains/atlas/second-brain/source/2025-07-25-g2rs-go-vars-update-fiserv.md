# Source: G2RS GO VARS Update - 2025 - July (Fiserv)

**Type:** PowerPoint deck, "G2RS GO Policy Analysis (VARS)", dated July 25th, 2025
**Retrieved from:** SharePoint, mary.williams@g2risksolutions.com OneDrive,
`G2RS GO VARS Update - 2025 - July  -  Read-Only.pptx`
**Retrieved:** 2026-10-07 via Microsoft 365 connector (sharepoint_search +
read_resource). Text-only extraction; slide graphics (architecture diagram,
roadmap Gantt bars, screenshots) not captured.

Raw extracted text follows, verbatim, in slide order.

---

PowerPoint Presentation Confidential and Proprietary – Do Not Distribute
G2RS GO Policy Analysis (VARS), July 25th, 2025

**Agenda (slide 2):** Introductions; Product Overview; Requirements Review;
Development Progress Overview; Project Timeline & Milestones; Collaboration;
Next Steps & Action Items

**Slide 3 - Global Onboarding (GO): Problem scenario:** Time = Money. For your
business to be agile and scale up, you need automation that will safely and
quickly mitigate these risks, with a minimum of human involvement required
while avoiding negative impacts.

**Slide 4 - GO Components (overview):** Source data feeding component reports:
Merchant risk history; Content compliance review; Watchlists, sanctions, and
legal; Consumer reviews and adverse media; Operational risk; Merchant Map;
Whois record collection; Merchant website: products and services; Business and
financial crimes data; US court activity; US Office of Foreign Assets Control
(OFAC) data; Adverse media data; PEPs, watchlists, and sanctions lists; Recent
consumer ratings, reviews, and complaints; Merchant website: business
policies; Merchant website: traffic analysis; Email address validity, match,
and fraud risk data. Component reports named: Policy Analysis (VARS); SSL
Certificate Check.

**Slide 5:** Section header - Product Requirements

**Slide 6 - Requirements Summary:**
- Verify merchant information matches the website: Merchant Name, DBA;
  Merchant Location
- Evaluate merchant's products sold: Restricted categories (acceptable
  industry); Matching expected product or services; Import / export / legal
  restrictions
- Merchant policy and operations: Negative findings in T&C or refund policy;
  Long delivery timelines; Insufficient privacy policy; Card brand usage;
  Contact us is easy
- Confirm merchant website has a valid SSL Certificate

**Slide 7 - Verify merchant information matches website (Name/DBA/Location/Contact Us):**

Fiserv requirement: Ensure DBA name on the application form matches name on
website.
- Input: Merchant URL, Merchant DBA, Merchant Legal Name
- Analysis: Crawl of website; search of DBA and Legal Name on provided
  Merchant URL
- Output: Merchant Name Risk flag 0-4 (0 default, 2 neither name found)

Fiserv requirement: Ensure the website has a customer service contact with an
electronic email address and/or telephone number. Validate that the business
is located in the country of origin.
- Input: Merchant URL, Merchant Address
- Analysis: Crawl of website; identify Contact Us page; extract emails,
  telephones, addresses; compare merchant address country to website address
  country
- Output: Emails found (up to 5), Email Risk flag 0-4 (0 default, 2 none
  found); Phone numbers found (up to 5), Phone Risk flag 0-4 (0 default, 2
  none found); Addresses found (up to 5), Address Risk flag 0-4 (1 default, 3
  merchant country not found in website address(es))

**Slide 8 - Verify merchant information matches website, continued (Currency):**

Fiserv requirement: Validate the currency accepted matches native/local
currencies for the country of origin.
- Input: Merchant URL, Merchant Address
- Analysis: Crawl of website; identification of product page; extraction of
  currencies; mapping of currency to country; compare merchant address
  country to website currency country(ies)
- Output: Currencies found list; Currency mismatch flag 0-4 (0 only one
  currency found and matches merchant country, 1 default, 2 currency country
  does not match merchant country or more than one currency found)

**Slide 9 - Evaluate merchant's products sold (restricted categories, product match):**

Fiserv requirement: Confirm the merchant's industry is acceptable as per the
channel's credit policy.
- Input: Merchant URL, Restricted MCC List (configured in risk policies)
- Analysis: Crawl of website; identification of product page; evaluation of
  product page and home page content against restricted MCCs
- Output: Disallowed MCC Risk flag 0-4 (0 no issues, 1 default, 2 disallowed
  MCC possible)

Fiserv requirement: Confirm that the website has a complete description of
the goods or services sold and is consistent with the product/services sold
as described on the application.
- Input: Merchant URL, Merchant Product and Services Description
- Analysis: Crawl of website; identification of product page; evaluation of
  product page and home page content against provided product and services
  description
- Output: Product mismatch Risk flag 0-4 (0 match, 1 default, 2 mismatch)

**Slide 10 - Evaluate merchant's products sold, continued (import/export/legal restrictions):**

Fiserv requirement: Review website to determine if any legal or export
restrictions apply (such as age-appropriate restrictions).
- Input: Merchant MCC
- Analysis: MCC lookup to import/export and legal restriction reference
- Output: Restricted MCC, reason, and restriction type; Product restriction
  Risk flag 0-4 (0 default, 1 matched to MCC risk-level 1, 2 matched to MCC
  risk-level 2, 3 matched to MCC risk-level 3)

**Slide 11 - Merchant policy and operations (T&C, refund policy):**

Fiserv requirement: Ensure there are no signs of deceptive practices including
Free Trials, Free Gifts, Rebates, Negative Renewal options,
Prizes/Sweepstakes, Hidden Disclosures, Pre-Checked boxes within the
merchant's terms and conditions, bogus claims or endorsements.
- Input: Merchant URL
- Analysis: Crawl of website; identify Terms and Conditions page; identify
  presence of negative findings (Free Trials, Free Gifts, Rebates, Negative
  Renewal options, Prizes/Sweepstakes)
- Output: List of negative finding name and website excerpt; T&C Risk flag
  0-4 (0 default, 1-4 based on negative finding type)

Fiserv requirement: Review the merchant's entire Refund/Cancellation Policy,
including backorders, return and refund policies, and highlight any negative
findings, including any policy that causes difficulty for a
consumer/cardholder to receive a refund.
- Input: Merchant URL
- Analysis: Crawl of website; identify Refund policy page; identify presence
  of negative findings (Short return period, Return fees, No refunds allowed)
- Output: List of negative finding name and website excerpt; Refund Risk flag
  0-4 (0 default, 1-4 based on negative finding type)

**Slide 12 - Merchant policy and operations, continued (delivery, privacy):**

Fiserv requirement: Review the delivery policy and confirm the policy and
timeframes on the website align with information provided on the MPA
(Merchant Processing Application).
- Input: Merchant URL
- Analysis: Crawl of website; identify Delivery Policy page; extract delivery
  time frames; calculate max delivery time
- Output: List of delivery time frames; Max delivery time in days; Long
  delivery Risk flag 0-4 (0 default/0-3 days, 1: 4-7 days, 2: 8-14 days, 3:
  15-21 days, 4: >21 days)

Fiserv requirement: Review the merchant's privacy statement to ensure it is
acceptable for handling consumer information and data.
- Input: Merchant URL
- Analysis: Crawl of website; identify Privacy policy page; identify presence
  of GDPR principles
- Output: List of GDPR principles missing; list of GDPR principles partially
  represented; Privacy Risk flag 0-4 (0 default, 1-4 based on count of
  missing principles)

**Slide 13 - Merchant policy and operations, continued (card brand usage, Contact Us friendliness):**

Fiserv requirement: Visa/MasterCard brand mark in full color to indicate card
acceptance, as specified by the Network Product Brand Standards.
- Input: Merchant URL
- Analysis: Crawl of website; identify Product page; identify Payment Policy
  page; check for presence of Visa/MC logo
- Output: Screenshot of Visa Logo; Visa logo Risk flag 0-4 (0 default/good
  logo found, 2 pages found/no logo match); Screenshot of MC logo; MC logo
  Risk flag 0-4 (0 default/good logo found, 2 pages found/no logo match)

Fiserv requirement: Ensure customer service information is clearly and
properly displayed for the consumer.
- Input: Merchant URL
- Analysis: Crawl of website; identify contact us page; evaluate for
  completeness
- Output: Customer service Risk flag 0-4 (0 complete, 1 default, 2 incomplete)

**Slide 14 - Confirm merchant website has a valid SSL Certificate:**

Fiserv requirement: Ensure the website has a secure method for taking credit
card payments (such as SSL or SQL) and ensure disclosure to cardholders.
- Input: Merchant URL
- Analysis: Check certificate presence and information
- Output certificate fields: Valid (true/false); Certificate ID; Issued on
  date; Expired on date; Issued to; Common name; Organization; Organizational
  unit

**Slide 15:** Section header - Development Progress

**Slide 16:** High-level architecture (diagram only, not text-extracted)

**Slide 17 - Milestones completed:**
- Architectural design
- Data collection pipelines: Website content update; SSL Certificate; MCC
  configuration; Product and services description
- Analysis pipelines: Homepage; Contact Us; Privacy; Terms and Conditions;
  Return/Refund; Product Page; Logo Identification
- MVP of model builds (10)
- API and UI output preliminary design

**Slide 18 - Challenges identified:**
- Merchant website crawling: Not all websites can be crawled - proxy; Policy
  pages may not be captured - crawling topology experimentation; Performance -
  finding the right balance between page count and speed
- Model accuracy: Test data volume - test data generation with G2RS
  operations; Test data variety - need real world Fiserv examples

**Slide 19:** Section header - Project Timeline & Milestones

**Slide 20 - G2RS GO Policy Analysis (VARS) Roadmap 2025:** Onboarding
Platform timeline spanning Q2 2025 - Q4 2025, with tracks: Product
Requirements; Analytical engine MVP build; Analytical engine test; API -
Build; API - Sandbox; UI - Build; Fiserv sandbox integration; Fiserv
production test; Fiserv Data Test; Analytical engine refine. (Gantt bar
positions not text-extracted.)

**Slide 21:** Section header - Collaboration

**Slide 22 - Collaboration Points:**
- Feedback schedule: Today; Monthly checkpoints
- Testing: Fiserv test data for development (Bulk batch; Weekly batches);
  Fiserv UAT (Bulk batch test; Results review)
- Implementation: API documentation review; Sandbox integration and testing;
  Production roll out planning

**Slide 23 - G2RS Collaboration Roadmap 2025:** Onboarding Platform timeline
spanning Q2 2025 - Q4 2025, with tracks: Fiserv sandbox integration and
testing; Fiserv production test; Fiserv Bulk Test and Feedback; Fiserv Test
Data Sharing; API Documentation Review. (Gantt bar positions not
text-extracted.)

**Slide 24:** Section header - Next Steps & Action Items (content not
text-extracted beyond header)
