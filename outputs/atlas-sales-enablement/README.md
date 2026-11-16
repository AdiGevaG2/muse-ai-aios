# Atlas Sales Enablement - Instructions

Read this file before creating or changing anything in this folder.

## Background

Source: Slack thread between Adi Geva and Mary Claire Williams.

Sales and Customer Success need an Atlas account to demo to clients. The demo account must stay usable without ongoing support or fixes from development.

### Agreed

- **Baseline data.** The demo account holds generic data, uploaded to Sergey's organization. The data is the set Ron and Sandrine provided in the demo channel, plus 50 merchants from different countries and with different MCCs.
- **Reset to baseline.** A snapshot of the account's settings and data is saved as the baseline. The account resets to that snapshot every two weeks, so changes made during demos do not remain.
- **Demo users cannot add merchants.** Sales users get a dedicated role with no option to add new merchants.
- **No real runs.** Nobody in the demo account, including sales and Customer Success, runs data and gets results.

### Open

- Can demo users open the create merchant and upload merchant flows to show them to a client, with submit disabled? Read-only users can probably see the wizard but not submit; this is unconfirmed. Sergey is not sure how granular the permissions are. Adi asked Sergey for access to permit.io to find out.

## What this folder is

Guides that teach sales and Customer Success to use the Atlas Demo account for client demos.

## Demo environment

- URL: https://app.g2rs.ai/
- Account: **Atlas Demo**
- Portfolio: **General Portfolio**
- Confirmation a reader is in the right place: the top-right corner shows **Atlas Demo • General Portfolio**.
- Support contacts: Adi Geva (adi.geva@g2risksolutions.com), Alla Avgustinov (alla.avgustinov@g2risksolutions.com).

Never write credentials into any file in this folder.

## How to write a guide

- One task per file, named `how-to-<task>.md`.
- Title: `# How to <Task>`. One line under it saying what the reader will do.
- Numbered steps as `## Step N: <Action>`. One action per step.
- UI labels in bold, spelled exactly as they appear on screen.
- End each guide with the confirmation the reader is in the right place, then a **Need help?** section with the support contacts.
- Plain language for a sales reader. No product-team or developer terms.
- No em dash. Cut words the reader does not need.

## Screenshots

- Stored in `screenshots/`, named `NN-<screen>.png`, numbered across the folder in the order guides use them.
- Taken in the Atlas Demo account only.
- Every screenshot has a 0.5pt dashed light grey border, baked into the PNG.
- One screenshot per step that shows a new screen, placed under that step.

## Current guides

- [how-to-log-in-to-atlas.md](how-to-log-in-to-atlas.md) - sign in and open Atlas Demo.
