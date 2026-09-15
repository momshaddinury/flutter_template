---
paths:
  - "lib/src/presentation/**/*.dart"
---
# Riverpod

## Provider modules

Keep a provider directly in `riverpod/` when it has no companion state types.
When a provider owns state classes or enums, give it a provider-named folder
inside `riverpod/` and keep the provider, generated file, and owned state types
together. Provider-owned state does not go in the feature's general `models/`
folder.

```text
riverpod/
  login_provider.dart
  reset_flow/
    reset_flow_provider.dart
    reset_flow_provider.g.dart
    reset_flow_state.dart
```

## Watched state

In a presentation widget, name the value returned by
`ref.watch(<name>Provider)` `<name>State`.

```dart
final loginState = ref.watch(loginProvider);
final itemsState = ref.watch(itemsProvider(category));
```

Hoist an inline watch to a local even when the widget reads it once. Derive other
values from that local so the watched state remains visible.

```dart
final sessionStatusState = ref.watch(sessionStatusProvider);
final signedIn = sessionStatusState.value ?? false;
```

This naming applies to widgets that render provider state. Dependency injection
and provider composition keep names that describe the dependency or value; do
not call a repository, use case, or domain value `repositoryState` merely
because it came from `ref.watch`.

## Operation side effects

Register `ref.listenManual` in a `ConsumerState.initState` for side effects
caused by an asynchronous provider operation. The listener handles navigation,
toasts, dialogs, sheets, and focus changes after the provider reports success or
failure. The event callback only starts the operation.

```dart
@override
void initState() {
  super.initState();
  ref.listenManual(saveProvider, (previous, next) {
    if (next case AsyncData(value: true)) context.pop();
    if (next case AsyncError(:final error)) _showFailure(error);
  });
}

void _save() {
  ref.read(saveProvider.notifier).save();
}
```

React to completed state transitions, not loading or unchanged states, so one
operation causes one effect. Riverpod owns the manual listener subscription and
closes it with the widget.

Navigation caused directly by a tap is not an operation side effect. Keep route
links, back actions, and opening a form in their callbacks.

## Provider lifecycle

- Declare providers at the top level with Riverpod annotations. A provider owns its initial state.
- Use `ref.watch` in provider and widget builds. Use `ref.read` in event callbacks and notifier methods.
- Keep form values, controllers, and animations in the widget. Use providers for shared application state.
- Use `AsyncValue` for asynchronous state. Do not duplicate its loading, data, and error states in a status enum.
- Use a notifier when callers need operation methods; use a function provider for derived or fetched values.
- Keep providers auto-disposed unless they have application lifetime. Dependency lifetimes are in [dependency_injection.md](dependency_injection.md).
- After an `await`, check `ref.mounted` before changing notifier state or reading its dependencies.
- Keep writes in notifier methods. Provider builds describe reads and derivations.
- Automatic retry is disabled in `bootstrap()`. Enable it on a specific provider only when the task needs it.
- For authentication changes, invalidate the appropriate status provider and let the router gate navigate. See [routing.md](routing.md).
