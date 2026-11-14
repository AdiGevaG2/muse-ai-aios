# PayPal Onboarding on Atlas

PayPal wants to run merchant onboarding checks through the Atlas API, with a
sandbox in testing by mid-December 2026. It is a new opportunity on top of the
current PayPal contract, and the internal thread shows the API, SLA, and
readiness answers were still being assembled while PayPal was evaluating.

Source for every claim below unless noted:
`source/2026-11-11-paypal-onboarding-atlas-email-thread.md` (internal G2 email
thread, 2026-10-12 to 2026-11-11). All tags are [verbal]: these are statements
in email, not checked against code, API docs, or contracts. Claims marked
"(SLA doc)" come from `source/2026-11-11-paypal-questions-4nov-doc.md`, the
shared PayPal SLA working document; those are [documented] as G2's written
answers to PayPal, still not checked against the build.

## What PayPal asked for

- Onboarding checks via API, sandbox testing by mid-December. [verbal] Mary
  Williams, 2026-11-11 call notes
- The redesigned PayPal onboarding flow makes a URL mandatory. In the POC about
  50% of merchants had no URL because it was optional. [verbal] same
- Inline checks while the merchant is present, starting with URL availability
  (offline or parked site), then possibly contact validation, generic URLs,
  fraud history from Graph and Merchant Risk History, and a shallow MCC check.
  Deeper checks run asynchronously. [verbal] same
- Staged, risk-based integration: not every service runs for every merchant.
  [verbal] same
- PayPal owes G2 the check sequence, required outputs, and acceptable SLA per
  onboarding stage. [verbal] same
- Technical ask from Rahil (PayPal) on 2026-10-16: API docs and endpoint URLs,
  per-component processing time, request and response fields, authentication,
  SLAs for latency and availability, maximum TPS with rate limits. Items 1 and 2
  were requested same day. [verbal] forwarded by John Hughes
- Baseline volume for pricing: 500K merchants per month, possibly 750K to 1M in
  some months. [verbal] John Hughes, 2026-10-12

## Why it matters commercially

- The onboarding initiative is a stated top-5 priority for PayPal's CRO.
  [verbal] John Hughes, 2026-10-14
- Not having SLAs and all required solutions API-ready by end of year risks
  PayPal choosing a competitor, and puts the existing ~$4M ACV at risk if
  PayPal consolidates with another provider. [verbal] John Hughes, 2026-10-19
- Mary Williams frames the deal as a direct outcome of the 100K-merchant POC.
  [verbal] 2026-11-11

## Which API path: Atlas, not GO/SP

- John Hughes: GO/SP is likely not an option because several solutions would
  run by file transfer or a manual route, for example WebID. [verbal] 2026-10-16
- No SP API returns WebID results; SP WebID accepts requests by API but results
  are portal-only. [verbal] Sarah Craven, 2026-10-13
- FSD and WebID have no SP-to-EverC integration; requests and responses would
  be manual. [verbal] Ron Cohen, 2026-10-13
- Exposing FSD and WebID through GO via the MLRC pipeline needs both components
  in the pipeline plus new GO components; as a pass-through with no new AME risk
  flags, Sarah Craven estimates about one month of Guardian/Jedi work. [verbal]
  2026-10-13
- Ishai Froind: PayPal's SLA expectations can only be met through Atlas.
  [verbal] 2026-10-13
- Interim tactic: GO and MDMX API docs were sent first, with the stated intent
  to swap to Atlas before PayPal's integration work starts. [verbal] Ishai
  Froind and Mary Williams, 2026-10-14 and 2026-10-16
- An Atlas API doc existed, written under NAB pressure; Ishai Froind was not
  confident a proper engineering design was in place. [verbal] 2026-10-16

## What the Atlas API covers (as of 2026-11-11)

- Documented: WebID, MCC, Content Compliance, Front Site Detection, Graph.
  [verbal] Mary Williams call notes
- Merchant Risk History will fold into Graph as one Atlas capability. [verbal]
  same
- Scam Network Detection is not in the Atlas API docs; the model is unfinished
  and the readiness date is unconfirmed. [verbal] same. See
  [[scam-network-intelligence]].
- Results are asynchronous: callback/webhook, or GET findings plus the evidence
  endpoint. [verbal] same
- In GO, MRH returned synchronously. Whether Graph, which will carry MRH,
  returns sync or async on Atlas was asked and not answered. [verbal] Ron Cohen,
  2026-10-20

### Conflict: what the callback returns

- Ron Cohen: the shared Atlas API docs describe the callback as a
  scan-complete notification only; results need a separate GET. [verbal]
  2026-10-20
