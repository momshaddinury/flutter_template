---
paths:
  - "lib/**/*.dart"
  - "test/**/*.dart"
---
# Architecture

Use the source project's layered design. Keep implementations as small as the task allows.

## Boundaries

| Location | Responsibility | May depend on |
|---|---|---|
| `domain/` | Entities, repository interfaces, use cases, business failures | Dart and pure domain values |
| `data/` | Services, server models, mappers, repository implementations | Domain, shared core, packages |
| `presentation/` | Widgets, providers, routing, display formatting | Domain, shared core, Flutter |
| `core/di/` | Dependency wiring | All layers |
| Other `core/` code | Shared primitives and utilities | Dependencies appropriate to every caller |

Domain code never imports Flutter, data, or presentation. Data and presentation never import each other.
Features are isolated; shared presentation code follows [presentation.md](presentation.md).
The guardian checks layer, feature, and service imports.

## Request flow

A widget starts a notifier operation. The notifier calls a use case, which calls a domain repository interface.
The data implementation calls a service, decodes its response, and maps it into domain values.
The result returns through the use case to the provider. The widget renders the provider state.

Repository operations return `Result<T, BusinessFailure>` at the domain boundary.
Services may throw infrastructure exceptions; repository guards translate them. Use `Unit` for operations with no payload.
Keep business decisions in use cases and display formatting in presentation.

Read [models.md](models.md), [network.md](network.md), [dependency_injection.md](dependency_injection.md), and [riverpod.md](riverpod.md) for those contracts.

## Generation and localization

Run `fvm dart run build_runner build --delete-conflicting-outputs` after changing annotated providers, models, or clients.
Generated Dart parts stay beside their source declarations. Never edit generated files.
Edit the ARB files under `lib/src/core/localization/` together, then run `fvm flutter gen-l10n`.
Read UI strings through `context.locale` and visual values through the existing theme extensions.
