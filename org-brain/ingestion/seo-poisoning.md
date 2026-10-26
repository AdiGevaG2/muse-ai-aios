# SEO poisoning and blackhat SEO

Search engine abuse — used both to promote illicit merchants and to hijack
legitimate sites into serving scams. Relevant to underwriting because it explains
several traffic anomalies in [[website-data-analysis]].

[documented — Berlin *SEO Poisoning*; also Web Shield Academy *Blackhat-SEO*
(2024, not read)]

## Blackhat practices

Whitehat plays by the search engine's rules — write naturally, keep up with
trends. Blackhat tries to trick it — cram or hide keywords, use suspicious
linking. Main families: spamdexing, hidden content, cloaking and doorways, URL
redirects and hijacking.

**Spamdexing** — keyword stuffing, meta tag stuffing, hidden or invisible text,
scraper sites, article spinning or translating, comment spam. Often paired with
deceptive marketing; frequently involves stealing content to promote paid ads
(an IP violation), leaves similar content on additional websites, and exploits
sites that allow user-generated content.

The classic artifact is the WordPress pharmacy hack — a compromised legitimate
site quietly serving a full Cialis/Viagra storefront.

**Cloaking and doorway pages** — showing crawlers a different page than users,
via IP delivery or user-agent/HTTP-referrer detection. A doorway page carries
text optimized for search engines and AI (e.g. election results); the user lands
on a scam page carrying video and images (crypto investment, ClickFix).

**Redirect abuse** — a 301 permanent redirect passes PageRank to the
destination; a 302 temporary redirect leaves it with the redirecting site.
Blackhat operators exploit this by 302-redirecting from their own site to a
reputable one so the search engine awards rank to the redirector.

**Open URL redirect vulnerabilities** — parameters on legitimate domains that
will forward anywhere, further obfuscated with shorteners or encoding, e.g.
`/redirect.php?url=http://bitly.com/98K8eH`. Common patterns include `/url?q=`,
`/url?sa=t&url=`, `/external-link.jspa?url=`, `proxy.php?link=`, `/redir.asp?url=`,
`/exit.aspx?url=`, `/bitrix/redirect.php?...&goto=`.

*Case study:* the UK Environment Agency's River Thames conditions site was used
to forward visitors to fake OnlyFans dating sites. It had to be taken offline and
DNS records removed. US government sites have been hit the same way.

**Synthetic backlinks** — generating backlink volume via directories and via
analyzer websites and AI models, to manufacture the appearance of authority.

## ClickFix

A social engineering pattern worth knowing by name. Checking a fake Cloudflare
CAPTCHA box triggers JavaScript that copies a malicious PowerShell script to the
victim's clipboard; the victim is then tricked into executing it themselves.
Scammers started with Cloudflare-styled CAPTCHAs and moved to other styles,
exploiting the fact that CAPTCHAs vary so much that users cannot tell a fake one.

One delivery variant uses full-screen hijack on adult entertainment sites — on
the theory that victims are more susceptible to fake system update prompts after
browsing higher-risk content.

## Why underwriters care

Extremely high search traffic share is an indicator of SERP hijacking; high
social or email share can indicate aggressive or deceptive marketing, even
phishing. Backlink structure review appears in the mitigation list for adult, AI,
and dating merchants alike. [documented] See [[website-data-analysis]],
[[adult-and-ai-merchants]].

## Related

[[website-data-analysis]] · [[osint-toolkit]] · [[transaction-laundering]] ·
[[adult-and-ai-merchants]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
