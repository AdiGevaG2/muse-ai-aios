# "PayPal questions_4Nov.docx": PayPal SLA working document

Origin: Ron Cohen's OneDrive, linked from Mary Williams' 2026-11-11 email. Pasted by the PM into chat 2026-11-12 (M365 connector returned 502). Text below is the paste, unedited; table cells arrive flattened one per line. Document carries a 4 Nov 2026 status header and call notes dated 10 and 11 November.

---

PAYPAL CALL OUTCOME – NOVEMBER 10TH 

PayPal needs basic checks while the merchant is present, starting with URL availability (e.g., offline/parked), followed potentially by contact validation, generic URLs, fraud history (e.g., Graph/Merchant Risk History), and a shallow MCC check. Deeper checks can run asynchronously. PP will get back to us about sequence of checks, required outputs, and acceptable SLA at each onboarding stage. 

 

Full notes from the call below but listing the immediate action items here: 

Confirm achievable SLAs and which inline checks Atlas can support, including URL availability (e.g., offline/parked), contact validation, generic URLs, fraud history (e.g., Graph/Merchant Risk History), and a shallow MCC check. 

URL availability (e.g., offline/parked) 

Contact validation 

Generic URL check: @Gal Sahar  

@Ron Cohen mentioned (internally) that based on what we saw in their POC data, things such as : generic URL, dummy/blurb URLs, fraud patterns like dummy names or verified bad address could be a potential upfront basic check. 

Graph/Merchant Risk History @Gal Sahar  

We put 30s for a Graph response time which is not sufficient. We need to think about how to reduce scope of the check to reduce the response. For example, check only for the worst violations (e.g., confirmed TL, scams). Hitting our database for specific history should have a shorter response time.  

MCC Check:  

What is the least number of pages required to crawl to output an MCC? And what is the impact to the precision?  

Clarify component-level SLAs and the recommended callback versus polling approach. Owner:   @Gal Sahar for services/components' SLA. @Alex Gershun for API SLA (generally negligible compared to Core/K9 SLAs) 

Confirm the Atlas readiness and API documentation timeline for Scam Network Detection. Owner: @Gal Sahar  + team 

 

NOTES FROM  NOVEMBER 11TH CALL - (Mary, Ishai, John, Ron, +PayPal's business + engineer stakeholders) 

Key alignments 

The current G2 Atlas API documentation covers WebID, MCC, Content Compliance, Front Site Detection, and Graph. 

Merchant Risk History will be incorporated into Graph and treated as a combined Atlas capability. Scam Network Detection is not yet included in the Atlas API documentation. G2 is still completing the model and needs to confirm its readiness timeline. 

The redesigned onboarding flow will require merchants to provide a URL. This differs from the POC, where approximately 50% of merchants did not have a URL because it was optional. 

The proposed integration will be staged and risk-based rather than running every service for every merchant. 

G2's current services operate asynchronously. Results can be delivered via a callback/webhook or retrieved via the GET findings API and the evidence endpoint. 

PayPal needs basic checks while the merchant is present, starting with URL availability, followed potentially by contact validation and a shallow MCC check. Deeper checks can run asynchronously. 

G2 noted that faster results may require shallower analysis, creating a tradeoff between response time and precision. 

Action items 

Define the sequence of checks, required outputs, and acceptable SLA at each onboarding stage (PayPal Onboarding team). 

Confirm achievable SLAs and which inline checks Atlas can support, including URL availability, contact validation, and shallow MCC classification @Ishai Froind, @Ron Cohen, G2 team). 

Confirm the Atlas readiness and API documentation timeline for Scam Network Detection @Mary Claire Williams, @John Hughes, G2 team). 

Clarify component-level SLAs and the recommended callback versus polling approach @Ron Cohen, G2 team). 

Schedule a follow-up working session for early next week to finalize the sequence, SLAs, and technical feasibility (John Hughes, PP) 

 

PayPal – G2 Open Questions & Action Items 

Status as of 4 Nov 2026. Assign an owner to each item, update the status (Open / In Progress / Answered) and add the response in the Vendor Response column. 

# 

Topic 

Question / Details 

Owner 

Status 

Vendor Response 

1 

Products evaluated 

a. Which products were included in the retrospective analysis, and for which were results shared with PayPal? 

b. What are the input data used for each product? 

Ron/Mary/Sarah 

Done 

As part of the PayPal POC, a total of 11 solutions were run on the 100K PayPal-selected sample. Additional details are available in the solution document provided, along with the Excel report of the results. 

 

Products/solutions and required input data: 

Merchant Monitoring  - URL (mandatory). 

Merchant Onboarding: 

Merchant Risk History (MRH) - URL or merchant name (at least one is mandatory); additional information, such as email, is optional but more the data provided may increase match rate. 

Watchlist, Sanctions, Legal (WSL) - merchant and/or principal information (mandatory). 

Consumer Reviews & Adverse Media (CRAM) -  merchant and/or principal information (mandatory); URL is also needed for some of the checks (e.g., Trust Pilot). 