- Shmuel Blitz: the callback returns all findings, as in the GO-MLRC/Atlas
  integration; the API uses a different callback version that was not in the
  shared doc. [verbal] 2026-10-20

Unresolved in the thread. It matters because Ron Cohen argued that a
pull-based API makes PayPal's TPS and rate-limit question more pressing.

## SLA statements in the thread

These are internal estimates, not commitments made to PayPal.

| Statement | Who, when |
|---|---|
| Single Platform response times shared with PayPal in August will drop on Atlas because services run through Core | Mary Williams, 2026-10-18 |
| CMP was originally built for instant onboarding with a modular release in single-digit minutes per URL; unknown if that still stands | Ron Cohen, 2026-10-18 |
| Phase 1, more partitions: 6K per 30 min at p95, no added cost, done | Gal Sahar, 2026-10-19 |
| Phase 2, CMP in production with Atlas/MLRC sending to it: 30K per 30 min at p95, benchmarked in K9-1124 | Gal Sahar, 2026-10-19 |
| Application layer can hold a 30K burst returning p95 within 30 min | Shmuel Blitz, 2026-10-19 |
| Processing load sits on K9; the pipeline chosen for PayPal sets the SLA | Shmuel Blitz, 2026-10-19 |
| FSD, MCC, WebID, CC, Graph: under 3 min committed, under 1.5 min believed achievable | Gal Sahar, 2026-10-20 |
| From Core's view, all solutions ready by end of year | Gal Sahar, 2026-10-20 |
| Atlas launches end of year but may not include every product PayPal signs for | Mary Williams, 2026-10-14 |

Open after the thread: how many URLs the under-3-minute SLA supports (Ron
Cohen), maximum TPS and throttle-versus-reject behavior (asked of Sergey Kogan
and Alex Gershun), and which inline checks Atlas can return while the merchant
is present.

### The gap: PayPal's 500-700 ms against component SLAs in seconds to minutes

PayPal's current onboarding SLA is 500-700 ms, and PayPal expects the real-time
API to respond within or close to that. [documented] SLA doc, item 2, status
Open

G2's written answer separates the API layer from the checks behind it.
[documented] SLA doc, item 2:

| Layer | p50 | p90 | p95 | p99 |
|---|---|---|---|---|
| Application, create merchant / onboarding / monitoring scans | 0.5 s | 0.8 s | | 2 s |
| External API create, standalone | 0.14 s | 0.21 s | | 0.39 s |
| Content Compliance | | | 1.5 min | |
| MCC | | | 1.5 min; 2.5 min with WebID | |
| WebID (average 30 s) | | 50 s | 55-60 s | |
| Graph, 0-hop and 1-hop | | | 30 s | |
| Front Site Detection | | | 30 s | |
| Scam Network Detection, future | | | target 1 min | |

Component figures are stated as conservative p95 under the current standard
configuration, tunable with PayPal. Earlier guidance of a 2-minute async SLA via
callback is said to still apply. [documented] same

[inference] The API acknowledges a request inside PayPal's range; no check
returns a result inside it. The fastest component, Graph or FSD at 30 s, is
about 40 times PayPal's upper bound. The MCC-plus-WebID combination at 2.5 min
exceeds the 2-minute async guidance the same answer says still applies.

Internal ideas for getting inline checks faster. [documented] SLA doc, 10
November call outcome:
- Graph/MRH: 30 s is called not sufficient. Proposal is to narrow the check to
  the worst violations, for example confirmed TL or scams, since a direct
  history lookup should return faster. Owner Gal Sahar.
- MCC: open question on the fewest pages to crawl to output an MCC, and the
  precision cost.
- Upfront checks Ron Cohen saw signal for in the POC data: generic URLs,
  dummy or blurb URLs, dummy names, verified bad addresses. Generic URL check
  owner Gal Sahar.
- Component SLAs owner Gal Sahar; API SLA owner Alex Gershun, described as
  negligible next to Core/K9.

## Throughput, caching, and country coverage

- Maximum throughput on the create merchant plus stores API: 250 TPS
  sustained, 120 TPS in the first 10-20 seconds of a cold start, raisable on
  request. [documented] SLA doc, item 4. Answers the TPS question from the email
  thread; throttle-versus-reject behavior is still not stated.
- Caching: PayPal asked how long G2 data can be cached and reused and the
  refresh rate for repeat requests. G2 replied asking for the objective; the
  item is marked Done with no answer. [documented] SLA doc, item 3
- Country coverage: PayPal listed 189 countries. G2 answered global coverage;
  Content Compliance, MCC Verification, and FSD are language-agnostic, with
  lower performance in less common languages and, for FSD, in smaller markets
  where front sites resemble new legitimate businesses. [documented] SLA doc,
  item 6. No per-country gap list was given.
