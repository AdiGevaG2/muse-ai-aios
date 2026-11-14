# PayPal onboarding on Atlas: internal email thread "Re: PayPal"

Date range: 2026-10-12 to 2026-11-11
Participants: John Hughes, Mary Claire Williams, Ishai Froind, Paul Stovall, Ron Cohen, Eyal Cohen, Sarah Craven, Gal Sahar, Shmuel Blitz, Yonatan Eisenberg, Yoni Arviv, Jeremy Haas, Sergey Kogan, Alex Gershun; Adi Geva cc on final message only
Origin: Outlook export supplied by the PM, outputs/paypal-atlas/Re_ PayPal .eml, extracted 2026-11-12. Body text below is the extraction, unedited; newest message first. Inline images (signature logos, one 214KB screenshot) not extracted. Linked attachments not opened: "PayPal questions_4Nov.docx" (Ron Cohen OneDrive), "PAYPAL ONBOARDING TEAM - PRICING.xlsx" (Mary Williams OneDrive), the onboarding proposal deck, POC deck, PayPal SOW, NAB API doc.

---

Team - We had a call with PayPal (PP) yesterday and they emphasized again their urgency for an onboarding solution (in Atlas). This is a significant opportunity (and a separate opportunity from the current PP contract). They want to be testing a sandbox environment by mid-December (Atlas API). Acknowledging the pressure here but landing PP’s onboarding + in-Atlas will be a significant win and direct outcome of our 100K POC that everyone contributed to.

PayPal needs basic checks while the merchant is present, starting with URL availability (e.g., offline/parked), followed potentially by contact validation, generic URLs, fraud history (e.g., Graph/Merchant Risk History), and a shallow MCC check. Deeper checks can run asynchronously. PP will get back to us about sequence of checks, required outputs, and acceptable SLA at each onboarding stage.

I’ve included the full notes from the call below but let’s continue to work from this PayPal SLA document for better collaboration. Use this document to review the immediate action items + more detail beyond the notes below ​[https://res-2.df.onecdn.static.microsoft/files/fabric-cdn-prod_20251010.003/assets/item-types/16/docx.svg]PayPal questions_4Nov.docx<https://g2risk-my.sharepoint.com/:w:/r/personal/ron_cohen_g2risksolutions_com/Documents/PayPal%20questions_4Nov.docx?d=wb6267ff688ba4c3dbbfafe144331bd44&csf=1&web=1&e=wj5juN>​

NOTES FROM NOVEMBER 11TH CALL - (Mary, Ishai, John, Ron, +PayPal’s business + engineer stakeholders)
Key alignments

 * The current G2 Atlas API documentation covers WebID, MCC, Content Compliance, Front Site Detection, and Graph.

 *
Merchant Risk History will be incorporated into Graph and treated as a combined Atlas capability. Scam Network Detection is not yet included in the Atlas API documentation. G2 is still completing the model and needs to confirm its readiness timeline.
 * The redesigned onboarding flow will require merchants to provide a URL. This differs from the POC, where approximately 50% of merchants did not have a URL because it was optional.

 * The proposed integration will be staged and risk-based rather than running every service for every merchant.

 * G2’s current services operate asynchronously. Results can be delivered via a callback/webhook or retrieved via the GET findings API and the evidence endpoint.

 *
PayPal needs basic checks while the merchant is present, starting with URL availability, followed potentially by contact validation and a shallow MCC check. Deeper checks can run asynchronously.
 *
G2 noted that faster results may require shallower analysis, creating a tradeoff between response time and precision.

Action items

 * Define the sequence of checks, required outputs, and acceptable SLA at each onboarding stage (PayPal Onboarding team).

 * Confirm achievable SLAs and which inline checks Atlas can support, including URL availability, contact validation, and shallow MCC classification @Ishai Froind, @Ron Cohen, G2 team).

 *
Confirm the Atlas readiness and API documentation timeline for Scam Network Detection @Mary Claire Williams, @John Hughes, G2 team).
 * Clarify component-level SLAs and the recommended callback versus polling approach @Ron Cohen, G2 team).

 * Schedule a follow-up working session for early next week to finalize the sequence, SLAs, and technical feasibility (John Hughes, PP)

Mary C. Williams
SVP, Product Management
Merchant, Digital Commerce & Bankruptcy Risk Solutions
Eastern Time Zone
[Image]
This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments.

From: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>
Date: Tuesday, October 20, 2026 at 4:17 PM
To: Ron Cohen <Ron.Cohen@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>; Sergey Kogan <Sergey.Kogan@g2risksolutions.com>; Alex Gershun <alex.gershun@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Ron,

Current callback already returns all findings.
That's how the GO-MLRC/Atlas integration works.
The API has a slightly different version of callback because we had a tight schedule and we wanted to make some adjustments to the API, so it wasn't shared in the doc.
I was understand the impression you were on that loop.
We can catch up offline.

Shmuel

Sent from Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Ron Cohen <Ron.Cohen@g2risksolutions.com>
Sent: Tuesday, 20 October 2026 11:44:09
To: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>; Sergey Kogan <Sergey.Kogan@g2risksolutions.com>; Alex Gershun <alex.gershun@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Thanks, @Shmuel Blitz<mailto:Shmuel.Blitz@g2risksolutions.com> .

Agree, we do have the callback mechanism, but the current Atlas API docs shared the callbacks are used sending notification only that scan is completed. Then you need to perform additional GET call to retrieve the results.

If it will change in the future then good.

Thank you!
Ron

From: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>
Date: Tuesday, 20 October 2026 at 11:36
To: Ron Cohen <Ron.Cohen@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>; Sergey Kogan <Sergey.Kogan@g2risksolutions.com>; Alex Gershun <alex.gershun@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Adding @Sergey Kogan<mailto:Sergey.Kogan@g2risksolutions.com> and @Alex Gershun<mailto:alex.gershun@g2risksolutions.com>.

Sergey and Alex,

