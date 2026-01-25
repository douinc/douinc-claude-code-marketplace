---
description: Create or list Joan todos
argument-hint: [list | create | update <id>]
allowed-tools: Bash(joan:*), AskUserQuestion
---

Manage todos in the current Joan workspace.

If $1 is "list" or empty:
  Run: `joan todo list`
  Display todos in a formatted table with:
  - ID (truncated)
  - Title
  - Status
  - Priority
  - Assignee

If $1 is "create":
  Use AskUserQuestion to gather:
  - Todo title (required)
  - Description (optional)
  - Priority (low/medium/high)

  Then run: `joan todo create` with the provided information
  Report the created todo ID

If $1 is "update" and $2 is a todo ID:
  First show current todo details
  Use AskUserQuestion to ask what to update:
  - Status
  - Priority
  - Title
  - Assignee

  Run: `joan todo update $2` with the changes
  Confirm the update was successful

Handle errors:
- If project not initialized, suggest `/joan:init`
- If todo not found, list available todos
