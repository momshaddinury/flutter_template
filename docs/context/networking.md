# Networking & Data Layer

- **`RestClient`** (Retrofit, `data/services/network/rest_client.dart`) defines
  API methods; base URL is in `endpoints.dart` (currently
  `https://dummyjson.com`).
- **`TokenManager`** interceptor handles auth headers / refresh.
- **`CacheService`** wraps `shared_preferences`; keys are the `CacheKey` enum
  (`accessToken`, `refreshToken`, `isOnBoardingCompleted`, `isLoggedIn`,
  `rememberMe`, `language`).
- **Models** use `dart_mappable` and extend their domain entities; map
  entity↔model at the repository boundary
  (`LoginRequestModel.fromEntity`, `LoginResponseModel.fromJson`).

## Rules

- Repository impls call **services** only — never expose Dio/Retrofit upward.
- Wrap network calls in `asyncGuard` so failures become `Result` / `Failure`.

See also: [error-handling](./error-handling.md), [dependency-injection](./dependency-injection.md).
