---
name: work-loop
description: Use when implementing a Flutter Template change or when the user asks to continue development, take the next task, or resume a task id.
---

# Work loop

For a review-only request, use `review-pass` in review-only mode. Do not start this implementation loop.

1. Read `agent/state/handoff.md`, then `agent/state/plan.md`. Briefly state the relevant context.
2. Read `agent/rules/process.md`. Select the task using its task-selection rules and mark it `doing`.
3. Read the other files under `agent/rules/` that the task touches: Dart means `architecture.md`, `naming.md`, and `comments.md`; dependency wiring means `dependency_injection.md`; transport means `network.md`; navigation means `routing.md`; a model, entity, enum, mapper, repository, or service means `models.md`; a widget means `presentation.md`; provider-consuming presentation code means `riverpod.md`; prose means `prose.md`; dependencies mean `pubspec.md`.
4. Write a brief spec: what changes, which files, and how you will check it. Reuse an approved brief when it covers these points. Apply the spec-approval rule in `process.md` if a shared public interface changes.
5. Execute using the roles in `process.md`. Use `build-screen` for a screen, then return here.
6. Run `review-pass` in implementation mode. Address findings within the task's scope.
7. Run `handoff`. It prepares state before the full gate and handles the user review checkpoint in `process.md`.
8. Report the task id, what changed, the gate's last line, and anything skipped or still pending.
