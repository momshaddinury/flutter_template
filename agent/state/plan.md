# Plan

Goal: replace the template's previous development and architecture guidance with the shared agent system.

Task line format: `- [status] id: description (link)`. Status is `todo`, `doing`, `done`, or `blocked`. At most one task is `doing`.
Append `; review: required` when completed work needs user review. See `agent/rules/process.md` for the checkpoint.

- [blocked] TEMPLATE-1: agent-system replacement is installed and tested; snapshot commit requested on `chore/adopt-agent-system`; full validation waits on TEMPLATE-2 and TEMPLATE-3
- [todo] TEMPLATE-2: format `test/presentation/core/failure/business_failure_ui_mapper_test.dart` and wrap the two existing list branches reported by the imported guardian rule
- [todo] TEMPLATE-3: update legacy doc-comment dash asides to the shared prose rule, then rerun the full gate

The migration changed no application or application-test files. See `agent/state/handoff.md` for validation details.
