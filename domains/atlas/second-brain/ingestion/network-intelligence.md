# Network intelligence

The premise underneath both G2RS solution sheets: risk lives in the *connections
between* entities, not in any single entity's record. Two products, one idea.

## The claim

[documented] Both solution sheets rest on the same argument, stated almost
identically:

| Product | The "why" line |
|---|---|
| [[merchantview]] | "Because merchant risk is driven by evolving behavior and **connected activity**, not point-in-time signals." |
| [[scam-network-intelligence]] | "Because scams operate as **coordinated networks**, not isolated incidents." |

Sources: `source/2026-08-30-g2rs-solution-sheet-merchantview.md`,
`source/2026-08-30-g2rs-solution-sheet-scam-network-intelligence.md`.

[inference] These are not two independent positioning choices. They are one
technical capability — an entity graph joined on shared identifiers — sold into
two different buying motions: lifecycle monitoring on one side, scam disruption
on the other.

## The two axes of risk

The sheets together frame risk as escaping a point-in-time check along two
different axes. Worth keeping distinct, because they imply different mechanisms:

1. **Time** — the merchant's own behavior changes after onboarding.
   ([[merchantview]]'s primary axis. Needs re-evaluation over time.)
2. **Connection** — risk is visible on a *related* entity, not this one.
   ([[scam-network-intelligence]]'s primary axis. Needs graph traversal.)

MerchantView claims both; Scam Network Intelligence is almost entirely axis 2.

## How it actually works today

[documented] The EverC KT session describes the concrete mechanism: traverse the
graph for other domains sharing an identifier — email, phone number, "etcetera" —
restart the full evaluation for each connected domain, then aggregate everything
into one result for the original site. Source:
`source/2025-10-20-everc-g2rs-kt-day1-fragment.md`.

[documented] The engineering team's own assessment of that loop: "It is
cumbersome, it's nasty. We don't really love it or like it."

[documented] A replacement exists in part — an endpoint that traverses the graph
and returns the result directly, without the recursive restart. The stated goal
is "to introduce it everywhere," removing the cyclic process from the pipeline.
See [[merchant-risk-classification-pipeline]].

## Marketing vs. engineering — the gap to hold

[inference] The collateral (Feb 2026) presents network attribution as a
delivered, confident capability. The KT session (Oct 2025) presents the
traversal as a known-bad implementation mid-replacement. The dates are
consistent with the rebuild having progressed in between, but nothing confirms
that.

**Practical rule:** treat the sheets as evidence of *product intent and
positioning*. Treat the KT fragment as evidence of *implementation reality*.
Neither overrides the other, and neither is a spec. When a PRD needs to state
what network intelligence does, go get current implementation evidence rather
than citing either of these.

## Open questions

- One graph or two? Whether both products traverse the same entity graph is
  unstated in every source we hold. `UNKNOWN`.
- What is the full identifier set the graph joins on? Only email and phone are
  named. `UNKNOWN`.
- Has the graph-traversal endpoint replaced the cyclic process by now?
  `UNKNOWN` — the KT fragment is ~10 months older than the collateral.

## Related

- [[merchantview]] · [[scam-network-intelligence]] — the two products
- [[merchant-risk-classification-pipeline]] — the runtime that does the traversal
