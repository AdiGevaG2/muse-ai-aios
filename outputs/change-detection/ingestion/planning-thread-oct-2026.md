# Planning thread, October 2026

Engineering planning for the in-house engine ran in #change-detection from 2026-10-20. Juan Martini owns the delivery plan; the Jira initiative is G2ENG-24984, "Change Detection: In-house engine (Visualping replacement)". The architecture route depends on how much Horizon, Rocket and K9 can take on.

Source: `sources/2026-11-05-slack-change-detection-channel.md` [verbal] unless marked.

## People

- Juan Martini: engineering lead on the plan, Guardians team.
- Sarah Craven: product counterpart; holds the Q4 planning doc and the Margo relationship.
- Daniel Grech: wrote the integration architecture options; built a POC.
- Margo: analyst who runs the service today.
- Adi Geva: arranged the K9 meeting; Rocket takes the item with K9 (2026-10-25).
- Nicolis Scandolo, Ruben Muccilli, Matias Alessandri: joined 2026-11-04; Juan pointed them to the user guide and special reporting doc.

## Architecture options

Daniel Grech's Confluence page, "Change Detection Integration Architecture Options" (page 4389732419), lays out routes that depend on Horizon, Rocket and K9 availability. All end at Scenario 4; the others are intermediate steps. Juan proposed planning on Scenario S3, "Horizon assists", if the cross-team meeting slipped past the Q4 plan presentation on 2026-11-02. Further pages: "Change Detection Engine Architecture" (4401332225) and "Change Detection Delivery Plan" (4403363869). These pages were not read in this ingest.

## Client types

Juan proposed four client types on 2026-10-27; Sarah confirmed "that sounds right":

1. Report all changes, as today, crawling up to 300 pages by contract.
2. Report only changes in areas of interest, such as policy pages.
3. Report pages the client chose.
4. Types 2 and 3 together.

Juan asked whether type 1 ends when current contracts end, which would make it a parity-only path that CSX could serve. Sarah's reply does not answer that part. Open.

## Timeline signals

- Q4 plan presentation: Monday 2026-11-02.
- Cross-team meeting with K9 and Horizon: moved to 2026-11-03, then expected the week of 2026-11-02. Delivery plan to be adjusted after it.
- Gantt to be attached to the Q4 planning slides.

## Open items raised in the channel

- Does tab 3 report every new URL or only product and policy pages? With Margo.
- How much configuration does Visualping support? With Margo.
- Is report-all, type 1, kept after current contracts end?

## Related

- [[how-change-detection-runs-today]]
- [[client-reporting-exceptions]]: the "use cases" table Juan and Sarah refer to.
- `sources/change-detection-architecture-meeting-transcript.md`, `sources/change-detection-q4-planning.md`
