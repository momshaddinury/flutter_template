# Network layer

How the template talks to a server: Retrofit call sites, a dio interceptor pipeline that handles auth invisibly, and five providers you override instead of editing transport code.

## The one rule at call sites

Repositories call Retrofit methods on `RestClient` and nothing else. No `dio.get`/`dio.post`, no token handling, no retry logic. Everything below this line is infrastructure the call site never sees.

```dart
final response = await remote.currentUser(); // token attach + 401 retry happen inside
```

## Marking endpoints: `RequestAuth`

One annotation on the Retrofit endpoint is the single source of truth for how a request participates in authentication. Both the header interceptor and the 401-retry interceptor read it.

```dart
/// Unmarked → RequestAuth.public: never carries a token.
@POST(Endpoints.login)
Future<HttpResponse> login(@Body() Map<String, dynamic> request);

/// Protected: bearer attached; 401 triggers refresh + replay.
@Extra({requestAuthKey: RequestAuth.protected})
@GET(Endpoints.currentUser)
Future<HttpResponse> currentUser();
```

Three modes:

- **`public`** (and every unmarked endpoint) — the interceptor never *attaches* a token, even when one exists. Login, signup, password reset, and the refresh call itself. A manually set `Authorization` header passes through untouched, so do not set one on public endpoints.
- **`optional`** — attach the token when one exists, proceed anonymously otherwise. For endpoints that serve guests but personalize for signed-in users.
- **`protected`** — attach the token; with no token available (and no recoverable refresh token), reject with `MissingAccessTokenException`, which the failure chain turns into `BusinessFailure.unauthenticated` — the session-expired UX path.

Unmarked-means-public is deliberate: the refresh call runs on the same transport with no extras, so "unmarked never carries a token" keeps the refresh path safe by construction. The cost is remembering to mark protected endpoints — a missing annotation fails loudly (401 on first use) rather than leaking a token.

## The pipeline

`DioBuilder` (in `lib/src/data/services/network/transport/dio_builder.dart`) assembles the transport. Interceptors run in this order:

1. **`LocaleHeaderInterceptor`** — stamps `Accept-Language` from `localeResolverProvider`.
2. **`AuthHeaderInterceptor`** — reads the endpoint's `RequestAuth` mode and attaches `Authorization: Bearer <token>`. When the access token is missing but a refresh token exists, it first attempts a recovery refresh so a lost access token heals silently.
3. **`ErrorAttachmentInterceptor`** — parses failing bodies via `ServerErrorParser` and attaches the structured `ServerError` to `DioException.error`, so nothing downstream reparses the body.
4. **Your extras** (`extraNetworkInterceptorsProvider`) — the seam for telemetry (Sentry, Datadog, Firebase Performance) and any other cross-cutting concern. Positioned here so your interceptor sees the enriched request (bearer attached) and the parsed error.
5. **Logger** (`networkLoggerProvider`) — see "Logging and redaction".
6. **`RefreshRetryInterceptor`** — last, so the logger has already recorded the failed attempt before the refresh + replay.

## The refresh contract

`TokenManager` owns tokens: an in-memory cache over a pluggable `TokenStore` (default: `flutter_secure_storage`), with single-flight refresh — concurrent callers share one HTTP roundtrip.

On a 401 whose request went out carrying a token, `RefreshRetryInterceptor` refreshes and replays the request once through the full chain. Guard rails:

- **One refresh + one replay per request.** The replay is stamped so its own 401 propagates instead of looping.
- **A late 401 never double-refreshes.** If the failed request carried a token that is no longer current (it raced a refresh that completed meanwhile), the interceptor replays directly with the fresh token — one rotation per expiry, even across concurrent requests. This matters on backends with single-use refresh tokens.
- **Anonymous 401s propagate untouched.** A guest hitting a members-only endpoint is a server signal, not a refresh trigger.
- **One-shot bodies (`FormData`) are not replayed** — the upload must be re-initiated by the caller.
- **Refresh failure ≠ logout.** Only an auth-definitive outcome — the server rejecting the refresh token (400/401/403), a malformed success response, or no refresh token at all — clears stored tokens. A timeout, connection error, or 5xx keeps them: a network blip or a refresh-endpoint outage must not log the user out.

