# CLAUDE.md Best Practices Reference

Source: "Writing a good CLAUDE.md" by Kyle (HumanLayer), November 25, 2025

## Core Principle: LLMs are (mostly) stateless

LLMs are stateless functions with frozen weights. They don't learn over time. The only thing the model knows about your codebase is the tokens you put into it.

**Implications:**
1. Coding agents know absolutely nothing about your codebase at the beginning of each session
2. The agent must be told anything important each time you start a session
3. CLAUDE.md is the preferred way of doing this

## CLAUDE.md Onboards Claude

Cover three aspects:

### WHAT
- Tech stack
- Project structure
- Monorepo layout (apps, shared packages)
- What everything is for

### WHY
- Project purpose
- Component responsibilities
- Why different parts exist

### HOW
- Essential commands (build, test, typecheck)
- How to verify changes
- **Don't stuff every possible command** - that gets sub-optimal results

## Why Claude Ignores CLAUDE.md

Claude Code injects this system reminder:

```
<system-reminder>
IMPORTANT: this context may or may not be relevant to your tasks. 
You should not respond to this context unless it is highly relevant to your task.
</system-reminder>
```

Claude will ignore contents it decides are not relevant to the current task. More irrelevant content = more likely Claude ignores your instructions.

## Writing a Good CLAUDE.md

### Less (Instructions) is More

Research findings:
- Frontier thinking LLMs can follow ~150-200 instructions with reasonable consistency
- Smaller models get worse much more quickly (exponential decay vs linear)
- LLMs bias towards instructions at peripheries (beginning and end)
- As instruction count increases, quality decreases uniformly across ALL instructions

Claude Code's system prompt already contains ~50 instructions. That's nearly 1/3 of the budget before your CLAUDE.md even loads.

**Recommendation:** Include as few instructions as possible - only universally applicable ones.

### File Length & Applicability

- Contents should be universally applicable
- Avoid task-specific instructions (e.g., "how to structure a database schema")
- **Target: < 300 lines** (shorter is better)
- HumanLayer's root CLAUDE.md is < 60 lines

### Progressive Disclosure

Instead of putting everything in CLAUDE.md, use separate files:

```
agent_docs/
├── building_the_project.md
├── running_tests.md
├── code_conventions.md
├── service_architecture.md
├── database_schema.md
└── service_communication_patterns.md
```

In CLAUDE.md, list these files with brief descriptions. Let Claude decide which to read.

**Key principle:** Prefer pointers to copies. Don't include code snippets - they become outdated. Use `file:line` references instead.

### Claude is NOT a Linter

**Never send an LLM to do a linter's job.**

Problems with style guidelines in CLAUDE.md:
- Comparably expensive and slow vs deterministic tools
- Adds instructions and irrelevant snippets
- Degrades performance and instruction-following
- Eats up context window

LLMs are in-context learners! They'll follow patterns from your codebase.

**Better approaches:**
- Use Claude Code Stop hooks to run formatter/linter
- Use auto-fixing linters (like Biome)
- Create a Slash Command for style checking that points at git changes

### Don't Auto-Generate CLAUDE.md

Avoid `/init` or auto-generation because:

```
Bad CLAUDE.md line
  → Bad implementation plan
    → Bad code
      → Affects EVERY session and artifact
```

CLAUDE.md is the highest leverage point. Craft it carefully.

## Quality Checklist

### Must Have
- [ ] Under 300 lines (ideally < 100)
- [ ] Covers WHAT, WHY, HOW
- [ ] Only universally applicable instructions
- [ ] Points to detailed docs (progressive disclosure)

### Must NOT Have
- [ ] Code snippets (use file:line references)
- [ ] Detailed style guidelines (use linters)
- [ ] Task-specific instructions
- [ ] Auto-generated content
- [ ] "Hotfix" instructions for edge cases

### Structure
- [ ] Brief project description
- [ ] Tech stack summary
- [ ] Directory structure overview
- [ ] Essential commands only
- [ ] Pointers to detailed documentation

## Scoring Guide

| Score | Description |
|-------|-------------|
| 90-100 | Excellent - Concise, focused, follows all best practices |
| 70-89 | Good - Minor issues, mostly well-structured |
| 50-69 | Needs Work - Too long, some anti-patterns |
| 30-49 | Poor - Many issues, likely being ignored by Claude |
| 0-29 | Critical - Complete rewrite recommended |

### Scoring Factors
- Length penalty: -1 point per 10 lines over 100
- Instruction count: -2 points per instruction over 30
- Code snippets: -5 points each
- Style guidelines present: -10 points
- Missing WHAT/WHY/HOW: -10 points each
- No progressive disclosure structure: -10 points
- Auto-generated markers detected: -20 points