- API spec, endpoints, and authentication: answered by pointing to the shared
  API doc PDF. Owners listed as Sergey Kogan and Adi Geva. [documented] SLA doc,
  item 5

## POC products and required inputs

The POC ran 11 solutions on PayPal's 100K-merchant sample. [documented] SLA
doc, item 1

| Product | Required input |
|---|---|
| Merchant Monitoring | URL |
| Merchant Risk History (MRH) | URL or merchant name; email optional, raises match rate |
| Watchlist, Sanctions, Legal (WSL) | Merchant and/or principal information |
| Consumer Reviews & Adverse Media (CRAM) | Merchant and/or principal information; URL for some checks such as Trustpilot |
| Operational Risk (OR) | URL for traffic and policy checks; email for email fraud check |
| MCC Verification | URL; reported MCC optional, needed for mismatch detection |
| Front Site Detection (FSD) | URL and merchant information |
| Scam Detection | URL and merchant information |
| Transaction Laundering Detection (TLD) | URL or merchant name; email, phone, billing descriptor optional |
| WebID | Name, DBA, email, phone, physical address |
| Graph | URL, name, email, phone, address; more is better |

[inference] With a mandatory URL in the redesigned flow, every URL-dependent
product becomes runnable for every merchant, which the POC could not test for
about half the sample.

## MCC timing

With PayPal's added MCC requirements, Core was weighing two routes: serve them
quickly on legacy, or ask PayPal for more time and deliver via CMP, where
production by end of November is tight. [verbal] Gal Sahar, 2026-10-19. This is
the same CMP routing gap described in [[mcc-mismatch-for-global-onboarding]].

## Pricing context

- Current contract: GO MRH $0.10 and GO CC $0.15 per report, priced at 45K per
  month with analyst review; the new opportunity is automated at 500K. [verbal]
  John Hughes, 2026-10-14
- Recently signed: MCC $0.66 at 10K per month, WebID $0.68 at 5K per month.
  [verbal] John Hughes, 2026-10-13
- Floor unit prices at 500K: WSL $0.20, CRAM $0.30, MRH $0.10 (later $0.08), OR
  $0.35, with lower margin assumed on the expectation that costs drop on Atlas.
  [verbal] Mary Williams, 2026-10-13 and 2026-10-14
- Draft scenarios ranged from about $11.1M a year with all nine components to
  about $5.4M to $6.0M without WSL, CRAM, OR, and in one scenario GO MRH. John
  Hughes called the all-components option unrealistic. [verbal] 2026-10-13.
  Final figures sit in "PAYPAL ONBOARDING TEAM - PRICING.xlsx", not ingested.
- PayPal has WSL covered elsewhere but asked for pricing anyway. [verbal] John
  Hughes, 2026-10-14
- Scam networks today are manual, at $5K per network and 4 networks per month,
  $240K a year. [verbal] John Hughes, 2026-10-13
- Option floated: send only non-high-risk merchants to FSD, on the reasoning
  that a front-site operator would avoid a high-risk profile. [hunch] John
  Hughes with Maya, 2026-10-13

## Open items from the 2026-11-11 call

- PayPal: sequence of checks, required outputs, SLA per onboarding stage.
- Ishai Froind, Ron Cohen: achievable SLAs and which inline checks Atlas can
  support.
- Mary Williams, John Hughes: Scam Network Detection readiness and API doc
  timeline.
- Ron Cohen: component-level SLAs and callback versus polling recommendation.
  The SLA doc reassigns component SLAs to Gal Sahar and API SLA to Alex
  Gershun.
- John Hughes: follow-up working session with PayPal, week of 2026-11-16.

## Unknown

- What "SD" means in the pricing tables. The SLA doc lists "Scam Detection" as
  a product; that SD is Scam Detection is [hunch].
- Whether the "November 10th call outcome" and "November 11th call" in the SLA
  doc are one call or two. Mary Williams' email of 2026-11-11 says the call was
  "yesterday".
- What the 214KB screenshot in the thread shows.

## Related

- [[mcc-mismatch-for-global-onboarding]]: PayPal's earlier MCC mismatch
  requirement and the CMP gap.
- [[scam-network-intelligence]]: the product behind Scam Network Detection.
- [[unified-platform-architecture]]: Atlas is built but not yet taking traffic;
  PayPal would be an early production integration.
- [[merchant-risk-classification-pipeline]]: legacy batch versus streaming,
  relevant to which pipeline sets PayPal's SLA.
- [[network-intelligence]]: Graph and MRH as the fraud-history inline check.
