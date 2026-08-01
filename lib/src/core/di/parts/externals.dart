part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) =>
    SharedPreferences.getInstance();

@Riverpod(keepAlive: true)
NetworkConfig networkConfig(Ref ref) => const NetworkConfig();

@Riverpod(keepAlive: true)
ServerErrorParser serverErrorParser(Ref ref) =>
    const DefaultServerErrorParser();

/// Resolves the current language for `Accept-Language`. Defaults to reading
/// from [localeRepositoryProvider]; override to plug a different source.
@Riverpod(keepAlive: true)
LocaleResolver localeResolver(Ref ref) =>
    () => ref.read(localeRepositoryProvider).getLanguage();

/// Override to append consumer-provided Dio interceptors after the
/// template's core stack — the seam for telemetry (Sentry, Datadog,
/// Firebase Performance) and any other cross-cutting concern. Documented
/// order is in [DioBuilder].
@Riverpod(keepAlive: true)
List<Interceptor> extraNetworkInterceptors(Ref ref) => const [];

/// The single logging interceptor, placed last before `RefreshRetryInterceptor`
/// so a 401 is logged before the refresh + replay.
///
/// The default is `PrettyDioLogger`, active in debug builds only and
/// configured to omit request headers (the pipeline hands the logger the
/// real request, bearer token included). Its package defaults still print
/// response bodies, which include the tokens in login and refresh
/// responses — acceptable for local debugging, not for a shared log sink.
///
/// Alternatives, all one override away:
/// - [DebugLoggerInterceptor] — the template's strict option: no bodies,
///   no header values, redaction built in.
/// - Any other logging [Interceptor] (talker, a custom one) — supply your
///   own release gate and redaction; neither carries over from the
///   default.
/// - `null` — disables request logging entirely.
@Riverpod(keepAlive: true)
Interceptor? networkLogger(Ref ref) =>
    kDebugMode ? PrettyDioLogger(requestHeader: false, compact: true) : null;

@Riverpod(keepAlive: true)
TokenStore tokenStore(Ref ref) => SecureTokenStore();

@Riverpod(keepAlive: true)
NetworkStack networkStack(Ref ref) => DioBuilder(
  config: ref.watch(networkConfigProvider),
  store: ref.watch(tokenStoreProvider),
  errorParser: ref.watch(serverErrorParserProvider),
  refreshEndpoint: Endpoints.refreshToken,
  localeResolver: ref.watch(localeResolverProvider),
  extraInterceptors: ref.watch(extraNetworkInterceptorsProvider),
  logger: ref.watch(networkLoggerProvider),
).build();

@Riverpod(keepAlive: true)
TokenManager tokenManager(Ref ref) => ref.watch(networkStackProvider).tokens;
