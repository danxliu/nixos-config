---
name: why
description: "Investigate why code or design decisions exist, including tradeoffs, regressions, postmortems, and unexplained thresholds. Use how for current runtime behavior."
---

# Why

Find the motivation behind code without inventing a story. Separate direct evidence from inference, cite the evidence, and make gaps visible.

`how` explains what the current code does. `why` explains the forces that shaped it.

## Scope the question

Identify the target code, decision, or behavior and the specific question: design rationale, an alternative that was rejected, an edge case, a business constraint, a regression, or the history of a feature.

If the target is vague, state the best interpretation from the conversation and repository context, then proceed. Do not present a plausible explanation as fact merely because the implementation makes sense.

## Investigate in layers

Start with the repository and its history. Expand to connected systems only when they are available and relevant:

1. **Current code:** Read the target, callers, tests, comments, configuration, and nearby abstractions. This establishes what needs explaining, but is not by itself proof of intent.
2. **Version history:** Use `git blame`, `git log --follow`, and focused patches. Look for the introducing commit, earlier implementations, revert/fix commits, and linked issue or PR identifiers.
3. **Change discussion:** For identified PRs, use the repository's supported tooling, such as `gh`, to inspect the description, reviews, and linked issues. Use the relevant installed skill or CLI for Jira, Confluence, or another tracker when applicable.
4. **Other records:** Search available project documentation, chat, incident records, error tracking, or product data when the question depends on them. Do not assume a source exists or claim to have searched one that is unavailable.

Useful starting commands:

```bash
git blame -L <start>,<end> -- <file>
git log --follow --oneline -- <file>
git log --follow -p -- <file>
git show <commit>
```

For a GitHub PR, inspect it only when the repository and authentication support it:

```bash
gh pr view <number> --json title,body,author,createdAt,mergedAt,closingIssuesReferences,comments,reviews
```

Search narrowly using file paths, symbols, commit subjects, issue IDs, and distinctive terms. Prefer the source closest to the decision that introduced the behavior.

## Evidence rules

- Cite every factual claim about motivation with a commit, PR, issue, document URL, chat permalink, code comment, or file and line range.
- Treat code as evidence of behavior, not automatically of intent.
- Label conclusions from indirect evidence as **inference** and use calibrated language such as "appears to" or "suggests".
- Surface contradictory sources instead of silently choosing one.
- Report meaningful gaps: unavailable systems, empty searches, missing history, or an answer the evidence does not establish.
- Do not search every possible system by default. Choose sources based on the question and available tools, and record what you did and did not consult.
- Never fabricate a ticket, PR, quote, metric, URL, or reason.

For a small change with a clear commit or PR explanation, answer directly after verifying that source. For a broad or disputed question, delegate distinct evidence-gathering lanes with Pi's subagent workflow, then synthesize in the parent. Keep lanes read-only in purpose, avoid duplicate prompts, and include their search scope and null results in the synthesis.

## Output

Use this compact structure:

### Question
Restate the question and identify the target.

### Direct evidence
Bullets containing only claims supported by explicit sources. Include citations inline.

### Reasonable inferences
Explain the evidence chain for each inference and use confidence-matched wording.

### Alternatives or contradictions
Include competing explanations when the record supports more than one, with evidence for and against each. Omit this section when unnecessary.

### Unknowns
State what the investigation could not establish and which relevant sources were unavailable or empty.

### Sources consulted
List each meaningful source and the search performed, including empty results. Example:

- Git history: `git log --follow -p -- path/to/file`; found the introducing commit and a later fix.
- PR discussion: inspected PR #123 and its linked issue; no explanation for the threshold.
- Project docs: searched for the symbol and decision name; no relevant result.

If the user is about to change the code, finish with a short constraint set:

- **Preserve:** behavior or constraints supported by evidence.
- **Change:** what the evidence says is safe or necessary to revisit.
- **Avoid:** assumptions or approaches contradicted by the record.
- **Risk:** unresolved rationale or missing evidence that should affect the change plan.

Keep the answer focused. Historical investigation should improve a decision, not become an exhaustive archive.
