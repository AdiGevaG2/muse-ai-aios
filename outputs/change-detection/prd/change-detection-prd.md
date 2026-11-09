# PRD: Change Detection

## Document Metadata

| Field | Value |
| --- | --- |
| Feature | Change Detection |
| Product Area | Monitoring |
| Release | MVP: M0 to M2, Visualping parity |
| Owner | TBD |
| Status | Draft |
| Version | v1 |
| Date | 2026-10-20 |

## Executive Summary

G2RS runs Change Detection, a $1.15M revenue line at about 70% gross margin, on Visualping. Visualping costs $140K a year and now markets content-compliance monitoring that overlaps with G2RS's core business, built partly on G2RS analysts' engagement with it. G2RS will stop using Visualping when the contract ends in September 2027.

The MVP replaces Visualping with an in-house capability that G2RS analysts and clients can use in its place. G2RS monitors each enrolled merchant's pages on a daily, weekly, monthly or quarterly cadence and captures screenshot evidence for every detected change. Analysts review changes in a queue, remove false positives and edit the significance note. The reviewed changes reach the client as the Excel report the client receives today.

This PRD covers M0 foundations, M1 monitoring and evidence, and M2 analyst review and client delivery. Configurable monitoring profiles and Atlas component integration follow later, and the foundations are built so those phases reuse them rather than rebuild them.

## Problem Statement

| Area | Description |
| --- | --- |
| Current gap | G2RS has no change-detection capability of its own. Every monitored page, comparison and screenshot comes from Visualping, with no integration into G2RS systems. |
| User pain points | Analysts carry about seven types of client-specific reporting rules in their heads and apply them by hand. Site-health and control-presence checks run as manual monthly walkthroughs. |
| Business impact | $140K a year to a vendor that now competes with G2RS. Visualping bills per page, so G2RS monitors individual pages, not whole domains. The monitored unit does not match the billed unit; right-sizing the Cliq account to match cut it by about 67% at renewal. |
| Risk if unsolved | Change Detection revenue has no delivery path after the Visualping contract ends in September 2027, and G2RS keeps feeding its use cases to a competitor until then. |
| Evidence | Change Detection Q4 Planning doc (`sources/change-detection-q4-planning.md`); meeting transcript excerpt 0:45 to 1:24 (`sources/change-detection-architecture-meeting-transcript.md`); `domains/atlas/second-brain/ingestion/crawler-capability-gaps.md` on per-page pricing. |

## Goals

- Retire Visualping by September 2027 with no gap in Change Detection delivery to clients.
- Give analysts one place to review, remove and annotate detected changes, with evidence attached to each one.
- Build page sources, the change record and evidence so M3 profiles and M4 Atlas consumers reuse them.

**Why we need it:** Change Detection is a $1.15M revenue line that depends on one vendor who now competes with G2RS. Owning the capability removes the $140K vendor cost and stops sharing G2RS use cases with that vendor.

**Value for the client:** The client receives the same Excel report tabs, with current and previous full-page screenshots for every change and the changed regions highlighted where G2RS can locate them.

**Why now:** The Visualping contract ends in September 2027. Daniel's change-detection POC on the Crolex Watcher produced results the team described as successful and promising.

## Assumptions

- The Atlas core pipeline provides page-type classification for refund and returns, shipping, privacy, contact, T&C and payment pages. M0 validates this against the page types today's reports cover.
- PLRC supplies product collection and product detail pages, and Change Detection does not build its own product extraction. M0 validates coverage.
- Clients keep receiving Change Detection through Excel on the SP File Share until they migrate to Atlas.
- The Crolex Watcher POC's two comparison modes, page text and HTML comparison plus full-page screenshot comparison, are a starting point for the engine. Change detection was not live as of the source session (`crolex.md`).

## Target Personas

| Persona | Description |
| --- | --- |
| G2RS analyst | Enrolls merchants, reviews detected changes, removes false positives, edits the significance note and releases changes to the client. Today does this work in the Visualping UI and in spreadsheets. |
| G2RS Ops | Delivers the Excel report to the client through the SP File Share. |
| Client | Has registered for Change Detection on a set of merchants. Receives the reviewed report and acts on the changes in it. |

### Client reporting types

Clients ask for Change Detection reporting in one of four ways today:

1. Report all changes, as G2RS does today, monitoring up to 300 pages per site under the client's contract.
2. Report only changes in areas the client cares about, such as policy pages.
3. Report changes on pages the client chose.
4. Types 2 and 3 together.

