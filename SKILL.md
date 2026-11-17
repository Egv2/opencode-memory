---
id: opencode-memory
name: OpenCode File-Based Memory
description: ZCode-style file-based project memory for OpenCode. Lazy bootstrap, recall/write rules, scope, and maintenance. Zero dependencies.
---

# OpenCode File-Based Memory (ZCode-style)

A lightweight, file-based memory system for OpenCode. No cloud, no vector DB, no API keys. Memory lives as markdown files with YAML frontmatter, one topic per file, indexed by `MEMORY.md`.

## Goals

- Persist durable knowledge across sessions without external services.
- Keep memory transparent, git-friendly, and human-readable.
- Minimize token cost by reading only relevant topic files.
- Prevent stale and duplicate memories.

## Directory layout

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

Project slug = basename of the working directory (never guess).

## Bootstrap (lazy, idempotent)

- If the project's `~/.opencode/memory/projects/<slug>/memory/MEMORY.md` does not exist AND memory-worthy information emerges, create the directory and index automatically. Do not ask the user.
- If the global structure (`~/.opencode/memory/MEMORY.md`, `template.md`) is missing, create it too.
- Never overwrite existing memory files. Only create missing ones.

## Recall

- At session start, read `~/.opencode/memory/MEMORY.md` and (if present) `~/.opencode/memory/projects/<slug>/memory/MEMORY.md`.
- Select relevant topic files via `read`/`grep`; do not load all memory into context.
- Before relying on a memory, verify the referenced file/function/symbol still exists (staleness guard).

## Write

- When durable information emerges (preference, decision, gotcha, architecture), create a new topic file: `~/.opencode/memory/projects/<slug>/<topic-slug>.md`.
- Use the frontmatter template from `~/.opencode/memory/template.md`.
- Add a single-line index entry: `- [Title](topic-slug.md) — short description`.
- Cross-reference topics with `[[topic-slug]]`.
- Never store secrets, tokens, or credentials.

## Scope

- Project-specific knowledge → project folder.
- Universal preferences/rules → global `~/.opencode/memory/MEMORY.md`.
- Session-only temporary info → do not write to memory.

## Maintenance (sustainability)

- One topic per file; split if a file exceeds 200 lines.
- Index entries are single lines.
- Check for duplicates before writing.
- Stale memory: if a referenced file/symbol no longer exists, update or delete the file and clean the index.
- Never store secrets; ask the user if content looks sensitive.
- Periodically (monthly, or when memory exceeds 50 files) clean up stale/conflicting records and reorganize the index.
- Version memory files with git (committing to the project repo is optional).

## Frontmatter template

```yaml
---
name: <slug>
description: <one-line description>
metadata:
  type: project   # user | feedback | project | reference
  originSessionId: <session_id>
---

<What we know, why, how to apply>

**Why:** ...
**How to apply:** ...
```

## Usage

- Run `/memory-setup` in a project to bootstrap missing files.
- Otherwise the lazy bootstrap rule creates them on first memory-worthy event.