# Prototype section: link and screenshots

Used by `/prd`, `/mini-prd`, and `/publish`. Applies when the feature has a
prototype in `outputs/<feature-name>/prototype/`. If none exists, omit the
Prototype section.

## What the section contains

1. One link, with the text `Open prototype`, to the hosted prototype.
2. One screenshot per screen of the flow, in flow order, left-aligned with
   its caption. Each screenshot has a bold numbered caption naming the screen
   and its state, e.g.
   `**2. Lifecycle step, Onboarding selected**`. Include the entry point, every
   step of the happy path, at least one validation-error state, and the
   confirmation.
3. If the prototype has prototype-only controls (demo toggles, simulated
   states), one line saying they exist only in the prototype.

Markdown form:

```markdown
## Prototype

[Open prototype](<hosted link>)

**1. [Screen and state]**

<img src="../prototype/screenshots/01-<screen>.png" alt="1. Screen and state" width="<image pixel width>">
```

**Screenshot format, required for every screenshot in a doc:**
- A dashed, light grey border, 0.5pt, `#d0d5dd`, inside the PNG itself.
- Exported at 1x: the PNG's pixel width equals the width of the screen
  element on screen, for example 602px for the 600px wizard modal plus
  its border. Text in the screenshot then matches the doc's text size.

Set `width` to the image's pixel width. The final PNG is exported at 1x (see
step 7 below), so its text is the size it has on screen, close to the doc's
own text. Many markdown viewers ignore `width`, so a 2x PNG shows its text
larger than the doc's even with `width` set. The 1x export is what keeps
the size right.

## Capture the screenshots

Take them from the prototype itself, never from memory or Figma.

1. Install `playwright-core` in the scratchpad (not the repo) and launch the
   installed Chrome with `chromium.launch({ channel: 'chrome' })`.
2. Open the prototype HTML with a `file://` URL, viewport 1440 x 1400,
   `deviceScaleFactor: 2`.
3. Drive the flow by visible text and placeholders (`getByRole('button',
   { name })`, `getByPlaceholder`). Dump visible buttons and inputs first if
   the labels are unknown.
4. Screenshot the dialog or panel element, not the full page. For a menu or
   entry point, clip the region around it.
5. Fill forms with neutral sample data. Never use real customer data.
6. Save as `outputs/<feature-name>/prototype/screenshots/NN-<screen>.png`.
7. Export the final PNG at 1x with a dashed, light grey, 0.5pt border in it.
   Render the 2x capture in headless Chromium at `deviceScaleFactor: 1`, with
   the image at half its pixel width and `border:0.5pt dashed #d0d5dd`, then
   screenshot the element. Keep the 2x capture in the scratchpad.
8. Look at each image before using it.

## Host the prototype

Confluence Cloud does not open HTML attachments, so the `Open prototype` link
points to a hosted copy.

1. Before publishing, read the whole prototype file, or have a subagent read
   it end to end, and check it for credentials, personal data, network calls,
   and real company names. Report findings to the PM.
2. Publish it as a private Artifact. Republish the same file path to keep the
   URL on later changes.
3. Tell the PM the link stays private until they share it from the Artifact's
   Share menu.

Until the prototype is hosted, the link line reads `Open prototype: TBD,
hosted at publish`.

## In Confluence

Upload each screenshot as a page attachment and embed it inline as an image
(`media-single`) at a fixed pixel width equal to the image's pixel width,
never a percentage of the page, so its text matches the page text size. Left-aligned under its numbered caption with
`data-layout="align-start"`. Never center it. Make `Open prototype` a link to the hosted
copy. Do not use the HTML attachment's file card as the link: clicking it does
not open the prototype.
