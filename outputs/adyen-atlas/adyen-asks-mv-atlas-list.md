# Adyen: Requests and MerchantView Use, Against Atlas

Built for the Atlas slides in the November 2026 QBR deck. Scope: MerchantView and Atlas only; SmartScan is out of scope.

Each item answers four questions:
- **What they need**: the request in plain words, with Adyen's own example where there is one.
- **MerchantView today**: whether MerchantView has it, and how much Adyen's own users used it from 2026-08-14 to 2026-11-12.
- **Atlas now**: from the Content Compliance parity check of 2026-11-05, Q3 roadmap items marked Done, and PM input.
- **Planned**: Q3 items not yet Done and Q4 items marked Must on the Monday board "Atlas Migration Packages Roadmap", all due by 27 February 2027. "None" means no Must item covers it.

---

## Part 1: What Adyen asked for

### 1. A summary view per platform
**Asked in:** feedback session, 2026-06-11.
**What they need:** Adyen's portfolio holds about 100 platforms. A platform is one company with many sub-merchants under it. Web Connects, an event ticketing company, has about 400. Adyen wants one page per platform showing total findings, top categories and how many are resolved, with a trend over time and the riskiest sub-merchants. Their example: "Web Connects has 340 findings this month: 60% dating, 30% gambling, 10% offline." They want the platform as a level inside the portfolio, not a separate sub-account per platform, which would mean managing 100+ sub-accounts.
- **MerchantView today:** No platform level.
- **Atlas now:** No platform level. Atlas has organization, portfolio and merchant.
- **Planned:** None.

### 2. Rules per platform
**Asked in:** feedback session, 2026-06-11.
**What they need:** Some platforms are approved for categories that would otherwise be flagged, such as tobacco, dating or event ticketing. Adyen wants to set the rules for that one platform, so findings in its approved categories are not raised for review. Today rules apply to a whole portfolio, so switching a category off would switch it off for every merchant in the portfolio.
- **MerchantView today:** Rules per portfolio only.
- **Atlas now:** Category risk settings per portfolio only.
- **Planned:** None. "Client Rules, Risk Matrix and Decisions" is Q4 but not Must.

### 3. Allow a whole category for a platform, and stop flagging redirects as offline
**Asked in:** feedback session, 2026-06-11.
**What they need:** Allowing a finding marks it as accepted so it stops alerting. Today this works per URL or per finding, so the same approved findings return every month. Adyen wants to allow a whole category for a platform, for one of two reasons: the finding is within Adyen's risk appetite, or the merchant holds documented approval such as a tobacco license. The reason must stay private to Adyen. Their example: Web Connects' event pages go offline after each event, producing about 1,000 offline findings per cycle. Adyen has compliance approval to ignore them, but removes those URLs by hand every cycle, and would miss a violation if a page came back online.
Second part: when a URL redirects to another URL, MerchantView flags the original as offline. Adyen considers it active and wants a setting that stops this.
- **MerchantView today:** Allow per URL or per finding only.
- **Atlas now:** Partly. Atlas can ignore a whole store, and snooze a finding or URL until a set date. No category-level allow.
- **Planned:** None.

### 4. Larger bulk actions, filtered by platform and category
**Asked in:** feedback session, 2026-06-11.
**What they need:** A bulk action today handles at most 50 findings. For Web Connects, 400 sub-merchants with similar findings take 8 separate passes. Adyen also wants to filter by platform and category together, select every match, and act once.
- **MerchantView today:** Limit of 50 findings per bulk action. Adyen made 144 bulk status changes in 90 days, against 9,189 single ones.
- **Atlas now:** Bulk status change and bulk dispute. The limit was not checked. No platform filter, since there is no platform level.
- **Planned:** None.

### 5. Assign an analyst to a whole platform
**Asked in:** feedback session, 2026-06-11.
**What they need:** Adyen gives each analyst whole platforms, from review through merchant outreach. They want an analyst to claim a platform so all its findings route to that analyst, and a personal view listing each analyst's platforms and merchants. Assignment per finding goes unused because it would take hundreds of assignments per platform.
- **MerchantView today:** Assignment per finding. Adyen opened it 12 times in 90 days.
- **Atlas now:** Assignment per merchant.
- **Planned:** Assign Analyst to Merchant (Q3, spillover) and Bulk analyst assignment (Q4 Must). Still per merchant, not per platform.

### 6. Detection that understands language and context
**Asked in:** feedback session, 2026-06-11.
**What they need:** Fewer false positives from plain keyword matching. Their examples: the Czech word "kava", which means coffee, is flagged as CBD; a page that says "do not use [drug]" is flagged as selling that drug. Adyen's false positive rate was 8-10% excluding offline findings, against a 5% target.
- **MerchantView today:** Keyword-based detection.
- **Atlas now:** Not confirmed.
- **Planned:** Not on the board by name. Gal Sahar told Adyen in June that AI classification that reads context is in progress and will reach Adyen on Atlas.

