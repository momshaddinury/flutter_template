# Flutter Template

Every agent starts here. Claude Code, Cursor, and Codex all read this file.

1. Read `agent/state/handoff.md`, then `agent/state/plan.md` for context. Follow the user's current request. Choose a planned task when asked to continue development.
2. Before you write Dart, read `agent/rules/architecture.md`, then `agent/rules/naming.md` and `agent/rules/comments.md`. Before you add or change a model, entity, enum, mapper, repository, or service, read `agent/rules/models.md`. Before you add a widget, read `agent/rules/presentation.md`. Before you change provider-consuming presentation code, read `agent/rules/riverpod.md`.
3. For implementation, follow `agent/README.md` and the `work-loop` skill. For review-only requests, report findings without editing, updating state, or committing.
4. Prepare the plan and handoff before running `agent/gate`. Report an implementation task as done only after the gate passes. Paste its last line in the report.
5. Commit the task's changes with its updated plan and handoff. Append to `agent/state/decisions.md` only when the user makes a new decision.

Toolchain: `fvm flutter` and `fvm dart`, never the PATH flutter. `fvm dart analyze` loads the guardian lints. `flutter analyze` does not.

Architecture and development rules live under `agent/rules/`. Start with `architecture.md`; read `dependency_injection.md`, `network.md`, or `routing.md` when changing those areas.
