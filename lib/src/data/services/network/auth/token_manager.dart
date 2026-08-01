import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../core/logger/log.dart';
import 'token_store.dart';

/// In-memory cache over a [TokenStore] with single-flight refresh.
///
/// The constructor starts the store read; readers await it once, then
/// read from memory. Writes are write-through: memory updates *after* the
/// store does, so a failed write cannot leave memory ahead of disk.
/// Refresh is single-flight — concurrent callers share one HTTP roundtrip
/// via an inflight [Completer]; while a [refresh] is in progress, later
/// callers await its outcome.
///
/// Refresh uses the same transport [Dio] as ordinary requests. The
/// refresh call is *unmarked*, which defaults to `RequestAuth.public`, so
/// the auth-header interceptor skips it; this class sends the refresh
/// token itself (see [_performRefresh] for the backend contract).
class TokenManager {
  TokenManager({
    required TokenStore store,
    required Dio transport,
    required String refreshEndpoint,
  }) : _store = store,
       _transport = transport,
       _refreshEndpoint = refreshEndpoint {
    _ready = _load();
  }

  final TokenStore _store;
  final Dio _transport;
  final String _refreshEndpoint;

  late final Future<void> _ready;
  String? _accessToken;
  String? _refreshToken;
  Completer<String>? _inflightRefresh;

  Future<String?> get accessToken async {
    await _ready;
    return _accessToken;
  }

  Future<String?> get refreshToken async {
    await _ready;
    return _refreshToken;
  }

  /// Stores [access] (and optionally [refresh]) in memory and the underlying
  /// store. Call after a successful login or signup response.
  ///
  /// Unlike reads (which swallow store errors and return null), a store
  /// *write* failure propagates by design: memory only updates after the
  /// store does, so a keystore failure surfaces as a failed login instead
  /// of a session that silently disappears on the next launch.
  Future<void> persist({required String access, String? refresh}) async {
    await _ready;
    await _store.write(TokenKey.access, access);
    _accessToken = access;
    if (refresh != null) {
      await _store.write(TokenKey.refresh, refresh);
      _refreshToken = refresh;
    }
  }

  /// Refreshes the access token. Concurrent callers share one HTTP roundtrip.
  ///
  /// On success the new access token is persisted and returned. On failure
  /// the underlying error rethrows — but what happens to the stored tokens
  /// depends on *why* the refresh failed:
  ///
  /// - **Auth-definitive** — the server rejected the refresh token (400/401/
  ///   403), the success response was malformed, or no refresh token exists.
  ///   The session is over; both tokens are [clear]ed.
  /// - **Transient** — timeout, connection error, 5xx, or any other fault
  ///   that proves nothing about the token's validity. Tokens are *kept*:
  ///   a momentary network failure or a refresh-endpoint outage must not
  ///   log the user out. The failed request still surfaces its original
  ///   error, and the next 401 triggers a fresh attempt.
  Future<String> refresh() async {
    await _ready;

    final existing = _inflightRefresh;
    if (existing != null) return existing.future;

    final completer = Completer<String>();
    _inflightRefresh = completer;
    unawaited(_runRefresh(completer));
    return completer.future;
  }

  Future<void> _runRefresh(Completer<String> completer) async {
    try {
      final newAccess = await _performRefresh();
      completer.complete(newAccess);
    } catch (e, stackTrace) {
      if (_isAuthDefinitive(e)) {
        // WHY: a throwing store must not leave the completer pending —
        // every request awaiting this refresh would hang forever.
        try {
          await clear();
        } catch (clearError, clearStack) {
          Log.error('TokenManager.clear failed: $clearError\n$clearStack');
        }
      }
      completer.completeError(e, stackTrace);
    } finally {
      _inflightRefresh = null;
    }
  }

  /// Whether a refresh failure proves the session is over. Clearing tokens
  /// is destructive, so the default is to keep them: only an explicit
  /// rejection of the refresh token (400/401/403) or a [StateError] from
  /// [_performRefresh] (no refresh token, malformed success response)
  /// qualifies. Timeouts, connection errors, and 5xx are transient.
  bool _isAuthDefinitive(Object error) {
    if (error is StateError) return true;
    if (error is DioException && error.type == DioExceptionType.badResponse) {
      return switch (error.response?.statusCode) {
        400 || 401 || 403 => true,
        _ => false,
      };
    }

    return false;
  }

  /// Empties memory and the underlying store.
  Future<void> clear() async {
    await _ready;
    _accessToken = null;
    _refreshToken = null;
    await _store.clear();
  }

  Future<void> _load() async {
    try {
      _accessToken = await _store.read(TokenKey.access);
      _refreshToken = await _store.read(TokenKey.refresh);
    } catch (e, stackTrace) {
      Log.error('TokenManager._load failed: $e\n$stackTrace');
    }
  }

  // WHY: the request/response shape below is the one backend-specific part
  // of this class — it matches the template's demo API (dummyjson.com:
  // refresh token in the body, camelCase keys). Adapt it to your backend
  // here; everything else (caching, single-flight, failure policy) is
  // contract-agnostic.
  Future<String> _performRefresh() async {
    final refreshToken = _refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw StateError('No refresh token available');
    }

    final response = await _transport.post<dynamic>(
      _refreshEndpoint,
      data: {'refreshToken': refreshToken},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw StateError('Refresh response was not a JSON object');
    }

    final newAccess = data['accessToken'];
    if (newAccess is! String || newAccess.isEmpty) {
      throw StateError('Refresh response missing accessToken');
    }

    await _store.write(TokenKey.access, newAccess);
    _accessToken = newAccess;

    final newRefresh = data['refreshToken'];
    if (newRefresh is String && newRefresh.isNotEmpty) {
      await _store.write(TokenKey.refresh, newRefresh);
      _refreshToken = newRefresh;
    }

    return newAccess;
  }
}
