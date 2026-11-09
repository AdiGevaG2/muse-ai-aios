# CAL x Atlas meeting: what was promised, what CAL asked for

G2 presented Atlas to CAL as the MerchantView replacement: what exists today, what lands by end of 2026, and what lands by end of February 2027. CAL cannot keep up with the rise in findings since the lang9 release, asked for training and a trial of Atlas on their own data, and wants pricing as soon as possible, scoped to the services they use.

Sources:
- [sources/2026-11-05-cal-atlas-meeting-raw.md](sources/2026-11-05-cal-atlas-meeting-raw.md): partial transcript and first written summary. Called "transcript" and "summary 1" below.
- [sources/2026-11-05-cal-atlas-meeting-summary-2-raw.md](sources/2026-11-05-cal-atlas-meeting-summary-2-raw.md): second written summary, covers the alcohol and custom-rules discussion that the transcript does not include. Called "summary 2" below.
- [sources/2026-11-05-cal-atlas-meeting-summary-3-raw.md](sources/2026-11-05-cal-atlas-meeting-summary-3-raw.md): third written summary, from the G2 side, focused on CAL's complaints and ideas. Called "summary 3" below.
- [sources/2026-11-05-cal-atlas-meeting-summary-4-raw.md](sources/2026-11-05-cal-atlas-meeting-summary-4-raw.md): client meeting notes from the G2 side, with action items. Called "summary 4" below.
- [cal-atlas-meeting-leadership-summary.md](cal-atlas-meeting-leadership-summary.md): leadership summary as corrected by Adi Geva. Corrections there override the meeting sources. Tagged `[PM]`.

All sources cover the same meeting, 5 November 2026. Speakers are unnamed in the transcript; the G2 presenter is referred to as "D.". Speaker labels in the transcript look swapped in places. Usage figures come from [cal-merchantview-usage.md](cal-merchantview-usage.md).

Tags: `[PM]` stated by Adi Geva, `[verbal]` said in the transcript, `[documented]` in a written summary, `[inference]` drawn by us.

## What CAL asked for

- A training session and a full Atlas demo, so the move does not happen blind. `[verbal]` `[documented]`
- Periodic training and notice of new releases, as a standing QBR item. `[documented]` summary 4
- Access to try Atlas before deciding, in a demo environment loaded with CAL's own data. `[documented]` summary 1, 2, 4
- Pricing per service, scoped to what CAL uses, as soon as possible. CAL will map its own use cases first "to avoid paying for unnecessary features". `[documented]` summary 1, 4
- A follow-up meeting on pricing, cost, and operational setup. `[documented]` summary 1
- Working sessions to map CAL's requirements, define custom rules and risk policies, and train in depth. `[documented]` summary 2

Link to usage: CAL has WebID and used it 4 times in 12 months `[PM]`. The usage file counts 9 WebID clicks: 6 page opens and 3 searches `[documented]`. The two figures may count different things; see open questions. The pricing ask makes the unused-service risk concrete. `[inference]`

## Commitments G2 made

Per the leadership summary `[PM]`:
- Quarterly business reviews showing new features and collecting feedback, with release updates and training as a standing item. Summary 4 confirms. `[documented]`
- Migration of MerchantView data into Atlas. The transcript added "with all your data" and no data loss `[verbal]`; the leadership summary does not carry that promise.
- A demo environment with CAL's data, and Atlas trial access. `[documented]` summary 4
- Transaction laundering detection through G2's Atlas. Summary 4 calls it TLD and says it came up several times. `[documented]`
- A review of the services CAL uses and does not use, with optional G2 shadowing of CAL's team to map how they work.

Also stated in the meeting but not listed as a commitment in the leadership summary: full Atlas platform consolidated by end of 2026 `[documented]` summary 2.

## CAL's complaints