You don't have to read the entire thread.
We'd like to give PayPal the "Maximum supported transactions per second (TPS), including any applicable rate limits or throttling".
Can you help provide that number please?

@Ron Cohen<mailto:Ron.Cohen@g2risksolutions.com> important correction - the "callbacks" mechanic is part of Atlas and we definitely offer customers that kind of response, in addition to the API endpoints for pulling the results independently.

Shmuel

Sent from Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Ron Cohen <Ron.Cohen@g2risksolutions.com>
Sent: Tuesday, 20 October 2026 11:21:21
To: Gal Sahar <gal.sahar@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Hi All,

Wanted to note that PayPal also asked for "Maximum supported transactions per second (TPS), including any applicable rate limits or throttling” - need to address that as well.

@Shmuel Blitz<mailto:Shmuel.Blitz@g2risksolutions.com> - who can assist with providing these numbers and how we handle rate limits ? (Reject/throttle?)

The way the Atlas API is built makes this ask more important as we ask our customers to retrieve results by themselves - list of findings, evidence per finding.

@Gal Sahar<mailto:gal.sahar@g2risksolutions.com> how many URLs can we support with the <3min SLA?

I just want to make sure we put proper guardrails from app perspective as well.

In G2 the MRH response in GO was a sync response- are we planning to have the graph (MRH should be part of it) as a sync response or all will by async?

Thank you!

Ron

From: Gal Sahar <gal.sahar@g2risksolutions.com>
Date: Tuesday, 20 October 2026 at 10:07
To: Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Hi all,

 1.
@Ishai Froind<mailto:ishai.froind@g2risksolutions.com> - The 30k/ p95 is the latest requirement I am aware of for SLA. Hence, that’s the SLA I referenced.
 2.
@John Hughes<mailto:john.hughes@g2risksolutions.com> - to be clear, from Core pov, all of the solutions will be ready by EOY, and I believe that is correct per all the relevant reqs across Atlas.
 3.
Approximate SLA for FSD, MCC, WEBID, CC, Graph (New Eco) - We currently feel comfortable committing to <3min. Pending on needs and priorities, we strongly believe we can optimize this to <1.5min.

Thanks, am happy to jump on a call if clarifications are required.

From: Ishai Froind <ishai.froind@g2risksolutions.com>
Date: Tuesday, 20 October 2026 at 8:45
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Needed this morning by noon.

Thanks
Ishai

Ishai Froind
+972-54-4323654

From: Mary Claire Williams <mary.williams@g2risksolutions.com>
Date: Tuesday, 20 October 2026 at 8:44
To: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

We should assume SLAs for Atlas. Who can provide approximate SLAs if we assume: FSD, MCC, WEBID, CC, Graph, CRAM, WSL

Mary C. Williams
SVP, Product Management
G2 Risk Solutions
________________________________
From: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>
Sent: Monday, 19 October 2026 19:40:25
To: Ishai Froind <ishai.froind@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Hi again,

The heavy lifting of the processing is on K9.
Whichever pipeline is expected to support PayPal's use-case will determine our SLA.

Shmuel

Sent from Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Ishai Froind <ishai.froind@g2risksolutions.com>
Sent: Monday, 19 October 2026 19:37:11
To: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>; Jeremy Haas <jeremy.haas@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

+@Jeremy Haas<mailto:jeremy.haas@g2risksolutions.com> for vis

Team,
We need to take some risks and commit to short SLAs with reasonable volumes across all services below.
This is urgent. We need to get back to them today (unless @John Hughes<mailto:john.hughes@g2risksolutions.com> is giving us the grace of getting back to them tomorrow?)

Thanks
Ishai

Ishai Froind
+972-54-4323654

From: Ishai Froind <ishai.froind@g2risksolutions.com>
Date: Monday, 19 October 2026 at 18:05
To: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Thanks Shmuel and Gal;
Not sure why we are referencing 30 minutes as the benchmark.
What do we anticipate the fastest SLA to be?
How many can we support in 1 minute? With p95?

Thanks
Ishai

Ishai Froind
+972-54-4323654

From: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>
Date: Monday, 19 October 2026 at 18:00
To: John Hughes <john.hughes@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Hi,

Reading @Gal Sahar<mailto:gal.sahar@g2risksolutions.com>’s message I can say that the Application layer can hold these SLAs (a burst of up to 30k can return p95 within 30 minutes).

Shmuel

Shmuel Blitz
R&D Director, Applications Group
M: +972 52 2521365<tel:+972522521365>
Israel Time
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/>

[Image]

From: John Hughes <john.hughes@g2risksolutions.com>
Date: Monday, 19 October 2026 at 17:57
To: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

I’m not sure I have been clear enough on the criticality of this.

Not having defined SLAs, and more importantly, not having all required solutions API-ready by EOY, creates a real risk that one of our largest customers selects a competitor.

The downside is not limited to losing a multi-million-dollar expansion opportunity. It also puts our existing ~$4M in ACV at risk if PayPal begins consolidating more of the relationship with another provider.

They are actively working towards accelerating their timeline, which makes our ability to deliver against these requirements critical to both the expansion and current relationship.

I need this today, even if it is only our best and most optimistic estimate at this stage.

Thank you,
John

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:48f3e32b-dbbd-4d2d-a870-f8221d81ee92]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>
Sent: Monday, October 19, 2026 4:26 AM
To: Gal Sahar <gal.sahar@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

HI,

Sorry for not replying yet.
I’m still catching up on the thread.
You’ll have my reply shortly.

Shmuel

Shmuel Blitz
R&D Director, Applications Group
M: +972 52 2521365<tel:+972522521365>
Israel Time
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/>

[Image]

From: Gal Sahar <gal.sahar@g2risksolutions.com>
Date: Monday, 19 October 2026 at 10:03
To: Ron Cohen <Ron.Cohen@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>; Yonatan Eisenberg <yonatan.eisenberg@g2risksolutions.com>; Yoni Arviv <yoni.arviv@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Morning all,

 1.
