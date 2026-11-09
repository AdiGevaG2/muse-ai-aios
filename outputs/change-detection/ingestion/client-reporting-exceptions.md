# Client reporting exceptions

Ten clients carry reporting rules on top of the default monitoring scope. The rules group into about seven types: page-type scope, numeric thresholds, catalog-size logic, watch terms, exclusions, site-health checks and control-presence checks. These are the rules the PRD defers to M3 monitoring profiles.

Source: "Clients with special reporting needs", from Margo via Sarah Craven, 2026-10-28 [documented] (`sources/slack-files/2026-10-28-clients-with-special-reporting-needs.docx`). Analysts keep the full set in a "Claude Reporting Criteria" document used to QA reports; that document was not shared in the channel.

## Rules by client

| Client | Rule | Type |
|---|---|---|
| NAB Specialty Markets | Report all changes on terms and ingredients pages; product price changes over $100 up or down; any billing descriptor change | Page-type scope, numeric threshold |
| Glacier | Report price changes only on sites with about 30 products or fewer; otherwise default | Catalog-size logic |
| TabaPay list 1 | Entity, business name or rebranding; APRs advertised; lending or money-transmission licenses; bank partnerships; mentions of Russia, Ukraine or Iran; TabaPay's name; surcharges; new products; promotions | Watch terms |
| TabaPay list 2 | Changes to stated bank partnerships on site or in T&Cs; promotions | Watch terms |
| TabaPay list 3 | Default reporting | None |
| TabaPay, all lists, March 2026 notes | Rebranding; surcharges, capped at 3% Visa and 4% Mastercard; TabaPay's name; new product or partnership announcements; card-network relationships advertised. Lenders: APRs above 36%, convenience fees above $2, lending license changes. Money transmitters and program managers: license changes, neobank bank-partnership changes, red-flag countries list | Watch terms, numeric thresholds |
| Banka Credins | Default monthly plus a monthly per-domain check that the SSL certificate is valid, requested 2025-11-12 | Site-health check |
| Paynovus | Default monthly plus a monthly per-domain check for removed age verification, requested 2025-12-02 under the UK Online Safety Act | Control-presence check |
| Cliq | Exclude font, style and cosmetic changes. Keep redirects to another domain, server errors and inaccessible sites, parked domains, product adds, removals and price changes. Small catalogs: all product and price changes. Large catalogs: trends and samples, plus everything in a "NEW" section. Also product-type shifts, blog posts, customer reviews, home page claims, header and footer, contact, terms, privacy and policy pages | Exclusions, catalog-size logic, site-health |
| Fibonatix | Report customer reviews; do not report copyright year, price changes, review counts or star-rating changes | Exclusions |
| Complete Merchant Solutions | Do not report customer reviews or review counts | Exclusions |
| ING Romania | Report price changes only for site-wide events such as "Going out of Business" | Numeric threshold, exclusions |

The type column is our grouping, not the source's [inference].

## Configuration intent

From the 2026-10-28 thread [verbal] (`sources/2026-11-05-slack-change-detection-channel.md`):

- Sarah Craven: configurable monitoring profiles are not MVP. The MVP needs only the degree of configuration Visualping supports, which she believes is small.
- Sarah Craven: configuration should eventually live in the Atlas risk matrix, and the options should serve future Atlas use cases, not only current contracts.
- The degree of configuration Visualping supports is unknown. Sarah plans another walkthrough with Margo.

## What this adds to the PRD

- The source document for the PRD's "about seven types of client-specific reporting rules" pain point.
- Site-health and control-presence checks are confirmed as manual monthly walkthroughs by the analyst for Banka Credins and Paynovus.
- Cliq's site-health items, redirects, server errors and parked domains, are reported today. Whether the MVP detects them is a question for the PRD.

## Related

- [[how-change-detection-runs-today]]: the default scope these rules sit on.
- [[client-base-and-cadence]]: merchant counts for each client named here.
