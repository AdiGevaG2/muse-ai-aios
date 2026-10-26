# Website Policy Types by Platform

Source: `website-policies-reverse-engineering.md`. One row per platform, all its
detected policy types in one place.

Corrected 2026-10-05 against `website-policies-reverse-engineering.md` after
Single Platform's native capability was found to have been missed in the
first pass. Full detail, evidence, and source citations for every row below
live in that document; this table is the list only. MV and SP are
code-verified. WS is evidence-based only, no repository was reachable to
confirm it. UP is code-verified for one service (`mlrc-finding`); whether it
has a native taxonomy elsewhere is open.

| Platform | Policy types detected |
|---|---|
| MerchantView (MV) | About Us Page, Contact Us Page, Privacy Policy Page, Shipping or Return Page, Terms and Conditions Page (each with a paired "missing" finding), plus 16 further `POLICIES` subtypes: Cancellation Link Not Present, Cancellation Link Noncompliant, Age Verification, Business Phone Number not Present, Cyber Locker, Generic URL, Licensed Pharmacy, NABP Not Recommended Pharmacies, Missing Address, Website Ownership Details, Missing Website Ownership Details, No Traffic Data, Policy Violation, Trial Period Noncompliant, US Licensed Cannabis Dispensaries, US Unlicensed Cannabis Dispensaries |
| Single Platform (SP) | Native `business_policies` domain, populated at merchant boarding, with 14 named risk flags: merchant name or DBA not found on homepage, Visa logo, Mastercard logo, phone number not found on Contact Us page, email address not found on Contact Us page, merchant country mismatch, customer service, return policy, long delivery, products and services mismatch, disallowed industry, currency mismatch, legal or export restriction, terms and conditions, privacy |
| WebShield (WS) | Terms & Conditions, Privacy Policy, Contact Us, Refund Policy, Shipping Policy, Cancellation Policy, 2257 Declaration |
| Atlas (UP) | None natively in `mlrc-finding` |

## Product decision

Business policies must be separated out as a standalone, separately-paid
component, not bundled into a package. ASSUMED: applies to UP going forward;
pricing/packaging mechanics TBD.

**Client workflow, MVP:** find the policy pages, then surface them to the
client month over month.

**MVP scope, policies as a standalone component:** treat Website Policies as
its own separated component within Findings, the same pattern as MCC, split
out from the rest of the findings, not commingled.

**Crawler configuration requirement:** the crawler must behave differently for
policies (separate from the rest of the findings crawl). Distinguish two kinds
of change:
- A **feature flag** controlling this is a crawler *configuration* change, not
  a UI change. It is configurable independent of any UI work.
- The **UI** (surfacing what the crawler finds) is a separate, phase 1
  deliverable.

**Phased rollout:**
1. **Phase 1 (MVP):** UI change only, surface the policy pages as their own
   component within Findings.
2. **Phase 2:** feature flag to run/not run the policies component (crawler
   config, not UI).
3. **Phase 3:** cadence configurable per product (supersedes/depends on the
   portfolio→product cadence requirement below).
4. **Phase 4:** data-driven (DD) migration of all policies from WS, SP, and MV
   into UP.

**Open decision, cadence:** default cadence is monthly. Per the phased plan
above, per-product cadence configurability is Phase 3, not MVP. PM to confirm
phase sequencing holds.

**Related requirement, cadence configuration level:** cadence today is
configured per portfolio. Requirement: cadence must be configurable at the
product level instead. Not policy-specific, but surfaced here because it
directly affects whether/how a policies-specific cadence override (above)
could even be offered. Cross-reference for spec/PRD work on cadence
configuration generally.

## Action items

| Item | Owner | Action | Status |
|---|---|---|---|
| Recall and permission status for all website policy docs: refund, shipping, cancellation, T&C, privacy, contact us | Adi Geva | Ask Aliona (loop in Gal) whether each doc is recalled/current and cleared for use | Open |

## Whiteboard notes (Blakeford / Ofra Haza room)

Raw capture from an in-person whiteboard session, transcribed as-is,
[verbal]/[hunch], not yet reconciled against the reverse-engineering doc.

**Per-platform, evidence format:**
- **WS**: Link, no screenshot (SS).
- **GO-OR / SP**: SS + Link. Note: "separate from findings."
- **MV**: mixed in findings; screenshots + link. Evidence pages: T&C, Privacy,
  Contact Us, Refund, Shipping, Cancellation. Also captured for MV: Homepage,
  About Us page, Product page, Payment Methods, Payment plan, Logos.

**"Business Policies" (top annotation, partly overlapping/hard to parse):**
2257/Adult, Refund, Shipping, Cancellation, Contact Us, T&C, Privacy Policy,
plus a secondary cluster: Contact, Refund, Delivery/Shipping, PP, T&C, Payment
policy.

**Data extraction pointers:** About Us, Homepage.

**Next steps (Adi):**
- Aliona: baseline for specialty (policy only).
- Precision/Recall.
- Separate Business Policies as a standalone component (confirms the product
  decision above).
- Cadence, marked with a question mark, i.e. still open (confirms the open
  cadence decision above).
