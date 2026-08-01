import 'package:dio/dio.dart';

import '../../auth/token_manager.dart';
import '../../request_auth.dart';

/// Refresh-on-401, invisible at the call site. Repositories call Retrofit
/// methods directly (`remote.login(...)`); when a request that went out
/// carrying an access token ([authAttachedKey] stamped by
/// `AuthHeaderInterceptor`) comes back 401, this interceptor refreshes via
/// [TokenManager] and replays the request once through the full chain —
/// the retry picks up the new token from `AuthHeaderInterceptor` like any
/// other request.
///
/// Guard rails:
/// - Anonymous 401s (no [authAttachedKey]) propagate untouched — a guest
///   hitting a members-only endpoint is a server signal, not a refresh
///   trigger.
/// - The retry is stamped so its own 401 is never refresh-eligible: one
///   refresh + one replay per request, no loops. The refresh call itself
///   is unmarked (`RequestAuth.public`), so it can never trigger this
///   interceptor either.
/// - One-shot bodies ([FormData]) cannot be replayed; those 401s propagate
///   and the upload must be re-initiated by the caller.
/// - A 401 whose request carried a token that is no longer current (it
///   raced a refresh that has since completed) replays directly without a
///   second refresh — one rotation per expiry, even across concurrent
///   requests whose 401s arrive after the shared refresh resolved.
/// - A failed refresh propagates the original 401. [TokenManager] decides
///   what a failure means for the stored tokens: cleared when the server
///   rejected the refresh token, kept when the failure was transient.
///
/// This is a plain [Interceptor], not a [QueuedInterceptor]: the replay
/// re-enters this same interceptor's chain, which would deadlock a queued
/// one. Concurrent 401s are deduplicated by [TokenManager]'s single-flight
/// refresh instead — each caller shares one HTTP roundtrip, then replays
/// its own request.
class RefreshRetryInterceptor extends Interceptor {
  RefreshRetryInterceptor({
    required TokenManager tokens,
    required Dio transport,
  }) : _tokens = tokens,
       _transport = transport;

  final TokenManager _tokens;
  final Dio _transport;

  static const _retriedKey = 'auth.retried';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_eligible(err)) return handler.next(err);

    // WHY: a 401 that raced an already-completed refresh must not rotate
    // again — on single-use refresh tokens a second rotation invalidates
    // the session. Replay directly; AuthHeaderInterceptor attaches the
    // current token.
    if (await _tokenIsStale(err.requestOptions)) return _replay(err, handler);

    final refreshed = await _refresh();
    if (!refreshed) return handler.next(err);

    return _replay(err, handler);
  }

  Future<bool> _tokenIsStale(RequestOptions options) async {
    final current = await _tokens.accessToken;
    if (current == null || current.isEmpty) return false;

    return options.headers['Authorization'] != 'Bearer $current';
  }

  Future<void> _replay(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions..extra[_retriedKey] = true;
    try {
      handler.resolve(await _transport.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    } catch (retryError) {
      // WHY: a non-Dio failure (a throwing transformer or adapter) must
      // still complete the handler chain — otherwise the caller's future
      // never finishes. The original 401 propagates with the replay
      // failure attached.
      handler.next(err.copyWith(error: retryError));
    }
  }

  bool _eligible(DioException err) {
    final options = err.requestOptions;
    return err.response?.statusCode == 401 &&
        options.extra[authAttachedKey] == true &&
        options.extra[_retriedKey] != true &&
        options.data is! FormData;
  }

  Future<bool> _refresh() async {
    try {
      await _tokens.refresh();

      return true;
    } catch (_) {
      // WHY: TokenManager owns what a failure means for the stored tokens;
      // here it only means the original 401 propagates.
      return false;
    }
  }
}
