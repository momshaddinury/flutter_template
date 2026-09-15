---
paths:
  - "lib/**/*.dart"
  - "test/**/*.dart"
---
# Comments

Write a comment only when the code cannot say the same thing. Good names beat comments. If a variable needs a comment, rename it. If a block needs one, extract a function with a good name.

## What gets a comment

- Why the code does it this way, when the code alone leaves a reader guessing.
- A business rule, a choice between two options, or a limit the code can't show.
- Surprising code: a line that looks wrong but is right. Say why.
- A warning of consequences: what breaks if you change or misuse this.
- A rule of a public API that the signature leaves out: who owns a value, what null means, which parameters can't go together, side effects, exact UI text, units.
- A known problem, tagged `TODO(#123)`.
- A source: the Figma node, the spec, the package issue.

## What doesn't

- Anything that repeats a name or signature. `onTap` needs no "Called when the user taps".
- Numbers and token names the code reads from the theme. If the widget reads `dimensions.size.touch`, the doc doesn't say "44dp". Keep a number only when it explains a surprise.
- Private widgets and helpers. The name is the doc. One line at most, and only when the name leaves a real question.
- Lists of similar widgets. One pointer to a widget a caller might pick by mistake is fine.
- Author names, dates, change logs, closing-brace markers, commented-out code. Git keeps those.

## Class doc shape for widgets

In this order, each a plain sentence or two:

1. What it is. "A tile in the date picker's months or years grid."
2. What it does and who owns what. "The tile shows one month or year and reports taps. It doesn't track selection: the picker passes the state to draw."
3. Design information only where the code stays silent: what each visual state means to the user, which state wins on a tie, why a size is fixed.
4. The design link, last: `/// Design: <Figma node URL>`.

Use this shape only for information the widget needs to explain.

A class whose name and members say it all gets no doc.

## Public members

A public field or parameter keeps a doc only when it says something the code doesn't show. Follow Effective Dart's formulas: "Whether ..." for booleans, a noun phrase for values, a third-person verb for methods. Don't write "Defaults to 6" when the constructor shows `= 6`.

Typography variant docs stay one line naming the style pair, such as `body/14` in `text/muted`.

## TODOs

```dart
// TODO(#123): what waits, and on what.
```

Always a ticket number. Topic-only tags such as `TODO(api)` are not allowed. `FIXME` and `HACK` follow the same form.

## Links

One line, the last in the doc comment:

```dart
/// Design: <URL of the component in the consuming project's design file>
```

Package quirks and API contracts link the issue or the spec the same way, with `See:` in place of `Design:`.

## Language

Follow [prose.md](prose.md) for sentence style, terminology, and literal UI text.

## Keep it current

A wrong comment is worse than none. Touching a member means rereading its doc. The `comment_references` lint fails analysis when a `[ref]` points at a symbol that no longer exists.
