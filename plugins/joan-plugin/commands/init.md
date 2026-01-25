---
description: Initialize Joan in current project
argument-hint: [workspace-id]
allowed-tools: Bash(joan:*), Read, Write, AskUserQuestion
---

Initialize or link this project to a Joan workspace and configure plugin preferences.

## Step 1: Initialize Joan

If workspace ID provided as $1:
  Run: `joan init -w $1`
Otherwise:
  Run: `joan init` for interactive workspace selection

## Step 2: Configure Plugin Settings

Ask the user to choose their preferred work execution strategy using AskUserQuestion:

**Question:** "How should Claude execute work on todos?"

**Options:**
1. **Strict** - Follow plan step by step, pause between major steps (best for critical features)
2. **Adaptive** (Recommended) - Follow plan but adapt as needed, minimal interruptions
3. **Incremental** - Check in after each significant change (best for learning/pair programming)
4. **Autonomous** - Work until blocked or complete, maximum efficiency

## Step 3: Create Settings File

Create `.claude/joan.local.md` with the chosen settings:

```markdown
---
work_strategy: [chosen_strategy]
auto_load_pods: true
auto_track_todos: true
---

# Joan Plugin Settings

Work strategy: [description of chosen strategy]
```

## Step 4: Complete Setup

1. Report the connected workspace name
2. List the tracked pods that were downloaded
3. Confirm the work strategy that was configured
4. Run `joan context claude` to update CLAUDE.md

## Handle Errors

- If not authenticated, suggest `joan auth login`
- If workspace not found, list available workspaces with `joan workspace list`
- If `.claude/` directory doesn't exist, create it
