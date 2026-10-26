# Adyen: Mismatch of e-commerce Merchant IP — email thread

Date range: 2026-09-07 to 2026-09-09
Participants: Juan Jose Jovel Ramos, Mary Williams, Ishai Froind, Gal Sahar, Marc Temple, Jack Voice, #G2 Product Management

---

**Juan Jose Jovel Ramos, 2026-09-07 14:35**

Sasha asked today whether G2RS can support Mastercard's recommended monitoring controls regarding the monitoring of mismatches of e-commerce merchant IP addresses. I'm aware we don't currently offer this signal but curious to understand if this has been considered for UP?

**Juan Jose Jovel Ramos, 2026-09-08 (follow-up)**

Further context: this ask from Adyen relates to the Mastercard Franchise onboarding Adyen must complete as part of their newly acquired UAE license. The license lets Adyen operate payment services more directly in the UAE and manage local settlements without relying on third-party providers.

**Mary Williams, 2026-09-08 14:46**

@Gal Sahar - Does MV look at the IP address of a website to compare to a merchant's location detail? Asking other PMs familiar with this signal on WS or SP platform to chime in.

**Gal Sahar, 2026-09-09 11:15**

The IP of the merchant != the IP of the website. These are small merchants; usually a whois on the website would raise the location of the host (the hosting service), not the merchant.

To adequately address this issue, we would need the IP the merchant came from while transacting/interacting with our clients (e.g., upon onboarding). Proposed approach:
- IP x2 whois (merchant IP and website IP)
- Validate not a hosting service (IP location is only applicable if it's not a hosting/proxy IP), choose IP country
- Compare IP country to location detail

Gal does not know/believe this merchant-transaction IP data is currently collected in either product (MV or WS), but is not certain.

Core MV does not do website whois + comparison today. Gal will check whether/how MV runs whois at all.

Two possible bars for the requirement:
- If "substantial" (i.e., actually needs to catch mismatches) → need the merchant's transaction-time IP, which we don't currently have.
- If "that Adyen can mark they checked" (compliance box-checking) → could do the website's whois with caveats, since website IP is what's available today.

Also noted separately, re: Whois in MV today — FSD has an internal call for a Whois external service. Clients registered to Scamadviser get Whois via that integration instead.

---

[verbal] — email thread, not yet validated against MV codebase or FSD documentation.
