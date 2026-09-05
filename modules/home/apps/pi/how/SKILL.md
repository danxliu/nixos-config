---
name: how
description: "Explain how code works, trace runtime behavior, and answer questions about ownership, layering, and placement. Use why for historical motivation."
---

# How

Explain the codebase well enough for an engineer to change it safely. Build a mental model, not an annotated copy of the source.

## Decide the scope

Interpret the user's question from the conversation and repository. If it is ambiguous, state the interpretation you are using and continue; do not stop to ask a question unless the work cannot proceed.

Use a direct investigation for a small function, module, or narrow flow. For a subsystem spanning several packages or services, split the investigation into two to four distinct angles such as:

- entry points and request/runtime flow
- data model and state transitions
- configuration, dependencies, and integration boundaries
- tests, operational behavior, and failure paths

Delegate only when the breadth justifies it. If delegating, use the Pi subagent workflow and give each child a distinct slice. The parent agent owns synthesis and the final answer. Do not make parallel writers for an explanation task.

## Investigate

Use the repository as the source of truth:

1. Locate likely files and symbols with `rg`, `find`, or the repository's search tools.
2. Read the relevant implementation, types, tests, configuration, and nearby callers.
3. Start at a concrete entry point and follow the call chain to its effects and outputs.
4. Check error handling, retries, caching, concurrency, feature flags, and boundaries between packages or services.
5. Use `git log` or `git blame` only when history explains a surprising current behavior. Use `why` for a broader rationale investigation.

Do not infer behavior from filenames or comments alone. Distinguish observed behavior from a likely interpretation. Mention uncertainty when the code or repository does not establish an answer.

## Explain

Use the sections that help; omit empty ones:

### Overview
What the system or flow does and where it starts and ends.

### Key concepts
The few types, services, interfaces, or state machines needed to understand the explanation.

### Flow
A numbered or prose walkthrough from trigger to result. Name files and symbols at the step where they matter. Include important branches and failure paths.

### Where things live
A short file map for the code a newcomer should read or modify.

### Gotchas
Non-obvious behavior, ownership boundaries, ordering constraints, generated code, configuration requirements, or sharp edges.

Keep the explanation proportional to the question. Prefer file paths, symbol names, and short quoted snippets over large code blocks. Cite line ranges when they materially help navigation.

## Critique mode

If the user asks whether the architecture has problems or how to improve it:

1. Complete the explanation first.
2. Check the actual code for coupling, unclear ownership, hidden state, failure handling, testability, and operational risks.
3. If independent critique would help, delegate a small number of fresh, read-only review lanes using Pi's subagent guidance.
4. Separate findings into **Act on**, **Consider**, **Noted**, and **Dismissed**. For each actionable finding, cite the code and explain impact, not just style preference.

Present the explanation before the critique so readers seeking understanding do not have to navigate the review first.

## Output rules

- Do not claim to have inspected files, history, or tools you did not inspect.
- Do not turn guesses about intent into facts; use `why` for intent and historical rationale.
- Do not dump every file or implementation detail. Include only what supports the user's mental model.
- End with concrete next files or symbols to inspect when the user is likely to make a change.
