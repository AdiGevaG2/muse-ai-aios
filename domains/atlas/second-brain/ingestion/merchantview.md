# MerchantView

EverC's founding product — merchant-level risk detection from a URL — now also
the name on G2RS-branded collateral. Continuous lifecycle risk rather than a
point-in-time onboarding check.

> **Name collision, resolved.** Day 1 of the EverC KT settles the open question
> this page previously carried. **MerchantView is EverC's original product**
> ("on the left side is where EverC started, with a product named MerchantView,
> as you probably all know") — it predates the G2RS collateral that also bears
> the name. Source: `source/2025-10-20-everc-g2rs-kt-day1.md`.
>
> Beware a *second* collision inside EverC: **MerchantView and MarketView are
> both "MV."** Asked how to tell them apart, the answer was that MarketView is
> **MKV** — a convention arrived at because "we also have Mervy and Marvie."
> Treat a bare "MV" in any EverC document as ambiguous.

## What it is

[documented] MerchantView is positioned as an *ongoing monitoring* solution that
evaluates merchant risk across the whole lifecycle, not just at onboarding.
Source: `source/2026-08-30-g2rs-solution-sheet-merchantview.md`.

[documented] Its stated inputs are three: proprietary data, AI-driven insights,
and **network intelligence** — the last of which is the same connected-entity
idea that underpins [[scam-network-intelligence]] and [[network-intelligence]].

## The problem it claims to solve

[documented] Merchant risk cannot be fully understood at onboarding alone. Two
named drivers of drift after onboarding:
- **Hidden connections** between merchants that are not visible on the merchant
  record itself.
- **Changing merchant behavior** over time.

Together these make consistent controls hard to maintain and make expansion into
new markets riskier.

## Claimed outcomes

[documented] As stated in the collateral — these are marketing claims, not
measured results, and none carry a number:
- Continuous visibility into evolving merchant risk
- Identification of hidden connections and emerging risk as behavior changes
- Safe expansion into new regions and verticals
- Less reactive enforcement, because risk surfaces earlier

## Latency claim

[documented] The sheet's tagline claims "AI-driven merchant risk intelligence,
delivered **in minutes**."

[hunch] This is plausibly the same capability the EverC KT session called
**instant onboarding** — a request-triggered, streaming path built so the
customer is not left waiting, as opposed to the classical batch pipeline. See
[[merchant-risk-classification-pipeline]]. Unverified: nobody has said in a
citable source that the MerchantView "minutes" claim and the instant-onboarding
pipeline are the same thing.

---

# From the EverC KT, Day 1

Everything below is [documented] from `source/2025-10-20-everc-g2rs-kt-day1.md`
(Shai, CPO; Assaf, CTO; Meni). This is the product as EverC actually runs it,
distinct from the collateral above.

## Origin and shape

Started as **monitoring only**, later extended to onboarding. Core loop: receive
a URL → visit the site → harvest data → run classifiers → check the entity graph
for connections to known-bad entities → respond, configurably.

## Monitoring cadence — narrower than expected

**Cadence is essentially monthly.** Directly asked what cadences are supported:

- **Monthly** — the default and the overwhelming norm
- **Quarterly** — supported reluctantly for parts of some portfolios. EverC
  pushed back using MasterCard bulletins and was "not being overly successful in
  convincing them"
- **Daily** — exactly one customer, a different setup, "hasn't picked up"
- **Weekly** — **not supported**
- No other configuration, "based on the demand that we've received"

This constrains any roadmap assuming flexible monitoring frequency.

## Delivery timing — onboarding vs. monitoring

Two distinct cases:

| Case | Timing |
|---|---|
| First-ever screening (onboarding), standard | 1 hour to 1 day, queue-dependent |
| Onboarding, premium tier | ~10 minutes |
| Onboarding, instant | "several seconds" |
| Second screening onwards (monitoring) | **Batch, on a specific day** |

"We don't do publish as you go." This corroborates the [hunch] above: the
"in minutes" claim maps to the premium/instant onboarding path, **not** to
steady-state monitoring. See [[merchant-risk-classification-pipeline]].

**A useful product finding, stated candidly:** asked whether they'd prefer
results continuously or three times a month instead of once, EverC's largest
customers were "not very excited about making any changes," giving "inconsistent
results, or counterintuitive results." Both companies independently reported the
same thing — G2RS: "we have some clients that are interested in that sort of
streaming reporting, but a lot aren't interested in moving to that framework."
Conclusion reached in-session: support both. Anyone proposing a move to
streaming delivery should read this before assuming demand exists.

## Two configuration layers

After classification, output is *EverC's* view of risk. Customers then reshape it:

1. **Risk matrix** — per category (100+ categories and signals), the customer
   sets severity. EverC ships defaults. Critically, severity can differ for a
   **reported** merchant (a direct relationship) versus one detected via the
   **ecosystem** (graph-discovered, one step removed).
2. **Rule customizer** — cross-references categories to express conditional
   rules: "if negative option billing AND cosmetics, then cosmetics is high
   risk." Works positively or negatively. EverC publishes templates.

**This is where a real G2RS/EverC definitional gap surfaced.** On tobacco and
alcohol, G2RS treats a finding as benign if **checkout is not enabled**; EverC
splits the two, reporting a payment page and an alcohol finding separately.
Shai's argument for EverC's position: the merchant asked the customer for a
processing key, so transactions "are bound to happen at one point, even if we
can't find them on the site." Proposed resolution is the rule customizer rather
than one side conceding. An effort to align category definitions had "just
recently started."

## Reported vs. unreported — the ecosystem finding

The clearest demoed mechanism. A customer-supplied ("reported", **R**) merchant
URL can be clean, while identifiers extracted from it — email, phone, physical
address, **Google Analytics tag** — match other URLs in the graph that are not
clean ("unreported", **U**). The severity shown can therefore come from a site
the customer never submitted. Demoed: a benign merchant connected via a shared
Google Analytics tag to an ENDS (vaping) product site.

Identifier extraction is standard on every crawl, not a special mode. This is
[[network-intelligence]] in practice, and the "hidden connections" claim in the
collateral above.

## Graph data boundary — worth knowing

Asked whether one acquirer's data informs another's results: "**only through the
graph**." And explicitly: "we are not preserving in the graph any data that we
received from our clients. It's only data that we were able to extract" — a data
controllership boundary. Customer submissions trigger crawls whose *extracted*
findings enter the graph; the customer's own data does not.

The graph is also fed proactively, beyond customer requests, and by the Risk
Insight Services team from outside the platform.

## Other platform behavior

- **Evidence** = an automatic screenshot of the page where the violation was
  found
- **Snooze** — defer a finding for a set period rather than ignore it
- **Disputes** — a structured challenge form with SLA-backed responses
- **Sub-accounts** — umbrella structures for acquirers serving processors/payfacs,
  each configurable independently
- **Onboarding fields** — only **two mandatory**. EverC uses a customer-generated
  unique ID and does **not** require MID; G2RS does. Flagged in-session as
  needing alignment

## Architecture

Portfolio manager → MySQL (central orchestration store) → scan manager (creates
a scan placeholder) → gateway manager (splits merchant into individual URLs,
holds intermediate state in **Redis**) → data collection → recombine → results
manager (applies rule customizer + risk matrix, aggregates) → MySQL → ETL to
Elasticsearch for UI.

Acknowledged weakness: a **centralized MySQL** that many services share, so
services deploy together despite being independently deployable Docker/JARs.
"It's not pure microservices."

**Multi-tenancy:** 5–6 separated sites, driven by data-localization requirements.
Dedicated stack and database per such customer, encrypted with **customer-managed
keys** (BYOK). Managed by infrastructure-as-code; everything runs on Kubernetes
or serverless, so provisioning many stacks costs little more than one. Retention
configurable, with long-term archive or deletion.

## Open questions

- What is the actual measured time-to-result behind "in minutes"? Tiers are now
  known; **no measured distribution or percentile exists**. `UNKNOWN`
- Category-definition alignment between EverC and G2RS — effort started, no
  scope or owner recorded. `UNKNOWN`
- MID as a required field: whose convention wins? `UNKNOWN`
- Recall. Precision is discussed across EverC products; recall almost never is.

## Related

- [[atlas-architecture]] — where MerchantView is heading (MLRC)
- [[marketview]] · [[smartscan]] — the product-level siblings
- [[network-intelligence]] — the reported/unreported mechanism
- [[merchant-risk-classification-pipeline]] — the runtime underneath
- [[scam-network-intelligence]] — sibling solution sheet, same network premise
- [[zinesec-group]] — the other half of the merged estate
