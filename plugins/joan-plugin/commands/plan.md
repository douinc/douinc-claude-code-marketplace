---
description: Create an elaborate implementation plan using parallel agents for analysis
argument-hint: <todo-id>
allowed-tools: Bash, Read, Glob, Grep, Write, Task, AskUserQuestion, TodoWrite
---

# Joan Plan - Implementation Planning

Create a detailed, actionable implementation plan for a Joan todo using parallel agents to analyze the codebase and design architecture.

## Core Principles

- **Understand before planning**: Launch parallel agents to analyze codebase first
- **Read files identified by agents**: Build deep context before designing
- **Ask clarifying questions**: Resolve ambiguities before finalizing plan
- **Use TodoWrite**: Track planning progress

---

## Phase 1: Todo & Context Loading

**Goal**: Understand what needs to be planned

**Actions**:
1. Create todo list for planning phases
2. Fetch todo details:
   ```bash
   joan todo list --json | jq '.[] | select(.id == "$1")'
   ```
3. If no ID provided, list todos and ask user to select one
4. Check for existing plans: `joan plan list $1`
5. Read relevant pods from `.joan/pods/`
6. Summarize: todo requirements, domain knowledge from pods

---

## Phase 2: Codebase Analysis (Parallel Agents)

**Goal**: Deep understanding of relevant code through parallel exploration

**Actions**:
1. Launch 3 exploration agents **in parallel**:

   **Agent 1 - Similar Features**:
   "Find existing features similar to [todo description]. Trace their implementation comprehensively. Return list of 5-10 key files."

   **Agent 2 - Architecture Patterns**:
   "Map the architecture and abstractions for [todo area]. Identify patterns, layers, and conventions. Return list of 5-10 key files."

   **Agent 3 - Integration Points**:
   "Identify dependencies, APIs, and integration points for [todo feature]. Return list of 5-10 key files."

2. After agents complete, **read all identified files**

3. Synthesize findings:
   - Patterns to follow
   - Abstractions to reuse
   - Files to modify
   - Potential challenges

---

## Phase 3: Clarifying Questions

**Goal**: Resolve all ambiguities before designing

**CRITICAL**: DO NOT SKIP

**Actions**:
1. Review todo, pods, and codebase findings
2. Identify underspecified aspects:
   - Edge cases and error handling strategy
   - Scope boundaries (what's in/out)
   - Performance requirements
   - Backward compatibility needs
   - Testing strategy
   - Deployment considerations

3. **Present questions to user in organized sections**
4. **Wait for answers before designing architecture**

---

## Phase 4: Architecture Design (Parallel Agents)

**Goal**: Generate multiple implementation approaches

**Actions**:
1. Launch 2 architecture agents **in parallel**:

   **Agent 1 - Minimal Changes**:
   "Design implementation with smallest possible changes. Maximize reuse of existing code. Focus on quick delivery."

   **Agent 2 - Clean Architecture**:
   "Design implementation with optimal maintainability. Create elegant abstractions. Focus on long-term quality."

2. For each approach, get:
   - Files to create/modify
   - Component responsibilities
   - Data flow
   - Trade-offs

3. Form recommendation considering:
   - Todo complexity
   - Team conventions from pods
   - Project urgency

4. **Present approaches to user with recommendation**
5. **Get explicit approval for chosen approach**

---

## Phase 5: Plan Creation

**Goal**: Create detailed, actionable implementation plan

**Actions**:
1. Based on chosen approach, create plan file:
   ```bash
   joan plan create $1
   ```

2. Write comprehensive plan following this structure:

```markdown
# Implementation Plan: [Todo Title]

## Overview
Brief summary of what will be implemented and why.
Link to relevant pods that inform this plan.

## Prerequisites
- [ ] Dependencies to install
- [ ] Configuration needed
- [ ] Environment setup

## Implementation Steps

### Step 1: [Action]
**Files:** `path/to/file.ts`, `path/to/other.ts`
**Description:** What to do and why
**Key decisions:** Design choices made
**Acceptance criteria:**
- [ ] Specific, testable criteria
- [ ] How to verify complete

### Step 2: [Action]
...continue for each step...

## Testing Strategy
- Unit tests: what to test, key scenarios
- Integration tests: end-to-end flows
- Manual verification steps

## Rollback Plan
How to undo changes if issues arise.

## Open Questions
Decisions deferred or needing future clarification.

## Related Pods
- [Pod Name]: How it informed this plan
```

3. Offer to push: `joan plan push $1`

---

## Phase 6: Summary

**Goal**: Present plan and next steps

**Actions**:
1. Mark planning todos complete
2. Present plan summary:
   - Number of implementation steps
   - Key files affected
   - Estimated complexity
   - Critical decisions made

3. Suggest next steps:
   - Review plan with team
   - Run `/joan:work $1` to implement
   - Update related todos

---

## Error Handling

- If todo not found, show available todos
- If no pods available, proceed with codebase analysis only
- If plan exists, ask: update existing or create new version?
- If agents return no files, expand search criteria
