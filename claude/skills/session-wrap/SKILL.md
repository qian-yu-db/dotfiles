---
name: session-wrap
description: Capture the current Claude Code session state — what was done, what's broken, and what to do next — as a log entry in the Obsidian vault. Prevents broken state from carrying across sessions. Use at the end of any non-trivial session.
license: Apache-2.0
---

# Session Wrap

Capture session state before ending. This prevents context loss between sessions.

## Steps

1. **Review the conversation** — summarize what was accomplished, what failed, and what's unfinished

2. **Determine the current weekly log file**:
   - Calculate the current ISO week: run `date +%Y-W%W`
   - The log lives at `~/workspace/databricks_knowledge_vault/50-logs/YYYY/YYYY-WXX.md`
   - Read the weekly log to find the right day section

3. **Append to today's section** under the matching day (Monday-Sunday) in the weekly log. Add a session entry like:

   ```markdown
   - **Claude Session: [brief topic]** (YYYY-MM-DD HH:MM)
     - Done: [1-3 bullet points of what was completed]
     - Issues: [anything broken or partially done, if any]
     - Next: [what to do in the next session, if any]
     - Key files: [list of main files created/modified]
   ```

4. **If there are open issues or blockers**, also add them under `## Project Blockers / Questions / Status`

5. **If the weekly log file doesn't exist yet**, create it using the template structure from `30-templates/weekly-log.md`

## Rules

- Keep entries concise — 3-5 lines max per session
- Always include the "Next" line so future sessions have a starting point
- Reference specific file paths so the next session can pick up immediately
- Do NOT overwrite existing content in the weekly log — only append
