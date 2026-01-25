#!/bin/bash
# Joan Session Start Hook
# Checks if project has Joan configured and reminds Claude about context

set -euo pipefail

# Check if Joan is configured in this project
JOAN_CONFIG="$CLAUDE_PROJECT_DIR/.joan/config.yaml"

if [ ! -f "$JOAN_CONFIG" ]; then
  # Project not configured with Joan, silently exit
  exit 0
fi

# Joan is configured, provide context reminder
MESSAGE="Joan is configured in this project. Domain knowledge pods are available in .joan/pods/. Check CLAUDE.md for the Joan context section listing tracked pods. Read relevant pods before starting significant work."

# Output JSON with system message for Claude
cat << EOF
{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "$MESSAGE"
}
EOF