## Scope

### In Scope - MVP

**M0: Foundations, decisions and benchmarks, by November 15, 2026**

- Benchmarks for throughput, model cost, false-negative rate, anti-bot handling and fleet operations, and the stack decision they inform.
- Confirmation of which page types Atlas and PLRC supply, and which page types need a new source.
- A rule catalog that classifies every client-specific reporting requirement by rule type.
- The change event contract, which defines the record a detected change produces for any consumer.

**M1: Core monitoring engine and screenshot evidence**

- Merchant enrollment through Atlas: add, remove, and reconcile enrolled merchants against the client's submitted list.
- A daily, weekly, monthly or quarterly cadence set per monitor. Quarterly runs in January, April, July and October.
- Baseline capture: a monitor's first scan produces no change; its second scan produces the first comparison.
- Page sources from Atlas, with added filtering where Atlas sources return pages outside the monitored scope.
- Screenshot evidence for every detected change: current and previous full-page captures, with changed regions highlighted where G2RS can locate them, and the unmarked pair where it cannot. Every capture carries a timestamp and a fingerprint that shows the capture was not altered after it was taken.

**M2: Analyst workflow and client delivery, by February 2027**

- A review queue of detected changes per client, filterable by change type.
- Side-by-side current and previous text next to the screenshot evidence.
- One-action removal of a change as a false positive, with a reason. A removed change is excluded from the client export and recorded with its reason.
- Editing the significance note before a change is released to the client.
- Releasing reviewed changes to the client. A released change leaves the review queue, is included in the client's next export and can no longer be removed or edited.
- Excel export with the current report tabs: change report with URL, current text, previous text, note and screenshot evidence; merchant list; and newly identified URLs.
- Export delivery to the client through the SP File Share, run by Ops.

### Out of Scope

- Configurable monitoring profiles and the seven rule types: page-type scope, numeric thresholds, catalog-aware logic, watchlists, exclusions, site-health signals and control presence. Planned for M3.
- Profile-aware exports, such as catalog trend summaries for large sites. Depends on M3.
- Site-health and control-presence checks. These need their own capture logic and are planned with M3.
- Atlas components consuming change events: Business Policies mismatch flag, Policy Analysis and UaaS re-triggers, Content Classification with PLRC, and marketing content. Planned for M4.
- Client self-serve selection of page types or product URLs.
- Changes to Change Detection pricing or the billing unit.

## User Journeys

### Primary Journey

1. An analyst enrolls a client's merchants in Atlas from the client's submitted list and sets each monitor's cadence.
2. G2RS takes the baseline capture for each monitored page on its first scan and reports nothing.
3. On each later scan, G2RS compares the page with its previous capture and records each detected change with its current and previous text and screenshots.
4. The analyst opens the client's review queue, filters by change type and compares the text and screenshots side by side.
5. The analyst removes each false positive with a reason, and edits the significance note on each change that stays.
6. The analyst releases the reviewed changes, and G2RS generates the Excel export from the released changes.
7. Ops delivers the export to the client through the SP File Share.
8. G2RS keeps each removal and its reason, and every capture with its timestamp and fingerprint.

<!-- diagram: change-detection-prd-primary-journey.drawio.svg -->

