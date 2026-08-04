part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) =>
    SharedPreferences.getInstance();

/// The single place to adapt the network stack. Every [DioBuilder]
/// argument below is a deliberate seam; change it here, never in
/// transport code:
///
/// - `config` — base URL, timeouts, default headers ([NetworkConfig]).
/// - `store` — token persistence; swap [SecureTokenStore] for another
///   [TokenStore] to change key management.
/// - `errorParser` — match your backend's error envelope.
/// - `localeResolver` — sources `Accept-Language`; defaults to reading
///   the locale repository.
/// - `extraInterceptors` — appended after the template's core stack, the
///   seam for telemetry (Sentry, Datadog, Firebase Performance) and any
///   other cross-cutting concern. Documented order is in [DioBuilder].
/// - `logger` — the single logging interceptor, placed last before
///   `RefreshRetryInterceptor` so a 401 is logged before the refresh +
///   replay. The default is `PrettyDioLogger`, active in debug builds
///   only and configured to omit request headers (the pipeline hands the
///   logger the real request, bearer token included). Its package
///   defaults still print response bodies, which include the tokens in
///   login and refresh responses — acceptable for local debugging, not
///   for a shared log sink. Alternatives: [DebugLoggerInterceptor], the
///   template's strict option (no bodies, no header values, redaction
///   built in); any other logging [Interceptor] (talker, a custom one —
///   supply your own release gate and redaction); or `null` to disable
///   request logging entirely.
@Riverpod(keepAlive: true)
NetworkStack networkStack(Ref ref) {
  final logger = kDebugMode
      ? PrettyDioLogger(requestHeader: false, compact: true)
      : null;

  return DioBuilder(
    config: const NetworkConfig(),
    store: SecureTokenStore(),
    errorParser: const DefaultServerErrorParser(),
    refreshEndpoint: Endpoints.refreshToken,
    localeResolver: () => ref.read(localeRepositoryProvider).getLanguage(),
    extraInterceptors: const [],
    logger: logger,
  ).build();
}

@Riverpod(keepAlive: true)
TokenManager tokenManager(Ref ref) => ref.watch(networkStackProvider).tokens;
