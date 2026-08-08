import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/auth/token_store.dart';
import 'package:flutter_template/src/data/services/network/request_auth.dart';

const testBaseUrl = 'https://test.local';
const testRefreshPath = '/auth/refresh';

/// Marks a request with the given [RequestAuth] mode, the way a Retrofit
/// `@Extra` annotation would.
Options authed(RequestAuth mode) => Options(extra: {requestAuthKey: mode});

/// In-memory [TokenStore] with fault injection and a write log.
class FakeTokenStore implements TokenStore {
  FakeTokenStore({Map<TokenKey, String>? initial}) : _data = {...?initial};

  final Map<TokenKey, String> _data;

  /// When set, the matching operation throws this instead of completing.
  Object? readThrows;
  Object? writeThrows;
  Object? clearThrows;

  /// Every successful write, in order.
  final List<(TokenKey, String)> writes = [];

  @override
  Future<String?> read(TokenKey key) async {
    if (readThrows != null) throw readThrows!;
    return _data[key];
  }

  @override
  Future<void> write(TokenKey key, String value) async {
    if (writeThrows != null) throw writeThrows!;
    writes.add((key, value));
    _data[key] = value;
  }

  @override
  Future<void> delete(TokenKey key) async {
    _data.remove(key);
  }

  @override
  Future<void> clear() async {
    if (clearThrows != null) throw clearThrows!;
    _data.clear();
  }
}

/// Records requests and errors as they pass through the chain.
///
/// http_mock_adapter's stub callbacks fire once at *registration*, not per
/// invocation — counting via an interceptor is the simplest reliable way to
/// assert how many HTTP roundtrips actually happened.
class RecordingInterceptor extends Interceptor {
  final Map<String, int> calls = {};
  final List<String?> authHeaders = [];
  final List<Object?> bodies = [];
  final List<Object?> errors = [];

  int callsTo(String path) => calls[path] ?? 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    calls[options.path] = (calls[options.path] ?? 0) + 1;
    authHeaders.add(options.headers['Authorization'] as String?);
    bodies.add(options.data);
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    errors.add(err.error);
    handler.next(err);
  }
}