### 7. Subcategories with their own risk rules
**Asked in:** feedback session, 2026-06-11.
**What they need:** Categories such as "adult content" are too broad for Adyen's internal risk matrix, which works at a finer level. Adyen wants subcategories under each category, and risk rules per subcategory.
- **MerchantView today:** No.
- **Atlas now:** No.
- **Planned:** Create your own categories, Phase 0; Content Categories Enhanced Coverage; MV 9 keyword categories in Atlas (all Q4 Must). Risk rules per subcategory: none.

### 8. An explanation of why a finding was flagged
**Asked in:** feedback session, 2026-06-11.
**What they need:** Analysts often cannot tell why a finding was raised. Adyen wants three things:
- An AI explanation linked to the law or card brand rule behind the finding, such as an FDA letter or a Visa rule, to save review time and support conversations with merchants.
- The exact place in the page source code where a keyword was found, instead of searching the source by hand.
- The country of the proxy used for the scan, because some violations show only when the page is viewed from a certain country.
- **MerchantView today:** Shows the text snippet and keyword that triggered a finding. No law link, source location or proxy country.
- **Atlas now:** Screenshot evidence only. No text snippet or keyword evidence.
- **Planned:** None for law links, source location or proxy country. Keyword evidence only if "CC / UI full parity validation" (Q4 Must) closes that gap.

### 9. History at the URL or merchant
**Asked in:** feedback session, 2026-06-11.
**What they need:** Analysts look for a history button on the URL or the merchant. In MerchantView, history is a separate top-level tab that is hard to find; during the session Sasha had to be shown where it is.
- **MerchantView today:** History as a top-level tab. Adyen opened it 3 times in 90 days.
- **Atlas now:** No finding change history.
- **Planned:** Merchant & Finding Activity Log (Q4 Must).

### 10. Disputes each analyst can track
**Asked in:** feedback session, 2026-06-11.
**What they need:** A dispute asks G2RS to re-check a finding Adyen believes is wrong. Adyen rarely disputes, for two reasons. All disputes sit in one shared view, so an analyst cannot see only their own or follow their status. And large spikes, such as hundreds of findings from one marketplace issue, would overwhelm the flow, so Adyen sends those through the CSM. Adyen wants each analyst to track their own disputes with clear status and replies.
- **MerchantView today:** One shared dispute view. Adyen submitted 120 disputes in 90 days.
- **Atlas now:** Disputes, including bulk disputes.
- **Planned:** Finding Dispute and Reassessment (Q3 partially done, Q4 Must): the client disputes a finding, adds evidence and tracks status; G2RS reassesses it and re-releases it with full history. A per-analyst view is not stated.

### 11. Easier URL upload
**Asked in:** feedback session, 2026-06-11.
**What they need:** Adyen uploads URLs by hand, since its API integration waits on an internal system change. Five problems:
- The limit of 1,000 URLs per merchant is hit regularly. One upload of 2,100 URLs took three files.
- There is no undo. After a wrong bulk upload or removal, the only fix is to re-upload everything. Adyen wants undo within 24 hours.
- In franchise and platform models, the same URL sits under many merchant IDs and is scanned and charged once per ID. Adyen wants one scan, with the result applied to every matching merchant.
- Adyen must log in to each sub-account to upload. It wants one file that names the target portfolio on each row.
- URLs uploaded with "www." come back without it, which breaks matching in Adyen's case management system.
- **MerchantView today:** 1,000-URL limit, no undo.
- **Atlas now:** Add merchants in bulk or one at a time.
- **Planned:** Wizard for Add Merchant, MVP and Enhancements; Existing Merchant Management (Q4 Must). These let a user add merchants from anywhere in the organization and choose the portfolio in the flow. The limit, undo, repeated URLs and "www." handling: none.

### 12. A notice when a scan finishes
**Asked in:** feedback session, 2026-06-11.
**What they need:** A scan of uploaded URLs takes up to 3 business days, with no notice when it ends. Adyen's team once started working before a scan finished and missed findings. Adyen wants an email or an in-platform notice.
- **MerchantView today:** No notice in the screens. MerchantView sends per-scan webhooks to API clients; Adyen does not use the API.
- **Atlas now:** No.
- **Planned:** System notifications; "New" indication for scan (Q4 Must). Which notifications are covered is not stated.

### 13. MCC findings for the Indian regulator
**Asked in:** QBR deck, November 2026, status Pending.
**What they need:** A merchant category code, MCC, is the card scheme code for a merchant's line of business. The deck says only: "MCC Findings: regulatory requirement from Indian Regulator."
- **MerchantView today:** Not established.
- **Atlas now:** Not established.
- **Planned:** Full MCC Parity MVP; MCC registration and prohibited flags (Q4 Must). Whether these meet the Indian requirement is not known.

