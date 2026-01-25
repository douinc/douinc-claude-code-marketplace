# Joan Plugin for Claude Code

Integrate [Joan](https://joan.land) workspace-based knowledge and task management into Claude Code projects.

## Features

- **Domain Knowledge Access**: Read pods (versioned knowledge documents) to understand project context
- **Task Management**: Create, list, and update todos scoped to the project's workspace
- **Plan Management**: Create and track implementation plans for todos
- **Context Generation**: Auto-inject Joan context into CLAUDE.md files
- **Smart Pod Loading**: Intelligently load only relevant pods based on current task

## Prerequisites

- [Joan CLI](https://github.com/douinc/joan) installed and authenticated
- A Joan workspace with your project

## Installation

Add this plugin to your Claude Code configuration:

```bash
# Option 1: Clone to local plugins directory
git clone <repo-url> ~/.claude/plugins/joan

# Option 2: Use --plugin-dir flag
claude --plugin-dir /path/to/joan-plugin
```

## Commands

| Command | Description |
|---------|-------------|
| `/joan:init` | Initialize Joan and configure work preferences |
| `/joan:sync` | Sync pods and todos with server |
| `/joan:todo` | Create or list Joan todos |
| `/joan:plan` | Create implementation plan for a todo |
| `/joan:work` | Implement a todo following its plan |
| `/joan:context` | Regenerate CLAUDE.md with Joan context |

### Usage Examples

```bash
# Initialize a new project (will ask for work strategy preference)
/joan:init

# Sync with specific workspace
/joan:init abc123-workspace-id

# Sync all data
/joan:sync

# Create an implementation plan for a todo
/joan:plan todo-uuid-here

# Implement a todo (follows configured work strategy)
/joan:work todo-uuid-here

# Update CLAUDE.md context
/joan:context
```

## Work Strategies

During `/joan:init`, you choose how Claude executes work on todos:

| Strategy | Best For | Behavior |
|----------|----------|----------|
| **Strict** | Critical features, learning codebases | Pauses between steps, asks for confirmation |
| **Adaptive** | Most development (default) | Follows plan but adapts, minimal interruptions |
| **Incremental** | Pair programming, complex refactors | Checks in after each meaningful change |
| **Autonomous** | Well-defined tasks | Works until blocked, reports at end |

Settings are stored in `.claude/joan.local.md` (gitignored for personal preferences).

## Agents

The plugin includes four specialized agents:

### pod-context-loader (Proactive)
Automatically loads relevant domain knowledge before you start working. Analyzes your task and reads only the pods that are relevant.

### todo-tracker (Proactive)
Suggests creating or updating todos after you complete significant work, keeping your team informed of progress.

### plan-creator (On-demand)
Creates structured implementation plans in Joan format when you're planning a feature or complex task.

### pod-author (On-demand)
Helps document learnings, decisions, and domain knowledge as well-structured Joan pods.

## MCP Integration

The plugin configures the Joan MCP server automatically, providing direct API access to:
- List workspaces
- List pods in a workspace
- Get pod content

The MCP server uses OAuth 2.1 authentication. Authenticate via CLI first: `joan auth login`

## Hooks

### SessionStart
When you start a Claude Code session in a Joan-configured project, the plugin reminds Claude about available domain knowledge pods.

## Project Structure

After running `/joan:init`, your project will have:

```
your-project/
├── .claude/
│   └── joan.local.md    # Plugin settings (gitignored)
├── .joan/
│   ├── config.yaml      # Joan configuration
│   └── pods/            # Local pod copies
│       ├── Pod-Name.md
│       └── ...
└── CLAUDE.md            # Updated with Joan context
```

## Skill

The `joan-workflow` skill provides Claude with knowledge about:
- When to use pods vs todos vs plans
- How Joan's workspace model works
- Best practices for domain knowledge management

This skill activates automatically when you discuss Joan-related topics.

## Authentication

The plugin uses the Joan CLI for authentication. To authenticate:

```bash
joan auth login
```

This opens a browser for OAuth 2.1 authentication with Joan.

## Support

- [Joan Documentation](https://joan.land/docs)
- [Joan CLI Repository](https://github.com/douinc/joan)
- [Report Issues](https://github.com/douinc/joan/issues)
