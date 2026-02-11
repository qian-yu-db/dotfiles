---
name: obsidian-inbox
description: Process Obsidian inbox notes by categorizing, applying templates, renaming, and filing into the correct vault folders. Updates Maps of Content (MOCs) accordingly. Works with the databricks_knowledge_vault structure.
license: Apache-2.0
---

# Obsidian Inbox Processor

Use this skill to process notes in the Obsidian inbox (`00-inbox/`).

## Vault Structure

The vault is at `~/workspace/databricks_knowledge_vault/` with this layout:

```
00-inbox/       # Unprocessed notes land here
01-projects/    # Active project notes
02-customers/   # Customer-specific notes
10-mocs/        # Maps of Content (index files)
20-notes/       # Permanent/evergreen notes
30-templates/   # Note templates
40-archive/     # Archived notes
50-logs/        # Weekly/monthly logs
```

## Processing Steps

For each file in `00-inbox/`:

1. **Read the note** and understand its content

2. **Categorize** — determine where it belongs:
   - Customer meeting/info → `02-customers/`
   - Project-related → `01-projects/`
   - Knowledge/reference → `20-notes/`
   - Log entry → `50-logs/`

3. **Check templates** in `30-templates/` and apply the matching template structure (frontmatter, sections, tags)

4. **Rename** the file using vault naming conventions (check existing files in the target folder for the pattern)

5. **Move** the file to the correct folder

6. **Update MOCs** — if a relevant MOC exists in `10-mocs/`, add a link to the new note

7. **Report** what was done for each file

## Rules

- Read existing notes in the target folder first to match naming patterns and style
- Preserve all original content — restructure but never delete information
- Add appropriate tags and links based on content
- If unsure about categorization, ask the user rather than guessing
- Process files one at a time, confirming each move