<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="518" height="1192" viewBox="0 0 518 1192" content="&lt;mxfile host=&quot;app.diagrams.net&quot; agent=&quot;pm-workflow&quot; version=&quot;24.0.0&quot; type=&quot;device&quot;&gt;&lt;diagram id=&quot;flow&quot; name=&quot;Flow&quot;&gt;&lt;mxGraphModel dx=&quot;518&quot; dy=&quot;1192&quot; grid=&quot;1&quot; gridSize=&quot;10&quot; guides=&quot;1&quot; tooltips=&quot;1&quot; connect=&quot;1&quot; arrows=&quot;1&quot; fold=&quot;1&quot; page=&quot;1&quot; pageScale=&quot;1&quot; pageWidth=&quot;850&quot; pageHeight=&quot;1100&quot; math=&quot;0&quot; shadow=&quot;0&quot; background=&quot;none&quot;&gt;&lt;root&gt;&lt;mxCell id=&quot;0&quot; /&gt;&lt;mxCell id=&quot;1&quot; parent=&quot;0&quot; /&gt;&lt;mxCell id=&quot;n2&quot; value=&quot;Analyst enrolls merchants and sets cadence&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#D5E8D4;strokeColor=#82B366;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;24&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n3&quot; value=&quot;First scan: baseline capture, no report&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;124&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n4&quot; value=&quot;Later scan: compare with previous capture&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;224&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n5&quot; value=&quot;Change detected?&quot; style=&quot;rhombus;whiteSpace=wrap;html=1;fillColor=#FFF2CC;strokeColor=#D6B656;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;324&quot; width=&quot;220&quot; height=&quot;100&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n6&quot; value=&quot;Record change with text and screenshot evidence&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;468&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n7&quot; value=&quot;Analyst reviews change in queue&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;568&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n8&quot; value=&quot;False positive?&quot; style=&quot;rhombus;whiteSpace=wrap;html=1;fillColor=#FFF2CC;strokeColor=#D6B656;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;668&quot; width=&quot;220&quot; height=&quot;100&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n9&quot; value=&quot;Remove with reason; excluded from export&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#DAE8FC;strokeColor=#6C8EBF;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;812&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n10&quot; value=&quot;Edit significance note&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;284&quot; y=&quot;812&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n11&quot; value=&quot;Analyst releases change&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;912&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n12&quot; value=&quot;Excel export generated&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;1012&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;n13&quot; value=&quot;Ops delivers export via SP File Share&quot; style=&quot;rounded=0;whiteSpace=wrap;html=1;fillColor=#DAE8FC;strokeColor=#6C8EBF;fontColor=#1a1a1a;&quot; vertex=&quot;1&quot; parent=&quot;1&quot;&gt;&lt;mxGeometry x=&quot;24&quot; y=&quot;1112&quot; width=&quot;210&quot; height=&quot;56&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e0&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n2&quot; target=&quot;n3&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e1&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n3&quot; target=&quot;n4&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e2&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n4&quot; target=&quot;n5&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e3&quot; value=&quot;No&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n5&quot; target=&quot;n4&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e4&quot; value=&quot;Yes&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n5&quot; target=&quot;n6&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e5&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n6&quot; target=&quot;n7&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e6&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n7&quot; target=&quot;n8&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e7&quot; value=&quot;Yes&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n8&quot; target=&quot;n9&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e8&quot; value=&quot;No&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n8&quot; target=&quot;n10&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e9&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n10&quot; target=&quot;n11&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e10&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n11&quot; target=&quot;n12&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;mxCell id=&quot;e11&quot; value=&quot;&quot; style=&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#333333;fontColor=#333333;endArrow=block;&quot; edge=&quot;1&quot; parent=&quot;1&quot; source=&quot;n12&quot; target=&quot;n13&quot;&gt;&lt;mxGeometry relative=&quot;1&quot; as=&quot;geometry&quot; /&gt;&lt;/mxCell&gt;&lt;/root&gt;&lt;/mxGraphModel&gt;&lt;/diagram&gt;&lt;/mxfile&gt;">
<defs><marker id="arrow" markerWidth="10" markerHeight="10" refX="8" refY="3" orient="auto" markerUnits="strokeWidth"><path d="M0,0 L8,3 L0,6 z" fill="#333333"/></marker></defs>
<line x1="129" y1="80" x2="129" y2="124" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<line x1="129" y1="180" x2="129" y2="224" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<line x1="130" y1="280" x2="132" y2="325" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<line x1="132" y1="325" x2="130" y2="280" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<rect x="122" y="293" width="19" height="14" fill="none"/><text x="131" y="305" font-family="Helvetica,Arial,sans-serif" font-size="11" fill="#333333" text-anchor="middle">No</text>
<line x1="132" y1="423" x2="130" y2="468" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<rect x="118" y="437" width="25" height="14" fill="none"/><text x="131" y="449" font-family="Helvetica,Arial,sans-serif" font-size="11" fill="#333333" text-anchor="middle">Yes</text>
<line x1="129" y1="524" x2="129" y2="568" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<line x1="130" y1="624" x2="132" y2="669" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<line x1="132" y1="767" x2="130" y2="812" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<rect x="118" y="781" width="25" height="14" fill="none"/><text x="131" y="793" font-family="Helvetica,Arial,sans-serif" font-size="11" fill="#333333" text-anchor="middle">Yes</text>
<line x1="188" y1="744" x2="330" y2="812" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<rect x="250" y="769" width="19" height="14" fill="none"/><text x="259" y="781" font-family="Helvetica,Arial,sans-serif" font-size="11" fill="#333333" text-anchor="middle">No</text>
<line x1="316" y1="868" x2="202" y2="912" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<line x1="129" y1="968" x2="129" y2="1012" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<line x1="129" y1="1068" x2="129" y2="1112" stroke="#333333" stroke-width="1.5" marker-end="url(#arrow)"/>
<rect x="24" y="24" width="210" height="56" rx="6" ry="6" fill="#D5E8D4" stroke="#82B366" stroke-width="1.5"/>
<text x="129" y="48" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Analyst enrolls merchants</text>
<text x="129" y="64" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">and sets cadence</text>
<rect x="24" y="124" width="210" height="56" rx="6" ry="6" fill="#E1D5E7" stroke="#9673A6" stroke-width="1.5"/>
<text x="129" y="148" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">First scan: baseline</text>
<text x="129" y="164" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">capture, no report</text>
<rect x="24" y="224" width="210" height="56" rx="6" ry="6" fill="#E1D5E7" stroke="#9673A6" stroke-width="1.5"/>
<text x="129" y="248" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Later scan: compare with</text>
<text x="129" y="264" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">previous capture</text>
<polygon points="134,324 244,374 134,424 24,374" fill="#FFF2CC" stroke="#D6B656" stroke-width="1.5"/>
<text x="134" y="378" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Change detected?</text>
<rect x="24" y="468" width="210" height="56" rx="6" ry="6" fill="#E1D5E7" stroke="#9673A6" stroke-width="1.5"/>
<text x="129" y="492" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Record change with text</text>
<text x="129" y="508" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">and screenshot evidence</text>
<rect x="24" y="568" width="210" height="56" rx="6" ry="6" fill="#E1D5E7" stroke="#9673A6" stroke-width="1.5"/>
<text x="129" y="592" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Analyst reviews change in</text>
<text x="129" y="608" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">queue</text>
<polygon points="134,668 244,718 134,768 24,718" fill="#FFF2CC" stroke="#D6B656" stroke-width="1.5"/>
<text x="134" y="722" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">False positive?</text>
<rect x="24" y="812" width="210" height="56" rx="6" ry="6" fill="#DAE8FC" stroke="#6C8EBF" stroke-width="1.5"/>
<text x="129" y="836" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Remove with reason;</text>
<text x="129" y="852" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">excluded from export</text>
<rect x="284" y="812" width="210" height="56" rx="6" ry="6" fill="#E1D5E7" stroke="#9673A6" stroke-width="1.5"/>
<text x="389" y="844" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Edit significance note</text>
<rect x="24" y="912" width="210" height="56" rx="6" ry="6" fill="#E1D5E7" stroke="#9673A6" stroke-width="1.5"/>
<text x="129" y="944" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Analyst releases change</text>
<rect x="24" y="1012" width="210" height="56" rx="6" ry="6" fill="#E1D5E7" stroke="#9673A6" stroke-width="1.5"/>
<text x="129" y="1044" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Excel export generated</text>
<rect x="24" y="1112" width="210" height="56" rx="6" ry="6" fill="#DAE8FC" stroke="#6C8EBF" stroke-width="1.5"/>
<text x="129" y="1136" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">Ops delivers export via SP</text>
<text x="129" y="1152" font-family="Helvetica,Arial,sans-serif" font-size="13" fill="#1a1a1a" text-anchor="middle">File Share</text>
</svg>

