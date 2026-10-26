# Weekly router refresh — agent instructions

You are running headless in CI, with `skills/company-brain/` (this directory, inside the ai-utils
checkout) as the working directory. Work only inside this directory — never touch anything else in
the ai-utils monorepo. Two tasks.

## Task 1 — fill blank capability cells in router.toon.md

`scripts/gen-router.sh` already ran. In `router.toon.md`, rows in the `[repos]` section have the
format `repo|lang|pushed|owners|capability|keywords`. Some rows have an empty `capability` (5th)
field.

For each such row, look up the same repo in `.cache/raw-inputs.json` (fields: `repo`, `desc`,
`topics`, `toplevel`, `readme`). Write:

- `capability`: max 8 words, lowercase, what the repo DOES — concrete domain nouns, phrased so
  "which repo handles X?" would match it.
- `keywords`: 3–6 comma-separated lowercase terms someone might search for.

Rules:
- If the digest is genuinely uninformative, write `unknown` and derive keywords from the repo
  name. Never invent a purpose you cannot support from the digest.
- Never use the `|` character inside a field.
- Do not touch rows whose capability field is already filled — those come from the repo's own
  AGENTS.md or a previous run.

## Task 2 — refresh the [spaces] and [projects] sections via the Atlassian MCP

Using the connected `atlassian` MCP server (site: g2rs.atlassian.net):

1. List all **global, current** Confluence spaces. Drop any space whose name starts with `OLD -`.
   Rewrite the `[spaces]` section rows as `key|title|keywords`, where keywords are 3–6 lowercase
   routing terms derived from the space's title and, where obvious, its domain. Keep the existing
   comment lines under the section header.
2. For the `[projects]` section: do NOT add or remove project keys — membership is a manually
   maintained allow-list (the keys currently in the file). For each existing key, verify its
   current display name via Jira and update the name if it changed. Keep keywords as they are.

## Invariants — violating any of these means stop and exit non-zero instead

- The three section headers `[repos]`, `[spaces]`, `[projects]` must all still exist afterward.
- The `[repos]` row count must not change (gen-router.sh owns membership, you own blank cells).
- The file header lines (`# RIG v2`, `generated_at=`, `scope=`, `trust=`) must be preserved.
- Edit `router.toon.md` only. Do not create, delete, or modify any other file.
