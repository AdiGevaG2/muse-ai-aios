# How Change Detection runs today

Change Detection today is an analyst-run service on Visualping: the client submits a list, an analyst picks up to about 300 pages per site, Visualping scans on a cadence, analysts filter the changes, and the client receives an Excel report through File Share. Sub-page discovery is a managed service Visualping performs by hand, not a product feature.

## Client-facing process

Per the Change Detection User Guide, last updated July 2026 [documented] (`sources/slack-files/2026-10-28-change-detection-user-guide.pdf`):

- The client uploads a website list in the "G2RS Change Detection Template" Excel file through File Share in the G2RS portal. The URL is the minimum; legal or business name and MID are optional and tracked together in the master list when given.
- G2RS sets up monitoring and returns "CLIENT NAME - Change Detection - Updated Master List_MM-DD-YYYY" as confirmation. The same upload is used for monthly additions and removals; G2RS compares it with the current master list.
- Monitoring scope is about 300 pages per website. Large sites, marketplaces and big catalogs are sampled.
- The first scan is a baseline with no report. The first report follows the next scan.
- Reports are uploaded only when analysts find a meaningful change: daily, on Fridays for weekly, on the last day of the month for monthly, moved to the next business day when month-end falls on a weekend. Formatting, technical and other non-material changes may be left out.
- File Share emails the client when a report or master list is uploaded.

## The report

Excel, three tabs [documented] (user guide):

1. Change report: URL, current text, previous text, and where applicable a note on what changed and why it matters.
2. Merchant list: every site in the client's account.
3. Newly identified URLs: sites are crawled quarterly for new URLs; the tab appears only in reports that follow those crawls.

Whether analysts put every new URL in tab 3 or only product and policy pages is unconfirmed. Juan Martini understood that only product and policy pages are reported and the rest discarded; Sarah Craven assumes all are reported. Logged as a question for Margo on 2026-10-28 [verbal] (`sources/2026-11-05-slack-change-detection-channel.md`).

## Recommended monitoring scope

The user guide's default scope [documented]. This is the default profile the PRD's M3 phase starts from.

| Content monitored | Focus |
|---|---|
| Header and footer | Ownership or business name, address, promotional statements, navigation and tab names, billing descriptors, payment methods and logos |
| Home page, pop-up banners | Ownership or name, address, significant price changes, site-wide discounts, "going out of business" messaging, primary content, banners and pop-ups, customer reviews |
| Product collection pages | Price changes across multiple products, site-wide promotions, liquidation messaging, product claims such as health or medical claims |
| Individual product pages, sample of up to 300 | Significant price changes, product claims, descriptions, ingredient lists, customer reviews |
| Billing descriptors | Ownership or business name |
| Payment methods on footer and product pages | Payment methods used |
| Terms and conditions, privacy policy | Ownership, address and contact, billing descriptor, any content revision |
| Contact page | Business name, address, email and phone, any other content |

## Analyst operations behind it

From Juan Martini's 2026-10-30 recap of a conversation with Margo [verbal] (Slack export):

- Pages per merchant come from two places: Margo selects them by hand, or Visualping supplies them. Margo imports up to 300 pages per merchant.
- A regular Visualping account does not discover sub-pages; Juan confirmed this on his own account. Margo sends the list to Bethel at Visualping, who loads the pages from Visualping's back end, and Margo checks them.
- Each client is one Visualping workspace. Inside it, pages from all merchants are mixed with no per-merchant view. Margo searches by domain or exports to Excel and groups by domain with AI formatting.
- Juan's takeaway: the two largest gaps to close are automatic sub-page discovery and a per-merchant view of monitored pages [verbal].
- Margo shared a Google Sheet of sample output. Not downloaded; link in the Slack export.

Analysts QA reports against a "Claude Reporting Criteria" document holding general notes, per-client notes and exceptions [documented] (`sources/slack-files/2026-10-28-clients-with-special-reporting-needs.docx`). See [[client-reporting-exceptions]].

## Related

- [[client-base-and-cadence]] for who is monitored and how often.
- [[client-reporting-exceptions]] for per-client rules on top of the default scope.
- [[planning-thread-oct-2026]] for how the team intends to replace this.
