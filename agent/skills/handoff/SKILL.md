---
name: handoff
description: Use when a Flutter Template implementation is ready to finish, when the user asks to wrap up implementation work, or before pausing it.
---

# Handoff

For a review-only request, report findings using `review-pass`; do not update state or commit.

1. Update `agent/state/plan.md` with the task's progress. Keep it `doing` while completing checks. For a pause, use `todo` if work can resume, or `blocked` with its reason.
2. Append to `agent/state/decisions.md` only for a new decision the user made this session. Include the date, decision, and reason. If there was no decision, leave the file unchanged. Keep earlier entries intact.
3. Draft `agent/state/handoff.md` before the full gate. Use `Done` for completed work, `Gate` for `pending` until this run finishes, `Next` for the task id and remaining work, and `Open questions` for what only the user can answer.
4. Run `agent/gate` and copy its last line into `Gate`. Fix failures within the task's scope and rerun. If a failure remains, record it, leave the task incomplete, and report it without committing.
5. Apply the user review checkpoint in `agent/rules/process.md`. If completed work needs user review, record the pause and show the result with the gate outcome. Resume after approval; recheck any requested changes.
6. Once checks and required review pass, mark the task `done`, finalize the handoff, and commit them with the task's changes. If the commit fails, restore an incomplete status and report why.
7. Report the task id, commit hash, gate's last line, and `Next`. For unfinished work, report what remains instead of a commit hash.
