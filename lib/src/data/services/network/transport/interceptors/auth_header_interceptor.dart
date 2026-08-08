import 'package:dio/dio.dart';

import '../../auth/token_manager.dart';
import '../../exceptions.dart';
import '../../request_auth.dart';

/// Reads the access token from [TokenManager] and attaches it as
/// `Authorization: Bearer <token>` according to the endpoint's
/// [RequestAuth] mode (declared via `@Extra({requestAuthKey: ...})`).
///
/// - [RequestAuth.public] (and unmarked endpoints): pass through untouched.
/// - [RequestAuth.optional]: attach the token if one exists; proceed
///   anonymously otherwise.
/// - [RequestAuth.protected]: attach the token; when none is available,
///   reject with a [MissingAccessTokenException]. The exception classifier
///   maps that to `InfraFailure.unauthorized` →
///   `BusinessFailure.unauthenticated`, so the session-expired flow also
///   covers the cold-start case where the user was never signed in.
///
/// When the access token is missing but a refresh token exists, both
/// non-public modes first attempt a [TokenManager.refresh] so a lost or
/// expired access token recovers silently instead of sending the user to
/// the session-expired flow (protected) or quietly serving the guest
/// experience to a signed-in user (optional). Single-flight inside
/// [TokenManager] means a cold-start burst of requests shares one refresh
/// roundtrip. The refresh call itself is unmarked, so it passes through
/// this interceptor untouched — no recursion.
///
/// When a header is attached, the request is stamped with [authAttachedKey]
/// so `RefreshRetryInterceptor` knows a 401 on it is refresh-eligible.
class AuthHeaderInterceptor extends Interceptor {
  const AuthHeaderInterceptor(this._tokens);

  final TokenManager _tokens;

  static const _headerName = 'Authorization';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final raw = options.extra[requestAuthKey];
    final mode = raw is RequestAuth ? raw : RequestAuth.public;
    if (mode == .public) return handler.next(options);

    var token = await _tokens.accessToken;
    if (token == null || token.isEmpty) {
      token = await _recoveredToken();
    }

    if (token == null || token.isEmpty) {
      if (mode == .optional) return handler.next(options);
      // WHY: `true` runs the following error interceptors — without it dio
      // skips them and the logger/telemetry never see this failure class.
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const MissingAccessTokenException(),
        ),
        true,
      );
    }

    options.headers[_headerName] = 'Bearer $token';
    options.extra[authAttachedKey] = true;
    handler.next(options);
  }

  /// Attempts to recover a missing access token via refresh. Returns `null`
  /// when there is no refresh token or the refresh fails ([TokenManager]
  /// clears both tokens only when the failure is auth-definitive — see
  /// [TokenManager.refresh]); the caller then applies the per-mode fallback.
  Future<String?> _recoveredToken() async {
    final refreshToken = await _tokens.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) return null;
    try {
      return await _tokens.refresh();
    } catch (_) {
      return null;
    }
  }
}
