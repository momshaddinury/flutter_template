---
paths:
  - "lib/**/*.dart"
  - "test/**/*.dart"
---
# Naming and Dart style

`agent/gate` runs the lints. This file holds naming decisions and Dart conventions that need judgment, plus short explanations and examples of linted rules.

## Names

- Name a widget by its role, never by its layout. `_ReportDay`, not `_DateRow`. `_TeamFilters`, not `_TeamFilterRow`. Figma layer names yield to this rule: `LogRow` becomes `LogEntry`. File names follow the class. Lint: `layout_named_widget`.
- No `App` prefix. `Button`, not `AppButton`. Keep `App` only where Flutter owns the term, such as `AppBar`. When the bare name collides with a Flutter class, pick a role name: `LabeledTextField`.
- No private top-level variables. Hang state off a named type, such as a static on the class that uses it.
- `Page` names what a route builds. Never `Screen`.
- A sheet or dialog presenter is a static method on its widget: `DatePicker.showRange(context, ...)`. Never a top-level `showX()`. Type the result. No `Object?` funnel and no `as`. Lint: `top_level_presenter`.

## Shape

- Dot shorthands wherever the context type is clear: `.center`, `.symmetric(horizontal: 16)`, `.all(8)`, `const .new()`. Geometry statics count: `EdgeInsetsGeometry` and `AlignmentGeometry` provide these constructors in the pinned Flutter SDK. Not on the left of `==`, and not as a statement.
- Wrap every `if` and `for` inside a list literal in `...[ ]`, one wrap per level, data lists included. Lint: `unwrapped_collection_branch`.
- A switch expression over a ternary for any branching value, nullable results included.
- `=>` only when the whole body fits on one line. Otherwise a block with `return`.
- A guard clause stays on one line: `if (records.isEmpty) return const SizedBox.shrink();`
- A UI fragment is a widget class, never a `Widget _build()` method. Lint: `widget_returning_helper`.

## Text

- Never `Text(..., style: ...)` in a shared component or a feature. Use a typography widget. When the style and color pair is missing, add the variant to `core/widgets/text/`. Lint: `text_style_outside_typography`. Exceptions: control labels styled by a component theme, and `Text.rich` spans.
- When Figma defines the type scale, typography classes mirror its style groups one to one. Never add a component-named text class.
