# Crolex

WebShield/ZineSec's modern crawler: Elixir, browser-rendering by default,
Gemini-backed analysis processors. Feature-rich but unproven at G2RS scale, and
hard to decompose.

Source: `source/2025-10-20-everc-g2rs-kt-day1.md` (Daniel Grash, CTO ZineSec
Group; assessment by Zombor, H-Tech).

## What it is

[documented] A standalone service in WebShield's microservices estate (RabbitMQ,
AKS cluster, gateway layer for outbound traffic). Its job: visit websites,
collect everything from the browser session — HTML, screenshots, cookies,
extracted links — and run analysis processors over that data.

[documented] Built in **Elixir**, chosen for built-in concurrency and fault
tolerance. [documented] Originated from the **Crawly** open-source project.

[documented] Internal web UI only — clients never log in. Integration is via
REST API. Minimum input is a start URL; everything else defaults.

## Rendering — three modes

[documented] Unlike [[csx]], Crolex renders by default:

1. **Local ChromeDriver** — the default; renders the page
2. **Plain HTTP/curl request** — no rendering
3. **Virtual browsers** — SaaS (Steel.dev, Browserbase); returns a WebSocket URL
   to drive a remote browser instance

Proxy management plugs into all three. [documented] WebShield procures proxies
through a **different provider** than G2RS — Daniel flagged proxies themselves
as a consolidation target.

## Per-instance configuration

[documented] An "instance" is one crawl of one website. Configurable: page
limits, screenshots (full-page or partial), scroll-to-bottom via Chrome
DevTools for lazy-loaded content, geographic location, whether to interact with
the page.

[documented] Stays within one domain; subdomains allowed.

## Processors

[documented] Post-fetch analysis pipeline. **Most processors use structured
prompts against Google Gemini**, some against fine-tuned Gemini variants.

Named processors:
- **MCC detection** — a third-party Google service classifies content into an
  industry code; an LLM plus additional data maps that to an MCC
- **Website compliance** — identifies T&C, privacy policy, shipping, refund
  pages; extracts governing law, merchant legal entity, contact details; produces
  AI summaries of compliance-relevant pages
- **Terms & conditions identification**
- **Product extraction to JSON**
- **Watcher / change detection** — see below

[documented] Production status is uneven: MCC detection and website compliance
run for WebShield customers day-to-day; several others "never really been used
in production yet." Zombor's independent read: "as far as I know, only MCC
detection is used in production, but keyword scanning and the other ones are not."

## MCC accuracy — the honest assessment

[documented] Evaluated under the wider G2 context. Outcome, in Daniel's words:
"in its current state, it's valuable, potentially to be used by analysts to
speed up their process. But we're not yet really at the accuracy that we would
need for... a full rollout into production."

This is the clearest statement in Day 1 of an AI capability that is
analyst-assist grade, not automation grade. Relevant to any MCC automation
scope. See [[crawler-capability-gaps]].

## Change detection (Watcher)

[documented] Same fetch infrastructure, but links crawls together over time and
diffs them. Two diff modes: HTML/text diff, and **visual diff** via full-page
screenshot pixel comparison.

[documented] Status: **experimental POC, not live.** Initial results "promising."

[documented] The point of it: G2RS currently pays a **third-party vendor** for
change detection, charged per page — which is why only individual pages, not
whole domains, are monitored today. Replacing that vendor is the stated goal.

[documented] Daniel declined to give a change-rate statistic, and the reason is
methodologically important: most modern websites return different content on
every fetch (rotating IDs etc.), so a raw diff rate is meaningless. Filtering
out user-irrelevant changes — via AI or rules — is itself an unsolved layer.
Current dataset skews to adult-site T&C pages, some marketplace T&Cs, and CBD
product pages.

**Do not quote a change-detection rate from this session. There isn't one.**

## Storage

[documented] Azure Blob Storage for HTML, screenshots, links, cookies, and
compliance pipeline output. Postgres for tabular data — mostly IDs and linking,
no heavy content. JSON API and CSV export available.

## Agentic / marketplace work

[documented] Recent POCs with product, aimed at marketplace data collection
where page-by-page crawling fails:
- **Browser session reuse** — an agent logs into a marketplace, the session
  state is stored, then crawling proceeds logged-in
- **Browser-use models** — given a high-level task ("go to eBay, search for X,
  return the first 20 products as JSON"), succeed "9 times out of 10" when
  already logged in

[documented] Motivation: some marketplaces require an account, or require
explicitly enabling adult content, before risky listings are visible at all.

[inference] This is the same problem EverC's SmartScan solves with agentic
crawling — see [[smartscan]]. Two independent agentic-crawl efforts now sit
inside the merged company.

## Scale — the open risk

[documented] Zombor's assessment: architecturally promising, but **scalability
has not been validated in production at G2 scale**. Would likely need to move
from its "modular monolith" shape to a distributed system to handle ~4–5M
merchants/month.

## Volume today

[documented] ~200,000 seeds/month (Daniel's estimate). Jeremy believed total
WebShield websites closer to half a million. Page limits: **500 for Investigate,
somewhat less for Monitor** — these are *maximums*, not averages. Most websites
have 14–20 pages; a small tail is very large, and Crolex stops at the limit.

## Related

- [[csx]] — the G2RS incumbent
- [[crawler-consolidation]] — the decision
- [[crawler-capability-gaps]] — what each stack can't do
- [[smartscan]] — EverC's agentic crawling, same problem space