Regarding SLA, this is the current summary:
 *
Phase#1 - immediate - We will increase # of partitions. This will result in us being able to serve 6K / 30m/ p95. We do not expect this to incur additional cost (Done).
 2.
Phase#2 - Move to CMP:
 *
Other solutions become competing resources with CMP go live, while enabling minimal improvement, and close to the CMP serving this in production.
 *
Once the CMP is in production, and Atlas/MLRC sends to it, the 30K/ p95/ 30m will not be an issue and is currently measured for BM performance out of the box<https://g2rs.atlassian.net/browse/K9-1124?atlOrigin=eyJpIjoiMjk4MzdiMDcxNzA0NDUxNmFlNTUwODgwOGIyNDJkMmUiLCJwIjoiaiJ9>.
 3.
With the additional MCC reqs, we are currently understanding whether we can:
 *
Serve these quickly in Legacy, and then move forward with that approach, or
 *
Work with the client (Sarah) to push times to enable us to provide this via CMP (Production in EOM November will be tight).

CC @Yonatan Eisenberg<mailto:yonatan.eisenberg@g2risksolutions.com> @Yoni Arviv<mailto:yoni.arviv@g2risksolutions.com>

From: Ron Cohen <Ron.Cohen@g2risksolutions.com>
Date: Sunday, 18 October 2026 at 10:38
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>; Gal Sahar <gal.sahar@g2risksolutions.com>; Shmuel Blitz <Shmuel.Blitz@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

@Mary Claire Williams<mailto:mary.williams@g2risksolutions.com> - I don’t know the current committed SLA. When CMP was originally built to support instant onboarding I recall a modular approach release that should finish in single minutes per URL but don’t know if this still stands.

Adding @Gal Sahar<mailto:gal.sahar@g2risksolutions.com> @Shmuel Blitz<mailto:Shmuel.Blitz@g2risksolutions.com> to provide committed SLA from pipeline + APP perspective.

Thank you!
Ron

From: Mary Claire Williams <mary.williams@g2risksolutions.com>
Date: Sunday, 18 October 2026 at 4:48
To: John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

No - these response times are for Single Platform (except Front Site Detection). These response times will be reduced in Atlas since the services will be streamlined through core.

@Ron Cohen<mailto:Ron.Cohen@g2risksolutions.com> Do you have response times for MCC, FSD, CC, WebID based on the EC pipeline?

Mary C. Williams
SVP, Product Management
Merchant, Digital Commerce & Bankruptcy Risk Solutions
Eastern Time Zone
[Image]
This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments.

From: John Hughes <john.hughes@g2risksolutions.com>
Date: Friday, October 16, 2026 at 11:37 PM
To: Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Hi Mary,

This was shared with Ramy, Balaji and Logan in August.

Are the response times based on where things stood at that time or is this reflective of the future state on Atlas?

Thanks,
John

[cid:86ccb5ac-6769-43f9-8e44-1e6e3309303d]

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:9a69e29c-c373-497d-8cc7-6eba4bdd075a]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: John Hughes <john.hughes@g2risksolutions.com>
Sent: Friday, October 16, 2026 12:19 PM
To: Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

GO/SP likely not an option. Too many of the solutions they’ll adopt would have to be run with either a file transfer or in a roundabout way, e.g. WebID.

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Ishai Froind <ishai.froind@g2risksolutions.com>
Sent: Friday, 16 October 2026 12:13:51
To: John Hughes <john.hughes@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Note that the file name is NAB so please edit before sharing and emphasize Ron’s point that this is a first draft.

If we can get a sense of their ACTUAL implementation timeline that would be great.
It might be the case that we won’t have a choice but to work through GO/SP (for which you already provided the API docs).

Thanks
Ishai

Ishai Froind
+972-54-4323654

From: Ishai Froind <ishai.froind@g2risksolutions.com>
Date: Friday, 16 October 2026 at 19:10
To: John Hughes <john.hughes@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

We did. Ron shared with NAB yesterday (see attached email and the doc attached to it).
Not crazy happy about it. It has been a rushed effort (due to NAB pressure) and we are not confident that proper Eng design was put in place. It exists, so if we choose to share it we can.

Thanks
Ishai

Ishai Froind
+972-54-4323654

From: John Hughes <john.hughes@g2risksolutions.com>
Date: Friday, 16 October 2026 at 19:05
To: Ishai Froind <ishai.froind@g2risksolutions.com>; Mary Claire Williams <mary.williams@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Thanks @Ishai Froind<mailto:ishai.froind@g2risksolutions.com>. I already sent them the GO and MDMX API documentation and explained that those APIs will likely be irrelevant for the solutions they ultimately adopt, as those capabilities would be accessed through Atlas.

API docs for Atlas are what they're asking for now. Didn't we prepare something based on a request from NAB?

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:532357b9-8c5c-4432-96e9-22242ae609c6]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Ishai Froind <ishai.froind@g2risksolutions.com>
Sent: Friday, October 16, 2026 11:54 AM
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ron Cohen <Ron.Cohen@g2risksolutions.com>; Eyal Cohen <Eyal.Cohen@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>; John Hughes <john.hughes@g2risksolutions.com>
Subject: Re: PayPal

+@Ron Cohen<mailto:Ron.Cohen@g2risksolutions.com> and @Eyal Cohen<mailto:Eyal.Cohen@g2risksolutions.com>

@Ron Cohen<mailto:Ron.Cohen@g2risksolutions.com> can we please send the API docs?
Per discussion with Mary, we should send the SP/GO docs - hopefully it will take them time to actually get into work and then we can ask to swap to Atlas before work actually begins on their end. @Mary Claire Williams<mailto:mary.williams@g2risksolutions.com> feel free to overrule me if I misspoke

Thanks
Ishai

Ishai Froind
+972-54-4323654

