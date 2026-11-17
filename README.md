# opencode-memory

<img src="https://raw.githubusercontent.com/phosphor-icons/core/main/assets/regular/brain.svg" width="24" alt="brain" />

File-based, zero-dependency project memory for OpenCode.

No cloud. No vector database. No API keys. Just markdown files with YAML frontmatter: transparent, git-friendly, and human-readable.

## Why

OpenCode forgets everything between sessions. Existing memory layers (Mem0, Zep, Letta) require cloud accounts, Docker stacks, or vector databases. opencode-memory gives you ZCode-style file-based memory with a single install script, and the agent manages it itself.

- Zero dependencies: pure markdown plus OpenCode's built-in file tools
- Project-scoped: each project gets its own memory folder
- Staleness guard: memories referencing deleted files get cleaned up
- Self-maintaining: duplicate detection, size limits, periodic cleanup
- Secret-safe: never writes keys, tokens, or credentials

## Quick start

<img src="https://raw.githubusercontent.com/phosphor-icons/core/main/assets/regular/rocket.svg" width="20" alt="rocket" />

```bash
git clone https://github.com/egv2/opencode-memory.git
cd opencode-memory
./install.sh
```

Restart OpenCode, then in any project:

```
/memory-setup
```

That is it. The lazy bootstrap rule also creates files automatically on the first memory-worthy event.

One-liner (after publishing):

```bash
curl -fsSL https://raw.githubusercontent.com/egv2/opencode-memory/main/install.sh | bash
```

## How it works

<img src="https://raw.githubusercontent.com/phosphor-icons/core/main/assets/regular/folder-open.svg" width="20" alt="folder" />

```
~/.opencode/memory/
├── MEMORY.md              # global index
├── template.md            # frontmatter template
└── projects/
    └── <project-slug>/
        └── memory/
            ├── MEMORY.md  # project index
            └── <topic>.md # one topic per file
```

Each topic file has YAML frontmatter:

```yaml
---
name: menubiz-deploy-setup
description: Cloudflare Pages deploy rules for menubiz
metadata:
  type: project   # user | feedback | project | reference
  originSessionId: sess_abc123
---

Cloudflare Pages production branch is main. Build format "file" is required.

Why: Missing build format caused 308 redirects and Google indexing failures.
How to apply: Always verify build format "file" in astro.config.mjs before deploy.
```

Cross-reference topics with [[topic-slug]].

## Memory rules (injected into ~/.config/opencode/AGENTS.md)

<img src="https://raw.githubusercontent.com/phosphor-icons/core/main/assets/regular/gear.svg" width="20" alt="gear" />

| Rule | Description |
|---|---|
| Bootstrap | Create project memory folder on first memory-worthy event, no prompt |
| Recall | Read indexes at session start, load only relevant topics |
| Write | Create topic file and update index when durable info emerges |
| Scope | Project-specific goes to project folder, universal goes to global index |
| Maintenance | Split files over 200 lines, dedup, stale cleanup, secret filter |

## Comparison

<img src="https://raw.githubusercontent.com/phosphor-icons/core/main/assets/regular/scales.svg" width="20" alt="scales" />

| Feature | opencode-memory | Mem0 | Zep |
|---|---|---|---|
| Dependencies | None | Cloud SDK | Docker plus graph DB |
| API key | No | Yes | Yes |
| Semantic search | No, grep based | Yes | Yes, temporal graph |
| Auto-capture hooks | No | Yes | No |
| Transparency | Full, markdown | Dashboard | Dashboard |
| Offline | Yes | No | Self-host only |

## What gets installed

<img src="https://raw.githubusercontent.com/phosphor-icons/core/main/assets/regular/package.svg" width="20" alt="package" />

| File | Location | Purpose |
|---|---|---|
| SKILL.md | ~/.config/opencode/skills/opencode-memory/ | Skill definition |
| memory-setup.md | ~/.config/opencode/commands/ | /memory-setup slash command |
| AGENTS.md rules | ~/.config/opencode/AGENTS.md | Global memory rules, idempotent |
| template.md | ~/.opencode/memory/ | Frontmatter template |
| MEMORY.md | ~/.opencode/memory/ | Global index |

## Contributing

<img src="https://raw.githubusercontent.com/phosphor-icons/core/main/assets/regular/handshake.svg" width="20" alt="handshake" />

PRs welcome. Please keep the skill dependency-free and the install script idempotent.

## License

MIT, 2026