import 'package:dio/dio.dart';

/// Resolves the active language code (e.g. "en", "bn", "ar"). Typically
/// wired to the app's locale repository. Async to support repositories backed
/// by SharedPreferences or other I/O.
typedef LocaleResolver = Future<String?> Function();

/// Sets `Accept-Language` on every outgoing request based on [resolver].
/// Skips requests that already carry the header (consumer interceptors
/// take precedence) and resolver results that are null or empty. Resolver
/// failures never block the request — a request without the header is
/// better than one stalled on I/O.
class LocaleHeaderInterceptor extends Interceptor {
  LocaleHeaderInterceptor(this.resolver);

  final LocaleResolver resolver;

  static const _headerName = 'Accept-Language';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.containsKey(_headerName)) return handler.next(options);

    try {
      final locale = await resolver();
      if (locale != null && locale.isNotEmpty) {
        options.headers[_headerName] = locale;
      }
    } catch (_) {}

    handler.next(options);
  }
}
