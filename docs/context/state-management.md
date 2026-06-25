# State Management — Riverpod

State management is **Riverpod 3.x** with code generation (`@riverpod`).
**Not** Bloc/Cubit.

- State lives in `@riverpod`-annotated notifiers/providers.
- Use `AsyncValue` for async screen state (loading / data / error).
- Use `@Riverpod(keepAlive: true)` for app-wide things (DI, router, auth/locale);
  default (auto-dispose) for screen-scoped state.

## Notifier (real example — `login_provider.dart`)

```dart
@riverpod
class Login extends _$Login {
  @override
  AsyncValue build() => const AsyncValue.data(null);

  void login({
    required String email,
    required String password,
    bool? shouldRemember,
  }) async {
    if (state.isLoading) return;
    state = const AsyncValue.loading();

    final result = await ref
        .read(loginUseCaseProvider)
        .call(email: email, password: password, shouldRemember: shouldRemember);

    state = switch (result) {
      Success() => AsyncValue.data(result),
      Error(:final error) => AsyncValue.error(error, StackTrace.current),
      _ => AsyncValue.error('Something went wrong', StackTrace.current),
    };
  }
}
```

## Consuming state in widgets

- Screens are `ConsumerWidget` / `ConsumerStatefulWidget`.
- `ref.watch(provider)` → rebuild on change.
- `ref.read(provider.notifier)` → call actions (in callbacks).
- `ref.listenManual(provider, ...)` → **side effects** (navigation, snackbars).

```dart
// side effects go in a listener, never in build()
ref.listenManual(loginProvider, (previous, next) {
  switch (next) {
    case AsyncData(:final value) when value != null:
      context.pushReplacementNamed(Routes.home);
    case AsyncError(:final error):
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    default:
  }
});
```

## Rules

- One domain per notifier.
- No `BuildContext` / navigation / widgets inside a notifier.
- Notifiers call **use cases / repositories**, never services or APIs directly.

See also: [dependency-injection](./dependency-injection.md), [error-handling](./error-handling.md).