From: John Hughes <john.hughes@g2risksolutions.com>
Date: Friday, 16 October 2026 at 17:50
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Cc: Sarah Craven <sarah.craven@g2risksolutions.com>
Subject: Re: PayPal

Hold that thought - he just sent over another laundry list:

Hi John,

Thank you for sharing the Onboarding proposal deck and a high-level walkthrough yesterday. To complete our evaluation, we need the following technical information from G2:

 1. API documentation, including specifications and endpoint URLs.

 2. Response/processing time for each solution component.

 3. Request and response parameters, with required and optional fields clearly identified.

 4. Authentication requirements, including the process for obtaining API keys or credentials.

 5. Applicable SLAs, including expected API response latency and availability commitments.

 6. Maximum supported transactions per second (TPS), including any applicable rate limits or throttling.

Could you please prioritize #1 (API documentation) and #2 (response/processing times) today? The remaining items can follow by early next week.

Please let me know if anything above needs clarification.

Thanks,
Rahil

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:818ce545-17a5-49ba-a683-4dc93d9f6107]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: John Hughes <john.hughes@g2risksolutions.com>
Sent: Friday, October 16, 2026 10:47 AM
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Hi Mary - Do we have the API docs for Atlas that I can share with PayPal today?

Thanks!

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:365b61dd-324c-47b0-a37f-d47d2cae4f08]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: John Hughes <john.hughes@g2risksolutions.com>
Sent: Wednesday, October 14, 2026 3:26 PM
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Please call me quickly and then I will let you sleep 🙂

I need to make sure I am 100% on the same page as you.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:76ed9dd6-58a6-4837-a6e4-0d1904b4bd43]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Mary Claire Williams <mary.williams@g2risksolutions.com>
Sent: Wednesday, October 14, 2026 3:20 PM
To: John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Hi John - Please send them the API docs for single platform that Ron shared.

We will launch Atlas EOY, but it may not include all products that they sign up for so we won't put the deal at risk. However, once I see what they sign up for, we will move quickly to cover the rest of the products in Atlas and gamble a bit that they will take longer to integrate.

I’m going to bed soon. Do you have what you need?

Mary C. Williams
SVP, Product Management
G2 Risk Solutions
________________________________
From: John Hughes <john.hughes@g2risksolutions.com>
Sent: Wednesday, 14 October 2026 21:08:59
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Thanks!

As for my other note below, what are our best estimates for APIs for all solutions through Atlas?

Example: Their Onboarding initiative gets prioritized before EOY. They want to integrate/begin testing in December.

I'm not saying this is going to happen, but we should operate as if it will. This is a stated top 5 priority for Aaron Webster (CRO), and as we all know, things that seem like they will take months for PayPal, suddenly happen in a week. Things that should take weeks end up happening in months or years.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:e06c6f4a-5744-4b43-b9c6-ce0fa2a25503]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Mary Claire Williams <mary.williams@g2risksolutions.com>
Sent: Wednesday, October 14, 2026 1:14 PM
To: John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

I must have read their MRH pricing wrong. Go ahead and update to $0.08 for MRH.

Mary C. Williams
SVP, Product Management
G2 Risk Solutions
________________________________
From: John Hughes <john.hughes@g2risksolutions.com>
Sent: Wednesday, 14 October 2026 18:50:28
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

First, let's close the loop on GO pricing in their current contract, for comparison purposes.

GO MRH - $0.10 per report
GO CC - $0.15 per report

Those unit costs were based on 45k per month with analyst review. This is automated at 500k.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:6a67c44b-c97c-4d70-ac0a-306b27444880]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Mary Claire Williams <mary.williams@g2risksolutions.com>
Sent: Wednesday, October 14, 2026 11:06 AM
To: John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

@John Hughes<mailto:john.hughes@g2risksolutions.com> I added WSL back into the scenarios.

The second scenario is giving more realistic volumes across solutions. That scenario is my recommendation but would like to get your thoughts.

Mary C. Williams
SVP, Product Management
Merchant, Digital Commerce & Bankruptcy Risk Solutions
Eastern Time Zone
[Image]
This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments.

From: John Hughes <john.hughes@g2risksolutions.com>
Date: Wednesday, October 14, 2026 at 5:57 PM
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

@Mary Claire Williams<mailto:mary.williams@g2risksolutions.com> @Ishai Froind<mailto:ishai.froind@g2risksolutions.com> I also want to flag that, in my discussion yesterday, I confirmed that having API access across all solutions is critical.

They are working to accelerate the process on their side, so our ability to have Atlas fully operational and ready at that point is going to be very important. All else being equal, a competing vendor that already has the required APIs in place will create a significant disadvantage for us.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:d1dc5505-4650-4838-9104-84219e7abad4]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: John Hughes <john.hughes@g2risksolutions.com>
Sent: Wednesday, October 14, 2026 9:50 AM
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Thanks, Mary. Sorry, I probably should have just sent you my spreadsheet so you didn’t have to recreate one!

Your instincts were correct. I confirmed yesterday that they do currently have WSL covered, but they still asked us to include pricing for it.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://g2risksolutions.com/> | LinkedIn<https://www.linkedin.com/company/g2-risk-solutions/posts/?feedView=all>

[cid:0a69c18c-f1c6-4a3d-bd5c-55698b19e022]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Mary Claire Williams <mary.williams@g2risksolutions.com>
Sent: Wednesday, October 14, 2026 6:21 AM
To: John Hughes <john.hughes@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Thanks, John. I put this into a spreadsheet with calculations. Please see the second sheet for my suggestions and let’s iterate from there. (See my reasoning for removal of 2 components in the second scenario.)

