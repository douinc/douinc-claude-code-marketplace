---
description: Regenerate CLAUDE.md with Joan context
allowed-tools: Bash(joan:*), Read
---

Update CLAUDE.md with current Joan context.

1. Run: `joan context claude`

2. Read the updated CLAUDE.md file to verify the Joan context section was added

3. Report what was updated:
   - List the pod references that were added
   - Show the last updated timestamp

4. If pods are referenced, remind to read them before starting work:
   - List each pod file path from .joan/pods/
   - Suggest reading the most relevant pods for current task

Handle errors:
- If project not initialized, suggest `/joan:init`
- If no pods are tracked, suggest adding pods with `joan pod add`
