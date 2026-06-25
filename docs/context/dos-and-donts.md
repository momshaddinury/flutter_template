# Do's and Don'ts (quick reference)

| Area | ✅ Do | ❌ Don't |
|---|---|---|
| State | `@riverpod` notifiers + `AsyncValue` | Bloc/Cubit, `setState` for business state |
| DI | Riverpod providers in `core/di/` | `get_it`, `injectable`, globals/singletons |
| Errors | return `Result<T, Failure>` via `asyncGuard` | `throw`, `fpdart`/`Either`, returning `null` on error |
| Theme | `context.color/textStyle/spacing/padding` | `Colors.*`, raw `TextStyle`, magic numbers |
| Sizing | theme tokens (`context.spacing.s16`) | `EdgeInsets.all(16)`, `SizedBox(height: 24)` |
| Nav | `context.*Named(Routes.x)` | `Navigator.push`, raw path strings |
| Side effects | `ref.listenManual` / listeners | side effects inside `build()` |
| Logging | `Log.info/error` | `print`, `debugPrint` |
| Imports | relative, single-quote, trailing comma | package imports within `lib/src`, double quotes |
| Codegen | run build_runner after annotation edits | hand-edit / commit `*.g/.freezed/.mapper.dart` |
| Layers | keep `domain` framework-free | Flutter/Dio imports in `domain` |