## Acceptance Criteria

### AC-001: Enroll merchants from a client's submitted list

**As a** G2RS analyst
**I want to** enroll a client's merchants in Atlas from the list the client submitted
**So that** G2RS monitors the merchants the client registered for

```gherkin
Given a client has submitted a list of merchants for Change Detection
When the analyst enrolls the merchants in Atlas and sets a cadence for each monitor
Then each merchant appears on the client's merchant list with its cadence
And the next export's merchant list tab shows the same merchants
```

### AC-002: Reconcile enrollment against an updated client list

**As a** G2RS analyst
**I want to** see the difference between enrolled merchants and the client's latest list
**So that** G2RS does not monitor merchants the client dropped or miss merchants the client added

```gherkin
Given a client's enrolled merchants differ from the client's latest submitted list
When the analyst runs reconciliation for that client
Then Atlas lists each merchant on the submitted list that is not enrolled
And lists each enrolled merchant that is not on the submitted list
And no enrollment changes until the analyst adds or removes the merchant
```

### AC-003: First scan sets the baseline

**As a** G2RS analyst
**I want** a new monitor's first scan to set the baseline
**So that** the client does not receive changes with nothing to compare against

```gherkin
Given a page is monitored and has never been scanned
When its first scheduled scan completes
Then G2RS stores the capture as the baseline
And no change for that page appears in the review queue
```

