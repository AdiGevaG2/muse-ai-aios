# Jira & Confluence Patterns — publish

How to push the PRD out. Read when running `/publish`. Project key, space, and
prefixes come from `domains/<domain>/config.json`.

## Confluence
- Publish/update the PRD page under the configured space + parent page.
- Show the user what will be created/updated BEFORE writing (approval gate).
- Preserve the PRD version stamp on the page.

### Figma link as embedded card
If the source artifact (PRD/spec/discovery) has a Figma link, embed it —
don't paste it as plain text. Add a "Design" heading followed by an
`embed-card` block with the Figma URL as an iframe src, in the same shape
Confluence renders when you paste a Figma link directly:

```html
<p><strong>Design</strong></p>
<div data-type="embed-card" data-layout="center" data-width="100">
  <iframe src="https://www.figma.com/design/..."></iframe>
</div>
```

Place it after the flow it illustrates (e.g. after User Journey, before
Assumptions) unless the page template says otherwise. If a Figma link already
exists on the page as an embed card, preserve it as-is when overwriting —
don't flatten it to plain text.

### Overwrites and comment preservation
Before updating or overwriting an existing page:

1. Retrieve the existing inline and page comments and identify the text each
  inline comment references.
2. Compare every commented text span with the proposed page content.
3. Keep comments attached normally when the referenced text remains unchanged.
4. When a sentence or word that carries a comment will be deleted or amended,
  keep the original text on the page with its comment anchor intact. Strike it
  through and prefix it with **Old text, not part of the requirement:**. Place
  the new text directly after it. Never delete the commented text, and never
  remove, resolve, or re-anchor the comment.
5. If the tooling cannot keep the original text and its comment anchor in place,
  add an appendix named **Comment History** to the proposed page with these
  exact columns, and state in the diff that the anchor could not be kept:

  | Original commented text | Comment | PM response |
  |---|---|---|
  | [Original sentence, paragraph, or relevant text span] | [Comment copied without changing its meaning] | |

  Keep separate rows for comments that refer to different text or raise
  different points. Leave **PM response** empty.

Never silently resolve, dismiss, rewrite, or discard comments. If the available
Confluence tooling cannot retrieve comments or verify that they will be
preserved, report that limitation and stop before showing the overwrite for
approval or writing the page.

### Text written by other users
Never overwrite text written by anyone other than Adi Geva
(adi.geva@g2risksolutions.com) with changes made by agents in this workspace.

Before updating an existing page:

1. Retrieve the page version history. Get Adi's account ID with
  `atlassianUserInfo`.
2. Diff the current page against the last version Adi authored. Every
  addition, edit, or deletion in a later version by another author is that
  author's text.
3. Keep that text verbatim in the proposed page. Do not reword, move, reformat,
  or delete it, even when the PRD says something different.
4. When the PRD change touches text another user wrote, leave their text as is,
  add the new text next to it, and list the conflict in the diff with the
  author's name, so Adi decides. Treat this as possible PRD drift.
5. If the version history cannot be retrieved, or authorship of a section cannot
  be determined, report that and stop before showing the overwrite for approval.

The diff shown for approval names every section that contains another user's
text and confirms it is unchanged.

## Jira
- Hierarchy: Initiative (multi-quarter strategic only) → Milestone (each
  roadmap item) → Epic (new-functionality or bucket) → Story/Bug → optional
  Subtask. See `initiative-template.md`, `milestone-template.md`,
  `epic-template.md`, `story-template.md` for the Description-field content
  per level. Not every feature needs an Initiative — most PRDs land at
  Milestone → Epic → Story.
- Derive from the PRD's goals/user-story section (acceptance criteria become
  story descriptions).
- Show a DIFF of what will be created/changed before writing.
- **Flag any existing story that is In Progress** — changing those mid-sprint is
  high-stakes; make the user approve them deliberately.
- Use the configured project key + epic prefix. Inherit the authenticated user's
  permissions — never broaden scope.

## Partial approval
Create only approved items. Leave rejected ones flagged
"diverged from PRD vN" so they resurface next run — never silently drop.

## Output
Record what was pushed (with IDs/links) and what was left diverged in
`outputs/<feature>/publish/publish-log.md`.