​[https://res-2.df.onecdn.static.microsoft/files/fabric-cdn-prod_20251010.003/assets/item-types/16/xlsx.svg]PAYPAL ONBOARDING TEAM - PRICING.xlsx<https://g2risk-my.sharepoint.com/:x:/r/personal/mary_williams_g2risksolutions_com/Documents/PAYPAL%20ONBOARDING%20TEAM%20-%20PRICING.xlsx?d=w097291b7d05a4c26848334c3b268ab8f&csf=1&web=1&e=MFgPqx>​

@Ishai Froind<mailto:ishai.froind@g2risksolutions.com> I left a comment on the MCC pricing for you.

Mary C. Williams
SVP, Product Management
Merchant, Digital Commerce & Bankruptcy Risk Solutions
Eastern Time Zone
[Image]
This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments.

From: John Hughes <john.hughes@g2risksolutions.com>
Date: Tuesday, October 13, 2026 at 11:57 PM
To: Mary Claire Williams <mary.williams@g2risksolutions.com>; Ishai Froind <ishai.froind@g2risksolutions.com>; Paul Stovall <paul.stovall@g2risksolutions.com>
Subject: Re: PayPal

Pricing scenarios below. The option with all solutions is crazy. No chance of landing there.

Everything
Product
Monthly Volume
Unit Cost
Monthly
Annual
WebID
250,000
$0.25
$62,500
$750,000
MCC
500,000
$0.30
$150,000
$1,800,000
FSD
250,000
$0.30
$75,000
$900,000
SD
250,000
$0.40
$100,000
$1,200,000
GO CC
500,000
$0.13
$65,000
$780,000
GO MRH
500,000
$0.09
$45,000
$540,000
WSL
500,000
$0.20
$100,000
$1,200,000
CRAM
500,000
$0.30
$150,000
$1,800,000
OR
500,000
$0.35
$175,000
$2,100,000
Total
$922,500
$11,070,000
Without WSL, CRAM, OR
Product
Monthly Volume
Unit Cost
Monthly
Annual
WebID
250,000
$0.25
$62,500
$750,000
MCC
500,000
$0.30
$150,000
$1,800,000
FSD
250,000
$0.30
$75,000
$900,000
SD
250,000
$0.40
$100,000
$1,200,000
GO CC
500,000
$0.13
$65,000
$780,000
GO MRH
500,000
$0.09
$45,000
$540,000
WSL
500,000
$0.20
CRAM
500,000
$0.30
OR
500,000
$0.35
Total
$497,500
$5,970,000

Without WSL, CRAM, OR, GO MRH
Product
Monthly Volume
Unit Cost
Monthly
Annual
WebID
250,000
$0.25
$62,500
$750,000
MCC
500,000
$0.30
$150,000
$1,800,000
FSD
250,000
$0.30
$75,000
$900,000
SD
250,000
$0.40
$100,000
$1,200,000
GO CC
500,000
$0.13
$65,000
$780,000
GO MRH
500,000
$0.09
WSL
500,000
$0.20
CRAM
500,000
$0.30
OR
500,000
$0.35
Total
$452,500
$5,430,000

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vZzJyaXNrc29sdXRpb25zLmNvbS8iLCJsaW5rVGV4dCI6IldlYnNpdGUiLCJ0ZW1wbGF0ZUlkIjoiIiwiZXhwIjoxNzkzNzM5Mzk1LCJpYXQiOjE3OTE5MjQ5OTUsImp0aSI6Im1MVlI2YjVKZ1ZUNSJ9.Iarc5gZPuYWRQvvRYL88BS9U05FsywaHmr16w-K5cb4> | LinkedIn<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2cyLXJpc2stc29sdXRpb25zL3Bvc3RzLz9mZWVkVmlldz1hbGwiLCJsaW5rVGV4dCI6IkxpbmtlZEluIiwidGVtcGxhdGVJZCI6IiIsImV4cCI6MTc5MzczOTM5NSwiaWF0IjoxNzkxOTI0OTk1LCJqdGkiOiIxTE1DZmxsV21ZblEifQ.leW7RZpQ9Vz17BJvcOakxP0_GLiBg0joM_T7dnOXslY>

[cid:9147f942-6ed3-414d-a2c5-257a454f9bb1]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>
Sent: Tuesday, October 13, 2026 2:56 PM
To: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

@John Hughes<mailto:john.hughes@g2risksolutions.com> (reduced thread) Below is the bottom per unit price for each component, which assumes 500K. Let me know if you need adjustments on any of these. We are taking a lower margin on some with an assumption that we are going to reduce some costs (e.g., OR) as we move to Atlas.

WSL: $0.20
CRAM: $0.30
MRH: $0.10
OR: $0.35

Mary C. Williams
SVP, Product Management
Merchant, Digital Commerce & Bankruptcy Risk Solutions
Eastern Time Zone
[Image]
This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments.

From: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>
Date: Tuesday, October 13, 2026 at 9:40 PM
To: Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>; Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

Thanks. I just discussed the RBA for FSD with Maya. I’ll present it as an option, but there will still be some gaps if they choose to go that route.

Another idea I discussed with Maya is presenting a third option where we only send non-high-risk merchants to FSD. The thinking is that if someone is operating a front site, why would they intentionally structure it in a way that would be classified as high-risk and invite additional scrutiny.

Regarding the RIS deliverable for the renewal contract, I think we’re in good shape to continue with the $175 extension pricing. At that price point, our margin is over 90%.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vZzJyaXNrc29sdXRpb25zLmNvbS8iLCJsaW5rVGV4dCI6IldlYnNpdGUiLCJ0ZW1wbGF0ZUlkIjoiIiwiZXhwIjoxNzkzNzM5Mzk1LCJpYXQiOjE3OTE5MjQ5OTUsImp0aSI6Ii9DbkExVHNhZ3B6ZiJ9.DNHeC2IWLRnAf1AoJKfkNvpZdlyAZ6vApXX7tKwvGLg> | LinkedIn<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2cyLXJpc2stc29sdXRpb25zL3Bvc3RzLz9mZWVkVmlldz1hbGwiLCJsaW5rVGV4dCI6IkxpbmtlZEluIiwidGVtcGxhdGVJZCI6IiIsImV4cCI6MTc5MzczOTM5NSwiaWF0IjoxNzkxOTI0OTk1LCJqdGkiOiJoeERyUXZJelkzMloifQ.4-Ucuk8DbCpIPtgrOqL43zteiqXFwpRrCX3vTEnYHNg>

[cid:ee2c6482-122a-4b1a-8e84-e5caa19ec4f1]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________
From: Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>
Sent: Tuesday, October 13, 2026 2:31 PM
To: Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>; John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

@John Hughes<mailto:john.hughes@g2risksolutions.com> I’ll send the costs for the other services we discussed via Slack. Attached is the modified deck. Please review and let me know if anything is missing.

Mary C. Williams
SVP, Product Management
Merchant, Digital Commerce & Bankruptcy Risk Solutions
Eastern Time Zone
[Image]
This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments.

From: Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Date: Tuesday, October 13, 2026 at 4:45 PM
To: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: RE: PayPal

Hi All,

Commenting on the API pieces –

We do not currently offer an SP API for WebID; clients can submit requests to SP WebID via API but they can only receive the results in portal. However, I assume for this use case PayPal would only be interested in an automated option anyway, and not the manual-only version we offer in SP.

To support FSD and WebID in GO via integration with the MLRC pipeline, we would need to 1) ensure these components are available in the pipeline, and 2) build new GO components for each. If we limit availability only to API/GO PDFs and simply pass through results rather than adding any new risk flags in AME, I anticipate that the Guardian/Jedi work would represent around 1 month.

