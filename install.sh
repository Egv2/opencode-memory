#!/usr/bin/env bash
set -euo pipefail

OPENCODE_CONFIG="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
OPENCODE_HOME="${OPENCODE_HOME_DIR:-$HOME/.opencode}"
SKILL_DIR="$OPENCODE_CONFIG/skills/opencode-memory"
COMMANDS_DIR="$OPENCODE_CONFIG/commands"
MEMORY_ROOT="$OPENCODE_HOME/memory"
GLOBAL_AGENTS="$OPENCODE_CONFIG/AGENTS.md"
MARKER="<!-- opencode-memory:global-rules -->"

mkdir -p "$SKILL_DIR" "$COMMANDS_DIR" "$MEMORY_ROOT" "$MEMORY_ROOT/projects"

cp SKILL.md "$SKILL_DIR/SKILL.md"
cp commands/memory-setup.md "$COMMANDS_DIR/memory-setup.md"
cp templates/template.md "$MEMORY_ROOT/template.md"

if [ ! -f "$MEMORY_ROOT/MEMORY.md" ]; then
  cat > "$MEMORY_ROOT/MEMORY.md" <<'EOF'
# Global Memory Index

(Universal preferences and rules. Project-specific knowledge lives in project folders.)
EOF
fi

# Append global rules to AGENTS.md if marker missing
if [ ! -f "$GLOBAL_AGENTS" ] || ! grep -q "$MARKER" "$GLOBAL_AGENTS"; then
  {
    echo ""
    echo "$MARKER"
    cat AGENTS.md
  } >> "$GLOBAL_AGENTS"
fi

echo "Installed opencode-memory skill."
echo "Skill: $SKILL_DIR/SKILL.md"
echo "Command: /memory-setup"
echo "Memory root: $MEMORY_ROOT"