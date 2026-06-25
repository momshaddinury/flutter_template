# Routing — GoRouter

Navigation is **GoRouter** (`^17.0.1`). Navigate by **name only** — never by raw
path string, and never use `Navigator.push/pop`.

- Route names/paths are constants in
  `lib/src/presentation/core/router/routes.dart` (the `Routes` class).
- The router is a `keepAlive` provider in `router.dart`; route groups live in
  `parts/` (`authentication_routes`, `on_boarding_routes`, `shell_routes`).
- The redirect/guard logic lives **only** in the router (driven by
  `routerStateProvider`) — never scatter auth checks across screens.

## Navigate by name

```dart
context.pushNamed(Routes.registration);
context.pushReplacementNamed(Routes.home);
context.goNamed(Routes.login);
context.pop();                          // GoRouter pop, not Navigator.pop
context.pushNamedAndRemoveUntil(Routes.login); // custom extension
```

Pass complex arguments via a typed model in `extra`, not many query params.

See also: [state-management](./state-management.md) (navigate from listeners, not `build()`).
