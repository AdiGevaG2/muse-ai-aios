# SmartScan

EverC's proactive, agentic scan of a website or marketplace. No customer
integration required. Deliberately a risk-area sampler, not an exhaustive sweep —
which is what separates it from [[marketview]].

Source: `source/2025-10-20-everc-g2rs-kt-day1.md` (Shmuel, Anna, Shai).

## The pitch

[documented] Removes every integration obstacle: EverC proactively scans the
customer's (or their customer's) websites. Results appear in the UI with
reasoning attached — why each product was flagged.

[documented] Two customer segments: **marketplaces**, and **payment service
providers** scanning the marketplaces they serve.

## Why it exists — the acquirer black box

[documented] Shai's framing, and the clearest product rationale in the session:
acquirers serving marketplaces face a black box. They don't want to walk away —
it's a growing segment — but "every marketplace opens the floodgates to many,
many, many sellers, and they have little control over that."

[documented] SmartScan was the first EverC feature to cross the
merchant-side/product-side line, which reinforced the thesis that the
merchant/product split is "somewhat artificial."

## The scope decision — deliberately not exhaustive

[documented] "The goal of SmartScan, it's not to find each and every illicit
item in the marketplace or on the merchant website. It aims to find what are the
risk areas and how risky the website is."

[documented] Anna's contrast with [[marketview]]: "in MarketView, we scan
everything; in SmartScan, we decide how many to scan."

[documented] Shai on how that limit is set — notable because it's commercial,
not technical: "it's as long or as short as we want. It's more of a calibration
between how much we want to run it compared to how much we can charge for it...
we can run for 2,000, we can run for 50,000, we can run for 100,000 [pages]."

## Flow

[documented] Three steps:
1. **Scan** — agentic crawling finds suspicious pages across risk areas
2. **Classify** — extract data from suspicious pages, classify
3. **Share** — violations surface in the UI

[documented] Coverage: **40+ product categories** plus service categories;
current focus is product categories.

[documented] Duration: 2–4 hours per scan; scans run in parallel. Shai's caveat:
"this is something that we're still working on, on baking, engineering-wise."

## Delivery status (Oct 2025)

[documented] UI: live. **API: not available** — "Not at the moment, this is
something we're working on in the next few weeks." Jeremy's dry response: "In a
couple weeks, it'll be done, is what I just heard." Listed as a Q4 roadmap item.

[documented] Where a customer has both products, SmartScan findings carry an
icon; the dashboard separates SmartScan from non-SmartScan; the callback API
will carry a key marking results as proactive rather than customer-requested.

## Related

- [[marketview]] — the exhaustive counterpart
- [[atlas-architecture]] — SmartScan shares its UI shell
- [[crawler-capability-gaps]] — Crolex is building similar agentic crawling
- [[crolex]] — the duplicate effort