### AC-004: Second scan produces the first comparison

**As a** G2RS analyst
**I want** each later scan compared with the previous capture
**So that** I see what changed since the last scan

```gherkin
Given a page has a baseline capture
When the next scheduled scan finds content that differs from the baseline
Then the change appears in the client's review queue
And it shows the current text, the previous text, and the current and previous full-page screenshots
```

### AC-005: Monitors run on their set cadence

**As a** G2RS analyst
**I want** each monitor to run on the cadence I set
**So that** each client is monitored at the frequency it registered for

```gherkin
Given a monitor has a daily, weekly, monthly or quarterly cadence
When the cadence period ends
Then G2RS scans the monitored pages for that monitor
And the scan time is recorded on each capture
```

### AC-006: Screenshot evidence with highlighted regions

**As a** client
**I want** to see where a page changed
**So that** I can check the change without opening the merchant's site

```gherkin
Given a detected change whose changed regions G2RS can locate
When the analyst opens the change
Then the current and previous full-page screenshots are shown
And the changed regions are highlighted on the screenshots
```

### AC-007: Screenshot evidence when regions cannot be located

**As a** G2RS analyst
**I want** the screenshots shown even when G2RS cannot locate the changed region
**So that** every change still carries evidence

```gherkin
Given a detected change whose changed regions G2RS cannot locate
When the analyst opens the change
Then the current and previous full-page screenshots are shown with no highlighting
```

### AC-008: Captures stand as evidence

**As a** G2RS analyst
**I want** each capture to carry a timestamp and fingerprint
**So that** a client or regulator can trust the capture was not altered

```gherkin
Given a capture is stored for a monitored page
When the capture is opened later
Then the capture shows the time it was taken
And its fingerprint matches the fingerprint recorded when it was taken
```

### AC-009: Review and filter the queue

**As a** G2RS analyst
**I want to** filter a client's review queue by change type
**So that** I review one kind of change at a time

```gherkin
Given a client's review queue holds changes of several change types
When the analyst filters by one change type
Then only changes of that type are listed
And clearing the filter lists all of the client's unreleased changes
```

### AC-010: Empty review queue

**As a** G2RS analyst
**I want to** know when a client has no changes to review
**So that** I do not wait on a queue with nothing in it

```gherkin
Given no change was detected for a client since the last release
When the analyst opens that client's review queue
Then the queue states that there are no changes to review
And shows the time of the client's most recent scan
```

### AC-011: Remove a false positive with a reason

**As a** G2RS analyst
**I want to** remove a change as a false positive and record why
**So that** the client does not receive it and G2RS learns from the removal

```gherkin
Given an unreleased change in a client's review queue
When the analyst removes it as a false positive and selects a reason
Then the change leaves the review queue
And the change is excluded from the client's export
And the removal is stored with its reason, the analyst and the time
```

### AC-012: Removal requires a reason

**As a** G2RS analyst
**I want** removal blocked until I give a reason
**So that** every removal can be used to improve detection

```gherkin
Given an unreleased change in a client's review queue
When the analyst tries to remove it as a false positive without a reason
Then the change is not removed
And the analyst is told a reason is required
```

### AC-013: Edit the significance note before release

**As a** G2RS analyst
**I want to** edit the significance note on a change
**So that** the client reads why the change matters

```gherkin
Given an unreleased change in a client's review queue
When the analyst edits its significance note and saves
Then the change shows the edited note
And the client's export shows the edited note for that change
```

### AC-014: Released changes are locked

**As a** client
**I want** the report I receive to match what the analyst released
**So that** I act on the reviewed version

```gherkin
Given a change was released to the client
When an analyst tries to remove it or edit its note
Then the change and its note stay unchanged
```

### AC-015: Generate the Excel export

**As a** G2RS Ops member
**I want** an Excel export with the current report tabs
**So that** the client receives the report in the format it uses today

```gherkin
Given a client has released changes for the reporting period
When the export is generated
Then it contains a change report tab with URL, current text, previous text, note and screenshot evidence for each released change
And a merchant list tab with the client's enrolled merchants
And a newly identified URLs tab
And it contains no change removed as a false positive
```

### AC-016: Export with no released changes

**As a** G2RS Ops member
**I want** an export generated when a client has no released changes
**So that** the client still receives the merchant list and newly identified URLs