@John Hughes<mailto:john.hughes@g2risksolutions.com> on usage estimates, I will need to get an update from Compliance Ops in terms of how many TL leads they believe they will be able to get through this month. Will get back to you later on this.

Best,

Sarah Craven (she/her)

Director, Product Management

M: +1-269-363-7126
Central Time (GMT-6)
Website<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vZzJyaXNrc29sdXRpb25zLmNvbS8iLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoiQm82Q0VrWWxGcXhJIn0.rhyaNWT10hl6hp4mg_KpsDpyEIWd318wokK5nkzadPE> | LinkedIn<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2cyLXJpc2stc29sdXRpb25zLyIsImxpbmtUZXh0IjoiIiwidGVtcGxhdGVJZCI6IiIsImV4cCI6MTc5MzczOTM5NSwiaWF0IjoxNzkxOTI0OTk1LCJqdGkiOiJ3TGFaeHFjaXdZZ3gifQ.4W7wnjdqJHR9bCFN8G-C1VZNhVyl3_k_gXvWaJMqIYg>

[cid:1310778b-beac-4c11-b567-7761c1fc4b6f]

From: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>
Sent: Tuesday, October 13, 2026 8:27 AM
To: Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

Yes, that works for me. I'll resend the invite. Whoever can join, fantastic. Whoever can't, I'll follow up with key takeaways and action items.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vZzJyaXNrc29sdXRpb25zLmNvbS8iLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoiYWNGYXBhMmJKcUMzIn0.GnWOshSwWWLyr5soCaijG6dfCckhZKqTWq5gbT4g-eE> | LinkedIn<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2cyLXJpc2stc29sdXRpb25zL3Bvc3RzLz9mZWVkVmlldz1hbGwiLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoiTDlOMExZOGE4S25IIn0.kXZNfroPLKvN4n_FddBGHTbHXz9JAIdMeBAA58ISyPM>

[cid:f26cec99-4a3f-4d27-93e0-e27950589132]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

From: Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>
Sent: Tuesday, October 13, 2026 9:20 AM
To: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

Thanks John

Can we meet earlier today? If the Business Review ends early we can talk that time. Alternatively, can we do 12:30 or 1:00pm EST? (And then still be opportunistic if business review ends early)

Thanks

Ishai

Ishai Froind

+972-54-4323654

From: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>
Date: Tuesday, 13 October 2026 at 16:12
To: Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

@Ishai Froind<mailto:ishai.froind@g2risksolutions.com>

All GO components - CC would be a definite, the others likely fall into "nice to have"

FSD

MCC

WebID

Scams - If and when it's productized. Pricing for that state and current state which involves a lot of manual effort. For the latter, we have generally used $5k per network/4 networks per month, $240k annually

@Ishai Froind<mailto:ishai.froind@g2risksolutions.com> For a better understanding of how they're priced now, please see price table on page 2 of the SOW attached.

Not included in this is MCC/WebID that they just signed.

MCC is $0.66 unit price for 10k per month. WebID is $0.68 unit price for 5k per month. Unit price on this opportunity is expected to be much lower given the baseline of 500-750k merchants per month.

I can handle pricing and structure and send back for review. I just need to better understand the guardrails for this opportunity. Floor on each solution, etc.

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vZzJyaXNrc29sdXRpb25zLmNvbS8iLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoiNFpWR2ZNditUMnpGIn0.5dSSIdxyYkrKX1LLr6Dm3YVRK-3_7otYSyRWni4_aeo> | LinkedIn<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2cyLXJpc2stc29sdXRpb25zL3Bvc3RzLz9mZWVkVmlldz1hbGwiLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoiVzdZL1lnRHlMM21sIn0.TEgMoft9f6Elr5rp1O7oRGD_BhUeCBmYTKxrcvxHjS4>

[cid:227b9423-8146-4d32-ad89-20ee596abee1]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

From: Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>
Sent: Tuesday, October 13, 2026 8:54 AM
To: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

Thanks Ron.

Is there no WebID API for SP? If their input and output are from SP I assume that their integration doesn’t change.

@Sarah Craven<mailto:sarah.craven@g2risksolutions.com> Acknowledging that there is no FSD integration to SP, if they choose to use it - what do you anticipate the effort to be in terms of integrating FSD to SP and exposing it in the API?

@Ron Cohen<mailto:Ron.Cohen@g2risksolutions.com> any other services we should account for?

