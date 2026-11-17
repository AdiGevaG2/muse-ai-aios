# Change Detection Categories (proposal)

A proposed taxonomy that labels each detected change by its business meaning:
13 content-change categories with subcategories, plus two separate check
classes, site health and control presence. Every item is a proposal awaiting
Product and analyst review.

Source: `source/2026-11-13-change-detection-categories-proposal.md`, pasted by
Adi Geva on 2026-11-13. Author, original date, and the "historical data" it
draws on are not stated. [unknown]

## How classification works
- Categories describe business meaning, independent of the technical diff kind
  (text, visual, text_visual, structural). [documented]
- Hierarchical: a client enables a whole category or picks subcategories.
  [documented]
- Multi-label: one change keeps every applicable classification and is not
  split. Example: an address change plus an APR change is labelled both
  Contact information / Address and Financial terms / APR. [documented]
- Classify by meaning, not page type: an address removed from a T&C footer is
  an Address change. Generic Website content labels apply only when no specific
  category fits. [documented]
- Classification rests on the before/after evidence, not a vendor-generated
  summary. Removing a company name or address does not by itself mean an
  ownership transfer. [documented]
- Category membership does not decide reportability; client significance and
  exclusion rules do. [documented]

## The 13 categories
| # | Category | Subcategories |
|---|---|---|
| 1 | Business identity | Business/legal name, Ownership, Rebranding |
| 2 | Contact information | Address, Phone number, Email address |
| 3 | Billing descriptor | None; add, modify, remove are operations, not subcategories |
| 4 | Payment | Payment methods; Card-network relationships and logos (Visa, Mastercard, Discover, AMEX; a logo alone is not a partnership) |
| 5 | Product | Products added/removed, Product types, Names/descriptions, Product claims, Ingredients (an existing product's list only) |
| 6 | Pricing | Individual prices; Catalog-wide price changes (not necessarily a promotion; client rules set exhaustive vs. trend/sample reporting) |
| 7 | Promotional | Offers and promotions (incl. a new countdown timer), Site-wide discounts, Going-out-of-business/liquidation (a clearance sale alone does not qualify) |
| 8 | Policy | T&C, Privacy, Refunds/returns, Shipping, Subscriptions/cancellation; proposed: Disclaimers, Age restrictions, Other policies |
| 9 | Financial terms | Surcharges, Convenience fees, APR |
| 10 | Licensing and partnership | Lending licenses, Money transmission licenses, Bank partnerships; proposed: Other partnerships |
| 11 | Website content | Primary messaging, Navigation, Banners/pop-ups, Blog content |
| 12 | Customer reviews | Review content, Review counts, Star ratings |
| 13 | Other | General fallback; does not make an out-of-scope or non-material change reportable |

All [documented]. "Proposed" marks items the source itself flags as less
settled than the rest.

## Separate check classes
- Site health: SSL certificate validity, redirects to another domain, server
  errors/inaccessibility, parked domains. A crawler access failure is not
  automatically customer-facing downtime. [documented]
- Control presence: age verification removed or disabled only. Presence does
  not prove effectiveness or compliance. Any other control needs an agreed
  requirement and verification method. [documented]
- Both match the site-health and control-presence rule types and examples in
  [[change-detection]] (Banka Credins SSL; Cliq redirects, server errors,
  parked domains; PayNovus age verification). Consistent, no conflict.
  [documented]

## Materiality and dynamic content
- Non-material formatting and technical updates may be omitted, per a "User
  Guide". A "WellHello example" is marked not reportable. [documented]
- Countdown timers: the first appearance of a timer is reportable even when
  the offer wording is unchanged; the ticking values are normalized or
  excluded. Cleanup must not remove the whole timer element. [documented]
- This narrows, but does not close, the open materiality gap in
  [[change-detection]]: the threshold still sits in per-client rules with no
  defined owner or test. [inference]

## Threads to other pages
- Rule catalog: the Q4 plan lists a rule catalog as an M0 deliverable due
  2026-11-15. This taxonomy is likely an input to it. [inference] Link:
  [[change-detection]].
- Rule types vs. categories: the seven client rule types (page-type scope,
  thresholds, catalog-aware logic, watchlists, exclusions, site health,
  control presence) configure what is reported; the categories label what
  changed. Different axes. Catalog-wide price changes depend on the
  catalog-aware rule type. [inference]
- Page coverage: Ingredients, Subscriptions/cancellation, Age restrictions,
  Blog content and Navigation sit on page types the Atlas core pipeline marks
  TBD (ingredients, subscription/cancellation, age gate, blog, header/footer).
  Classification by meaning still needs those pages captured. [inference]
  Links: [[crawler-capability-gaps]], [[crawler-consolidation]].
- Extraction: Business identity, Contact, Billing descriptor, Payment methods
  and Pricing line up with the structured-entity foundation; billing
  descriptor, payment methods and prices are its named gaps. [inference]
- Policy Analysis overlap: VARS checks SSL, card-brand, T&C, refund, delivery,
  privacy and contact-us. Policy categories and site health are the change
  signals that would feed those re-runs. [inference] Link:
  [[go-policy-analysis-vars-fiserv]].
- Review queue: M2 filters by change type. With multi-label, one change
  appears under several filters. [inference]
- Price changes: the Q4 use-case table maps significant price changes to
  Marketing content (TBD). Here Pricing is its own category, separate from
  Promotional and Website content. Not a conflict; ownership stays open.
  [documented]

## Unknowns
- Author, date, and the historical data behind the proposal.
- The "User Guide", "WellHello example" and "analyst example" it cites; none
  are in the brain.
- Whether "technical kind" values are Visualping's diff types or a G2RS model.
