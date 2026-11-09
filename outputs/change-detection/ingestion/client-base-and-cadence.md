# Client base and cadence

23 clients and 10,350 merchants are on Change Detection, per Margo's breakdown dated 2026-10-01. NAB Specialty Markets alone is 6,494 merchants, 63% of the total, all on daily cadence.

Source: `sources/slack-files/2026-10-28-merchant-and-cadence-breakdown.xlsx`, provided by Margo via Sarah Craven on 2026-10-28 [documented]. The sheet's date cell reads 2026-10-01. Counts are merchants, not pages or monitors. Totals below are summed from the sheet; the sheet itself gives only client counts per cadence.

## By cadence

| Cadence | Clients | Merchants |
|---|---|---|
| Daily | 3 | 6,600 |
| Weekly, Fridays | 4 | 476 |
| Monthly, mid-month | 2 | 661 |
| Monthly, end of month | 13 | 2,553 |
| Quarterly, January, April, July, October | 1 | 60 |
| **Total** | **23** | **10,350** |

## By client

| Cadence | Client | Merchants |
|---|---|---|
| Daily | Glacier Payments | 85 |
| Daily | NAB, North American Bancard, Specialty Markets | 6,494 |
| Daily | Paynovate (Loyaltek) | 21 |
| Weekly | Cliq, Inc. | 370 |
| Weekly | Cospay Limited, Cardaq | 65 |
| Weekly | Merchant E | 41 |
| Weekly | Pixxles | 0, waiting on client data |
| Monthly, mid | Fibonatix | 80 |
| Monthly, mid | Valmar Merchant Services | 581 |
| Monthly, end | Axos | 206 |
| Monthly, end | Banka Credins | 91 |
| Monthly, end | Complete Merchant Solutions, dba Nexio | 15 |
| Monthly, end | ING Romania | 556 |
| Monthly, end | Marqeta | 152 |
| Monthly, end | North American Banking Company | Not counted; service stopped for non-payment |
| Monthly, end | Paynetics EAD | 111 |
| Monthly, end | Paynovus | 962 |
| Monthly, end | TabaPay, Inc., three lists | 321 |
| Monthly, end | Viking Service | 76 |
| Monthly, end | VPO | 42 |
| Monthly, end | Steven AB | 8 |
| Monthly, end | Uspex (Lancelot Pay LTD) | 13 |
| Quarterly | Fiserv (First Data USA) | 60 |

The sheet's monthly total of 15 clients includes North American Banking Company, which is stopped.

## What this adds to the PRD

- **Quarterly cadence exists today.** Fiserv runs quarterly. The user guide and the PRD list daily, weekly and monthly only [documented]. A Visualping replacement at parity needs quarterly, or Fiserv moves cadence.
- **Monthly has two run dates.** Mid-month and end-of-month. The user guide describes end-of-month only.
- **Answers part of the PRD's open item to pull monitor volumes.** This gives merchant counts by cadence; page and monitor counts are still missing. At up to about 300 pages per site, daily volume is bounded by NAB's 6,494 merchants [inference].

## Related

- [[how-change-detection-runs-today]]
- [[client-reporting-exceptions]]: NAB, Glacier, TabaPay, Cliq, Fibonatix, Banka Credins, Paynovus, ING Romania and Complete Merchant Solutions all carry special rules.
