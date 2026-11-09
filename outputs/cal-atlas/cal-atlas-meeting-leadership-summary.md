# CAL x Atlas meeting, 5 November 2026: leadership summary

## Bottom line

CAL is open to moving from MerchantView to Atlas. CAL pays for services it does not use and says false positives have risen over the past few months. CAL will define its own use cases before discussing price. Our assessment: price is the deciding factor, and if pricing comes before a demo on CAL's data, the unused services look like waste and are at risk at renewal.

## What CAL told us

- **They do not know what they have.** CAL does not hear about new features and does not know what MerchantView does today. They were surprised that rule configuration exists. The rules screen was opened 7 times in 12 months, which we read as consistent with this.
- **False positives are rising.** More alerts reach CAL that need no action. Findings rose sharply after the lang9 release, and CAL cannot keep up with the volume.
- **They have services they do not use.** CAL has WebID. In 12 months WebID was used 4 times.

## What CAL asked for

- Training and a full Atlas demo, in a demo environment loaded with CAL's own data.
- Pricing per service, scoped to the services CAL uses.
- Working sessions to map CAL's requirements and set up custom risk rules.
- Proactive notice of new features.

## What CAL offered

- Their business logic and risk appetite, so we can help them prioritize findings.
- Merchant-level transaction statistics, to focus our findings. Whether we use them is a G2 decision.

## Ideas CAL raised

None of these exist in Atlas today unless noted.

- Compare one month of G2 alerts against what needed action, to measure false positives.
- Alert when a merchant changes behavior: starts selling abroad, adds products, or changes MCC. Whether this exists today is unknown. Currently CAL don't have MCC gen pop.
- Find which processor handles payments for blacklisted sites, and tie it back by test transactions - scan merchants in blacklist list.
- A card watchlist that notifies CAL when a listed card transacts.
- Flag when consumer complaints point to a different business than the MCC. Example given: a merchant registered for accommodation credits whose complaints showed online stock trading.

## What G2 committed to

- Quarterly business reviews showing new features and collecting feedback.
- Migration of MerchantView data into Atlas.
- A demo environment with CAL's data.
- Transaction laundering detection through Atlas (G2's).
- A review of CAL's unused/used services, with G2 shadowing (optional) CAL's team to map how they work.

## Decisions needed from leadership

- Pricing approach for CAL: price only the services CAL uses, or keep WebID and Graph in the package and show their value in the demo first.
- Order of next steps: demo on CAL's data before the pricing meeting, or in parallel.
- Which of CAL's ideas to evaluate for the roadmap.
- Owner and date for the CAL demo environment.
- Whether to use CAL's merchant-level transaction statistics.

## Next steps

| Step | Owner |
|---|---|
| Training session and full Atlas demo | G2, owner not named |
| Demo environment with CAL data | G2, owner not named |
| Pricing per service, for Atlas and FSD, as soon as possible | Javier |
| Send business logic and risk appetite | CAL |
| Map use cases and ideal flow | CAL |
| Follow-up meeting on pricing and setup | CAL to schedule |
