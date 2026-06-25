# Code Generation (MANDATORY workflow)

This project relies heavily on code generation. **Any** change to a file with
`@riverpod`, `@freezed`, `@MappableClass`, or Retrofit annotations requires a
regen, or the app won't compile.

```bash
# one-time build
dart run build_runner build --delete-conflicting-outputs

# watch mode during development (preferred)
dart run build_runner watch --delete-conflicting-outputs

# regenerate localizations after editing ARB files
flutter gen-l10n
```

> If your team uses **FVM**, prefix commands with `fvm` (e.g.
> `fvm dart run build_runner build`). Note: no `.fvmrc` is committed in this
> repo, so plain `flutter`/`dart` is the current default.

## Generated files

Generated files end in `*.g.dart`, `*.freezed.dart`, `*.mapper.dart`,
`*.gen.dart` and are **gitignored**.

- ❌ Never hand-edit a generated file.
- ❌ Never commit a generated file.
- ✅ Re-run build_runner instead.

See also: [state-management](./state-management.md), [error-handling](./error-handling.md), [localization](./localization.md).
