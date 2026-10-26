# SETUP — pm-aios in the Claude Code extension

This is a Claude Code workspace: skills, agents, hooks, and a knowledge base as
plain markdown. Nothing compiles; the "install" is putting the folder somewhere
Claude Code can see it, proving the guards fire, and filling the context.

**Time:** ~10 min to a working session, ~30 min more to fill context.
**You need to be comfortable in a terminal. You do not need to write code.**

Work top to bottom. Each section ends with a check that must pass before the
next one is worth doing.

---

## 1. Prerequisites

| Need | Why | Install |
|---|---|---|
| **Claude Code** | The runtime. CLI, or the extension in VS Code / Cursor. | Extension marketplace, or `npm i -g @anthropic-ai/claude-code` |
| A Claude subscription including Claude Code | Auth | — |
| **`jq`** | The guard hooks parse their stdin payload with it and **fail closed** without it — every write gets blocked. | `brew install jq` |
| **Python 3** | `scripts/mermaid_to_drawio.py` turns a mermaid block into an inline editable draw.io SVG. Only needed if you want editable diagrams. | Preinstalled on macOS |
| Draw.io VS Code extension | Editing the SVG the script produces. Optional. | Extension marketplace |

**Check:**
```bash
jq --version && python3 --version && claude --version
```
All three must print a version. If `jq` is missing, stop here — the workspace
will appear installed and then block every write.

---

## 2. Put the workspace in place

1. Put `pm-aios/` wherever you keep projects. Path doesn't matter; avoid a
   directory synced by iCloud/Dropbox (file locks fight the hooks).
2. Open that folder in the Claude Code extension, or `cd pm-aios && claude`.
3. Claude Code discovers `.claude/` on launch. Because this adds a new
   top-level skills directory, **restart the session once** so it's watched.
   Skipping this is the single most common setup failure — skills silently
   don't appear.
4. If you'll run `/reverse-engineer` against local repo clones: set
   `CODE_REPOS_ROOT` to wherever you keep them (defaults to
   `~/vsCode/code-repos-git`) and add that directory as an **additional working
   directory** in the extension. Without the working-directory grant, Claude
   can't read the clones no matter what the variable says.

**Check:** type `/` — you should see **12** workflow skills:

`/reverse-engineer` `/discovery` `/prd` `/spec` `/validation` `/analytics-plan`
`/ai-eval` `/baseline-data` `/publish` `/ingest` `/retro` `/review`

If you see none: you skipped the restart in step 3. If you see some: check you
opened the repo root, not a subfolder — `.claude/` must be at the top level of
the opened directory.

---

## 3. Prove the guards actually fire

Do this **before** trusting the workspace with anything sensitive.

```bash
bash scripts/test-hooks          # 40 assertions: guards block, allow, fail closed
bash scripts/validate-workspace  # structure, skill set, context-budget drift
```

`test-hooks` must end `40 passed, 0 failed`. It exists because the guards once
read a `TOOL_INPUT_PATH` environment variable that Claude Code never sets — they
exited 0 on empty input, so they passed everything silently while appearing
configured. **An untested guard is theatre.** Re-run this suite after any change
to `.claude/hooks/` or `.claude/settings.json`.

Four guards are wired in `.claude/settings.json`:

| Guard | Fires on | Behavior |
|---|---|---|
| `secret-guard` | Write/Edit | Blocks credentials entering repo files |
| `destructive-operation-guard` | Bash | Blocks destructive shell operations |
| `prd-change-guard` | Write/Edit on PRD paths | Notifies on PRD mutation |
| `provenance-guard` | Write/Edit in the brains | Blocks untagged evidence rows |

**`validate-workspace` exits 0 even when it prints problems.** Read its output;
don't trust the exit code. Two kinds of finding:

- **`active skill set drifted`** — the validator's expected skill list is
  hardcoded and has fallen behind the actual `.claude/skills/` directory.
  Compare the two lists it prints. If the difference is a skill you meant to
  add, update the expected list in the script. Today it lags by `ai-eval`.
- **`warning: ... exceeds token budget`** — a file grew past its context
  budget. Not fatal, but it's the early signal of context rot. Currently
  `CLAUDE.md`, the PRD skill, and the simple-PRD read path are over.

**Confirm the hooks fire in a real session**, not just the harness: run
`claude --debug`, trigger a write, and look for the hook invocation in the debug
log. The test suite proves the scripts work; only this proves they're wired.

---

## 4. Fill the context (the real setup — ~30 min)

The structure ships built; the knowledge is what makes output good. Run the
readiness check first — it tells you what's actually still a stub, which beats
working from a list:

```bash
bash scripts/validate-ai-readiness
```

It reports `ok / warnings / blockers`. **Blockers must be zero** before a real
run. Warnings are expected on a fresh install and burn down as you use the
system.

Files to fill, highest leverage first:

1. **`domains/atlas/second-brain/writing-samples.md`** — paste 2–4
   **real** examples of how you write. Single highest-leverage file for output
   quality; without it every artifact reads generically.
2. **`domains/atlas/config.json`** — replace every `<...>`: tool
   project IDs (Mixpanel, Coralogix, Looker, Jira, Confluence, Figma), naming,
   gates.
3. **`domains/atlas/CLAUDE.md`** — the `<...>` in strategy, voice,
   delegation.
4. **`org-brain/context/policies.md`** (org-wide) and
   **`domains/atlas/second-brain/context/compliance.md`** (domain) —
   your real governance facts. **Human-owned; never auto-written.**
