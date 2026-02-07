# CLAUDE.md Review Plugin for Claude Code

Review and optimize your CLAUDE.md (or AGENTS.md) files following context engineering best practices.

Based on ["Writing a good CLAUDE.md"](https://humanlayer.dev/blog/writing-a-good-claude-md) by Kyle from HumanLayer.

## Why This Plugin?

CLAUDE.md is the highest leverage point of Claude Code. A well-crafted file dramatically improves Claude's performance. A bloated or auto-generated file causes Claude to ignore your instructions.

This plugin helps you:
- **Audit** your CLAUDE.md against proven best practices
- **Score** your file's health at a glance
- **Fix** issues automatically with smart rewrites

## Installation

```bash
# Clone to your Claude Code plugins directory
git clone <repo-url> ~/.claude/plugins/claudemd

# Or use --plugin-dir flag
claude --plugin-dir /path/to/claudemd-plugin
```

## Commands

| Command | Description |
|---------|-------------|
| `/claudemd` | Full review with detailed analysis and recommendations |
| `/claudemd --health` | Quick health score (perfect for CI/pre-commit) |
| `/claudemd --fix` | Automatically rewrite following best practices |
| `/claudemd /path` | Review CLAUDE.md in specific directory |

## Usage Examples

### Quick Health Check

```bash
/claudemd --health
```

Output:
```
📊 CLAUDE.md Health: my-project

Score: 72/100 🟡

Lines:         45 / 300   ✅
Instructions:  35 / 50    🟡
Code snippets: 0          ✅
Has WHAT:      Yes        ✅
Has WHY:       Yes        ✅
Has HOW:       Yes        ✅
Progressive:   No         ❌
Auto-generated: No        ✅
```

### Full Review

```bash
/claudemd
```

Provides detailed analysis including:
- Critical issues that cause Claude to ignore instructions
- Warnings about suboptimal patterns
- Suggestions for improvement
- Recommended file structure
- A suggested rewrite

### Auto-Fix

```bash
/claudemd --fix
```

Automatically rewrites your CLAUDE.md:
1. Shows current score
2. Proposes optimized version
3. Asks for confirmation
4. Applies changes
5. Shows improvement

## Scoring

The plugin scores your CLAUDE.md out of 100 points:

| Score | Rating | Meaning |
|-------|--------|---------|
| 90-100 | 🟢 Excellent | Follows all best practices |
| 70-89 | 🟡 Good | Minor issues, mostly well-structured |
| 50-69 | 🟠 Needs Work | Too long or has anti-patterns |
| 30-49 | 🔴 Poor | Many issues, likely being ignored |
| 0-29 | ⛔ Critical | Complete rewrite recommended |

### What Gets Checked

✅ **Good Practices**
- Under 300 lines (ideally < 100)
- Fewer than 50 instructions
- Covers WHAT, WHY, HOW
- Uses progressive disclosure
- No code snippets (uses file:line references)

❌ **Anti-Patterns**
- Auto-generated content (`/init`, Boost, etc.)
- Embedded code snippets
- Style guidelines (use linters instead)
- Task-specific instructions
- Verbose explanations

## Best Practices Summary

1. **Less is more** - Claude Code already uses ~50 instructions. Keep yours minimal.

2. **Universal applicability** - Only include what matters for EVERY task.

3. **Progressive disclosure** - Point to `agent_docs/` for detailed context.

4. **Pointers over copies** - Use `file:line` references, not code snippets.

5. **Claude is not a linter** - Use Pint, ESLint, Biome for style enforcement.

6. **Don't auto-generate** - Craft your CLAUDE.md carefully. It affects everything.

## Example of a Good CLAUDE.md

```markdown
# my-project

One-line description of the project.

## Stack
- Next.js 14 (App Router)
- PostgreSQL + Prisma
- NextAuth.js

## Structure
- `app/` - Next.js pages
- `lib/` - Shared utilities
- `prisma/` - Database schema

## Commands
- `pnpm dev` - Start dev server
- `pnpm test` - Run tests
- `pnpm typecheck` - TypeScript checks

## Before You Start
Read the relevant doc in `agent_docs/` for your task:
- `database.md` - Schema changes
- `api.md` - API conventions
- `testing.md` - Test patterns
```

~30 lines. Covers WHAT, WHY, HOW. Uses progressive disclosure.

## Resources

- [Writing a good CLAUDE.md](https://humanlayer.dev/blog/writing-a-good-claude-md) - Original article
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Context Engineering Best Practices](https://humanlayer.dev/blog)

## License

MIT
