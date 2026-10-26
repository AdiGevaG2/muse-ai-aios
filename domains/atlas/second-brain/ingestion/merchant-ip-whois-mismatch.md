# Merchant IP / Whois Mismatch Signal

Mastercard-recommended control (via Adyen/UAE onboarding) to flag mismatches
between an e-commerce merchant's IP-derived location and its declared/onboarded
location. Not currently offered by MV or (per Gal Sahar, unconfirmed) WS/SP.
Core gap: merchant transaction-time IP isn't collected today; website whois
gives host/hosting-provider location, not merchant location.

## Trigger and context

- **Ask origin:** Adyen, via Mastercard's recommended monitoring controls for
  e-commerce merchant IP mismatches. [documented — source email thread]
- **Business driver:** Adyen's Mastercard Franchise onboarding, required for
  its newly acquired UAE license (lets Adyen run payment services directly in
  the UAE and manage local settlements without third-party providers).
  [documented — source email thread]
- Raised 2026-09-07 by Juan Jose Jovel Ramos (CSM) to Mary Williams / Ishai
  Froind; routed to #G2 Product Management. [verbal]

## Why website whois isn't the merchant signal

- Merchant IP (address the merchant transacts/interacts from) != website IP
  (where the site is hosted). For small merchants especially, a whois lookup
  on the website resolves to the **hosting provider's** location, not the
  merchant's. [verbal — Gal Sahar]
- To catch a real mismatch, you need the IP the merchant came from while
  interacting with clients (e.g., at onboarding) — not derivable from the
  website alone. [verbal — Gal Sahar]

## Proposed approach (unbuilt, not scoped)

1. Whois both IPs: merchant's transaction IP and the website's IP.
2. Validate the resolved IP isn't a hosting/proxy service before trusting its
   geolocation — IP-based country is only meaningful for non-hosting IPs.
3. Compare resolved IP country to the merchant's declared location detail.

[verbal — Gal Sahar's proposal; not validated against any product roadmap]

## Two possible requirement bars

- **Substantial** (must actually catch mismatches): requires merchant
  transaction-time IP — data G2RS likely doesn't currently collect in either
  MV or WS. [inference — Gal Sahar "does not know and doesn't believe," not
  confirmed]
- **Compliance box-check only** (Adyen needs to show they checked): website
  whois alone could suffice, with caveats that it reflects hosting location,
  not merchant location. [verbal — Gal Sahar]

Which bar Mastercard/Adyen actually requires is unresolved as of thread close
(2026-09-09).

## Current whois behavior in MV, as of now

- Core MV does **not** do website whois + location comparison today. [verbal —
  Gal Sahar, to be confirmed]
- FSD (presumably Field/Fraud Solutions Delivery — unconfirmed expansion) has
  an internal call to an external Whois service. [verbal]
- Clients registered to **Scamadviser** get Whois data via that integration
  instead of the FSD call. [verbal]
- Gal committed to checking whether/how MV runs whois at all — open item, not
  yet answered in this thread.

## Open questions

- Does WS or SP already capture any IP/location signal? Asked in-thread, no
  PM had answered as of 2026-09-09.
- Is merchant transaction-time IP available anywhere in G2RS data (onboarding
  systems, payment processor feeds)? Unknown.
- Which requirement bar (substantial vs. compliance box-check) applies?
  Unresolved — needs direct Adyen/Mastercard clarification.

## Links

- [[merchantview]] — the product this gap sits in; whois/IP is not part of MV's
  documented monitoring today.
- [[crawler-capability-gaps]] — separate capability-gap page; this is a distinct
  gap (data collection, not crawling) but same "what MV can't do today" theme.
- [[atlas-architecture]] — any new IP/whois signal would need a home
  in UP, not just legacy MV, if built.

[verbal] tags throughout — this entire page derives from one internal email
thread, none of it yet confirmed against MV code, FSD documentation, or a
scoped roadmap decision.