```gherkin
Given a client has no released changes for the reporting period
When the export is generated
Then the change report tab states that no changes were reported for the period
And the merchant list and newly identified URLs tabs are filled
```

### AC-017: Scan failure on a monitored page

**As a** G2RS analyst
**I want to** know when a monitored page could not be captured
**So that** I do not read a missing scan as no change

```gherkin
Given a monitored page cannot be captured on a scheduled scan
When the scan for that page fails
Then no change is recorded for that page
And the previous capture stays the comparison point for the next scan
And the failure is shown to the analyst with the page URL and the scan time
```

### AC-018: Access to the review queue

**As a** G2RS analyst
**I want** the review queue limited to G2RS staff
**So that** clients see only released changes

```gherkin
Given an Atlas sign-in without G2RS analyst access
When a client's review queue is requested from that sign-in
Then access is denied
And no unreleased change is shown
```

## Permissions, Roles, and Visibility

| Action / Capability | Role | Access | Notes |
| --- | --- | --- | --- |
| Enroll, remove and reconcile merchants | G2RS analyst | Allowed | |
| Set a monitor's cadence | G2RS analyst | Allowed | Daily, weekly, monthly or quarterly |
| Open the review queue and evidence | G2RS analyst | Allowed | |
| Remove a change as a false positive | G2RS analyst | Allowed | Reason required |
| Edit the significance note | G2RS analyst | Allowed | Before release only |
| Release changes | G2RS analyst | Allowed | |
| Generate and deliver the export | G2RS Ops | Allowed | Delivery through the SP File Share |
| Open the review queue | Client | Denied | The client receives released changes in the export |

## Prototype

N/A - no prototype

## UX and Product Behavior

### Prerequisites

- The client has registered for Change Detection and submitted its merchant list.
- Atlas supplies page sources for the client's monitored page types.

### Requirements

| Area | Requirement |
| --- | --- |
| Entry point | The analyst opens Change Detection in Atlas and selects a client to reach its review queue and merchant list. |
| Main action | The analyst reviews each unreleased change, removes false positives with a reason, edits the significance note and releases the rest. |
| Empty state | A client with no unreleased changes shows that there are no changes to review and the time of its most recent scan. |
| Error state | A page that cannot be captured shows the page URL and scan time to the analyst; the previous capture stays the comparison point. |
| Success state | Released changes appear in the next export, and removed changes do not. |
| Notifications / communication | Ops delivers the export to the client through the SP File Share. |
| Accessibility / usability | Current and previous text sit side by side with the screenshot evidence for the same change. |

## Data and Analytics

### Current Data

#### Mixpanel

N/A - Change Detection runs on Visualping, and G2RS has no events for it. Monitor volumes come from Visualping.

| Surface / Flow | Coverage | Usage (90-day) | Top Clients |
| --- | --- | --- | --- |
| Change Detection on Visualping | N/A - not instrumented in G2RS | N/A - not instrumented in G2RS | By merchant count: NAB 6,494, Paynovus 962, Valmar 581, ING Romania 556, Cliq 370 |

> _*Source:* [Merchant and cadence breakdown](../sources/slack-files/2026-10-28-merchant-and-cadence-breakdown.xlsx), October 1, 2026._

#### Current clients and cadence

23 clients, one of them stopped, and 10,350 merchants were on Change Detection on October 1, 2026. Counts are merchants, not monitored pages.

> _*Source:* [Merchant and cadence breakdown](../sources/slack-files/2026-10-28-merchant-and-cadence-breakdown.xlsx), provided by Margo through Sarah Craven on October 28, 2026. Totals per cadence are summed from the sheet._

| Cadence | Clients | Merchants |
| --- | --- | --- |
| Daily | 3 | 6,600 |
| Weekly, Fridays | 4 | 476 |
| Monthly, mid-month | 2 | 661 |
| Monthly, end of month | 13 | 2,553 |
| Quarterly, January, April, July, October | 1 | 60 |
| **Total** | **23** | **10,350** |

