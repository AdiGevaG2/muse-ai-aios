# Raw source: CAL x Atlas meeting, third written summary

Ingested 2026-11-05. Pasted by Adi Geva. Assumed to cover the 5 November 2026 meeting; the source does not state a date. Written from the G2 side ("we", "Shirley"). Stored untouched; do not edit.

---

Meeting Summary:

Product Updates & Communication:
They requested proactive notifications regarding new features, expressing that they feel uninformed about recent updates and current MV functionalities. Shirley noted that we will establish quarterly product meetings to showcase what’s new.

False Positives & Validation:
They complained about a high volume of false positives—noting a significant increase over the past few months in alerts assigned to them that do not necessarily require intervention, and where the system's assessment isn't always accurate. They want to take a snapshot from a specific month and compare what we surface against what actually requires action.

Filtering & Behavioral Monitoring:
Your role is to build the appropriate filters and add an additional validation layer checking the probability of sales by industry and geographic region. They also want to monitor behavioral changes—such as a merchant suddenly starting to sell internationally, introducing new products, or changing their MCC (Merchant Category Code).

Rules Engine:
They are very interested in using rules and were surprised to learn that rule configuration is already available today.

Blacklist & Processing Cross-Check:
They proposed checking websites listed on blacklists. Since a merchant wouldn't onboard a blacklisted site directly onto their platform, the approach should be to proactively take the blacklist, review all merchants listed there, identify where they process payments, and potentially tie it back to Visa. Obviously, a blacklisted site processes transactions; the question is through whom. Shirley suggested pulling by URL from the blacklist rather than searching via reported sites—running a test against the blacklists to see if any of those cards are visible in our system, and determining who they process payments with.

Card Utilization:
They mentioned that we hold cards of theirs that we haven't utilized, and from their perspective, they handle even more cards.

Transaction Laundering (Atlas / G2):
We informed them that we will provide them with transaction laundering capabilities through Atlas (by G2).

Pre-defined Card Watchlists:
Ideally, the list of cards would be pre-defined, so that whenever a transaction occurs using those specific cards, they receive a notification.

CRAM & Consumer Complaints Mismatch:
Their use of CRAM is interesting because online complaints often pertain to entirely different types of products. (For example, a merchant reported they provide accommodation credits, but customer complaints ultimately revealed online stock trading). This feature doesn't exist today, but it is worth exploring the addition of a feature that flags when customer complaints don't match the MCC.

Contract Utilization & Shadowing:
They have contracted services they aren't utilizing. We suggested conducting an internal review—either independently or together with us—to identify unused features and map their usage. We can use shadowing to map workflows and deliver the services they need the most.

Next Steps & Commercials:
They will internally discuss and define their required use cases and what interests them most. First, they will map out what an ideal flow looks like for them. They also want to know the pricing structure.

Risk Matrix:
They are very interested in a risk matrix.

Areas of Interest:

Web traffic

CRAM and WSL (specifically CRAM)

Graph - connected sites
