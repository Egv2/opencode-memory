# Global Memory Rules (file-based, ZCode-style)

## Bootstrap (lazy)
- If the project's `~/.opencode/memory/projects/<dir-name>/MEMORY.md` does not exist and memory-worthy information emerges, create that directory and index automatically. Do not ask the user.
- If the global memory structure (`~/.opencode/memory/MEMORY.md`, `template.md`) is missing, create it too.
- Use the current working directory's basename as the project name (never guess).

## Recall
- At session start, read `~/.opencode/memory/MEMORY.md` and (if present) `~/.opencode/memory/projects/<dir-name>/MEMORY.md`.
- Select relevant topic files via `read`/`grep`; do not load all memory into context.
- Before relying on a memory, verify referenced files/functions/symbols still exist (staleness guard).

## Write
- When durable information emerges (preference, decision, gotcha, architecture), create a new topic file: `~/.opencode/memory/projects/<dir-name>/<slug>.md`.
- Use the frontmatter template at `~/.opencode/memory/template.md`.
- Add a single-line index entry: `- [Title](slug.md) — short description`.
- Cross-reference topics with `[[slug]]`.
- Never store secrets, tokens, or credentials.

## Scope
- Project-specific knowledge → project folder.
- Universal preferences/rules → `~/.opencode/memory/MEMORY.md` (global).
- Session-only temporary info → do not write to memory.

## Maintenance (sustainability)
- One topic per file; split if a file exceeds 200 lines.
- Index entries are single lines.
- Check for duplicates before writing.
- Stale memory: if a referenced file/symbol no longer exists, update or delete the file and clean the index.
- Never store secrets; ask the user if content looks sensitive.
- Periodically (monthly, or when memory exceeds 50 files) clean up stale/conflicting records and reorganize the index.
- Version memory files with git (committing to the project repo is optional).