| Client | Cadence | Merchants |
| --- | --- | --- |
| Glacier Payments | Daily | 85 |
| NAB, North American Bancard, Specialty Markets | Daily | 6,494 |
| Paynovate (Loyaltek) | Daily | 21 |
| Cliq, Inc. | Weekly, Fridays | 370 |
| Cospay Limited, Cardaq | Weekly, Fridays | 65 |
| Merchant E | Weekly, Fridays | 41 |
| Pixxles | Weekly, Fridays | 0, waiting on client data |
| Fibonatix | Monthly, mid-month | 80 |
| Valmar Merchant Services | Monthly, mid-month | 581 |
| Axos | Monthly, end of month | 206 |
| Banka Credins | Monthly, end of month | 91 |
| Complete Merchant Solutions, dba Nexio | Monthly, end of month | 15 |
| ING Romania | Monthly, end of month | 556 |
| Marqeta | Monthly, end of month | 152 |
| North American Banking Company | Monthly, end of month | Not counted, service stopped for non-payment |
| Paynetics EAD | Monthly, end of month | 111 |
| Paynovus | Monthly, end of month | 962 |
| TabaPay, Inc., three lists | Monthly, end of month | 321 |
| Viking Service | Monthly, end of month | 76 |
| VPO | Monthly, end of month | 42 |
| Steven AB | Monthly, end of month | 8 |
| Uspex (Lancelot Pay LTD) | Monthly, end of month | 13 |
| Fiserv (First Data USA) | Quarterly | 60 |

### Success Metrics

#### **Objective (OKR)**

> Change Detection runs on G2RS's own capability and Visualping is retired by September 2027.
> _*Note:* Targets are initial estimates and will be recalibrated after 30 days of post-launch data._

#### **KPIs**

##### **Primary Metric: Clients delivered from the in-house capability**
- **Baseline:** 0
- **Target:** Every client with Change Detection
- **Timeline:** Before the Visualping contract ends in September 2027

##### **Secondary Metric: Share of detected changes removed as false positives**
- **Baseline:** TBD
- **Target:** TBD
- **Timeline:** TBD

##### **Guardrail Metric: Changes Visualping reported that G2RS missed**
- **Baseline:** TBD, set by the M0 false-negative benchmark
- **Maximum Allowed:** TBD
- **Timeline:** Ongoing from the first client moved off Visualping

### Required Events / Signals

| Event / Signal | Trigger | Key Properties | Purpose | Required for MVP |
| --- | --- | --- | --- | --- |
| Change detected | A scan finds a difference from the previous capture | Client, merchant, page URL, change type, scan time | Queue volume and change-type mix | Yes |
| Change removed as false positive | Analyst removes a change | Client, change type, reason, analyst, time | False-positive share and detection tuning | Yes |
| Significance note edited | Analyst saves an edited note | Client, change, analyst, time | Analyst effort per change | Yes |
| Change released | Analyst releases a change | Client, change type, analyst, time | Released volume per client | Yes |
| Export generated | Export is produced for a client | Client, period, released change count | Delivery tracking | Yes |
| Scan failed | A monitored page cannot be captured | Client, merchant, page URL, scan time | Coverage gaps | Yes |

## Risks and Mitigations

| Risk | Why It Matters | Impact | Likelihood | Mitigation |
| --- | --- | --- | --- | --- |
| No persistent storage for crawled content | Comparing with a previous capture requires keeping it. Elasticsearch on CSX holds content only temporarily (`crawler-consolidation.md`, `crawler-capability-gaps.md`). | H | H | Settle capture storage in the M0 stack decision. |
| Raw comparisons flag every page | Most sites return different content on every fetch, so the share of pages a raw comparison flags says nothing and filtering irrelevant changes was unsolved in the POC (`crolex.md`). | H | H | Benchmark false positives in M0; feed analyst removals with reasons back into detection. |
| G2RS misses changes Visualping reports | A missed change is a compliance gap for the client. | H | M | Run the M0 false-negative benchmark against Visualping output on the same pages. |
| Undocumented analyst shortcuts in Visualping | Analysts may rely on Visualping features this PRD does not list. | M | M | Walk through the Visualping portal with Margo before M2 scope is final. |
| Anti-bot blocking | A page G2RS cannot fetch produces no evidence. | M | M | M0 anti-bot benchmark; scan failures are shown to the analyst. |
| Schedule | M0 is due November 15, 2026, and the vendor exit is September 2027. | H | M | Keep M3 and M4 off the vendor-exit path. |

## Open Questions

