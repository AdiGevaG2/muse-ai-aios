# Raw source: CAL x Atlas meeting, second written summary

Ingested 2026-11-05. Pasted by Adi Geva. Covers the 5 November 2026 meeting, including a part (section 4) not in the transcript. Stored untouched; do not edit.

---

# Meeting Summary – Atlas Platform, Features & Roadmap

### 1. Introduction and Meeting Objectives

- Opening: Company and client representatives discussed the importance of understanding the added value that new features and products bring to the platform.
- Quarterly Business Reviews (QBRs): In addition to regular working meetings, quarterly business reviews will be held to present new products, features, and enhancements.
- Feature Announcements: Emphasis was placed on communicating new feature releases to ensure clients are aware of and benefit from them, while allowing the company to collect feedback on what works well and what requires improvement.
- Comments: The ability to add comments to specific findings was discussed, along with a review of the existing Merchant Policies functionality.

### 2. Feature Management, Ecosystem & Noise Reduction

- Connected Sites (Ecosystem):
  - The platform identifies the URL provided by the client and discovers additional URLs associated with it, assessing whether they present potential risks.
  - The platform identifies the merchant's business category and highlights mismatches between the declared information and the actual website content.
- Reducing False Positives and Noise:
  - Significant improvements have been made to the detection models to reduce unnecessary alerts.
  - The average number of connections identified was reduced from approximately 1–4 to 0.25, focusing on stronger, more reliable associations, such as exact IP address matches rather than broad IP ranges.
  - All relevant information is now consolidated into a single merchant-level view to simplify investigation and review.
- Available Reports: Summary Reports, MMP Reports, and URL-level Reports are already available and operational within the platform.

### 3. Advanced Features Planned for 2026–2027

\- Advanced Detection Capabilities:

- Front-side Detection
- Scam Detection
- Web Traffic analysis using third-party providers to assess merchant website traffic volumes
- Watchlist and Sanctions Screening

\- Enhanced Website Policy Verification:

- Moving beyond identifying whether a policy exists on a website.
- Analyzing policy content to verify its relevance to the merchant's business category and ensure all required policies are provided.

\- New Scan Indicator:

- Notifications and indicators informing users when a scan has been completed, including email notifications.

\- Web ID:

- Designed for cases where clients upload merchant lists without website URLs.
- Automatically discovers the merchant's URL or labels it as `Detected by EverC`.
- Identifies potential mismatches and automatically passes the information into the onboarding process.

\- Merchant Data Check:

- Verifies whether merchant information provided by the client matches the information displayed on the merchant's website, including business name, address, and email.

\- IdentIQ Underwriting:

- A major AI-powered capability planned for the end of February.
- Designed to automate and accelerate the merchant underwriting and onboarding process, significantly reducing manual analyst work.

\- Reporting Center:

- A centralized reporting hub that includes Billing Reports, evidence screenshots for individual findings, and direct links to Connected URLs.

\- Activity Log:

- Provides a complete history of actions and changes made to a merchant from the time of the initial scan.
- Examples include analyst updates to risk levels and new scans performed.

\- Wizard and Disputes:

- Built-in tools to support merchant addition workflows through a guided wizard and manage disputes with clients.

\- Client Migration:

- Capabilities designed to migrate the client's existing merchant data from legacy platforms into Atlas.
- The goal is to ensure a seamless transition without requiring clients to manually re-enter their data.

### 4. Category Detection Challenges, Alcohol & Risk Management

\- Alcohol-Related Risk Detection:

- A detailed discussion focused on alcohol-related alerts, which represent a significant portion of risk indications.
- Approximately 94% of relevant cases involve detection of alcohol-related keywords.
- The importance of distinguishing between a keyword appearing on a website and actual alcohol sales was emphasized.
- Additional context is required to determine whether a merchant is selling alcohol without a license or operating in restricted jurisdictions.

\- Custom Rules and Risk Policies:

- The ability to configure custom risk rules based on specific conditions, such as merchant location and business characteristics.
- For example, automatically assigning a predefined risk level when certain geographic and business conditions are met.
- A distinction was made between Indication Categories, which are based on keyword detection, and Content Categories, which reflect the actual nature of website content.

\- Advanced MCCM and G2 Capabilities:

- Integration of additional capabilities for merchant monitoring, external review analysis (e.g., Trustpilot), and cross-referencing regulatory information.

### 5. Summary and Next Steps

\- Timeline:

- Atlas capabilities will continue to expand throughout the year, with the full platform expected to be consolidated by year-end.
- Additional features, including AI-powered Underwriting, are planned for subsequent delivery, with the latter targeted for the end of February.

\- Demo Environment:

- A customized demo environment will be established using the client's own data, enabling the team to explore and evaluate the platform in real-world scenarios.

\- Follow-up Sessions:

- Additional internal and technical working sessions will be scheduled to:
  - Map detailed client requirements.
  - Define custom rules and risk policies.
  - Provide deeper training on platform capabilities and workflows.