Operational Risk (OR) - URL is required for checks such traffic data and policies; email is required for email fraud check. 

MCC Verification - URL (mandatory); reported MCC (optional, required for MCC mismatch detection). 

Front Site Detection (FSD) - URL (mandatory) and merchant information. 

Scam Detection - URL (mandatory) and merchant information. 

Transaction Laundering Detection (TLD) - URL or merchant name (at least one is mandatory); additional information, such as email, phone, billing descriptor, is optional but more the data provided may increase TL detection rate. 

WebID - merchant information: name, DBA, email, phone, physical address. 

Graph - merchant information (the more, the better): URL, name, email, phone, address. 

2 

API response time (SLA) 

SLA of the G2 real-time API requests: 

a. P50 – TBS 

b. P90 – TBS 

c. P99 – TBS 

PayPal requirement: current onboarding SLA is 500 -700 ms; PayPal expects the real-time API to respond within or close to this range. 

G2 status: component response times are being finalized; prior guidance of a 2-minute SLA for async response via callback still applies. PayPal's requirements to be incorporated into the new Atlas platform design. 

Application/Core 

Open 

Application (average for create merchant flow/onboarding/monitoring scans) in seconds 

a. P50 – 0.5 

b. P90 – 0.8 

c. P99 – 2 

External API create as standalone 

0.14 / 0.21 / 0.39 

 

Under P95, conservative assumptions: 

 

Product 

SLA 

CC 

1.5 min 

MCC 

1.5 min (2.5 min when combined with WebID) 

WebID 

p90: 50s, p95: 55-60s, average: 30s 

Graph (0-hop & 1-hop) 

30 sec 

FSD 

30 sec 

Scams Network Detection (future) 

Target: 1 min 

Note:  

    

The SLAs reflect our current standard configuration. We will work with PayPal to tune the underlying parameters where faster turnaround is a priority, and can align on a configuration that best fits your operational requirements.  

 

3 

Data caching 

What is the cache time for storing and reusing the G2 data? 

a. For how long can this data be cached and reused across various touchpoints? 

b. What is the data refresh rate for each request with the same input data? 

Gal/K9? 

Done 

Can you please clarify the objective behind the question? What are you looking to solve?  

4 

Throughput (TPS) 

What is the maximum transactions per second (TPS) for G2 APIs? 

Alex/Sergey 

Done 

Maximum throughput, measured on the create merchant + stores API: 

Sustained: up to 250 TPS 

Cold start (first 10–20 seconds): up to 120 TPS 

Capacity can be increased on request to meet PayPal's expected volumes. 

5 

API specification & endpoints 

API specification and endpoint URLs (to access each product) – for both Sandbox and Production environments: 

a. Input and response parameters, including mandatory and optional fields 

b. API authentication requirements, such as API keys or credentials 

Sergey/Adi 

Done 

Information is available in API doc shared (PDF version). 

 

6 

Country coverage 

Review the list of PayPal-supported countries below (189 total) and confirm whether G2 provides coverage across all of them; list any gaps in the Vendor Response. 

APAC (17): ID, KR, PH, SG, TW, VN, NZ, BT, KH, LA, MV, FM, MN, NP, WS, LK, TO 

MEA – Part A (34): AL, AD, BH, BA, BW, HR, EG, FO, GE, PF, GL, IS, JO, KZ, KE, KW, LS, MW, MU, MD, MC, MA, MZ, OM, QA, SA, SN, RS, SC, ZA, PM, CH, WF, AE 

MEA – Part B (56): KM, CG, KI, CD, KG, CI, MK, MG, CK, ML, MH, MR, BJ, YT, DJ, BY, ME, ER, ET, NA, NR, NC, NE, NG, BN, PW, PG, FJ, RW, ST, BF, GA, BI, CM, SL, SB, SO, GW, GM, SZ, GN, TJ, TZ, TG, TN, TM, UG, CV, TD, YE, ZM, ZW, AO, AM, AZ, DZ 

Independent Markets (12): HK, JP, AU, C2, IN, MY, TH, IL, MX, BR, CA, US 

LATAM (36): AR, BM, BS, CL, CO, CR, DO, EC, GT, HN, JM, KY, NI, PA, PE, SV, UY, VE, AG, AI, AW, BB, BO, BZ, DM, GD, GY, KN, LC, MS, PY, SR, TC, TT, VC, VG 

LUX (34): AT, BE, BG, CY, CZ, DK, EE, FI, FR, GF, DE, GI, GR, GP, HU, IE, IT, LV, LI, LT, LU, MT, MQ, NL, NO, PL, PT, RO, SM, SK, SI, ES, SE, GB 

Gal/K9 

Done 

G2RS provides global coverage. 

Content Compliance and MCC Verification are language-agnostic. As with any model-driven solution, performance is strongest in widely used languages and may be somewhat lower for less common languages. 
 
Front Site Detection (FSD) is also language-agnostic. In smaller markets, performance may be somewhat lower, as front sites there can closely resemble newly launched legitimate businesses, making them harder to distinguish.