- **Findings volume since lang9.** CAL sees a sharp rise in findings since the lang9 release and cannot keep up. `[documented]` summary 4
- **False positives rising.** More alerts reach CAL that need no action, and the system's assessment is not always right. `[documented]` summary 3. Summary 4 ties the rise to the lang9 release. `[documented]`
- **Uninformed about features.** CAL does not know about recent updates or what MerchantView can do today. They were surprised rule configuration exists. `[documented]` summary 3
- **Unused services.** CAL has services it does not use. `[PM]` `[documented]` summary 3
- **Unused card data.** G2 holds CAL cards it has not used; CAL handles more cards than G2 holds. `[documented]` summary 3

Link to usage: CAL's filter use dropped from 2,449 in Q3 to 1,152 in Q4 while paging through the merchant list rose from 2,788 to 4,840 (usage file). That fits a rising findings volume. `[inference]` Rules manager MCC opened 7 times in 12 months, consistent with CAL not knowing rules exist. `[PM]`

## What CAL will give G2

- Their business logic and risk appetite, so G2 can help them prioritize findings. `[documented]` summary 4
- Merchant-level transaction statistics, to focus findings. Whether G2 uses them is pending a G2 decision; the summary 4 author recommends considering them. `[documented]` summary 4

## CAL's ideas and requests

| Idea | What CAL wants | Exists today? |
|---|---|---|
| False-positive snapshot | Take one month, compare what G2 surfaced with what needed action `[PM]` | No |
| Behavior change alerts | Flag when a merchant starts selling abroad, adds products, or changes MCC. CAL does not have MCC gen pop today `[PM]` | Unknown |
| Blacklist to processor | Scan the merchants on a blacklist, find who processes their payments, and tie it back by test transactions `[PM]`. Summary 3 says tie back to Visa; the PM correction replaces that | No |
| Card watchlist | Pre-defined card list; notify when a listed card transacts `[PM]` | No |
| Complaints vs. MCC | Flag when consumer complaints point to a different business than the MCC. Example: registered for accommodation credits, complaints showed online stock trading `[PM]` | No |
| Rules | Use rule configuration `[documented]` summary 3 | Yes |
| Probability-of-sale check | Extra validation by industry and region `[documented]` summary 3. Not carried into the leadership summary | No |
| Risk matrix | Strong interest, no detail `[documented]` summary 3. Not carried into the leadership summary | Unknown |

Areas of interest: web traffic, CRAM (more than WSL), Graph / connected sites. `[documented]` summary 3

## FSD

- FSD was discussed, including its limits in the small Israeli market. `[documented]` summary 4
- CAL is interested and will contact Javier for pricing. `[documented]` summary 4
- FSD likely stands for the "front-side detection" listed on the roadmap slide. `[inference]`

## Alcohol alerts and custom rules

Only in summary 2; not in the transcript, and not carried into the leadership summary.

- Alcohol alerts are a large share of CAL's risk indications. About 94% of these cases are an alcohol keyword detected on the site. `[documented]` summary 2. Population and source of the 94% are not given; treat as unverified.
- A keyword on a site is not the same as selling alcohol. Deciding whether a merchant sells alcohol without a license, or in a restricted jurisdiction, needs more context. `[documented]` summary 2
- Custom risk rules: assign a set risk level automatically when conditions match, for example merchant location plus business type. `[documented]` summary 2
- Indication Categories come from keyword detection; Content Categories reflect what the site sells. `[documented]` summary 2
- Additional capabilities mentioned: external review analysis such as Trustpilot, and cross-referencing regulatory information. Summary 2 labels these "Advanced MCCM"; the meaning of MCCM is unknown. `[documented]` summary 2

## Connected sites

- Today, reading a connection needs system expertise; "most clients do not use this". Said by G2. `[verbal]`
- Models are being tuned to cut noise to an average of 0.25 connected sites per submitted site. Only strong links stay, for example a one-to-one IP match, not a shared range, shared address, or shared cloud IP. `[verbal]` `[documented]`
- Starting figure conflicts: the transcript says an average of 4 `[verbal]`; summary 2 says "approximately 1-4" `[documented]`. Source of either figure not given; treat as unverified.
- Tense conflicts: the transcript says the models "are improving" `[verbal]`; summary 2 says improvements "have been made" `[documented]`. Whether the change is live is unknown.
- Connected sites will show on the merchant screen, in one view. `[verbal]`

## Exists today, per the presenter

