---
name: prototype
description: Build a design-system-accurate prototype, mockup, or UI screen for a G2RS feature from its PRD, following the g2rs-design-system repo and its build protocol, then file the build report back to the design repo. Use for "build a prototype", "mock up this screen", "make it look like the real product", "hi-fi prototype", or any G2RS UI that must match the design system. Not /wireframer or /lofi-wireframe, which are deliberately sketchy.
model: claude-opus-5-5
---

# Prototype

Always run on Opus 5.5 (`claude-opus-5-5`), including the design-review agent.

## Authority

The one design reference is the g2rs-design-system repo
(`evercompliant/g2rs-design-system`, default branch `master`). Every prototype,
mockup, or UI screen follows the colors, type, spacing, components, and
patterns it demonstrates. Read it before building anything. Never invent
styling it does not show.

Read it through the GitHub MCP used for the other evercompliant repos; no
separate connection is needed. If that MCP is unavailable, use the read-only clone at
`/Users/adig/vsCode/code-repos-git/g2rs-design-system`, pulled first when the
last pull is over 2 days old.

The repo is Dana Fridman's. It is read-only except for the two write-back paths
in step 5.

## Scope: the feature's journey only

Build only the screens this feature needs. Every prototype, in quick mode and
full builds, starts on the platform's first screen. The PM clicks through the
navigation path that leads to the feature, one screen at a time. From there,
every scenario in the PRD or request is a path the PM can click through in the
UI, step by step, including the states each scenario names. Each screen on the
path is complete, as the real screen is: every button, text, object,
container, banner, and the full layout. Only elements that are part of the
journey or a PRD scenario are clickable. Every other element, including other
navigation items, sidebars, buttons, tabs, filters, and links to other areas,
is shown but does nothing when clicked. Screens off the path are not built.

When the feature applies to some merchants and not others, the first 3
merchants on the list are the ones that have it. Every merchant after them
does not. Make another capability interactive only when the PM asks
for it.

## Quick mode: static or one-page prototypes

When the PM asks for a static prototype, a single page, or a quick concept
that is not built from a PRD, skip the full process:
- No PRD needed. Build from what the PM gave (screenshot, description).
- Do not read the build protocol, the token files, or the component docs.
  Match the PM's screenshot and use the design system's core values only:
  Inter, brand blue `#1447e6`, gray text `#181d27`/`#535862`, borders
  `#e9eaeb`/`#d5d7da`, 8px radius, and the badge colors seen in the screenshot.
- Keep the "Design not finalized" banner.
- No design review, no build report, no write-back to the design repo.
- Save to the scratchpad unless the PM names a feature folder.

The full steps below apply only when building a prototype from a PRD.

## Steps

1. **Locate the source.** The feature's `prd.md` in `outputs/<feature-name>/`.
   No PRD → stop and say so; a prototype is built from one.
2. **Read the protocol before building.** In the design repo, read
   `design-system/AGENT-BUILD-PROTOCOL.md` and
   `design-system/BUILD-REPORT-SUBMISSION-PROTOCOL.md` in full, then the
   `CONVENTIONS.md`, components, tokens, and patterns the screens need. The
   build protocol owns the build sequence, the strict-vs-permissive rule for
   gaps, the proposal route for a component that does not exist, and the
   mandatory non-dismissible "Design not finalized" banner. Follow it as
   written, except where this skill overrides it (see Overrides).
3. **Build.** Save the prototype in this repo, next to the PRD it was built
   from: `outputs/<feature-name>/prototype/<prototype-name>.html`. A copy also
   goes to the design repo at write-back (step 5). Every build carries the
   banner.

   **One file, everything embedded.** The prototype is a single `.html` file
   that opens by double-click with no other files beside it. Inline all CSS and
   JS, the design tokens, icons as inline SVG, and images and fonts as `data:`
   URIs. No sidecar `.css`, `.js`, `assets/`, or token files, and no build step.
   To update a prototype, edit that one file.
4. **Design review.** Run the protocol's independent design-review pass in a
   fresh context: spawn the `prototype-design-reviewer` agent with only the
   prototype path and the design-repo location. Tell the PM in one line that it
   is running. Apply its findings per the build protocol.
5. **Write back to the design repo.** Exactly these, nothing else, ever:
   - Always: a build report at
     `design-system/build-reports/<prototype-name>-<YYYY-MM-DD>.md`, per
     `BUILD-REPORT-TEMPLATE.md`.
   - Only when the PM approves it for this build: the prototype itself at
     `design-system/pm-prototypes/<prototype-name>-<YYYY-MM-DD>.html`, the same
     single file, named to match the report. Ask before every submission, in
     one line, before the PR is opened. If the PM declines, submit the report
     alone and state in its prototype line that the prototype was not
     submitted.
   - Only when the build needed a component the design system does not
     document: a proposal at `design-system/_proposed/<component-name>.md` plus
     one appended row in `design-system/_proposed/REGISTER.md`.

   Never touch `components/`, `tokens/`, `guidelines/`, `src/`, or
   `prototypes/` at the repo root. Direct pushes to `master` are blocked: land
   the write-back as branch → PR → merge immediately through the GitHub API, per
   the submission protocol. Never push from the local clone; its push is locked
   on purpose. Before merging, confirm the diff touches only
   `design-system/build-reports/`, `design-system/pm-prototypes/`, and
   `design-system/_proposed/` with its `REGISTER.md` row. Anything else: stop and
   tell the PM instead of merging. No reviewer waits on it.

   The PM has authorized the build report and proposal write-back as a
   standing operation. It needs no per-build approval. The prototype does, and
   so does any other write to the design repo.

## Overrides of the design repo's protocol

1. **Do not hide the report from the PM.** The design repo's protocol says to
   keep the build report, rule conflicts, and proposed components hidden from
   the PM. This repo overrides that. State in one line that a report was filed,
   and that a proposal was filed if one was. Flag every strict-rule conflict that
   changed what the PM asked for: the PM owns the PRD and needs to know when the
   built screen diverges from it. Such a divergence is PRD drift: flag it per
   `CLAUDE.md`, do not amend the PRD.
2. **Design review is announced, not detailed.** Say it is running; do not
   narrate it.
3. **Single-file output.** Where the design repo's protocol says to link,
   import, or copy token, component, or asset files, embed their content in the
   one HTML file instead (see step 3).

Keep rule numbers, the branch name, and the PR link out of the reply.

## Reply

Per `CLAUDE.md` Response Style. **Did** covers: prototype built, design review
ran, report filed (and proposal, if any). Any strict-rule divergence from the
PRD goes in **Need from you**.
