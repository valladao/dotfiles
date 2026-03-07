---
name: prd-writer
description: Create or refine product requirement documents (PRDs) from rough ideas, goals, and constraints. Use when users ask for PRD creation, feature specs, scope definition, acceptance criteria, rollout plans, or stakeholder-ready product docs.
---

# PRD Writer

Use this skill when the user needs a PRD that can guide design, engineering, and rollout.

## Workflow

1. Confirm the request scope.
- If key facts are missing, ask only the minimum blocking questions.
- If user prefers speed, proceed with explicit assumptions.

2. Build the PRD using the template.
- Always use `references/prd-template.md` as the base structure.
- Keep sections concise and implementation-oriented.

3. Validate quality before finalizing.
- Run through `references/prd-checklist.md`.
- If any section is weak, revise before returning.

4. Output format.
- Default output is Markdown.
- If writing to file is requested, use `docs/prd-<slug>.md` unless user specifies another path.

## Authoring Rules

- Prefer measurable outcomes over generic goals.
- Separate `Goals` vs `Non-goals` clearly.
- Use testable acceptance criteria (`AC-001`, `AC-002`, ...).
- Mark uncertain points as `Assumption:`.
- Include risks, mitigations, and rollout guardrails.
- Do not include implementation-level tickets unless explicitly requested.

## Optional Fast Mode

If user says "quick draft" or similar:
- Produce a lean PRD with the same section headings.
- Keep each section to short bullets.
- Keep acceptance criteria and risks mandatory.

## References

- Template: `references/prd-template.md`
- Quality checks: `references/prd-checklist.md`
- Example framing patterns: `references/prd-examples.md`
