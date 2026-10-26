# Org Ingestion Log

Newest first. One line per `/ingest` run routed to the org brain: what came in,
pages created/updated, links drawn.

**Do not load this file during feature work.** It is ingest history, not
knowledge, and it grows without bound. Only `/review` and `/retro` read it. For
what the brain knows, use `index.md` and the entity pages.

## 2026-08-30 — G2RS corporate overview decks (×2)

**In:** `G2RS overview simplified.pptx` (3 slides) and `G2RS overview.pptx`
(~30 slides), both from SharePoint `G2RiskSolutions/General/G2RS/`, via the
Microsoft 365 connector. ©2024 — predates the Oct 2025 EverC acquisition. Raw
text at [`source/2026-08-30-g2rs-overview-decks.md`](../source/2026-08-30-g2rs-overview-decks.md).

**Routed to org brain** — company-wide positioning and all four business lines.
Not specific to any one domain.

**Created (5 pages):** g2rs-solution-suite · g2rs-positioning-and-differentiators ·
g2rs-scale-and-performance-claims · g2rs-merchant-risk-products ·
atlas-consolidation-context

**Links drawn:** the five pages cross-link; each points back to
`context/company.md` (history, portfolio, Merchant Map moat, not-in-focus list),
`glossary/g2rs-terms.md`, `context/competitors.md`, `context/everc.md`. Threads
worth naming: the transaction-laundering worked example (no URL → analyst finds
domain → shared registrant data → ring) makes the Merchant Map network-effect
moat concrete and is the same primitive the connected-sites graph work needs;
"minds and machines" recurs as a *claimed differentiator*, so removing analyst
review is a positioning change, not just an efficiency one; all four bankruptcy
displacement case studies are precision/recall failures, which argues detection
quality — not feature parity — is the bar a UP migration must clear.

**Conflicts surfaced (not overwritten):**
1. *Digital Commerce Risk lineage* — `company.md` reads as though DCR is the
   ex-EverC line; the 2024 deck shows DCR existed as a G2RS line with its own
   Marketplace Monitoring **before** EverC. Consequence: marketplace monitoring
   is a two-system overlap on the same footing as merchant monitoring —
   previously unrecorded, needs a canonical-system decision.
2. *Country count* — deck lists 78 countries of presence vs `company.md`'s "50+
   countries" of partner FIs. Different measures; deck list has duplicates
   (Belgium/Belgique, Korea/South Korea), true count ~75.
3. *Instant Onboarding* — deck lists it as an accomplishment; `company.md`
   records it as deprioritized. Newer brief wins; deck is stale here.
4. *Merchant-risk product naming* — deck contradicts itself across two adjacent
   slides on tier (Reputation Monitoring, Change Detection: core or add-on?) and
   spelling (WebID/Web ID, CBD Monitoring/CBD Risk Management). Four products
   appear on one slide only, including trademarked Compass Score®.

**Not written:** nothing added to `context/` — the ©2024 figures are marketing
claims without methodology and would contaminate governed human-owned facts.

## 2026-08-30 — G2RS Academy modules (SharePoint)

**In:** the Academy modules library — four event folders (Berlin 4-26, Sofia &
Amsterdam 9-26, Warsaw 10-2025, Web Shield Academy 2024–25), ~60 files, ~790 MB.
Inventoried in full; content extracted from 17 files this pass — all four
Mastercard regulatory bulletins, all three Berlin client guides, and six Berlin
decks plus the Warsaw tool list. Raw originals stay in SharePoint; manifest at
`source/2026-08-30-g2rs-academy/MANIFEST.md` marks what was read.

**Routed to org brain** — card scheme rules, BRAM/MMP standards, TL typologies
and G2RS's own reporting positions bind every domain, not just atlas.

**Created (13 pages):** transaction-laundering · website-data-analysis ·
mastercard-bram-and-mmp · gambling-and-miscoding · peptide-merchants ·
merchant-risk-by-mcc · ai-merchants-as-tl-fronts · adult-and-ai-merchants ·
crypto-as-gambling-payment-rail · financial-risk-exposure · seo-poisoning ·
osint-toolkit · e-cigarettes · assessment-trends-2025

**Links drawn:** transaction-laundering is the hub — every page links back to it.
Threads worth naming: the AI merchant jump (0.8%→36% of incident reports) ties
TL typologies to the Feb 2026 Rule 5.12.7 revision on AI-generated imagery; the
"disclaimer substituting for a control" pattern connects peptide RUO shields to
AI platform opacity; MMP's members-only-area monitoring requirement lands
directly on the adult 5967 gated-content screening step; gambling concentration
shows up independently in both assessment trends (42%) and TL beneficiary data
(51%/97%).

**Not read:** the Sofia & Amsterdam decks (including *2026 Assessment Trends*,
which should supersede assessment-trends-2025), the Warsaw module set (CBD,
crypto, credit card fundamentals, pharma, nutraceuticals, VAMP metrics, test
cases), and the Web Shield Academy legacy folder. All inventoried in the
manifest and available for a follow-up pass.
