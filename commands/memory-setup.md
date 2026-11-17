---
description: Set up file-based memory for the current project (idempotent)
---

Set up the file-based memory structure for the current project if missing.

Steps:
1. Determine project slug = basename of current working directory.
2. Create `~/.opencode/memory/projects/<slug>/memory/` if missing.
3. Create `MEMORY.md` index if missing.
4. Ensure global `~/.opencode/memory/MEMORY.md` and `template.md` exist (create if missing).
5. Read `~/.opencode/memory/template.md` for frontmatter format.
6. Optionally seed 1-3 example memories based on the repo, then update the index.
7. Verify files exist and print paths.

Do not overwrite existing memory files. Only create missing ones.