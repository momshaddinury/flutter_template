---
paths: []
---
# Process

## Roles

- The user reviews the work. These rules come from the source project's reviewed agent system.
- For implementation, the session agent leads: it reads state, writes the spec, reviews, updates state, runs the gate, and commits.
- Who edits code: in a Claude Code session, the Cursor CLI. Write the task to a spec file and run `agent -p -f --trust --model composer-2.5 --output-format text "$(cat spec)"` in the checkout, not in a worktree, because generated files are gitignored. `--continue` sends corrections. In a Cursor or Codex session, the agent edits directly.
- Prose files under `agent/` and `docs/`, and comments, may be written by the session agent in any session.

## One task at a time

- Follow the user's current request. A review-only request produces findings without edits, state updates, or commits.
- When asked to continue development, resume the `doing` task. If none exists, take the first `todo`.
- When the user names different work, take that work. Record any unfinished task you set aside as `todo`, or `blocked` with its reason.
- Keep at most one task `doing` in `agent/state/plan.md`.

## User review

- Build and check the first screen of a section. Then pause for user review before committing or continuing the section.
- A task with `review: required` follows the same checkpoint after its work is built and checked. This is a task flag, not a status.
- Record the pause as `blocked`, with the reason `awaiting user review`. After approval, finish the handoff. If changes are requested, resume as `doing`.
- Spec approval is separate. Before changing a public interface another feature uses, get approval for that interface change. Existing approval counts.

## Done means

1. `agent/gate` exits 0.
2. The `review-pass` skill ran and findings within the task's scope are fixed. Any required user review is complete.
3. The task's changes are committed with the updated plan and handoff. Append to `decisions.md` only when the user makes a new decision.
4. The report pastes the gate's last line and names anything skipped.

Never claim a test passed without running it.
If an unrelated failure prevents the gate from passing, report it and leave the task incomplete. Do not expand the task to fix it.

## Commits

- One commit per task. Include only that task's changes. Message: `type: what changed`, present tense, under 72 characters. Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`.
- Never commit generated files, a pubspec change the task did not ask for, or a secret. Live tokens stay in the session scratchpad.

## Figma

- When the task provides a Figma design, it owns the visual values. Fetch every component state. Never infer one state's colors from another. Without a design, use the template's existing theme and components.
- Icons: a bare snake_case name, the 24px master, stripped to the icon group, committed once. Size is chosen at the render site with a token.
- Node ids appear in code only on a `Design:` link line.

## Toolchain

- `fvm flutter` and `fvm dart`. `flutter analyze` does not load the guardian; `fvm dart analyze` does.
- Fresh clone: `fvm install`, `fvm flutter pub get`, `fvm dart pub get` inside `packages/flutter_guardian`, then `fvm dart run build_runner build --delete-conflicting-outputs`.
- Any change under `packages/flutter_guardian/lib` can crash the analyzer once. The gate swaps the plugin binary and retries.
- The Flutter version is pinned in `.fvmrc`. Use that version for this checkout.
