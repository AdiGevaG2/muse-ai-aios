# Financial risk exposure and chargeback forecasting

How much an acquirer stands to lose if a merchant fails, and when the
chargebacks will actually land. The quantitative half of underwriting.

[documented — Berlin *Financial Risk Exposure*]

## Exposure formulas

**Physical goods** — exposure is the delivery gap:

```
Risk = (Highest monthly turnover / 30 days) × days until delivery of goods
```

E.g. €120,000 peak month with 15 days to delivery → €60,000 exposure.

**Subscription services** — the gap is the full billing cycle:

```
Risk = (Highest monthly turnover / 30 days) × 30.5
```

**Gambling merchants** — bets are placed at different horizons, so exposure is
weighted across the distribution of when wagers settle:

```
Risk = Σ (% of wagers placed in category × (highest monthly turnover / 30) × category)
```

A worked distribution: 47.6% immediate, 7.9% within a week, 11.1% two weeks,
20.6% a month, 4.8% two months, 6.4% three months, 1.6% half a year.

The through-line: exposure is turnover multiplied by the time the acquirer is on
the hook, and the business model sets that time. [inference]

## Chargeback forecasting

Method: take 3–4 months of data (a similar merchant's data also works) and split
it into ticket-size layers. For each layer, compute chargeback-to-transaction
rate. Then break chargebacks down by day and express each as a share of total, to
get a distribution curve — cumulative chargebacks typically climb steeply from
around day 14 and level off well past day 100.

To forecast: layer new transactions and phase out old data; multiply each layer
by its CTR to get forecast chargebacks; multiply the forecast per day by the
distribution rate; read the cumulative to know when to expect how many.

Example: 1,203 new transactions in the €30–40 layer at 3.71% CTR → 44.59
forecast chargebacks, spread across the curve.

## Chargeback prevention tools

- **Rapid Dispute Resolution** — automatically refunds certain disputes before
  they become chargebacks; thresholds set by the merchant, usually a monetary
  amount
- **Ethoca Alerts** — issuer chargeback requests forward to the Ethoca portal;
  merchant gets transaction information and 24–72 hours to resolve; merchant must
  issue a final state outcome to prevent the chargeback
- **Compelling Evidence 3.0** — links patterns to prove friendly fraud: two
  undisputed transactions plus device/network match, customer data match,
  payment/transaction match, with an optional authentication bonus

## Visa Acquirer Monitoring Program

Transaction codes: TC 05 settled transaction, TC 15 dispute/chargeback, TC 40
confirmed fraud event provided by the issuer.

```
VAMP ratio = (TC15 + TC40) / TC05
```

E.g. (1,500 + 1,000) / 200,000 = 0.0125 → 1.25%.

Thresholds:

| Level | Threshold |
|---|---|
| Acquirer — above standard | 50 bps (0.50%) |
| Acquirer — excessive | 70 bps (0.70%) |
| Merchant — ratio | 150 bps (1.5%) |
| Merchant — volume | 1,500 (TC15+TC40) |
| Enumeration — ratio | 2,000 bps (20%) |
| Enumeration — volume | 300,000 auths/month |

## Lineage

Negative option billing traces back to an 1899 livestock trader; the Fair Credit
Billing Act landed 1974; NOB rules were revised 2016 and again 2022. See the acai
berry case in [[merchant-risk-by-mcc]] under MCC 5968.

## Related

[[merchant-risk-by-mcc]] · [[mastercard-bram-and-mmp]] ·
[[website-data-analysis]] · [[gambling-and-miscoding]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
