# Scam Network Intelligence

G2RS product that identifies coordinated scam *networks* — linked domains,
infrastructure and actors — rather than treating each scam site as an isolated
incident, so platforms can disrupt the network instead of playing takedown
whack-a-mole.

## What it is

[documented] Scam Network Intelligence identifies and analyzes coordinated scam
activity to surface risk earlier and enable "decisive disruption." Source:
`source/2026-08-30-g2rs-solution-sheet-scam-network-intelligence.md`.

[documented] Stated method: AI-driven technology **plus expert-led
intelligence** — an explicit human-in-the-loop claim — connecting related
activity across **infrastructure and payment flows**.

Note the two-sided linkage: it joins evidence from the open web
(domains, hosting infrastructure) to evidence from the payments side. That is a
broader join than [[merchantview]] describes for itself.

## The problem it claims to solve

[documented] Scams operate as coordinated networks across multiple domains,
infrastructure, and actors. Responding to individual incidents instead of the
connected activity produces two consequences the sheet names explicitly:
- Losses repeat.
- Regulatory scrutiny increases.

The second is the tell that the buyer is a platform or acquirer carrying
regulatory exposure, not just a fraud-loss budget.

## Claimed outcomes

[documented] Marketing claims, unquantified:
- Identify coordinated scam networks early, not just individual scam sites
- Attribute related activity across domains, infrastructure, and actors
- Disrupt networks before losses and regulatory exposure escalate
- Reduce reactive investigations and repeated takedowns

## Where this touches the engineering reality

[industry] "Attribute related activity across domains, infrastructure, and
actors" is a graph problem: entities are domains/sites, edges are shared
identifiers.

[documented] The EverC KT session describes exactly this mechanism in the
current system — going "back again to the graph, looking for any connected or
other domains that have the same e-mail or phone number," restarting the process
for each connected domain and aggregating the results. Source:
`source/2025-10-20-everc-g2rs-kt-day1-fragment.md`.

[documented] The same source says that traversal is currently implemented as a
recursive, self-restarting loop the engineering team describes as "cumbersome"
and "nasty," and that a single graph-traversal endpoint now exists to replace it.
See [[network-intelligence]] and [[merchant-risk-classification-pipeline]].

**Tension worth holding:** the sheet sells network attribution as a finished,
confident capability. The KT fragment describes the mechanism behind it as
actively being rebuilt. Both can be true — the capability works, the
implementation is being replaced — but do not cite the collateral as evidence
that the network traversal is mature.

## Open questions

- Does Scam Network Intelligence share the same graph and identifier-matching
  infrastructure as [[merchantview]], or are they separate pipelines with
  separate graphs? `UNKNOWN` — nothing in either sheet says.
- What does "expert-led intelligence" mean operationally — an analyst review
  step in the product, or a services engagement wrapped around it? `UNKNOWN`.
- What identifiers beyond email and phone drive attribution? The KT fragment
  says "e-mail or phone number, etcetera"; the "etcetera" is unenumerated.

## Related

- [[merchantview]] — sibling solution sheet
- [[network-intelligence]] — the shared concept
- [[merchant-risk-classification-pipeline]] — how the traversal actually runs
