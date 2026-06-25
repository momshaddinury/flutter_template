# Error Handling — `Result` + `Failure`

No exceptions cross layer boundaries. Repositories return `Result<T, Failure>`
and wrap work in `asyncGuard` (from the base `Repository`). **Not** `fpdart` /
`Either`.

```dart
// data/repositories/authentication_repository_impl.dart
@override
Future<Result<LoginResponseEntity, Failure>> login(
  LoginRequestEntity data,
) async {
  return asyncGuard(() async {
    final model = LoginRequestModel.fromEntity(data);
    final response = await remote.login(model.toJson());
    if (data.shouldRemeber ?? false) await _saveSession();
    return LoginResponseModel.fromJson(response.data);
  });
}
```

## Building blocks

- `Result` is a Freezed union: `Success({T? data})` | `Error(E error)`.
- `Failure` carries a `FailureType` enum + user-facing `message` (+ optional
  `code`, `stackTrace`). `Failure.mapExceptionToFailure` converts `DioException`,
  `CustomException`, and `Error` into typed failures.
- Use cases may downcast `Failure` → `String` for the UI (see `LoginUseCase`).

## Handle results exhaustively

Repository methods return `Result<T, Failure>`. Use cases that prepare data for
the UI project domain failures to user-facing strings in the same
`Success` / `Error` path — the `Result` union is unchanged; only the error
type narrows from `Failure` to `String`:

```dart
// LoginUseCase.call — UI-facing conversion (authentication_use_case.dart)
final Result<LoginResponseEntity, Failure> result = await repository.login(request);

return switch (result) {
  Success(:final data) => Success(data: data),
  // Failure → user-facing String (not a repository contract change)
  Error(:final error) => Error(error.message),
  _ => const Error('Something went wrong'),
};
```

Log errors via `Log` (`lib/src/core/logger/`). Never `print()` / `debugPrint()`.

See also: [networking](./networking.md), [state-management](./state-management.md).