@John Hughes<mailto:john.hughes@g2risksolutions.com> Tselmeg mentioned to me SLA expectations - we’ll be able to deliver to such expectations only through Atlas. We don’t need to lead with that - but something to consider, especially if we were to develop more capabilities back to SP - and will be unable to meet their SLA.

Please share all product/services they are currently engaged on and we can map out when will they be “migration ready” in terms of covering all their features in Atlas.

Thanks

Ishai

Ishai Froind

+972-54-4323654

From: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>
Date: Tuesday, 13 October 2026 at 15:49
To: Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>; Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

Thanks Ron. What are the plans for FSD/WebID API? A manual file upload is not suitable for this use case.

Also, to be confirm, MDMX API is for PMM, correct?

Get Outlook for iOS<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vYWthLm1zL28wdWtlZiIsImxpbmtUZXh0IjoiIiwidGVtcGxhdGVJZCI6IiIsImV4cCI6MTc5MzczOTM5NSwiaWF0IjoxNzkxOTI0OTk1LCJqdGkiOiJzS3JPdWY4K1QwRVMifQ._9s_acnixQuFsAAY8PzBJJRUlzI6kL94t7j5SCID83I>

________________________________

From: Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Sent: Tuesday, 13 October 2026 08:41:39
To: Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

Hi,

Sharing the latest API docs for GO and MDMX (I assume PayPal already have these but sharing the most updated version just in case).

For FSD and WebID, there is no SP-EC integration for these so there will be manual process to be involved for sending requests to EC and retrieving the responses.

Thank you!

Ron

From: Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>
Date: Tuesday, 13 October 2026 at 13:17
To: Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>; Ron Cohen <Ron.Cohen<https://Ron.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Cc: Eyal Cohen <Eyal.Cohen<https://Eyal.Cohen>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: Re: PayPal

+Ron and copying Eyal.

Thanks for including me.

Sarah is on a plane on her way to Israel.

Mary is in Israel and this meeting is scheduled for our 10:00pm (BTW - it’s also her b-day today and I hope she isn’t planning to work this evening…)

@Ron Cohen<mailto:Ron.Cohen@g2risksolutions.com> can you please pull the API docs together per John’s request?

@John Hughes<mailto:john.hughes@g2risksolutions.com> can you please pull all the current services and pricing that are in place with PayPal? This will help streamline the process by creating a baseline.

@John Hughes<mailto:john.hughes@g2risksolutions.com> @Ron Cohen<mailto:Ron.Cohen@g2risksolutions.com> if we have the other decks and can use them as baseline can you please put together a draft deck, see what’s missing and then pull the needed individuals to fill the gaps?

Once we have the baseline pricing (current + calculator) and estimated volumes (should we simply use 500K?) - we can provide a proposal

Thanks

Ishai

Ishai Froind

+972-54-4323654

From: Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>
Date: Tuesday, 13 October 2026 at 12:35
To: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>; Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>; Ishai Froind <ishai.froind<https://ishai.froind>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: RE: PayPal

+Ishai

Regards,

Paul Stovall
Chief Revenue Officer (CRO)
P: +1 214-417-4650
Central Time
Website<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vZzJyaXNrc29sdXRpb25zLmNvbS8iLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoieVlzanBuWGRXV1JoIn0.74luUxpOoOPLyQI7J-vFDeFTqE-nZ1H6b0DrpkVjN0w> | LinkedIn<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vbmFtMTAuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnVybGRlZmVuc2UuY29tJTJGdjMlMkZfX2h0dHBzJTNBJTJGYWJjeHl6aHR0cCUzQSUyRmFiY3p5dmxpbmtlZGluLmNvbSUyRmNvbXBhbnklMkZnMi13ZWItc2VydmljZXMlMkZfXyUzQiEhQ0FGTEVXSUIhR2U2NVZPN3V6OTl2UVROWHFncnVHZktwU0FzMkdqTk5nanVtcXFVRmRObE0yeFFBZmJiam5hTHNqWHhnSkZtb2cwZUpncllKdVR4ZGw2S2tTSUctY1llRVBrS3FnVzNiWkElMjQmZGF0YT0wNSU3QzAxJTdDTmljb2xhcy5FdnJhcmQlNDBnMmxsYy5jb20lN0NkZGI3OTk3N2Y1MWI0MTU4ZWE1MzA4ZGJjZDU4NjYyNiU3QzVjMTBlYWM4Zjg3MjQ1NTdhZWFmYzVhNDM5NDExNzAxJTdDMCU3QzAlN0M2MzgzMjk1NTE3OTcwMTA1NDglN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT1JeFZ4OTcwVGc1ZVBKc2c3ODRRcjBHSEdSYVk0dFFyJTJCWkp5aCUyQlZTYVBlRSUzRCZyZXNlcnZlZD0wIiwibGlua1RleHQiOiIiLCJ0ZW1wbGF0ZUlkIjoiIiwiZXhwIjoxNzkzNzM5Mzk1LCJpYXQiOjE3OTE5MjQ5OTUsImp0aSI6IjVZQW56aDJpRFErTCJ9.REZRgb8OyWtSNR4eAnh47dU2OJp67Le66GkFqd9GzK4>

[Blue text on a black background Description automatically generated]

From: John Hughes <john.hughes<https://john.hughes>@g2risksolutions.com<https://g2risksolutions.com>>
Sent: Monday, October 12, 2026 4:35 PM
To: Mary Claire Williams <mary.williams<https://mary.williams>@g2risksolutions.com<https://g2risksolutions.com>>; Paul Stovall <paul.stovall<https://paul.stovall>@g2risksolutions.com<https://g2risksolutions.com>>; Sarah Craven <sarah.craven<https://sarah.craven>@g2risksolutions.com<https://g2risksolutions.com>>
Subject: PayPal
Importance: High

Per my discussion with Rahil today, I have a number of follow up items that I need collaboration on.

 1. API docs: First, the easy (I hope) part: I need to send them API documentation for all products associated with the Onboarding opportunity. GO, FSD, MCC, WebID. A) do we have API docs for all solutions? B) If yes, please forward them to me.

