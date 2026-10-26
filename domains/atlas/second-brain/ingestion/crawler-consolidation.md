# Crawler consolidation

At least five crawler stacks now sit inside one company. Day 1 of the EverC KT
was largely an argument about which survive, with a TCO baseline and an
independent architectural assessment.

Source: `source/2025-10-20-everc-g2rs-kt-day1.md`.

## The estate

[documented] Jeremy, framing the day: "we have had several crawlers within the
G2 environment, and it's the same story within the WebShield environment as
well... at least two crawlers within WebShield. There's at least two crawlers
within G2."

Add EverC's WebID and the count grows again. [documented] Jeremy's stated goal:
"consolidation of crawler stacks... reducing our dependency on the legacy."

| Stack | Owner | Language/base | Renders JS | Volume |
|---|---|---|---|---|
| [[csx]] | G2RS | Java, Apache Storm | No (except Web Unlocker) | 5.3M merchants/mo |
| [[crolex]] | WebShield/ZineSec | Elixir, ex-Crawly | Yes, by default | ~200K seeds/mo |
| WebID | EverC | not covered Day 1 | unknown | unknown |
| (legacy G2 crawler) | G2RS | unnamed | unknown | unknown |
| (2nd WebShield crawler) | WebShield | unnamed | unknown | unknown |

## Pages per site — the metric that got corrected

[documented] Jeremy's initial comparison, then corrected live by Daniel:

- **EverC**: ~10 pages per website
- **G2RS**: ~50 pages per website (an **average**)
- **WebShield**: 500 for Investigate (a **maximum**, not an average)

[documented] Jeremy's own correction: "I was kind of mixing things,
unfortunately. The 50 is, on average, where the 500 is... not the average for
WebShield, it's their max. It's a little misleading."

**Worth preserving as a caution.** These three numbers are not comparable and
were briefly presented as if they were. Any depth comparison needs
like-for-like definitions first.

[documented] Underlying distribution (Daniel): most websites have 14–20 pages;
a small tail runs to thousands or tens of thousands, where crawlers hit their
configured limit.

## TCO baseline (Zombor / H-Tech)

[documented] Method: AWS Cost Explorer plus Kubernetes analysis over recent
months, amortized. Covers **all environments**, not just production. Scope is
pure crawling + classification — it **excludes** the components that ingest into
single platform, Go, and other products. Some components are assumption-based
because per-component metrics don't exist.

[documented] Volume denominator: 5.3M merchants crawled monthly, 4.6M through
the term collection engine.

[documented] Dominant cost contributors:
- **Crawling** → the storm crawler (Apache Storm). Expensive in lower
  environments because Zookeeper, Nimbus and coordination must run continuously;
  large nodes provisioned.
- **Data collection** → **Elasticsearch**, "the most expensive part." Zombor's
  argument: Elastic is only justified by the Lucene term queries. Without
  term-based querying you could use cheap object storage instead.
- Plus Redis cache, and third-party calls (Bright Data).
- Plus 2–3 engineers maintaining and upgrading the system.

[documented] **Over-provisioning**: the cluster was "quite massively
over-provisioned"; recent optimizations cut lower-environment cost. Estimate for
the crawler specifically — 15 nodes provisioned, "7 to 8 would do the job" on a
monthly average. Roughly **half**. Elasticity existed in the architecture but had
not been implemented until recently.

[documented] Zombor's purpose in doing this: to answer "how much reduction is
possible through integrating EC data classification pipeline into G2" you first
need G2's current per-merchant cost. He asked for the same figures from EverC's
side so the two can be compared — *what does it actually cost to classify one
merchant, end to end.* **That comparison does not yet exist.**

> Note: specific dollar figures were shown on slides during the session and are
> not recoverable from the captions. The cost *structure* above is reliable; the
> amounts are not in this source.

## Can Crolex's features be lifted into CSX?

[documented] This was the concrete integration question — CSX lacks change
detection, MCC detection, and JavaScript rendering; Crolex has all three.

Zombor's assessment, per component:

- **MCC detector** — a separate content-processing pipeline. *In theory*
  extractable into a standalone service and integrated into CSX the way the term
  collection engine is. **But**: "the diverse investing in that work is bigger
  than... taking the core codebase and prompts and everything and creating a
  Java version of that in CSX ecosystem using AI-assisted coding." Recommendation
  is effectively **rewrite, not port**.
- **Fetcher** — "literally impossible to decouple in the current form." Core to
  Crolex's runtime.
- **Change detection** — the hard part isn't the diff, it's that CSX has no
  **persistent storage** for crawled content (Elasticsearch is temporary). Needs
  cheap persistent storage (S3-like) first; the diff layer can then be built
  *inspired by* Crolex rather than moved from it.

[documented] Root cause across all three: "despite being modular, the components
run in a shared runtime at the moment," so direct reuse is difficult.

[documented] Second concern, non-technical: Elixir is "great for this concurrency
stuff" but raises a talent/hiring question "in a bigger enterprise."

## Where it stands

[documented] Nothing decided. Daniel: "there's some bigger decisions that need
to be made in terms of where we actually invest into crawling technology."
Zombor: "it's still not decided what to do with that." Jeremy: plans and ideas
for WebShield/G2RS integration were **paused** pending the EverC transaction —
"we really paused on a lot of those activities while we waited to see how this
would play out."

[documented] Platforms are **not merged**. Jeremy was explicit that the KT's goal
included educating EverC on WebShield and ZineSec as separate platforms.

## Open questions

- Per-merchant end-to-end classification cost for EverC, for comparison. `UNKNOWN`
- The actual TCO dollar figures (on slides, not in captions). `UNKNOWN`
- WebID's architecture and volume — not covered Day 1. `UNKNOWN`
- Identity of the two unnamed legacy crawlers. `UNKNOWN`
- Proxy vendor consolidation: G2RS on Bright Data, WebShield on another,
  EverC on Bright Data + Nimble. Flagged, not scoped.

## Related

- [[csx]] · [[crolex]] — the two stacks assessed in detail
- [[crawler-capability-gaps]] — the feature deltas driving this
- [[zinesec-group]] — why WebShield is in scope at all
- [[merchant-risk-classification-pipeline]] — EverC's side of the comparison
