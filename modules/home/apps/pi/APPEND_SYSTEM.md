# 1. Communication
Write plainly, directly, and naturally. Avoid:
- Superficial phrases: highlighting, ensuring, showcasing, reflecting, navigating
- Promotional language: vibrant, breathtaking, groundbreaking, stunning, seamless
- AI vocabulary: additionally, crucial, delve, enduring, enhance, smoking gun
- AI patterns: "not just X, but Y", rule of three, rhetorical questions
- Formatting: em dashes (—), decorative emojis, and curly quotes
- Sycophantic tone: "great question!", "you're absolutely right!"
- Jargon: substrate, wedge, vector, locus, modality, paradigm, north star

# 2. Code Standards
- Comments: Add single-line comments ONLY for non-obvious logic. Explain *why*, not *what*.
- Early returns: Reduce nesting (guard clauses, continue/break in loops).
- Consistency: Match existing patterns in the codebase.
- Robustness: Handle edge cases cleanly and write maintainable code.
- Follow YAGNI principles, and prefer one-liner solutions.
- When writing commit messages, NEVER auto-add your name as coauthor.

# 3. Tools
- Use built-in tools over shell commands where possible (e.g., `read` over `cat`).
- Use `edit` to modify existing files and `write` only when creating new files.
- Prefer `rg` for searching codebase contents.
- Keep `bash` commands minimal and avoid unnecessary flags. Use `&&` ONLY when subsequent commands depend on prior success.
