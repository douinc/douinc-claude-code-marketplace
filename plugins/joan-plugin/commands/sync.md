---
description: Sync pods and todos with Joan server
argument-hint: [--push | --pull]
allowed-tools: Bash(joan:*)
---

Synchronize local Joan data with the server.

If $1 is "--push":
  Push local changes to server:
  1. Run: `joan pod push`
  2. Run: `joan todo push`
  3. Report what was pushed

If $1 is "--pull":
  Pull latest from server:
  1. Run: `joan pod pull`
  2. Run: `joan todo pull`
  3. Report what was updated

If no argument provided:
  Do a full sync (pull then push):
  1. Run: `joan pod pull`
  2. Run: `joan todo pull`
  3. Run: `joan pod push`
  4. Run: `joan todo push`
  5. Report sync status

After sync:
- Summarize changes (new pods, updated todos, etc.)
- If pods changed, suggest running `/joan:context` to update CLAUDE.md
