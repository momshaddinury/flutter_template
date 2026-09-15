---
paths:
  - "lib/src/core/di/**/*.dart"
  - "lib/src/domain/use_cases/**/*.dart"
---
# Dependency injection

Riverpod providers wire the layers together. Add wiring under `lib/src/core/di/parts/`.

| File | Holds | Lifetime | Provider name |
|---|---|---|---|
| `externals.dart` | Package objects, network stack, tokens, crash reporter | `keepAlive: true` | Name the dependency |
| `services.dart` | Cache and network service providers | `keepAlive: true` | Contains `Service` |
| `repository.dart` | Domain repository implementations | `keepAlive: true` | Contains `Repository` |
| `use_cases.dart` | Use cases | Auto-dispose | Contains `UseCase` |

The guardian enforces DI names and lifetimes. The long-lived objects hold application state; use cases are stateless.
Use `ref.watch` when composing providers so overrides and invalidations rebuild their dependents.
Use `ref.read` inside callbacks and operation methods. Follow [riverpod.md](riverpod.md) for presentation state.

When adding a dependency, define its domain interface and data implementation, register the provider, and regenerate code.
Override providers in tests to supply fakes. Keep the application's single provider container in `bootstrap()`.
The `only_use_keep_alive_inside_keep_alive` diagnostic remains disabled for the template's existing dependency graph.

Configure network overrides in `networkStackProvider`; see [network.md](network.md).
Use `ResetRepositoryUseCase` when resetting session-scoped repositories. Invalidate the relevant status provider after authentication changes.
