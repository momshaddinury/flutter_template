---
paths:
  - "lib/**/*.dart"
  - "test/**/*.dart"
---
# Presentation layer

First decide who owns a widget: the design system, multiple features, or one feature.
Then choose its file and visibility. Create folders when code needs them.

## Folders

```text
presentation/
  core/
    application_state/ shared providers
    extensions/        shared UI behavior on domain values
    models/            shared presentation models
    router/            Routes, RedirectGate, and route definitions
    theme/             design tokens and component themes
    widgets/           shared widgets, grouped by purpose
      text/            typography widgets
  features/
    <feature>/
      models/          feature presentation models
      riverpod/        feature providers and their owned state
      view/            routed pages
      widgets/         page parts and feature widgets
```

A feature group may contain subfeatures with distinct pages and state.
Code shared by those subfeatures goes in `<feature>/core/`, using the same ownership folders.
Code outside the feature group may not import its internal `core/`.

## Choose ownership

- **Design component:** use `presentation/core/widgets/<category>/`, even when only one page uses it. Accept primitives, callbacks, and child widgets. Do not read providers or import feature or domain types. Link its design when one is supplied. Design components get widget tests.
- **Shared application widget:** use `presentation/core/widgets/` when two or more features use it. It may accept domain or presentation values through parameters. Keep provider reads at the page or app frame.
- **Feature widget:** keep it in the owning feature. A feature may not import another feature's widgets. Test feature widgets when they carry logic.

Move a widget on its second feature use. Keep its parameters until a third use shows what needs to become more general.
The existing app frame is `core/widgets/navigation_shell.dart`; startup UI is under `core/widgets/startup/`.
These widgets integrate with the router and may read application providers.

## Choose a feature widget's file

Use a public class with its own imports in `features/<feature>/widgets/` when it:

- Is used by two or more pages of that feature.
- Owns state, an animation, or a controller.
- Needs a separate widget test.

Otherwise, keep a small stateless widget as a private class in its page file.
About 50 lines is a useful size guide. A UI fragment is always a widget class; see [naming.md](naming.md).

When private widgets make a page file long, split them into `widgets/` using `part`.
The widgets share the page's imports and private scope. A shared public widget uses its own imports instead.
A large public feature widget may also split private helpers into parts.

```dart
// view/catalog_page.dart
part '../widgets/catalog_filters.dart';
part '../widgets/catalog_list.dart';
```

## Names and state

- A route builds an `XPage`. A private variant of its body may be `_XView`.
- Use role names for other widgets and the consuming project's established component names.
- Keep screen-only state, controllers, and animations in the widget.
- Feature providers live under `riverpod/`. Providers shared by subfeatures live under `<feature>/core/riverpod/`.
- State read by multiple features lives in `presentation/core/application_state/`.
- Follow [models.md](models.md) for entities, presentation models, and extensions.
- Follow [riverpod.md](riverpod.md) for provider modules, watched-state names, and operation side effects.
- Follow [routing.md](routing.md) for navigation.
