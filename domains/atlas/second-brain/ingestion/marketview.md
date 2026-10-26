# MarketView

EverC's product-level classification service for marketplaces. Customer pushes
listings, EverC returns red/yellow/green at millions of items per day, and the
customer's own removal actions feed back as training signal.

Source: `source/2025-10-20-everc-g2rs-kt-day1.md` (Shmuel, Anna, Sergei).

## Position

[documented] Where MerchantView takes a URL and assesses a merchant, MarketView
takes **product listings** and classifies items. Marketplaces partner with EverC
and feed millions of listings daily.

[documented] Shai's framing of why both exist under one roof: "a merchant is a
seller, a seller is a merchant. Merchants are known to be operating on multiple
platforms." The dichotomy is "somewhat artificial." See
[[atlas-architecture]].

[documented] Positioned as "an airtight solution" — send everything, and the
marketplace stays clean. Contrast [[smartscan]], which samples.

## Service levels

[documented]
- Scale: **millions of items per day**
- **90% of results within 5 minutes** (stated once as "95, 90%")
- **SLA: all results within 4 hours**
- Integration: API, or CSV upload for non-API customers

## The traffic-light model

[documented] Three outcomes:

| Colour | Meaning |
|---|---|
| **Green** | Not a violation |
| **Red** | Violation — "we encourage you to remove this item" |
| **Yellow** | Violation, but feedback wanted before acting — risk appetites differ |
| **Blue** | Violation, but suppressed by the customer's own business rules |

[documented] Blue is the business-rule outcome: trusted sellers, specific
brands. The customer still sees the finding but has said they don't want to act
on it. Purpose is noise reduction.

[documented] Observed adoption pattern: after a few weeks customers gain
confidence and **automate removal of red items**, reserving human review for
yellow.

## Precision over recall — an explicit choice

[documented] "One of the key vectors that we have in MarketView is very high
precision, because we want to reduce the noise from the customer side."

[documented] Models trained on **billions of items** across marketplaces.

**Note the trade-off.** Precision is named as the optimization target;
recall is never mentioned. Combined with per-customer category scoping (below),
MarketView is not designed to find everything — it's designed to be trustworthy
about what it does surface. Worth stating plainly in any spec that cites it.

## Scoping is contractual, not technical

[documented] Anna: unlike MerchantView, MarketView does **not** cover
"everything that there is in the world." EverC and the client agree in advance:
which violation categories, which jurisdictions, and for counterfeits, **which
brands and which product types**.

[documented] "Packaging of MarketView is built on how many categories, which
jurisdictions, what brands." Configurations differ client to client.

[documented] These configurations are **account-level and not
self-service** — "We don't let the customers do that through the UI, we do it on
a pull request, we do it manually, or with scripts, behind the scene."

## Feedback loop

[documented] Two channels:

1. **Customer feedback** — analysts mark findings violation / not violation in
   the UI. If the customer is API-connected, marking a yellow item as a
   violation sends it back as red *through the same API*, which removes it from
   the customer's site automatically.
2. **Action monitoring** — EverC re-checks every flagged item **daily for 30
   days**, stopping early once an item goes dead. An item disappearing is read
   as confirmation the finding was valid.

[documented] Action monitoring hits the product page directly where there's no
API — proxied through **Bright Data** and **Nimble**. A couple of customers
expose direct APIs returning live/not-live.

[inference] Action monitoring is a genuinely clever ground-truth source: it
harvests labels from customer behaviour without asking anyone to label. But it
measures *removal*, not *correctness* — a customer removing an item for an
unrelated reason reads as a confirmed hit. Fine as signal, not as an accuracy
metric.

## Architecture

[documented] Five component groups: API layer, UI layer, algorithmic layer,
callback system, SLA monitoring.

[documented] **Two API generations:**
- **Which API** (current, preferred) — customer sends the full product payload
  (ID, title, description, images, brand, price, seller name, seller location).
  Request goes to S3; a reference goes to Kafka (AWS-managed MSK).
- **Legacy API** — customer sends only item IDs. IDs land in DynamoDB, are
  chunked, and an **enrichment** Lambda calls the *customer's* API to fetch the
  data points.

[documented] **Flow router** decides whether an item is in scope; out-of-scope
items skip the pipeline and return immediately via callback.

[documented] **AC service** aggregates items into an "acquired collection" —
typically ~6,000 items per collection — which is the unit sent for scanning.

[documented] **Augmentation** is the business-rule engine, applied after
classification: it can drop findings or downgrade red/yellow to not-violation or
to blue.

[documented] Data layer abstracts MySQL; UI is React with a Java backend.
Dashboards are **Looker embedded in the UI** — chosen because chart changes
don't need R&D work and dashboards can be tuned per customer.

[documented] SLA monitoring: nearly every component reports in, so any item can
be located in the pipeline and SLA compliance tracked.

## Roadmap (Q4 2025)

[documented] SmartScan results in the callback API; **reasoning** extended from
SmartScan to all MarketView findings, exposed via API.

## Related

- [[smartscan]] — the sampling counterpart, same UI
- [[atlas-architecture]] — how these converge
- [[merchant-risk-classification-pipeline]] — the merchant-side equivalent
