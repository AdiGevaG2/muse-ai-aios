# Website data analysis

Reading a merchant's traffic profile to decide whether the site is what it
claims. The core underwriting technique taught across every Academy cohort.

## Why it works

A front site has to exist, but it does not have to attract customers — its
transactions arrive from elsewhere. So the gap between "transactions processed"
and "humans visiting" is the signal. [documented — Berlin *Data-driven Merchant
Onboarding*] [inference on the mechanism]

## The four reads

**Visitor count** — no visitors while transactions process points to
[[transaction-laundering]]. "Zig-zag" traffic points to click farms, bots, or
deceptive marketing. High bounce or low pages-per-visit points to a front site.
The canonical front-site fingerprint: 100% direct traffic, 1.00 pages per visit,
100% bounce rate.

**Traffic sources** — 100% direct traffic indicates inorganic user flows,
characteristic of TL fronts. High referral share always warrants a backlink
check. Extremely high search share often indicates SERP hijacking (see
[[seo-poisoning]]). High social or email share can indicate aggressive or
deceptive marketing, even phishing.

**Traffic geography** — look for geographies where the goods are illegal or
regulated, and geographies that deviate from assumed shipping destinations.

**Backlinks / outgoing links** — high referral traffic triggers a backlink check
against high-risk sites. If backlinks look benign but still carry high referral
traffic, run a second-layer check. Always check the backlink sites that account
for most traffic for *their* outgoing links, to find "distributors".

An expected traffic mix differs by business type, so the profile is read against
the MCC's norm rather than against an absolute. See [[merchant-risk-by-mcc]].

## Onboarding structure

Collect and enrich (name, URL, UBO from registries) → scrutinize the datapoints
→ assess outcomes → decide, with risk exposure attached. [documented]

## Knowing when to stop

Advanced OSINT frames the discipline as finding the *main dealbreaker*, not
cataloguing everything. In the taught case a crypto voucher merchant showed six
issues — no KYC, sanctions compliance gaps, obscure corporate structure, license
issues, load balancing — but the dealbreaker was a single backlink carrying over
80% of traffic from an IPTV provider, i.e. TL. [documented — Berlin *Advanced
OSINT*]

## Related

[[transaction-laundering]] · [[osint-toolkit]] · [[merchant-risk-by-mcc]] ·
[[seo-poisoning]] · [[financial-risk-exposure]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
