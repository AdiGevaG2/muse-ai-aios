# OSINT toolkit

The open-source tools taught across Academy cohorts for merchant investigation.
Kept as a reference list; the method that uses them is in
[[website-data-analysis]].

[documented — Berlin *Advanced OSINT*; Warsaw *G2RS Academy tools list*]

## Basics

VPN; keyboard shortcuts.

## Corporate data and background research

- Data aggregators: endole.co.uk (UK), northdata.com (DE), youcontrol.com.ua (UA)
- Google search operators — `""` for exact expressions (company names, contact
  data, addresses); `site:` to pull specific information from a domain. Taught
  use cases: `site:itez.com terms` for website compliance, `site:linkedin.com
  <name>` for UBO research, `site:fintelegram.com <company>` for adverse media,
  `site:trustpilot.com <entity>` for review boards
- Meta-search engines (e.g. DuckDuckGo) to supplement Google
- Source code analysis via right-click → View page source, for compromised sites
  and keyword detection

## Historical data and additional site discovery

- archive.org / web.archive.org — old or removed content, historical merchant
  data
- copyscape.com — plagiarism detection to find additional websites running the
  same content

## IP, DNS and infrastructure

- viewdns.info, search.dnslytics.com — WHOIS and reverse IP lookups
- builtwith.com — web stack analysis, finding additional sites

## Traffic and backlinks

- similarweb.com, semrush.com — third-party traffic estimates: volume, audience
  geography, traffic sources, referral and outgoing traffic
- seobility.net, ahrefs.com — backlink checkers

## Ghost shopping

Throwaway email and phone providers for test transactions — temp-mail.org, SMS
services.

## Advanced techniques

- **DevTools / Inspect** — payment page and element analysis; API endpoint and
  callback analysis via the Network tab
- **Favicon hash lookups** — identify a favicon via search, or create its hash
  via a service (kriztalz.sh, favihash.com), then look the hash up with special
  commands in specialized search engines (fofa.so, shodan.io, censys.com) to find
  every other site sharing it
- **Shared tech lookup** — builtwith.com; network pattern recognition via
  SimilarWeb
- **Reverse image search** — tineye.com, Google Lens

Favicon hashing and reverse IP are the two that most reliably surface a
merchant's hidden estate — load-balanced mirrors and sibling front sites that
share infrastructure but nothing visible. [inference]

## Related

[[website-data-analysis]] · [[transaction-laundering]] · [[seo-poisoning]] ·
[[merchant-risk-by-mcc]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
