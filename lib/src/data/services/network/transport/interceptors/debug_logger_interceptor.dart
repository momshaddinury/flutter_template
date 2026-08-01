import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/logger/log.dart';

/// Minimal request/response logger that fires only in debug builds and
/// never logs the value of sensitive headers or request bodies.
///
/// Not the default — `networkLoggerProvider` ships `PrettyDioLogger` for
/// day-to-day debugging. Swap this in via that provider when logs must
/// stay free of bodies and header values (shared log sinks, screen
/// recordings, compliance-sensitive work).
///
/// What it logs:
/// - request: method + uri + a presence flag for the Authorization header
/// - response: status + method + uri + latency
/// - error: status (or '?') + method + uri + DioExceptionType
///
/// What it intentionally does *not* log:
/// - request body (may contain credentials, PII)
/// - response body (may contain tokens, PII)
/// - the value of the Authorization header (only whether one was set)
///
/// In release builds [kDebugMode] is `false` and every callback is a
/// no-op (`handler.next` only). The interceptor stays in the chain so
/// release/debug behavior diverges only in logging, not in request flow.
class DebugLoggerInterceptor extends Interceptor {
  const DebugLoggerInterceptor();

  static const _startTimeKey = '_debug_logger_start';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      options.extra[_startTimeKey] = DateTime.now();
      final hasAuth = options.headers.containsKey('Authorization');
      Log.debug(
        '→ ${options.method} ${options.uri}'
        '${hasAuth ? ' [auth: ✓]' : ''}',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      final elapsed = _elapsedFrom(response.requestOptions);
      Log.debug(
        '← ${response.statusCode} ${response.requestOptions.method} '
        '${response.requestOptions.uri}'
        '${elapsed != null ? ' (${elapsed.inMilliseconds}ms)' : ''}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final elapsed = _elapsedFrom(err.requestOptions);
      Log.warning(
        '✗ ${err.response?.statusCode ?? '?'} '
        '${err.requestOptions.method} ${err.requestOptions.uri} '
        '(${err.type})'
        '${elapsed != null ? ' (${elapsed.inMilliseconds}ms)' : ''}',
      );
    }
    handler.next(err);
  }

  Duration? _elapsedFrom(RequestOptions options) {
    final start = options.extra[_startTimeKey];
    if (start is DateTime) return DateTime.now().difference(start);
    return null;
  }
}