5. **`OWNERSHIP.md`** — fill `<owners>` when the pilot expands past you.

Two lazy brains: `org-brain/` (company-wide) and the domain `second-brain/`.
Put material in the one it belongs to, the domain when unclear; **org wins
conflicts.**

**Check:** re-run `validate-ai-readiness`. Zero blockers. Warnings about an
empty wiki and template-only `decisions/` and `stakeholders/` are normal here —
section 8 is how they fill.

---

## 5. Connect tools (MCP)

**Configuration metadata does not prove a working connection.** `config.json`
keeps each integration `UNVERIFIED` until an actual runtime probe succeeds. Use
`VERIFIED_READ` or `VERIFIED_WRITE` only for the capability you directly tested
— read access verified does not imply write.

Wire connectors in the extension settings:

| Connector | Purpose | Notes |
|---|---|---|
| **Mixpanel** | Product analytics baselines | Official MCP, service-account auth. **Org admin must enable it.** |
| **Coralogix** | Logs / error baselines | Official MCP, `mcp-version: v2` header, OAuth |
| **Looker** | BI baselines | No MCP server available — see the setup path in `config.json` |
| **Jira** | External handoff | Writes require explicit approval |
| **Confluence** | Rendered PRD/spec pages | Writes require explicit approval |
| **Figma** | Spec/design reconciliation | Read |

Until a connector is wired, the stage that uses it **runs everything except the
live call** — you still get the artifact, with the data pull marked unavailable.
Nothing hard-blocks on a missing connector.

**Never put a credential in a repo file, artifact, prompt, or chat.** The
secret-guard hook blocks it, and you should not be relying on the hook.

**Check:** `bash scripts/validate-ai-readiness` and read the integration
section. Each connector you wired should have moved off `UNVERIFIED` — and it
only moves after a real probe, so if it didn't, the connection isn't live.

---

## 6. First run

**Don't run the full flow first.** Prove one stage on something small:

- `/reverse-engineer <a small real module>` — pressure-tests the evidence loop.
- or `/ingest <an article>` — see the wiki, index, and log build.

Standalone stages ask **Quick** (assume low-stakes gaps, flag them) or **Strict**
(ask every gap). **High-stakes gaps always stop regardless of mode.**

**Check:** the stage produced an artifact under `outputs/<feature-name>/`, with
sources cited. Feature work lives only there.

---

## 7. The flow

```
/reverse-engineer  → source-cited evidence about what exists today
/discovery         → problem, direction, scope        [approval gate]
/prd               → product intent + acceptance      [approval gate]
/spec              → figma delta review + exact build behavior  → engineering
/validation        → did we build the spec? + alignment drift check
/analytics-plan    → measurement plan                 (when warranted)
/publish           → Jira handoff; Confluence only when explicitly requested
/retro             → learnings back into the brains   [approval gate]
```

Supporting stages, called when the work needs them rather than in sequence:
`/baseline-data` (pull current-state numbers before a PRD that cites metrics)
and `/ai-eval` (accuracy bar for a feature's AI behavior — distinct from
`/validation`, which checks build against spec).

Figma delta review is a step **inside** `/spec`, not a separate skill — it
writes `reconcile-notes.md` and the PM arbitrates each mismatch.

`/publish` asks about Confluence and Jira **separately. A yes to one is never a
yes to the other.** It renders `prd.md` and `spec.md` into Confluence pages —
those are **renderings, not sources of truth**, so intent changes go to the
markdown first, then republish. Jira uses
`Initiative → Milestone → Epic → Story/Bug → Subtask`; there is no Feature level.

---

## 8. Keep it alive (avoid context rot)

- **`/ingest`** as you read — the wiki compounds.
- **`/retro`** at each feature close — corrections flow back to the brains.
- **`/review`** on a cadence — sweeps for drift, contradictions, broken wiki
  links, and stale eval results whose model or prompt version has moved on.
- **`bash scripts/test-hooks`** after any hook or settings change.
- **`bash scripts/validate-workspace`** when a token-budget warning appears —
  that's context rot starting.

The system maintains itself only if someone runs the loops. An empty
`second-brain/` is not a neutral state: it means **every feature starts from
zero.**

---

## 9. Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| No skills under `/` | New skills dir not watched | Restart the session (§2.3) |
| Some skills missing | Opened a subfolder | Reopen the repo root so `.claude/` is top-level |
| Every write blocked | `jq` missing — guards fail closed | `brew install jq` |
| `test-hooks` fails after an edit | Guard or settings contract broke | Read the failing assertion; the stdin payload contract is in `.claude/hooks/_payload.sh` |
| `active skill set drifted` | Validator's hardcoded list is stale | Compare printed lists; update the expected list if the new skill is intended |
| `exceeds token budget` | A file grew | Trim it, or move detail into a skill reference |
| Connector stays `UNVERIFIED` | No successful runtime probe | The connection isn't live — recheck auth; for Mixpanel, org admin enablement |
| Can't read repo clones | Missing working-directory grant | Add the dir as an additional working directory (§2.4) |
| Guards pass in tests, not in session | Not wired in settings | `claude --debug`, trigger a write, look for the hook invocation |

---

## 10. Later: migrate to a team plugin

When it's proven and you want the team on it: add `.claude-plugin/plugin.json`,
move `skills/` + `agents/` to the plugin root, swap relative refs for
`${CLAUDE_PLUGIN_ROOT}`, and publish to a private marketplace. Knowledge
(`domains/`, `org-brain/`) **stays out of the plugin** so the engine stays
portable. See `OWNERSHIP.md` for who owns what at team scale.
