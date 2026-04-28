---
name: prd-to-tasks
description: Convert a PRD into an execution plan with epics, user stories, technical tasks, dependencies, priorities, estimates, and delivery milestones. Use when users ask to break specs into actionable work.
---

# PRD to Tasks

Use this skill to transform a product requirements document into an implementation backlog.

## When To Use

- User asks to "quebrar PRD em tarefas", "gerar backlog", "planejar implementação".
- User has a PRD and needs epics/stories/tasks for execution.
- User needs phased milestones, dependencies, or priority sequencing.

## Workflow

1. Read the PRD and extract scope.
- Capture: goals, in-scope/out-of-scope, acceptance criteria, constraints.
- If input is incomplete, proceed with explicit assumptions.

2. Build delivery structure.
- Use `references/backlog-template.md`.
- Group work into epics aligned to user value.
- Split each epic into stories and implementable tasks.

3. Add planning metadata.
- Priority (`P0`/`P1`/`P2`)
- Effort (`XS`/`S`/`M`/`L`/`XL`)
- Dependencies
- Risks/blockers

4. Validate quality.
- Run `references/decomposition-checklist.md`.
- Ensure tasks are testable and linked to PRD acceptance criteria.

5. Output format.
- Default: Markdown backlog.
- Optional: JSON using `references/backlog-schema.json`.

## Rules

- Keep traceability: every story/task must map to PRD goals or acceptance criteria.
- Avoid vague tasks (e.g., "improve performance"). Use measurable outcomes.
- Separate product stories from technical enablers.
- Keep scope discipline; avoid adding features outside PRD unless marked as suggestion.
- Mark unknowns explicitly as `Assumption:` or `Open question:`.

## References

- Backlog template: `references/backlog-template.md`
- Quality checklist: `references/decomposition-checklist.md`
- JSON schema: `references/backlog-schema.json`
