---
name: review-pass
description: Use when the user asks for a Flutter Template review or when an implementation is ready for review before handoff.
---

# Review pass

Choose the mode from the user's request:

- **Review-only:** inspect and report findings. Do not edit, update state, or commit.
- **Implementation:** review the authorized task and fix findings within its scope. Report unrelated findings separately.

Review the files or revision range the user names. For uncommitted work, use `git status --short`, `git diff HEAD --stat`, and `git diff HEAD`. Read relevant untracked files too; they are absent from the diff.

Check the applicable items below. Give each finding a file, line, and explanation of its effect.

1. **Architecture, names, and Dart style:** apply `agent/rules/architecture.md` and `agent/rules/naming.md`. Check dependency wiring and transport against their rule files when relevant.
2. **Text:** apply the Text section in `agent/rules/naming.md`.
3. **Comments and prose:** apply `agent/rules/comments.md` and `agent/rules/prose.md`. Check that statements are accurate and add useful information.
4. **Placement:** apply `agent/rules/presentation.md`, choosing ownership before file and visibility.
5. **Routes** (`agent/rules/routing.md`): id in the path, values in the query, no objects as the only source.
6. **Models** (`agent/rules/models.md`): entities raw, formatting in presentation, and one mapper per independently owned response model.
7. **Tests:** check the coverage required by `agent/rules/presentation.md`. Check that no test was weakened to pass.
8. **Scope**: nothing changed that the task did not ask for. No generated file drift. A `pubspec.yaml` change follows `agent/rules/pubspec.md`.

In review-only mode, finish with the findings and any limits of the review.
In implementation mode, report what you fixed and what remains, then return to `work-loop`. The `handoff` skill prepares state and runs the full gate.
