# The loop

Follow the user's current request. Use the `work-loop` skill for implementation, one task at a time.
For a review-only request, use `review-pass` to report findings without changing files or state.

The implementation loop is:

1. **Orient.** Read `state/handoff.md` and `state/plan.md`. Select the task using `rules/process.md`.
2. **Read.** Read the rule files relevant to the task. `work-loop` lists them.
3. **Spec.** State what changes, which files, and how you will check it. Reuse an approved brief when it covers these points.
4. **Execute.** Follow the editing roles in `rules/process.md`. Use `build-screen` for a screen.
5. **Review.** Use `review-pass` in implementation mode and address findings within the task's scope.
6. **Handoff.** Use `handoff` to prepare state, run the gate, complete any required user review, and commit.

User review checkpoints are defined in `rules/process.md`. They happen after the work is built and checked.

## What goes where

| It is | It goes to |
|---|---|
| A rule a machine can check on the AST | a guardian lint in `packages/flutter_guardian` |
| A rule a shell command can check | a function in `agent/gate` |
| A rule that needs judgement | one file under `rules/` |
| A repeatable procedure | a skill under `skills/` |
| A decision the user made | `state/decisions.md` |
| A task | `state/plan.md` |
| A fact about the user's machine or accounts | the agent's own memory, never the repo |

Each rule has one authoritative definition. Other files may link to it.
For linted rules, the lint defines what is enforced; keep a short explanation and example in the relevant rule file.
That file also holds any judgment the lint cannot check. Skills link to rules instead of repeating their details.
Decisions explain past choices; the current rules and skills define how to work.
The former architecture guides and coding guidelines are replaced by this folder.

## Layout

```
agent/
  README.md      this file
  gate           the one check; `agent/gate --quick` for mid-task runs
  rules/         architecture, dependencies, network, routing, naming,
                 comments, models, presentation, Riverpod, process, prose, pubspec
  state/         plan.md, decisions.md, handoff.md, archive/
  skills/        work-loop, build-screen, review-pass, handoff
```
