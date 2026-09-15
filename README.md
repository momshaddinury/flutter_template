# Flutter Template

A Flutter starter with authentication, Riverpod state and dependency injection, named routing, a Dio/Retrofit network stack, localization, and theme extensions.

## Setup

Use the Flutter version pinned in [.fvmrc](.fvmrc). Install FVM, then run from the repository root:

```bash
fvm install
fvm flutter pub get
(cd packages/flutter_guardian && fvm dart pub get)
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
fvm flutter run
```

Generated files are ignored. Regenerate them after cloning or changing annotated declarations.

## Development

Start with [AGENTS.md](AGENTS.md). Claude Code, Cursor, and Codex use the same [agent system](agent/README.md).
It contains the workflow, current rules, skills, and task state.
The previous architecture documents and coding guidelines have been replaced by this system.

- [Architecture](agent/rules/architecture.md): layer boundaries and request flow.
- [Models](agent/rules/models.md): server shapes, entities, and presentation models.
- [Presentation](agent/rules/presentation.md): widget ownership and placement.
- [Riverpod](agent/rules/riverpod.md): provider modules, state, and effects.
- [Dependency injection](agent/rules/dependency_injection.md), [network](agent/rules/network.md), and [routing](agent/rules/routing.md).
- [Naming](agent/rules/naming.md), [comments](agent/rules/comments.md), and [prose](agent/rules/prose.md).

The template keeps its existing typography under `presentation/core/widgets/text/` and shared components under `core/widgets/`.
Rules adapted from the source project describe how to develop this template; they do not imply every older file has been migrated.

## Checks

```bash
agent/gate --quick
agent/gate
```

The full gate checks formatting, analysis, comment conventions, task state, app tests, and guardian tests.
Its first run configures `.githooks/pre-commit`, which runs the staged quick gate.
Use `fvm dart analyze` for native analyzer plugins.

For focused tests:

```bash
fvm flutter test test/presentation/core/router/
(cd packages/flutter_guardian && fvm dart test)
```

Live API smoke tests are manual and separate from normal verification.

## Reusing the template

Set the app identity, backend configuration, localization, and theme for the consuming project.
Start a new task list under `agent/state/` and record its decisions there.
When a task supplies Figma designs, use the `build-screen` skill with that project's design file.

## License

See [LICENSE](LICENSE).
