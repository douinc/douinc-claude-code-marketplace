---
# Joan Plugin Settings
# Copy this file to .claude/joan.local.md in your project

# Work execution strategy for /joan:work command
# Options:
#   - strict: Follow plan step by step, pause between major steps for confirmation
#   - adaptive: Follow plan but adapt as needed, minimal interruptions
#   - incremental: Check in after each significant change, good for learning
#   - autonomous: Work until blocked or complete, maximum efficiency
work_strategy: adaptive

# Auto-load pods at session start
# When true, the pod-context-loader agent proactively reads relevant pods
auto_load_pods: true

# Auto-track todos after completing work
# When true, the todo-tracker agent suggests updating todos after major work
auto_track_todos: true
---

# Joan Plugin Configuration

This file configures the Joan plugin behavior for this project.

## Work Strategies Explained

### Strict
Best for: Critical features, learning new codebases
- Follows plan exactly as written
- Pauses between major steps for confirmation
- Asks before making architectural decisions

### Adaptive (Default)
Best for: Most development work
- Uses plan as a guide but adapts to discoveries
- Continues autonomously unless blocked
- Asks only for significant deviations from plan

### Incremental
Best for: Pair programming, teaching, complex refactors
- Checks in after each meaningful change
- Explains what was done and what's next
- Good visibility into progress

### Autonomous
Best for: Well-defined tasks, experienced users
- Works until complete or blocked
- Minimal interruptions
- Reports summary at the end
