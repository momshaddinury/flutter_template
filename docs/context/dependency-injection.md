# Dependency Injection

DI is plain **Riverpod providers** (not get_it/injectable), organized with
`part` files under `lib/src/core/di/`.

| Part file | Provides |
|---|---|
| `parts/externals.dart` | `sharedPreferencesProvider`, `dioProvider` (Dio + `TokenManager` + `PrettyDioLogger`) |
| `parts/services.dart` | `cacheServiceProvider`, `restClientServiceProvider` |
| `parts/repository.dart` | repository providers |
| `parts/use_cases.dart` | use case providers |

```dart
// parts/repository.dart
@Riverpod(keepAlive: true)
AuthenticationRepository authenticationRepository(Ref ref) {
  return AuthenticationRepositoryImpl(
    remote: ref.read(restClientServiceProvider),
    local: ref.read(cacheServiceProvider),
  );
}
```

## Enforced naming (flutter_guardian)

Identifiers declared in these files **must** contain a keyword, or the custom
linter reports an **error**:

- `di/parts/repository.dart` → must contain `"Repository"`
- `di/parts/services.dart` → must contain `"Service"`
- `di/parts/use_cases.dart` → must contain `"UseCase"`

See also: [naming-conventions](./naming-conventions.md), [networking](./networking.md).