Context: This is a direct ask from the evaluating team. They are heads down working to finish the evaluation ASAP, so that they may be able to include it with the "Brand Risk" renewal, which is November 1st. Very ambitious and not probable, but it's their stated goal. At the very least we could be moving towards commercials soon after the renewal if we're selected.

 1.
Deck: To assist with this, they've requested a proposal deck with all services that we're proposing for the Onboarding opportunity. @Mary Claire Williams<mailto:mary.williams@g2risksolutions.com> We previously provided something similar in our follow up to Balaji, Ramy and Logan, as well as in the POC deck, both of which I have attached. They would also like unit cost rates per service included based on 500k merchants per month. It may be closer to 750k and even 1M for certain months, but they'd like to use 500k as the baseline. My assumption is that we need something much more custom for this situation.

 1. Renewal (exiting services - G2+EC): We also need to get them paperwork for a flat renewal option on their current services. Volume may go up on PMM but at a minimum, they need a flat renewal option now to start engaging procurement. I do not under any circumstances expect this to be the final version. I will connect with Legal separately on this piece.

 1.
Usage: @Sarah Craven<mailto:sarah.craven@g2risksolutions.com> They asked for another update on usage estimates for the one-time project. Is the picture clearer now that we've run some of the batches? I modeled out estimated usage, but it was only based on the first batch. What's the probable range for TLD now?

 1. Delivery

 * API docs: Tomorrow
 * Onboarding opportunity deck + pricing: Thursday
 * Flat renewal option paper: Thursday
 * Updated usage estimate: Tomorrow

I'd like to connect on a call ASAP to discuss further.

Thank you,

John

John Hughes

Strategic Accounts Director

P: +1 914-466-2566
Eastern Time Zone
Website<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vZzJyaXNrc29sdXRpb25zLmNvbS8iLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoidkNIMWh1TFhpR3BFIn0.nsMyVWsqX-v7iCXW-681Ym8iH1AmJHlvETCWRXe4abg> | LinkedIn<https://us-70319.et.gong.io/email-tracking/clicked?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwibGlua1VybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2cyLXJpc2stc29sdXRpb25zL3Bvc3RzLz9mZWVkVmlldz1hbGwiLCJsaW5rVGV4dCI6IiIsInRlbXBsYXRlSWQiOiIiLCJleHAiOjE3OTM3MzkzOTUsImlhdCI6MTc5MTkyNDk5NSwianRpIjoid1RoVFJuUkRjVHUvIn0.hNEOa6d19DKo08BbUn8djKzf0X1lIh0Wo-anD-lGwug>

[cid:efb39df0-7b95-408b-8f11-730b1ef6036e]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

[https://us-70319.et.gong.io/email-tracking/open?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFESk56VnJBQUE9IiwiZXhwIjoxNzkzNjU1Mjg3LCJpYXQiOjE3OTE4NDA4ODcsImp0aSI6IkdmVVBpOVlZYXNYZSJ9.o8lpzZNhEVXfEdXelv1RxlDrPsTfBxdk4VAJZGSTS5s]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

[https://us-70319.et.gong.io/email-tracking/open?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRDlBQUE9IiwiZXhwIjoxNzkzNzExNTI5LCJpYXQiOjE3OTE4OTcxMjksImp0aSI6ImFpaG1TV3E4UlcxcCJ9.mNJ5-F3PwtnFoGLkyRjpGfkzJJdwWBxhprS90m9dun4]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

[https://us-70319.et.gong.io/email-tracking/open?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRF9BQUE9IiwiZXhwIjoxNzkzNzEyNDI1LCJpYXQiOjE3OTE4OTgwMjUsImp0aSI6InZCTFBGbWxlZ2JWRyJ9.B8x_4QPPag3Mbmy2wci31Dyl-i3B-NKjgsiEDfcXGyc]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.
[https://us-70319.et.gong.io/email-tracking/open?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRURBQUE9IiwiZXhwIjoxNzkzNzMxMjU0LCJpYXQiOjE3OTE5MTY4NTQsImp0aSI6ImlOb1dBQytwSU8vOCJ9.jTicdmT6n7fEiqkM70KMYOMLt8WnsE6thFujvuip2Tw]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.
[https://us-70319.et.gong.io/email-tracking/open?email-info-token=eyJhbGciOiJIUzI1NiJ9.eyJjb21wYW55SWQiOiIyNjc2MzU1MTQyMDk3NDM4NzE5IiwiZHJhZnRJZCI6IkFBTWtBR1l5T1RnNFpXRmlMV0kyTWpZdE5EUmxNQzA1TVRZekxUTTBOVE5qTldRMVpUWTJOQUJHQUFBQUFBQXQyeHI0ckl6U1RwV0t3Y2VxbkFhLUJ3RC11Qi1YTzZqZVFMYWNiUGFhMU1XaUFBQUFBQUVQQUFELXVCLVhPNmplUUxhY2JQYWExTVdpQUFES0pqRUdBQUE9IiwiZXhwIjoxNzkzNzM5Mzk1LCJpYXQiOjE3OTE5MjQ5OTUsImp0aSI6Ik52MlBHRWJUQyt5VyJ9.WQ_bKod-6DLVr42OO1BREs0aI7ozOV_FpT7m_-88-eI]

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.

________________________________

This email including, without limitation, its attachments (if any) may contain information that is confidential and/or privileged and exempt from disclosure under applicable law. The information is only for the use of the intended recipient. If you are not the intended recipient, please be aware that any disclosure, copying, distribution, review, or use of the contents of this email and/or its attachments (if any) is without authorization and is strictly prohibited. If you have received this email in error, please notify the sender immediately by reply email and destroy all copies of this email and its attachments. We are committed to protecting European Union residents' personal data in accordance with the General Data Protection Regulation (EU) 2016/679 (GDPR) and applicable data protection laws. For more information, please refer to our Privacy Policy.
