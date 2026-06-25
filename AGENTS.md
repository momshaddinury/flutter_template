# AGENTS.md — Project Context

> Index for `flutter_template` (Clean Architecture). Pick the topic you need
> below; each links to one focused doc in [`docs/context/`](./docs/context/)
> whose examples match the real code. **Follow this repo's conventions**, even
> when they differ from generic Flutter habits.
>
> **SDK:** Dart `^3.10.3`, Flutter `>=3.38.4`.

## Map (one file = one concern)

| Topic | Doc |
|---|---|
| 🏛️ Layers & dependency direction | [architecture](./docs/context/architecture.md) |
| 🗂️ Directory layout | [project-structure](./docs/context/project-structure.md) |
| ⚙️ Code generation (build_runner, gen-l10n) | [codegen](./docs/context/codegen.md) |
| 🧠 State management — Riverpod (not Bloc) | [state-management](./docs/context/state-management.md) |
| 🔌 Dependency injection — Riverpod (not get_it) | [dependency-injection](./docs/context/dependency-injection.md) |
| 🧭 Routing — GoRouter, named routes | [routing](./docs/context/routing.md) |
| 🎨 Theming — `context.*` (not AppTheme/AppSize) | [theming](./docs/context/theming.md) |
| 🛑 Error handling — `Result`/`Failure` (not fpdart) | [error-handling](./docs/context/error-handling.md) |
| 🌐 Networking & data — Retrofit/Dio, dart_mappable | [networking](./docs/context/networking.md) |
| 🌍 Localization — ARB (en/bn/ar) | [localization](./docs/context/localization.md) |
| 🏷️ Naming & lint conventions | [naming-conventions](./docs/context/naming-conventions.md) |
| ➕ Adding a new feature (recipe) | [adding-a-feature](./docs/context/adding-a-feature.md) |
| ✅ Do's and Don'ts | [dos-and-donts](./docs/context/dos-and-donts.md) |
| ⚠️ Known gotchas | [gotchas](./docs/context/gotchas.md) |

## Non-negotiables

- Use **Riverpod** for state + DI. No Bloc/Cubit, `get_it`, or `fpdart`.
- Theme only via `context.color/textStyle/spacing/padding` — never hardcode.
- Repositories return `Result<T, Failure>` via `asyncGuard` — never throw across layers.
- Navigate by route name; never `Navigator.push/pop` or raw paths.
- Run **build_runner** after editing annotated files; never commit generated files.

Full rules: [dos-and-donts](./docs/context/dos-and-donts.md).
