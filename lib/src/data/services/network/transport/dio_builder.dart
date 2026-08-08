import 'package:dio/dio.dart';

import '../auth/token_manager.dart';
import '../auth/token_store.dart';
import '../config/network_config.dart';
import '../config/server_error_parser.dart';
import 'interceptors/auth_header_interceptor.dart';
import 'interceptors/debug_logger_interceptor.dart';
import 'interceptors/error_attachment_interceptor.dart';
import 'interceptors/locale_header_interceptor.dart';
import 'interceptors/refresh_retry_interceptor.dart';

/// What [DioBuilder.build] returns: the transport [Dio] and its
/// [TokenManager], constructed together so their inter-dependencies
/// (TokenManager needs Dio for refresh; AuthHeaderInterceptor needs
/// TokenManager for lookups) resolve in one place.
///
/// `NetworkStack.transport` feeds Retrofit (`RestClient(stack.transport)`);
/// `NetworkStack.tokens` is for session lifecycle (`persist` after login,
/// `clear` on logout).
typedef NetworkStack = ({Dio transport, TokenManager tokens});

/// Production wiring for the network layer.
///
/// Pipeline (FIFO — `Dio` runs request interceptors in addition order,
/// error interceptors in addition order, response interceptors in
/// addition order):
///
/// 1. [LocaleHeaderInterceptor] (if [localeResolver] is provided) — sets
///    `Accept-Language` before downstream interceptors or the server see
///    the request.
/// 2. [AuthHeaderInterceptor] — injects Authorization for marked endpoints.
/// 3. [ErrorAttachmentInterceptor] — attaches the parsed [ServerError] to
///    [DioException.error] so repositories do not reparse the body.
/// 4. Consumer-provided [extraInterceptors] — run last before the logger
///    so they see the enriched state. This is the seam for telemetry
///    (Sentry, Datadog, Firebase Performance): add the SDK's own
///    interceptor here rather than wrapping the transport.
/// 5. [logger] (if non-null) — the single logging interceptor, supplied
///    by the DI wiring in `core/di/parts/externals.dart`. The DI default
///    is a debug-gated
///    `PrettyDioLogger`; this builder's own fallback is the stricter
///    [DebugLoggerInterceptor]. Whatever runs here sees the real request,
///    including the bearer token — release gating and redaction are the
///    logger's responsibility, not the pipeline's.
/// 6. [RefreshRetryInterceptor] — always last, so the logger records a
///    401 before the refresh and replay happen. Driven by the endpoint's
///    `RequestAuth` marker; call sites stay plain Retrofit calls.
class DioBuilder {
  const DioBuilder({
    required this.config,
    required this.store,
    required this.errorParser,
    required this.refreshEndpoint,
    this.localeResolver,
    this.extraInterceptors = const [],
    this.logger = const DebugLoggerInterceptor(),
  });

  final NetworkConfig config;
  final TokenStore store;
  final ServerErrorParser errorParser;
  final String refreshEndpoint;
  final LocaleResolver? localeResolver;
  final List<Interceptor> extraInterceptors;
  final Interceptor? logger;

  NetworkStack build() {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.sendTimeout,
        contentType: Headers.jsonContentType,
        headers: {...config.defaultHeaders},
      ),
    );

    final tokens = TokenManager(
      store: store,
      transport: dio,
      refreshEndpoint: refreshEndpoint,
    );

    dio.interceptors.addAll([
      if (localeResolver != null) LocaleHeaderInterceptor(localeResolver!),
      AuthHeaderInterceptor(tokens),
      ErrorAttachmentInterceptor(errorParser),
      ...extraInterceptors,
      ?logger,
      RefreshRetryInterceptor(tokens: tokens, transport: dio),
    ]);

    return (transport: dio, tokens: tokens);
  }
}
