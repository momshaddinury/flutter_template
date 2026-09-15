# Handoff

Read this file for context, then follow the user's current request.

## Done

- Replaced the six previous architecture and coding guides with the current agent rules and four skills.
- Added shared entry points for Claude Code, Cursor, and Codex, skill/rule adapters, the gate, and the pre-commit hook.
- Adapted source-project examples, design references, state, and setup for Flutter Template and its pinned Flutter version.
- Added the three missing guardian rules. Preserved the existing rules and test harness; the imported rules use the template's path helper.
- Verified local documentation links, removals, adapter targets, script syntax, and whitespace.
- App tests passed: 129. Guardian tests passed: 72, including 11 new cases.

## Gate

gate: FAIL format: run fvm dart format .

The gate stopped at the existing formatting drift in `test/presentation/core/failure/business_failure_ui_mapper_test.dart`.
The formatting diagnostic used `--output=none` and did not change that file.

Separate analysis found two existing list branches that the imported rule now flags:

- `lib/src/data/services/network/transport/dio_builder.dart:87`
- `test/presentation/core/router/router_state_test.dart:22`

A line-length information diagnostic in generated `rest_client.g.dart` was already present before migration.
A separate scan found 107 existing doc-comment lines matching the gate's dash-aside check. TODO and Figma-id checks had no matches.
The gate has not passed. The user requested this migration be committed on `chore/adopt-agent-system` with the known cleanup items still open. The pre-commit hook is skipped for this snapshot only; the repository hook configuration stays `.githooks`. Application and application-test files are unchanged.

## Next

TEMPLATE-2: resolve the recorded formatting and collection-branch findings.
Then complete TEMPLATE-3 and rerun `agent/gate` to finish validation of TEMPLATE-1.

## Open questions

None.