The wire contract is the one backend-specific piece: a `POST` to `Endpoints.refreshToken` (`/auth/refresh`) with `{"refreshToken": …}` in the body, response parsed for `accessToken` (required) and `refreshToken` (optional rotation). All of it lives in `TokenManager._performRefresh` — the single method to adapt when your backend differs.

Session lifecycle from the app side: `tokens.persist(...)` after login, `tokens.clear()` on logout (see `AuthenticationRepositoryImpl`).

## Logging and redaction

The default logger is `pretty_dio_logger`, gated to debug builds and configured without request headers, so the bearer token never prints. Its package defaults do print response bodies — including the tokens in login and refresh responses — which suits local debugging but not a shared log sink.

The pipeline itself guarantees nothing here: whatever interceptor `networkLoggerProvider` supplies sees the real request, bearer token included, and owns its release gate and redaction. Two alternatives ship with the template: `DebugLoggerInterceptor`, the strict option (no bodies, no header values, debug-only — for compliance-sensitive work or shared sinks), and `null`, which disables request logging entirely.

## The five override points

All in `lib/src/core/di/parts/externals.dart`; override the provider, never edit transport code.

| Provider | Default | Override to |
|---|---|---|
| `networkConfigProvider` | `Endpoints.base`, 10 s timeouts | Switch base URL per flavor, tune timeouts, add default headers |
| `serverErrorParserProvider` | `DefaultServerErrorParser` (`{message, statusCode | code}` envelope; whole body kept in `ServerError.details`) | Match your backend's error envelope |
| `localeResolverProvider` | Reads `localeRepositoryProvider` | Source `Accept-Language` differently |
| `extraNetworkInterceptorsProvider` | `[]` | Add telemetry or other cross-cutting interceptors |
| `networkLoggerProvider` | Debug-gated `PrettyDioLogger` (no request headers) | Swap in `DebugLoggerInterceptor` (strict), another logger, or `null` to silence |

(`tokenStoreProvider` is a sixth, rarely needed: swap secure storage for another `TokenStore`.)

## Error flow

The transport never surfaces raw exceptions to features. The chain is:

```
DioException (+attached ServerError)
  → Object.toInfraFailure()        // data/failures/exception_classifier.dart
  → InfraFailure.toBusinessFailure() // data/failures/infra_failure_mapper.dart
  → Result<T, BusinessFailure>       // via BaseRepository.asyncGuard
```

See `docs/CODING_GUIDELINES.md` ("Failures") for the repository-side rules.

## Cancellation

The template ships no request-cancellation helper, on purpose. Riverpod's provider lifecycle already prevents the stale-response bug cancellation usually targets: when a provider is invalidated or disposed, a late response resolves into state nobody reads. Cancelling also saves little on typical small JSON calls — the server has already processed the request by the time the client cancels.

If your app moves large payloads (uploads, downloads, media) or drives aggressive search-as-you-type, add cancellation as a domain concept rather than passing dio's `CancelToken` through the layers: define a small pure-Dart `CancellationToken` interface in `domain/`, bridge it to a dio `CancelToken` inside the repository implementation, give the Retrofit endpoint a `@CancelRequest()` parameter, and expose a `Ref` extension in the presentation layer that cancels on dispose. The failure pipeline already maps a cancelled request to its own failure variant.

## Testing

`test/data/services/network/` shows the patterns (shared fakes live in its `helpers.dart`; `test/integration/dummyjson_smoke.dart` runs the stack against the live demo API):

- **Stub the adapter, not Dio**: `http_mock_adapter`'s `DioAdapter` with header-matched stubs lets one test distinguish the original request from its replay (`dio_builder_test.dart`).
- **Swap the whole stack in DI tests**: override `networkStackProvider` with `(transport: stubbedDio, tokens: testTokenManager)` and everything downstream (`restClientServiceProvider`) follows (`rest_client_test.dart`).
- **Count roundtrips with an interceptor**, not stub callbacks — `http_mock_adapter` fires its callback at registration, not per invocation (`refresh_retry_interceptor_test.dart`).
