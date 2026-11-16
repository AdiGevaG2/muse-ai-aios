# Adyen QBR internal sync, 2026-11-16

G2RS planned the Adyen QBR at Adyen HQ on Wednesday 25 November 2026. The deal team challenged presenting Atlas this early. The call ended with a plan to move the Atlas product session one to three weeks later, so Ishai and Mary Williams can join, and to hold a shorter QBR on the 25th.

Source: [source/2026-11-16-qbr-internal-sync-transcript.rtf](source/2026-11-16-qbr-internal-sync-transcript.rtf). Every claim below is `[verbal]`: it is what someone said on the call, not a document.

Attendees: Juan Jose Jovel Ramos (JJ), Natasha Bottari, Franz Reinhöfer, Marc Temple, Jack Voice, Adi Geva.

## QBR goals, as JJ set them

1. **Relationship with Rosa van Vagenhof.** Rosa led payment risk operations in San Francisco, was promoted to global head of payment risk, moved back to Amsterdam, and is now Sasha's manager. `[verbal]`
2. **Insight into Atlas.** Adyen has 8 people using the UI and is revamping its risk operations. Adyen wants to know what is coming and how integration works. `[verbal]`
3. **Value realization.** Industry and scheme insights. Sasha asked for about an hour of in-person category training for the team. `[verbal]`

## Proposed day, 25 November, Adyen HQ

| Session | Content | Audience | G2RS lead |
|---|---|---|---|
| 1. Atlas demo and roadmap | 2 or 3 slides, then a live demo. JJ called it the hero of the QBR. | Rosa, Reece Coles, Sasha and team | Adi |
| 2. Compliance | 30 minutes with the payment operations team, which handles scheme notifications and investigations. 30 minutes with Sasha's team on categories Sasha picks. | Payment operations, Sasha's team | Franz |
| 3. SmartScan partnership | One-hour open discussion, no proposal. Data on the deep investigation requests Adyen received this year. | Not stated | JJ, with Marc and Jack |

- Client dinner with Rosa and Sasha. Maciej is in Chicago and will not attend; Richard is expected. `[verbal]`
- Mary Williams will not be there in person, because of US Thanksgiving. `[verbal]`
- Reece Coles is a new Adyen product manager who is redesigning Adyen's internal risk processes. `[verbal]`

## What Adyen's product team asked, per JJ

JJ reported a call the previous week that was planned as 10 minutes and ran an hour. `[verbal, second-hand]`

- Agentic capabilities, AI, and age verification.
- Detecting products shipped to restricted regions.
- API and signals; MCC; front site detection; PEP.
- How the crawler works: how many pages it crawls and for how long (Reece).
- Near real-time onboarding screening. JJ read this as a speed and SLA need, not a signals need. Adyen does no onboarding today and has not defined what it needs.

Natasha said Mary had a call with Adyen the previous Thursday about AI adult content detection that G2RS put in production with Ant Group. Franz understood this as the "nudifying" detection, not the adult high-risk agent. No notes were available. `[verbal]`

## Concerns raised

- **Agentic agents don't match Adyen's business.** Franz said the agents target gambling, pharmaceutical and adult merchants, which Adyen is not building a book of business in. `[verbal]`
- **Front site detection.** Franz said clients that use it today are unhappy with it, and selling it as is would hurt. `[verbal, opinion]`
- **MCC is not an Atlas capability.** Franz said G2RS could sell MCC to Adyen today, outside Atlas. `[verbal]`
- **Competitive pressure.** Franz said Adyen only renews for 12 months, competitors are cheaper, and the new product manager will compare G2RS side by side with competitors' onboarding. Showing a future state may be weaker than showing nothing. `[verbal, opinion]`
- **One shot.** Jack said G2RS has one chance to present Atlas; if it is not ready, run a standard QBR instead. Natasha agreed and added that no product leader would be on site. `[verbal]`
- **Design partner.** Jack said G2RS told Adyen in earlier QBRs it wants Adyen as a design partner, and asked whether backlog items can be shared for Adyen's input. `[verbal]`

## Quarter timing

- Adi said G2RS quarters changed company-wide: Q4 runs to the end of February 2027, and Q1 starts in March 2027. `[verbal]`
- Natasha and Franz said this was not communicated internally and will confuse clients. `[verbal]`
- Agreed direction: client material states dates, not G2RS quarters. Franz and Natasha suggested H1 and H2. Adi preferred exact dates, because a half-year label makes three months of work look like six. `[verbal]`

## What Adi stated about Atlas

- The features MerchantView clients need to migrate are planned and will be done by the end of February 2027. `[verbal]`
- Atlas will be ready for client migration by the end of calendar 2026. `[verbal]`
- Onboarding as it works in MerchantView: mostly by the end of 2026, with the remaining changes by the end of February 2027. `[verbal]`
- Web traffic and agentic underwriting are planned for this quarter, which ends in February 2027. `[verbal]`
- Bulk merchant upload includes AI that fixes errors in the file. `[verbal]`
- The prototype covers everything planned through February 2027. Atlas has about 80 to 85% of MerchantView's capabilities. `[verbal]`
- There is no Q1 2027 plan yet. About 100 backlog items are not prioritized, and planning starts in about two months. Items from that backlog can be pulled forward for a client that sets a condition for migrating. `[verbal]`
- Questions about how the core engine works need Gal, the PMM of core. `[verbal]`

## Outcome and next steps

- JJ will tell Sasha the product session may move a week or two. Natasha suggested the week of 7 December, when Ishai and Mary are in Europe. `[verbal]`
- Fallback: on 25 November, run a shorter QBR with Franz's session, the dinner, and an introduction to Rosa. Hold the product session in December or January. `[verbal]`
- JJ will set up an internal follow-up with Mary, Ishai, Franz and Adi, likely on Wednesday or Thursday. `[verbal]`
- JJ will share notes from the previous week's Adyen product call; Adi asked for them. `[verbal]`
- JJ will get Sasha's category list for Franz within a day or two. `[verbal]`
- Adi will show dates instead of quarters, prepare a prototype matched to what Adyen needs, and find out what Adyen means by onboarding. `[verbal]`

## Links to the rest of the wiki

- [account.md](account.md): this call adds three Adyen contacts, Rosa van Vagenhof, Reece Coles and Richard, and confirms 8 UI users.
- [timeline.md](timeline.md): the QBR date and the possible move of the product session.
- [requests.md](requests.md) and [feedback-2026-06-11.md](feedback-2026-06-11.md): restricted-region shipping, age verification, crawler depth and onboarding speed are new themes. The June asks were about workflow and detection.
- [../adyen-asks-mv-atlas-list.md](../adyen-asks-mv-atlas-list.md) and the QBR slides: the slides state dates, as agreed here. They feature front site detection and agentic underwriting as new capabilities; Franz's concerns above apply to both. `[hunch]`
