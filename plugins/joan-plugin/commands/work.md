---
description: Implement a Joan todo with structured phases, parallel agents, and quality review
argument-hint: <todo-id>
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, Task, AskUserQuestion, TodoWrite
---

# Joan Work - Feature Implementation

Implement the specified Joan todo using a systematic approach with parallel agents for exploration, architecture, and review.

## Core Principles

- **Ask clarifying questions**: Identify ambiguities before implementing. Wait for answers.
- **Understand before acting**: Read pods and codebase patterns first
- **Read files identified by agents**: After agents complete, read their recommended files
- **Use TodoWrite**: Track all progress throughout phases
- **Follow configured strategy**: Apply user's work_strategy setting

---

## Phase 1: Discovery & Context Loading

**Goal**: Understand the todo and load all relevant context

**Actions**:
1. Read `.claude/joan.local.md` to get `work_strategy` setting (default: `adaptive`)
2. Create todo list with all 7 phases
3. Fetch todo details: `joan todo list --json | jq '.[] | select(.id == "$1")'`
4. If no ID provided, list todos and ask user to select one
5. Check for existing plans: `joan plan list $1`
6. Read all tracked pods from `.joan/pods/` that relate to the todo domain
7. Summarize: todo scope, related pods loaded, existing plans

---

## Phase 2: Codebase Exploration

**Goal**: Understand relevant existing code patterns through parallel agent analysis

**Actions**:
1. Launch 2-3 pod-context-loader and code exploration agents **in parallel**:
   - "Analyze existing implementations similar to [todo description]"
   - "Map architecture and patterns relevant to [todo area]"
   - "Find integration points and dependencies for [todo feature]"

2. Each agent should return a **list of 5-10 key files to read**

3. After agents complete, **read all identified files** to build deep understanding

4. Present findings summary:
   - Patterns discovered
   - Key abstractions to use
   - Files that will need modification

---

## Phase 3: Clarifying Questions

**Goal**: Resolve all ambiguities before designing implementation

**CRITICAL**: This is one of the most important phases. DO NOT SKIP.

**Actions**:
1. Review todo, plan (if exists), pods, and codebase findings
2. Identify underspecified aspects:
   - Edge cases and error handling
   - Integration with existing features
   - Scope boundaries
   - Performance requirements
   - Backward compatibility

3. **Present all questions to user in organized sections**
4. **Wait for answers before proceeding**

If user says "whatever you think is best", provide recommendation and get confirmation.

---

## Phase 4: Architecture Design

**Goal**: Design implementation approach with trade-offs

**Actions**:
1. If no plan exists, create one using `/joan:plan` workflow
2. Launch 2 architecture agents **in parallel** with different focuses:
   - Minimal changes approach (smallest change, maximum reuse)
   - Clean architecture approach (maintainability, elegant abstractions)

3. Review approaches and form opinion on best fit considering:
   - Todo complexity
   - Urgency
   - Team conventions from pods

4. Present to user:
   - Brief summary of each approach
   - Trade-offs comparison
   - **Your recommendation with reasoning**

5. **Ask user which approach they prefer**

---

## Phase 5: Implementation

**Goal**: Build the feature following chosen architecture

**DO NOT START WITHOUT USER APPROVAL**

**Actions**:
Based on configured `work_strategy`:

### If `work_strategy: strict`
- Implement step by step, pausing after each major step
- Ask: "Step N complete. Ready for Step N+1?"
- Show diff preview before significant changes

### If `work_strategy: adaptive` (default)
- Implement using plan as guide
- Continue autonomously unless blocked
- Report adaptations: "Plan said X, but did Y because..."

### If `work_strategy: incremental`
- Pause after each meaningful change
- Explain: "Just did X. Next: Y. Continue?"

### If `work_strategy: autonomous`
- Work continuously until complete or blocked
- Minimize interruptions
- Comprehensive summary at end

**For all strategies**:
- Follow codebase conventions from pods and CLAUDE.md
- Write clean, well-documented code
- Update todos as you progress

---

## Phase 6: Quality Review

**Goal**: Ensure code is correct, clean, and follows conventions

**Actions**:
1. Launch 3 review agents **in parallel** with different focuses:
   - Simplicity and DRY principles
   - Bugs and functional correctness
   - Project conventions from pods/CLAUDE.md

2. Consolidate findings with confidence scoring:
   - Only report issues with confidence ≥ 80%
   - Focus on issues that truly matter

3. **Present findings to user** and ask:
   - Fix now?
   - Fix later?
   - Proceed as-is?

4. Address issues based on user decision

---

## Phase 7: Summary & Completion

**Goal**: Document accomplishments and update Joan

**Actions**:
1. Mark all todos complete
2. Update Joan todo status: `joan todo update $1 --status done`
3. Summarize:
   - What was built
   - Key decisions made
   - Files modified
   - Pods that informed the work
4. Suggest next steps:
   - Related todos to tackle
   - Documentation to update
   - Tests to add

---

## Error Handling

- If blocked, document blocker and ask for guidance
- If tests fail, fix before marking complete
- If plan is outdated, suggest updating it
- If settings file missing, use `adaptive` as default