### 14. Website change detection
**Asked in:** QBR deck, November 2026, status Pending.
**What they need:** For what the deck calls Adyen's "PMR initiative", Adyen wants automated monitoring that detects when a merchant's website changes. The deck does not define PMR.
- **MerchantView today:** No. G2RS sells change detection as a separate service run on Visualping, outside MerchantView.
- **Atlas now:** No.
- **Planned:** None. Change Detection Phase 1 is Q4 but not Must.

### 15. IP mismatch check
**Asked in:** email thread, 2026-09-07 to 09-09.
**What they need:** Adyen received a UAE license and must complete Mastercard Franchise onboarding. Mastercard's recommended controls include checking whether a merchant's IP address matches its stated location. Gal Sahar's answer in the thread: a website's IP shows where it is hosted, not where the merchant is. A real check needs the IP the merchant used when onboarding with Adyen, which G2RS does not receive. A website lookup could satisfy a "we checked" compliance need, with caveats.
- **MerchantView today:** No.
- **Atlas now:** No.
- **Planned:** None. The WHOIS IP item is Q4 but not Must.

### 16. Email mismatch check
**Asked in:** Slack #team-merchantview, 2026-08-05.
**What they need:** For Apple Pay requirements, Adyen is looking for a check that a merchant's email matches its website.
- **MerchantView today:** The check exists, but Adyen submits no merchant emails, so nothing real is compared. Old email mismatch findings from September 2025 keep carrying over each month (defect RT-1407).
- **Atlas now:** No.
- **Planned:** Verify Merchant Details Against Website (Q4 Must). It compares the name, phone, email and address a client submits with what the merchant's website shows. It works for Adyen only if Adyen submits merchant emails.

### 17. Monitoring of AI-image generating platforms
**Asked in:** Mary Williams email, 2026-10-29.
**What they need:** Adyen asked on 2026-10-29 for monitoring of merchants that offer AI image generation. Five or more clients have asked for this in 3-4 months. The email gives no further detail of Adyen's ask.
- **MerchantView today:** No.
- **Atlas now:** No.
- **Planned:** None.

---

## Part 2: What Adyen uses in MerchantView today

Adyen's own users, 2026-08-14 to 2026-11-12.

| MerchantView capability | What it is | Adyen use, 90 days | Atlas now | Planned, Q3 or Q4 Must |
|---|---|---|---|---|
| Filter findings | Narrow the findings list, for example by category or status, to choose what to work on | 19,374 actions by 10 users | Yes: one findings list across all merchants in a portfolio, with filters | |
| Open a finding's log | Open the record of a finding's status changes and notes | 12,982 by 10 users | No finding change history | Merchant & Finding Activity Log |
| Add a note to a finding | Write what the analyst checked or decided on that finding | 9,972 by 9 users | Yes: comments per finding and per merchant | |
| Change a finding's status | Set where a finding stands in Adyen's review | 9,189 by 10 users | Yes | |
| Snooze a finding | Hide a finding until a set date, after which it returns to the active list | 2,119 by 8 users | Yes, when the portfolio's snooze setting is on | |
| Switch portfolio | Move between Adyen's 6 portfolios: Sonar Acquiring, Sonar AO - Acquiring, Sonar - Advanced, Sonar Manage, Sonar PayFac, Sonar AO - Platforms | 1,986 by 10 users | Organization, portfolio, merchant hierarchy exists. Switching between portfolios not confirmed. | |
| Search for a merchant | Find a merchant by name or ID | 1,572 by 8 users | Not checked | |
| Review evidence | Open the screenshot and text snippet that show the violation | 1,288 by 9 users | Screenshots yes; text snippet and keyword no | Only if CC / UI full parity validation closes it |
| Network view | See websites connected to a merchant, to spot related sites | 383 by 7 users | Yes: Connected Sites / Graph | Graph enhancements; Graph and Merchant Map |
| Change statuses in bulk | Set the same status on up to 50 findings at once | 144 by 6 users | Yes | |
| Submit a dispute | Ask G2RS to re-check a finding Adyen believes is wrong | 120 by 8 users | Yes, including bulk | Finding Dispute and Reassessment |
| Executive dashboard | Open the dashboard tab | 48 by 6 users | Not checked | Report Center in Atlas |
| Generate a report | Create a findings report | 42 by 4 users | CSV yes, PDF no | Report Center in Atlas; Generate Finding Summary and Resolution Report |
| Download files | Download generated reports and exports | 42 by 4 users | Not checked | |
| Assign a finding | Give a finding to an analyst | 12 by 5 users | Assignment per merchant | Bulk analyst assignment |
| Add merchants in bulk | Upload a file of merchants and URLs | 13 by 1 user | Yes | Wizard for Add Merchant |
| Rules Customizer | Set rules for which findings are raised and at what risk level. Adyen reported it broken in July 2026 (MERV-45774). | 2 by 2 users | Category risk settings per portfolio | None. Client Rules, Risk Matrix and Decisions is Q4 but not Must. |
