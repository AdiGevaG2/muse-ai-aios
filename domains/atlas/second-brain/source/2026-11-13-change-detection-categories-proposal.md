<!-- Raw source. Do not edit. Pasted by Adi Geva into /ingest on 2026-11-13. Author and original date not stated in the paste. -->

Proposed change categories and subcategories
This proposal is based on the documentation provided and historical data. The hierarchy, names, and interpretation rules remain proposed for Product and analyst review.
The taxonomy is hierarchical: clients can enable a whole category or select individual subcategories. Categories describe the business meaning of a change, independently of its technical kind (text, visual, text_visual, or structural). The grouping and names below are proposed for Product and analyst review. Classification is not mutually exclusive: a single change may be assigned multiple applicable categories and subcategories when it contains multiple independent business topics. All applicable classifications should be retained on the same change; it should not be split into separate changes solely to assign different classifications. For example, an update that changes both a business address and an advertised APR may be classified under Contact information changes / Address and Financial terms changes / APR.
1. Business identity changes
Business/legal name: Changes to the merchant’s trading name or legal entity name.
Ownership: Changes to the entity stated as owning or operating the business.
Rebranding: Changes to the merchant’s public brand identity, including its brand name, logo, or rebranding announcements.
2. Contact information changes
Address: Changes to published business, registered, mailing, or customer-service addresses.
Phone number: Contact or support phone numbers added, removed, or replaced.
Email address: Contact or support email addresses added, removed, or replaced.
3. Billing descriptor changes
Changes to the billing descriptor shown on the website: the merchant identifier customers are told to expect on their payment statements. Adding, modifying, or removing a descriptor are operations, not separate business subcategories.
4. Payment changes
Payment methods: Changes to accepted payment options, such as cards, bank transfers, digital wallets, cryptocurrency, or installment payments.
Card-network relationships and logos: Changes to statements or logos indicating acceptance of, or a claimed relationship with, Visa, Mastercard, Discover, or AMEX. A displayed logo alone does not establish a formal partnership.
5. Product changes
Products added/removed: Products entering or leaving the catalog. Temporary unavailability does not necessarily mean removal.
Product types: Changes to the kinds of products offered—for example, a jewelry retailer starting to sell apparel.
Product names/descriptions: Changes to product names, descriptions, specifications, or other descriptive attributes.
Product claims: Changes to assertions about benefits, performance, safety, or health/medical effects.
Ingredients: Changes to the ingredient list or stated composition of an existing product. A newly added product’s initial ingredient list is not, by itself, an ingredient change.
6. Pricing changes
Individual prices: Increases or decreases in the price of a specific product or service.
Catalog-wide price changes: Pricing changes affecting multiple products or a substantial part of a catalog. Client rules determine whether reporting is exhaustive or based on trends and samples.
A catalog-wide price change is not necessarily a promotion; it can be a permanent pricing adjustment.
7. Promotional changes
Offers and promotions: Changes to promotional offers, campaign messaging, discounts, or associated conditions, including the introduction of a countdown timer as a marketing urgency tactic. Expected changes to the values of an existing countdown are not substantive promotional changes.
Site-wide discounts: Discounts advertised across the website or a broad portion of its inventory.
Going-out-of-business/liquidation messaging: Statements announcing business closure or liquidation. An ordinary clearance sale does not by itself establish that the business is closing.
8. Policy changes
Terms and conditions: Changes to contractual terms governing website use, purchases, services, or customer obligations.
Privacy: Changes to statements about collecting, using, sharing, retaining, or protecting personal information.
Refunds/returns: Changes to eligibility, deadlines, procedures, conditions, or charges for refunds and returns.
Shipping: Changes to shipping charges, delivery timelines, fulfillment terms, destinations, or restrictions.
Subscriptions/cancellation: Changes to recurring billing, trials, automatic renewal, cancellation procedures, or cancellation conditions.
Disclaimers (proposed): Changes to legal or regulatory disclaimers and disclosures, for example health, FDA, or liability statements, that are added, modified, or removed.
Age restrictions (proposed): Changes to minimum age or age-eligibility requirements for using the site or buying products. The presence of an age-verification control is covered by the separate control-presence check.
Other policies (proposed fallback): Changes to identifiable policies not covered above.
9. Financial terms changes
Surcharges: Additional transaction or payment-method charges, including percentage-based card surcharges.
Convenience fees: Charges described as fees for using a particular payment channel or service.
APR: Advertised annual percentage rates, including their presence and changes to their values.
10. Licensing and partnership changes
Lending licenses: Changes to advertised lending authorizations, license details, or stated licensing status.
Money transmission licenses: Changes to advertised authorizations or licenses for transferring money.
Bank partnerships: Changes to banks named as providing or supporting the merchant’s services, including statements in terms and conditions.
Other partnerships (proposed fallback): New or changed partnership announcements outside banking. Planning mentions partnership announcements.
11. Website content changes
Primary messaging: Changes to the main statements or positioning of a page that do not fit a more specific business category.
Navigation: Changes to menus, tab labels, navigation links, or their destinations.
Banners/pop-ups: Changes to banner or pop-up content not covered by a more specific category.
Blog content: Blog posts added, removed, or updated, including changes to their titles and body content.
12. Customer review changes
Review content: Written customer reviews added, removed, or edited.
Review counts: Changes to the displayed number of reviews.
Star ratings: Changes to displayed rating scores.
13. Other changes (other)
Relevant content changes that do not fit the categories above. Use this fallback only when no existing category describes the business meaning; it does not make an otherwise out-of-scope or non-material change reportable. Other policies is a policy-specific fallback and does not replace this general category.
Separate check classifications
Site health and control presence are included as classifications of monitoring findings, separately from the content-change categories above. As stated in Q4 Planning, they are distinct check classes with their own capture logic, not technical diff kinds or checks that rely solely on comparing page content.
Site health
SSL certificate validity: Check certificate validity and identify invalid or expired certificates.
Redirects: Identify redirects to a different domain or website.
Server errors/inaccessibility: Identify server errors or sites that become inaccessible. A crawler access failure should not automatically be interpreted as customer-facing unavailability.
Parked domains: Identify parking or placeholder pages replacing the expected merchant website.
Control presence
Age verification: Detect removal or disabling of an expected age-verification mechanism. Presence alone does not establish its effectiveness or legal compliance.
No additional controls are assumed. Any extension requires an explicitly agreed requirement and verification method.
Classification and reporting rules
The rules below complement the taxonomy; they are not additional business categories. Category membership alone does not determine whether a detected change belongs in a client report.
Meaning, page type, and overlapping topics: Classify the changed content by its business meaning, independently of page type and region. An address removed from a Terms-page footer is an Address change; a promotional banner on that page is a Promotional change. 
Use generic Website content labels only where a more specific category does not apply. Retain multiple specific classifications when the change contains independent topics, as described in the introduction.
Evidence and interpretation: Classifications must be supported by the actual before/after evidence, not solely by a vendor-generated summary. Removing a published company name or address does not by itself establish an ownership transfer. 
Materiality and dynamic content: Apply the client's agreed significance and exclusion rules. The User Guide permits omission of non-material formatting and technical updates; the WellHello example is explicitly marked not reportable. For countdowns, preserve the signal that a timer has appeared, while normalizing or excluding expected ticking values. Do not remove the entire timer element during cleanup if that would hide its first appearance. A new countdown is reportable in the analyst example even if the offer wording remains unchanged.