Comments on findings, merchant policy review, connected sites with MCC mismatch, Summary / MMP / URL-level reports, new-scan email for monitoring scans, WebID upload without a URL inside the system, "Detected by EverC" indicator on the merchant. `[verbal]` `[documented]`

WebID: previously a separate file exchange outside the system. Now a file without URLs uploads like an onboarding scan, runs a WebID scan, and on a match can move to onboarding and monitoring. `[verbal]` `[documented]` summary 2

## Roadmap shown

The slide marked some items with asterisks as "in Atlas by end of year"; the rest by end of February 2027. Which items carried asterisks is not in any source. `[verbal]`

| Item | What was said | CAL usage today |
|---|---|---|
| Front-side detection (FSD), scam detection | Listed; FSD has limits in the Israeli market | Not tracked |
| Web traffic | Third-party providers assess merchant site traffic volume | Not tracked |
| Watchlists and sanctions | Screened | Not tracked |
| Website policies, expanded | Checks policy content, fit to category, and required policies; MerchantView checks only exists / missing | Not tracked |
| Merchant Data Check | Compares merchant name, address, email given vs. on site; shows mismatches | Not tracked |
| IdentIQ Underwriting | AI-run underwriting flow, faster onboarding results; by end of February | New Onboarding QI: 304 underwriting clicks |
| Report center | Downloaded and available reports in one place; billing report | 82 reports generated |
| Help center | Mentioned | Not tracked |
| Evidence screenshots | Screenshot per finding where capturable, including connected URLs | 2,819 evidence reviews |
| Activity log | Every merchant change, labeled by client user, G2 analyst, or system | Not tracked |
| Add-merchant wizard | Shown in demo | 7,642 one-by-one adds |
| Disputes | Presenter noted CAL uses them "a bit" | 1,117 tab opens, 41 submitted |
| System notifications | Email and in-app, per user choice | Not tracked |

"Not tracked" means the usage file has no matching event. `[inference]`

Summary 2 places evidence screenshots and connected-URL links inside the Reporting Center; the transcript lists them as separate items, with screenshots shown inside findings. The transcript is the direct record. `[inference]`

## Action items

| Action | Owner | Source |
|---|---|---|
| Send business logic and risk appetite | CAL | summary 4 |
| Share merchant-level transaction statistics, pending G2 decision on using them | CAL | summary 4 |
| Map use cases and ideal flow | CAL | summary 1, 3, leadership summary |
| Schedule follow-up meeting on pricing and setup | CAL | summary 1, leadership summary |
| Add release updates and training to QBR agenda | G2 | summary 4 |
| Arrange Atlas trial access and demo environment with CAL data | G2, owner not named | summary 1, 4, leadership summary |
| Training session and full Atlas demo | G2, owner not named | summary 1, leadership summary |
| Send pricing for Atlas and FSD, as soon as possible | G2 / Javier | summary 4 |

Overall impression from summary 4: CAL wants to deepen the collaboration with G2. `[documented]`

## Transcript issues

- "Eversee" in the transcript is "EverC"; summary 2 names the label "Detected by EverC". `[documented]`
- The underwriting feature is named "IdentIQ Underwriting" in summary 2; the transcript says "Identity Underwriting". `[documented]`
- "Using inside cost scans" is unclear; meaning unknown.

## Open questions

- Confirm attendee names, and whether Shirley is the presenter the transcript calls "D.".
- Confirm what the 4 WebID uses count, since the usage file shows 9 WebID clicks in the same period.
- Confirm what "MCC gen pop" means for CAL.
- Confirm what lang9 changed and how much findings volume rose for CAL after it.
- Confirm which roadmap items were marked for end of 2026.
- Confirm the source of the connected-sites starting figure (4 or 1-4) and of 0.25 before reusing them, and whether the change is live.
- Confirm the population and source of the 94% alcohol-keyword figure.
- Confirm what "MCCM", CRAM, WSL, and the risk matrix CAL asked about refer to.
- Confirm which card data G2 holds for CAL and why it is unused.
- Decide whether G2 will use CAL's merchant-level transaction statistics.
