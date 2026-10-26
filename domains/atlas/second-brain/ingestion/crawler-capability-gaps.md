# Crawler capability gaps

What the crawling estate cannot do today, gathered in one place. Several gaps
are pulled forward by a 2025 MasterCard rule change, and no single stack closes
all of them.

Source: `source/2025-10-20-everc-g2rs-kt-day1.md`.

## The forcing function

[documented] Daniel, unprompted: "this year, MasterCard introduced some rules,
basically, where they're actually telling merchants to make sure that their
providers are screening every page of every merchant, **including beyond login
screens** and whatever."

[documented] His read on enforceability: "I don't know, I think it's not
enforceable, but we've been getting a few customers asking about this."

[documented] EverC side confirmed the same pressure — logins, pop-ups, age gates
— and raised social accounts as a further emerging request.

> Scheme-rule detail is compliance territory and stays human-owned in
> `context/compliance.md`. Recorded here only as the demand signal behind the
> gaps below. Someone should verify the actual bulletin — this is one engineer's
> paraphrase, hedged by the speaker himself.

## The gap table

| Capability | [[csx]] | [[crolex]] | Notes |
|---|---|---|---|
| JS rendering | Only via Web Unlocker, pre-configured per client | Default (ChromeDriver) | CSX's biggest hole |
| Auto-detect render failure → escalate | **Roadmap, not built** | Trigger-based in predecessor | The "smart proxy" |
| Pop-ups / age verification | Only where Web Unlocker pre-configured | Handled in browser session | Not reactive on CSX |
| Login-gated content | No | POC (session reuse) | MasterCard-relevant |
| Change detection | No — third-party vendor, per-page pricing | POC, not live | Both incomplete |
| MCC detection | No | Live, but not accurate enough for full rollout | See below |
| Persistent content storage | No — Elasticsearch is temporary | Azure Blob | Blocks change detection on CSX |
| Social media monitoring | **No** | No | Neither. Customer demand exists |
| Marketplace/agentic crawling | No | POC (browser-use models) | Overlaps [[smartscan]] |

## The three that matter most

**1. JavaScript rendering.** [documented] CSX doesn't render by default. Web
Unlocker is configured per client or per probe — a human decides in advance. The
"smart proxy" that detects insufficient content and reroutes through Web Unlocker
is explicitly *on the roadmap, not in place*. Juan: "That's part of our roadmap.
We have a smarter proxy decision maker in the roadmap... But it's not in place
yet."

[documented] Crolex's predecessor system used exactly this trigger pattern — try
cheap, escalate to rendering on thin content. Daniel: "our idea [after] G2
acquisition was to start rendering all the pages for everyone."

[inference] So the target state is agreed across both teams; only CSX's
implementation is missing. This looks like the least contentious consolidation
win available.

**2. Change detection.** [documented] G2RS pays a third-party per page, which
directly constrains the product: only individual pages are monitored, not whole
domains, because domain-level monitoring is "cost prohibitive." Crolex's
replacement POC isn't live. Blocking dependency on CSX is persistent storage.

**3. MCC detection.** [documented] Crolex has it in production for WebShield
customers. Evaluated against wider G2 needs: analyst-assist grade, not
automation grade — "not yet really at the accuracy that we would need for a full
rollout into production."

[documented] Daniel noted internal MCC initiatives already exist at G2, and that
EverC should now be in that conversation. EverC's MerchantView surfaces MCC
classification in its findings UI, and MLRC has an MCC detection filter — so
**three** MCC efforts now exist across the merged company.

[documented] The Core group's [[mcc-risk-scoring]] design (July–Aug 2026) sits
**downstream** of this gap, not inside it: it interprets a prediction it does
not produce. Detection accuracy remains the unresolved half. A mismatch verdict
is only as trustworthy as the predicted MCC feeding it, which makes the
"analyst-assist grade, not automation grade" finding above a direct constraint
on how far [[mcc-mismatch-for-global-onboarding]] can be automated.

## Duplicated effort — the pattern

[inference] The same capability is being built more than once in parallel:

- **Agentic/marketplace crawling** — Crolex browser-use POC ‖ EverC [[smartscan]]
- **MCC detection** — Crolex (live, imperfect) ‖ G2 internal ‖ EverC
- **Change detection** — third-party vendor ‖ Crolex POC
- **Proxy procurement** — Bright Data (G2RS) ‖ other (WebShield) ‖ Bright Data +
  Nimble (EverC)

Each was surfaced by a different speaker, in a different session block, without
anyone connecting them. That connection is the value of holding them on one page.

## Open questions

- The actual MasterCard bulletin — verify against the source document, not a
  paraphrase. Compliance owns this.
- Is "screen every page" commercially viable at 220M pages/month? Nobody
  costed it in-session.
- Social monitoring: real roadmap item or one customer asking? Two mentions,
  no owner.
- Does EverC's WebID close any of these? Not covered Day 1.

## Related

- [[csx]] · [[crolex]] — the two stacks
- [[crawler-consolidation]] — the decision these gaps feed
- [[smartscan]] — EverC's agentic answer to the marketplace problem
- [[go-policy-analysis-vars-fiserv]] — names the same category of gap from a
  Fiserv product review (proxy need, policy-page capture, speed/coverage
  tradeoff); unconfirmed whether it's the same crawler estate
