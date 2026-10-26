# MCC Verification for Brick-and-Mortar Merchants

Visa Hong Kong wants to know if MCC Verification can extend from eCommerce
merchants to physical (brick-and-mortar) merchants, to catch acquirers/PayFacs
gaming interchange rates via MCC misclassification. Raised as an open question
to G2RS product, not yet a scoped initiative.

## The market problem (Visa HK's account)

- Acquirers and PayFacs onboard or reclassify merchants under lower-interchange
  MCCs (Fast Food 5814, Convenience Store 5499, Bakery 5462, Charity 8398)
  instead of the code that matches actual business activity, to reduce
  interchange cost. [verbal] Sunniva Wong relaying Visa HK, email 2026-08-25
- Named example: merchants moved from 5812 (Eating Places/Restaurants) → 5499
  (Misc. Food Stores/Convenience) → 5814 (Fast Food) each time Visa challenged
  the prior code. [verbal] Sunniva Wong relaying Visa HK, same
- Named example: a restaurant group ("Ruby Tuesday") cycling among 5814/5499/
  5462/8398 over time. [verbal] Sunniva Wong relaying Visa HK, same — one
  company name, unverified independently
- Today Visa's detection is manual review/investigation; card networks watch
  select high-risk MCCs but the process doesn't scale. [verbal] same

This is a **classification-drift / misuse** pattern — code shopping over time —
not a single-point mismatch. It's a different shape of problem from the
PayPal ask below.

## Why this is a new problem for us, not an extension of existing work

Every MCC capability G2RS has today is scoped to **eCommerce, URL-based
evidence**:

- MerchantView's mismatch rule compares a reported MCC against a MCC
  *predicted from crawling a scanned URL*. [[mcc-mismatch-for-global-onboarding]]
- Core's reported-vs-predicted design ([[mcc-risk-scoring]]) and the MCC
  grouping taxonomy ([[mcc-grouping-taxonomy]]) both assume a **predicted MCC
  signal exists** — today that signal comes from crawling/classifying a
  merchant's website.

A brick-and-mortar merchant has no crawlable storefront producing that signal.
Visa HK's ask requires a different evidence source entirely: something that
infers actual business activity for a physical location without a website to
scan.

## What would be needed (not yet answered — open, not a plan)

- **A B&M classification signal.** Candidates raised only as categories, not
  verified as available: card network transaction/settlement data, merchant
  location + business-listing data (e.g. maps/POI providers), site visits or
  photos, licensing/permit records. [hunch] none of these confirmed as a G2RS
  data source today.
- **A "drift" detection model**, not a single mismatch check — the Visa
  examples are a merchant changing code over time, so the capability would
  need history, not just a point-in-time reported-vs-predicted compare.
- Whether card networks (as the requester) or acquirers/PayFacs (as the
  onboarding party) would be the buyer/user of this — undetermined from the
  email.

## Status

No roadmap, initiative, or technical assessment exists yet for MCC verification
beyond eCommerce. [documented] this is literally one of Sunniva's questions,
unanswered as of ingestion. This page is the record of the ask; it is not a
discovery or PRD.

## Links

- [[mcc-mismatch-for-global-onboarding]] — the active, funded MCC mismatch work
  (PayPal/Global Onboarding), eCommerce/URL-scoped. This B&M ask is adjacent
  but out of scope for that phase-1 work.
- [[mcc-risk-scoring]] — Core's reported-vs-predicted design; the "predicted"
  half has no B&M equivalent today.
- [[mcc-grouping-taxonomy]] — the group/tier reference data; B&M misuse
  examples in this source (5812/5499/5814/5462/8398) are candidate test cases
  against the existing taxonomy once a predicted signal exists.
- [[crawler-capability-gaps]] — crawling is the current predicted-MCC signal
  source; underscores why B&M has no equivalent today.
