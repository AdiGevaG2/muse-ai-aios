# Merchant risk classification pipeline

How merchant/site risk actually gets computed at EverC: a legacy Java batch path
being replaced by a PySpark streaming path built for instant onboarding.

> **Provenance warning.** Nearly everything on this page comes from a single
> low-fidelity, session-unattributed speech-to-text fragment. Read the caveat at
> the top of `source/2025-10-20-everc-g2rs-kt-day1-fragment.md` before citing any
> of it. This page exists to connect the engineering picture to the product
> claims in [[merchantview]] and [[scam-network-intelligence]] — it is not a
> system spec.

## Two pipelines

[documented] The KT session explicitly distinguishes "the current pipeline" from
"the new pipeline with instant onboarding."

**Current / legacy:** Java-based. [documented] Its scale ceiling is unproven —
"the Java based process that we have today yet to be proven" at larger scale.

**New:** Spark Streaming jobs written in PySpark, consuming from Kafka, deployed
on **EMR on AWS** — explicitly *not* Databricks, when asked directly. Continuous
consumption, described as efficient at high volume.

[documented] It was "built for the instant onboarding" case: a request arrives
and the customer is not left waiting for a batch cycle. This is the likely
mechanism behind [[merchantview]]'s "delivered in minutes" claim, though nothing
states that link outright.

## The graph traversal problem

[documented] Risk evaluation for a site fans out through the entity graph:
find connected domains sharing an email, phone number, or other identifier;
restart the whole evaluation for each; aggregate all results into the answer for
the original site.

[documented] Team's verdict on this loop: "cumbersome," "nasty."

[documented] Partial fix already shipped: an endpoint that traverses the graph
and returns the result without the cyclic restart. Intent is to adopt it
everywhere and delete the loop.

See [[network-intelligence]] for what this mechanism is selling as.

## Current engineering focus

[documented] Stated as the team's main focus "during this quarter" (quarter
unidentified; fragment is from Oct 2025):

- **Monitoring and auto-scaling of the PySpark streaming services.** Explicitly
  not classical Spark batch — streaming autoscaling is the hard part. Goal is to
  avoid over-provisioning without increasing cloud spend.
- [documented] Solving that is framed as the gate to running at "large scale."
  Claimed upside: if it works as planned, it should also be *cheaper* — but
  "we need to get to this milestone. Maybe we are not there yet."

## Known metrics

[documented] **Phone number extraction**: precision above 90%; recall
"pretty high, around 90 as well" — speaker did not recall the exact figure.

Caveats before this number is ever reused: no population, no time range, no
per-region or per-country breakdown, and the questioner specifically raised
varying formats across regions as a concern. The answer to *how* matching works
(distance-based comparison, country codes) was deferred offline and never given.
Treat as directional only. Do not put it in a PRD as a measured baseline.

## Vendors mentioned

[documented] Proxy/data-collection vendors **Bright Data** and **Nimble** appear
in the retry path — some per-round decision about whether to stop or continue is
configured, and the configuration is "similar between the two." The fragment is
badly garbled here; low confidence on details beyond the vendor names.

## Open questions

- Which quarter is "this quarter," and has streaming autoscaling landed since?
- Has the graph endpoint replaced the cyclic process everywhere yet?
- What triggers legacy vs. new pipeline for a given request today?
- Exact recall figure for phone extraction, and its regional breakdown.

## Related

- [[network-intelligence]] — the concept this pipeline implements
- [[merchantview]] — "in minutes" likely maps to instant onboarding here
- [[scam-network-intelligence]] — depends on the same graph traversal