| Question | Owner | Needed Before | Priority | Decision Type |
| --- | --- | --- | --- | --- |
| Confirm the M1 target date. The planning doc lists January 2026, which comes before M0's November 15, 2026 date. | Sarah Craven | PRD | H | Product |
| Confirm with Sarah Craven whether M3 monitoring profiles gate the vendor exit. The milestone table says no; the milestone summary says M0 to M3 deliver parity and calls Atlas integration M5. | Sarah Craven | PRD | H | Product |
| Confirm how analysts apply client-specific reporting rules between the vendor exit and M3. | TBD | Spec | H | Product |
| Check with Core whether an existing Core model can decide which differences between old and new HTML and screenshots are worth reporting, or whether a new model is needed. | Juan Martini | Spec | H | Engineering |
| Decide whether the Excel export embeds screenshot images or links to hosted evidence with the changed regions highlighted. | TBD | Spec | H | Product |
| Decide whether the client portal in Atlas shows released changes and exports at launch. | TBD | Spec | M | Product |
| Define the change types the review queue filters by. | TBD | Spec | H | Product |
| Define the reasons an analyst selects when removing a false positive. | TBD | Spec | M | Product |
| Check whether Visualping supports change severity and whether analysts use it. | TBD | Spec | M | Product |
| Check whether Visualping reports changes without a screenshot, and how G2RS reports them. | TBD | Spec | M | Product |
| Check whether Visualping history can be exported for historical purposes. | TBD | Launch | M | Data |
| Pull monitored page counts per client from Visualping. | TBD | Spec | H | Data |
| Decide which client reporting types the MVP supports, and whether type 1, report all changes, ends when current contracts end. | Sarah Craven | PRD | H | Product |
| Define the areas a type 2 client can choose, and who selects the pages for a type 3 client. | Sarah Craven | PRD | H | Product |
| Decide which run days the MVP keeps: Fridays for weekly, mid-month or end of month for monthly, and the run day for quarterly. | Sarah Craven | Spec | H | Product |
| Ask Margo to set the team up as Visualping users and walk through the analyst flow. | TBD | Spec | H | Product |
| Confirm the relationship to Jira GPM-37 and G2ENG-15038, "Change Detection Integration with Single Platform", which plans Change Detection in Single Platform while this PRD builds it in Atlas. | TBD | PRD | M | Product |
| Decide the billing unit: URL, page or page-type bundle, and whether the 300-pages-per-site cap becomes a per-client page budget. | TBD | M3 | M | Product |
| Decide whether page-type and product-URL selection are client self-serve in Atlas or G2RS-configured. | TBD | M3 | M | Product |
| Decide whether Policy Analysis and UaaS re-triggers are automatic or analyst-approved. | TBD | M4 | M | Product |
| Decide which Atlas component owns marketing content changes. | TBD | M4 | L | Product |

## Future Phases

| Phase | Purpose | Candidate Scope |
| --- | --- | --- |
| Phase 1 - MVP | Retire Visualping | M0 foundations, M1 monitoring and evidence, M2 analyst review and Excel delivery |
| Phase 2 - Fast Follow | Turn analyst-held client rules into configuration | M3: default profile from the User Guide's monitoring scope; page-type scope, numeric thresholds, catalog-aware logic, watchlists, exclusions; site-health and control-presence checks; profile-aware exports |
| Phase 3 - Expansion | Change signals feed other Atlas components | M4: Business Policies mismatch flag and new policy page identification, Policy Analysis and UaaS re-triggers behind a materiality gate, Content Classification with PLRC, marketing content |

## Evidence

- `outputs/change-detection/sources/change-detection-q4-planning.md`: business case, milestones, use case catalog, rule types, decisions needed and follow-ups.
- `outputs/change-detection/sources/change-detection-architecture-meeting-transcript.md`: vendor cost, contract end, POC status, Core model question, Visualping portal walkthrough.
- `outputs/change-detection/sources/slack-files/2026-10-28-merchant-and-cadence-breakdown.xlsx`: clients, merchant counts and cadence, including the quarterly cadence.
- `outputs/change-detection/sources/2026-11-05-slack-change-detection-channel.md`: client reporting types, October 27, 2026.
- `domains/atlas/second-brain/ingestion/crolex.md`: Watcher POC diff modes and status; no reliable change rate.
- `domains/atlas/second-brain/ingestion/crawler-capability-gaps.md`: per-page vendor pricing limits monitoring to individual pages; persistent storage dependency.
- `domains/atlas/second-brain/ingestion/crawler-consolidation.md`: no persistent storage for crawled content on CSX.
- `org-brain/ingestion/g2rs-merchant-risk-products.md`: Change Detection is listed both as a Monitoring product and as an add-on.
- The brains hold no feature note, hypothesis or decision for Change Detection. Confluence holds no Change Detection page for Atlas.
