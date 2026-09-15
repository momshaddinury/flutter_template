---
name: build-screen
description: Use when implementing a Flutter Template screen from a Figma frame, section, or node.
---

# Build a screen

1. Read `presentation.md`, `naming.md`, `comments.md`, and `process.md` under `agent/rules/`.
2. Fetch the frame and component states using the Figma rules in `process.md`.
3. List the shared design components the frame uses. For each, say whether it exists, needs a variant, or is new.
4. Choose each widget's ownership using `presentation.md`. For feature widgets, then choose its file and visibility.
5. Implement the frame using the naming, typography, and comment rules. Every visual value is a token. If Figma defines a value the theme lacks, add the token using its name in the Figma token tree.
6. Prepare icons using `process.md` and wire routes using `agent/rules/routing.md`.
7. Run the app in the simulator and compare it against the frame. Fix what differs.
8. Return to `work-loop` at the review step. Its handoff completes the gate and any user review required by `process.md` before another screen starts.
