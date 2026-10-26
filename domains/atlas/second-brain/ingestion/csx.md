# CSX

G2RS's production web-crawling and content-classification platform. Message-driven,
Apache Storm based, ~5.3M merchants/month. The incumbent in any
[[crawler-consolidation]] decision.

Source: `source/2025-10-20-everc-g2rs-kt-day1.md` (Augusto, Juan).

## What it is

[documented] A crawler plus a data-classification engine, architected around
RabbitMQ messaging so any internal consumer can request a crawl and subscribe to
the result. Deployed on AWS/Kubernetes.

Consumers named: digital commerce, ingestion services (legacy), global
onboarding, AME, Go, and PMM via single platform. [documented] "Ingestion" is
what feeds single platform for the PMM workflow.

## Flow

[documented] Five RabbitMQ exchanges mark the pipeline stages:

1. **crawl request** — from Request API
2. **page crawl complete** — one page fetched
3. **page audit complete** — that page evaluated by TC
4. **seed complete** — all pages for one website done, summarized
5. **report complete** — all seeds in the report done

[documented] **Request API** is the single entry point. It accepts crawl
settings per URL: seed URLs, crawl date, `stopCrawl` date, priority, source ID,
audit type, merchant group, proxy configuration.

[documented] **Crawler** listens on the request exchange, downloads content,
extracts links, recurses. Content is written to Elasticsearch.

[documented] **TC (Term Collection)** is the classification step. It pulls
**Lucene queries** from the PMM API and runs them against the crawled content in
Elasticsearch to find violations. Queries support inclusion/exclusion terms.
Which queries run depends on the merchant group configured on the request.

[documented] **Shop Saver / shop service** watches for seed completion,
summarizes findings across all pages of a seed, and handles cleanup — deleting
Elasticsearch indices and archiving to S3.

[documented] Redis caches PMM queries and holds per-seed findings until the seed
completes.

## Not every page is classified

[documented] Only audit types `CC`, `automated CC`, and `ML Model CC` go through
term validation. Other audit types skip classification entirely. Within a CC
request, though, **every** crawled page is evaluated — "if we are, for example,
crawling 3Ks of pages for a specific merchant URL, and that request... has the
audit in CC, we are gonna be evaluating every single page."

## Volume (September 2025)

[documented]

| Metric | Figure |
|---|---|
| Merchants/seeds crawled monthly | 5.3M (4.4M PMM) |
| Going through classification (TC) | 4.6M |
| Pages crawled monthly | ~220M |
| Go product requests | ~781 seeds, ~79K pages |
| Avg pages per domain | ~100 |

[documented] These figures **exclude WebShield** entirely.

[documented] Go is one report per seed, sent one URL at a time; CSX is built to
accept ~15,000/day from Go. PMM seeds can carry 1 to hundreds of thousands of
URLs, which is why report-level completion signalling matters.

## JavaScript and proxies

[documented] **CSX does not render JavaScript by default.** Web Unlocker is used
for specific merchant groups to get JS content.

[documented] Four proxy types, managed by a proxy manager:
- **internal static** — a fixed IP offered to clients who whitelist G2RS so
  crawls aren't blocked. Some clients require their *merchants* to whitelist it.
- **Bright Data data center** — cheapest; the default retry proxy
- **Bright Data residential**
- **Bright Data Web Unlocker** — handles JS rendering, pop-ups, age verification

[documented] Two ways a proxy gets used: pre-configured per merchant group or
domain (including a country property), or as a retry after a configured list of
status codes/exceptions. Retry defaults to data center on cost grounds.

[documented] Pop-ups and age gates are handled **only** where Web Unlocker is
pre-configured — not detected and escalated automatically. A "smart proxy"
decision-maker that routes to Web Unlocker on detecting a rendering failure is
**on the roadmap, not built**. See [[crawler-capability-gaps]].

## stopCrawl semantics

[documented] Crawls are time-bounded, not completeness-bounded. The crawler
continuously asks for expired pages; at `stopCrawl` those pages are marked
stopped and the merchant URL is **considered completed** even with pages still
pending. Juan: "if we reach, I don't know, 8 hours, and we are still crawling...
we are just considering that that merchant URL is completed."

[documented] Mitigation: seeds are randomized and URLs distributed roughly
equally across seeds, so a short window yields partial coverage of all seeds
rather than full coverage of some — unless the time budget is very short
relative to seed count.

## Message payloads

[documented] Two patterns. Some messages carry the parsed content or raw HTML
inline. For the EC initiative (in development at the time), a cache is used
instead: the message carries a page key and the consumer fetches content from an
API. Interfaces are kept deliberately static; new audit types are added rather
than existing message shapes changed, and each consumer has its own queue keyed
by routing keys built from audit type + source ID.

## Cost

See [[crawler-consolidation]] for the TCO analysis. Headline: storm crawler and
Elasticsearch dominate; the cluster was significantly over-provisioned.

## Related

- [[crolex]] — the WebShield crawler evaluated against this
- [[crawler-consolidation]] — the decision this feeds
- [[crawler-capability-gaps]] — what CSX cannot do today
- [[merchant-risk-classification-pipeline]] — EverC's equivalent runtime
