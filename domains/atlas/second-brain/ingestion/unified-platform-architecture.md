# Atlas — architecture and migration

EverC's convergence of merchant-level and product-level risk into one surface.
Built and deployed as of Oct 2025, taking **no production traffic**. This domain
is named after it.

Source: `source/2025-10-20-everc-g2rs-kt-day1.md` (Shmuel, Assaf, Meni, Shai).

## The thesis

[documented] Shai's argument: the merchant/product split is "somewhat
artificial." A merchant is a seller; a seller is a merchant; sellers operate
across multiple marketplaces *and* their own sites. Evidence cited for
convergence happening in both directions:

- [[smartscan]] — a MarketView extension whose first use case serves **acquirers**
  (a merchant-side buyer)
- Payment-side customers asking for **product-level** classification

[documented] Conclusion: "what you need is a strong platform that can support and
scale to both the merchant level and the product level."

## What "unified" means concretely

[documented] Already shared today:
- **One UI codebase** — two teams working in the same project, same design system
- **One authentication** system
- Same UX patterns across [[marketview]], [[smartscan]] and MLRC — demoed by
  switching between them live

[documented] Deliberately **not** shared: "what we're trying to avoid is pushing
everything into the same data structure, or databases... These are small services
that own their data and can provide and read data from other components."

[documented] So the per-product pipelines stay distinct — MarketView orchestrating
millions of items/day, MLRC monitoring merchants — while services expose REST or
async endpoints to each other as needed. Stated as by design, with a target of
one page showing findings from both architectures.

## MLRC — Merchant Level Risk Classification

[documented] The rebuild of [[merchantview]] onto the unified platform. Modular
where the existing system is not.

Flow: UI → BFF (or external API) → create merchant in a **dedicated merchant
database** → **analysis sender** (reshapes and forwards, *no intermediate state*)
→ data collection → **finding service** (aggregates) → enrichment pipeline →
status → **risk calculation** via risk matrix → notifications (email, webhook,
SQS).

[documented] Key design choices and their stated rationale:

- **No intermediate state** between analysis sender and findings — the explicit
  break from the old gateway-manager/Redis design. Enables **incremental scans**
  and findings from **multiple sources** (graph, content) arriving independently,
  rather than requiring everything at once. "Anyone basically can send us a
  finding."
- **DynamoDB** per-component, enabling a **dedicated table per customer** for
  multi-tenancy with customer-managed KMS keys — without "the heavy lifting of
  created RDSs." Contrast MerchantView's shared MySQL.
- **Zero-ETL** from the merchant database to **OpenSearch** for portfolio
  filtering.
- **CDC to Apache Iceberg** from every database by default, giving an audit and
  historical layer — "if you want to see what was the status and timetable."
- **Queue-only** inter-service communication; independent scaling and
  independent deployment. Two developers can ship risk and status changes
  separately.
- Reuses the **existing data collection protocol** deliberately, to avoid
  depending on another team to ship.

## Status — built, not live

[documented] The most important fact on this page, and easy to misread from the
demo. Assaf: "This is already implemented, but what you see now on the screen."
Then, unambiguously: "**So it's there, but it's not taking any traffic.**"

[documented] The UI shown was *not* the prototype demoed earlier — the prototype
represents end-of-quarter target state. The live demo was rougher, and hit an
**AWS us-east-1 outage** mid-demo ("we have challenges with AWS... I don't know
if you are on East one today").

[documented] Q4 targets: report component, risk matrix customization (currently
using EverC's default matrix), populating existing backend capability into the UI.

## Migration — no plan, and they say so

[documented] Asked directly whether they'd implement separately then migrate
data, or go incremental with a strangler pattern, the answer was neither. The
actual approach:

1. Decide the **minimum capability bar** at which product, R&D and go-to-market
   are confident enough to sell it — that line is not yet drawn
2. Recruit "a couple of our smaller customers" as **design partners** with
   incentives to try it and give feedback
3. Point **net-new customers** at the unified platform once that bar is met
4. Migrate existing customers last

[documented] On existing-customer migration: "that's somewhat painful, and so
we're not necessarily jumping on this one." The lever is incentive, not
mandate — an acquirer wanting [[smartscan]] gets it end-to-end in one view, and
"through that, ideally, we'll be able to incentivize them to move over."

[documented] Shai's summary: "**It's a journey. It's a journey.**"

[documented] The honest constraint behind the sequencing: "it's somewhat
difficult to go to market with a product that is subpar in terms of its
fully-fledged functionality to what's available out there, **even by us**" —
i.e. the new platform competes with EverC's own MerchantView.

## Why this matters here

[inference] For a PM working this domain, three things follow:

1. **Nothing on the unified platform has production usage data.** Any metric
   about it is necessarily from MerchantView or MarketView instead.
2. **The migration trigger is a product decision that has not been made** — the
   minimum-capability bar. That is an open decision with a named owner set
   (product + R&D + go-to-market), not a technical blocker.
3. **The G2RS/WebShield estate is not in this picture at all.** Day 1's unified
   platform discussion is entirely EverC-internal; [[crawler-consolidation]]
   is a separate, unresolved track.

## Open questions

- Where does the minimum-capability bar sit? `UNKNOWN` — open decision
- Which smaller customers are the design partners? `UNKNOWN`
- How do G2RS products (PMM, Go) relate to this platform? Not addressed. `UNKNOWN`
- Does the unified platform absorb WebShield, or run alongside it? `UNKNOWN`

## Related

- [[merchantview]] — the system MLRC replaces
- [[marketview]] · [[smartscan]] — already on the unified surface
- [[merchant-risk-classification-pipeline]] — the runtime beneath MLRC
- [[crawler-consolidation]] — the parallel, unresolved estate question
- [[zinesec-group]] — the third platform nobody has placed yet
