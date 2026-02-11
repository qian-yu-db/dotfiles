## General Rules

- Do not add excessive try except
- Always use uv as python environment manager and use uv run to run python code. Do not set up pyproject.toml for python package, always use minimal package configuration in pyproject.toml unless it is asked.
- Always write changes directly to the relevant file rather than presenting them in chat. When asked to update, add, or modify content, write to the file immediately unless explicitly told otherwise.
- When asked a question, answer it directly first before investigating further. Do not launch into lengthy tool-calling explorations unless the user explicitly asks for deep investigation.

## Problem Solving

- When fixing issues, prefer the simplest approach first. If a fix doesn't work after one attempt, step back and reconsider the approach rather than iterating on the same strategy. Limit to 2 attempts per approach before trying a fundamentally different solution.
- Before running any destructive command (rm, overwrite, force push) or system-level command (sudo, npm global install), show the exact command first and explain what it will do. Wait for confirmation.

## Python

- Always check system-level dependencies (e.g., WeasyPrint needs system libs, ffmpeg, etc.) before assuming pip/uv install alone will work. If a dependency has optional system requirements, note them clearly.

## Databricks

- Use `databricks auth profiles` to check workspace config before deployment.
- When deploying apps, always verify authentication method and service principal setup before attempting deployment.
- Vector Search endpoints require specific credential patterns — check existing working examples first.

## Large Project Protocol

When the user starts a task that involves multiple files, deployment, or multi-step implementation:
1. Proactively suggest splitting into phases (plan → implement → deploy) if the user hasn't already
2. Ask about known constraints or past failures before starting ("Any gotchas I should know about?")
3. Outline your approach in 3-5 bullet points and wait for confirmation before writing code
4. If you hit the same error twice, stop and present findings — do not keep iterating on the same approach

## Claude Code Plugins & Skills

- The plugin format uses marketplace-style plugin.json (not array-based plugins.json).
- Skill files use markdown without YAML frontmatter (skills use the skill description section pattern).
- Always verify slash commands appear in a new session before considering a plugin task complete.