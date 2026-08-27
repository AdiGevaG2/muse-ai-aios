# Jira & Confluence Patterns — publish

How to push the PRD out. Read when running `/publish`. Project key, space, and
prefixes come from `domains/<domain>/config.json`.

## Confluence
- Publish/update the PRD page under the configured space + parent page.
- Show the user what will be created/updated BEFORE writing (approval gate).
- Preserve the PRD version stamp on the page.

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
`features/<feature>/prd/publish-log.md`.
