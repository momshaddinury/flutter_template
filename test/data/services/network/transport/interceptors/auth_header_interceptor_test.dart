import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/auth/token_manager.dart';
import 'package:flutter_template/src/data/services/network/auth/token_store.dart';
import 'package:flutter_template/src/data/services/network/exceptions.dart';
import 'package:flutter_template/src/data/services/network/request_auth.dart';
import 'package:flutter_template/src/data/services/network/transport/interceptors/auth_header_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../helpers.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late TokenManager tokens;

  /// Captures what the request looked like after the interceptor ran.
  String? capturedAuthHeader;
  Object? capturedAttachedFlag;

  setUp(() {
    capturedAuthHeader = null;
    capturedAttachedFlag = null;
  });

  void setupWith({String? accessToken, String? refreshToken}) {
    dio = Dio(BaseOptions(baseUrl: testBaseUrl));
    adapter = DioAdapter(dio: dio);
    final initial = <TokenKey, String>{};
    if (accessToken != null) initial[TokenKey.access] = accessToken;
    if (refreshToken != null) initial[TokenKey.refresh] = refreshToken;
    tokens = TokenManager(
      store: FakeTokenStore(initial: initial),
      transport: dio,
      refreshEndpoint: testRefreshPath,
    );
    dio.interceptors.add(AuthHeaderInterceptor(tokens));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.path != testRefreshPath) {
            capturedAuthHeader = options.headers['Authorization'] as String?;
            capturedAttachedFlag = options.extra[authAttachedKey];
          }
          handler.next(options);
        },
      ),
    );
  }

  final throwsMissingAccessToken = throwsA(
    isA<DioException>().having(
      (e) => e.error,
      'error',
      isA<MissingAccessTokenException>(),
    ),
  );

  group('AuthHeaderInterceptor', () {
    test(
      'protected: attaches Bearer token and stamps authAttachedKey',
      () async {
        setupWith(accessToken: 'a.tok');
        adapter.onGet('/me', (request) => request.reply(200, {'ok': true}));

        await dio.get<dynamic>('/me', options: authed(RequestAuth.protected));

        expect(capturedAuthHeader, 'Bearer a.tok');
        expect(capturedAttachedFlag, isTrue);
      },
    );

    test('unmarked (public): passes through unchanged', () async {
      setupWith(accessToken: 'a.tok');
      adapter.onGet('/public', (request) => request.reply(200, {'ok': true}));

      await dio.get<dynamic>('/public');

      expect(capturedAuthHeader, isNull);
      expect(capturedAttachedFlag, isNull);
    });

    test('optional: attaches token and stamp when a token exists', () async {
      setupWith(accessToken: 'a.tok');
      adapter.onGet('/products', (request) => request.reply(200, {'ok': true}));

      await dio.get<dynamic>(
        '/products',
        options: authed(RequestAuth.optional),
      );

      expect(capturedAuthHeader, 'Bearer a.tok');
      expect(capturedAttachedFlag, isTrue);
    });

    test('optional: proceeds anonymously when no tokens exist', () async {
      setupWith();
      adapter.onGet('/products', (request) => request.reply(200, {'ok': true}));

      final response = await dio.get<dynamic>(
        '/products',
        options: authed(RequestAuth.optional),
      );

      expect(response.statusCode, 200);
      expect(capturedAuthHeader, isNull);
      expect(capturedAttachedFlag, isNull);
    });

    test(
      'protected: rejects with MissingAccessTokenException when no tokens',
      () async {
        setupWith();
        adapter.onGet('/me', (request) => request.reply(200, {'ok': true}));

        await expectLater(
          dio.get<dynamic>('/me', options: authed(RequestAuth.protected)),
          throwsMissingAccessToken,
        );
      },
    );

    test(
      'rejection reaches downstream error interceptors (logger, telemetry)',
      () async {
        setupWith();
        Object? seenByDownstream;
        dio.interceptors.add(
          InterceptorsWrapper(
            onError: (err, handler) {
              seenByDownstream = err.error;
              handler.next(err);
            },
          ),
        );
        adapter.onGet('/me', (request) => request.reply(200, {'ok': true}));

        await expectLater(
          dio.get<dynamic>('/me', options: authed(RequestAuth.protected)),
          throwsMissingAccessToken,
        );

        expect(seenByDownstream, isA<MissingAccessTokenException>());
      },
    );

    test(
      'protected: rejects when token is empty and no refresh token',
      () async {
        setupWith(accessToken: '');
        adapter.onGet('/me', (request) => request.reply(200, {'ok': true}));

        await expectLater(
          dio.get<dynamic>('/me', options: authed(RequestAuth.protected)),
          throwsMissingAccessToken,
        );
      },
    );

    group('missing-access-token recovery', () {
      test('protected: refreshes and attaches the new token when only a '
          'refresh token exists', () async {
        setupWith(refreshToken: 'r.tok');
        adapter
          ..onPost(
            testRefreshPath,
            (request) => request.reply(200, {'accessToken': 'new.a'}),
            data: Matchers.any,
          )
          ..onGet('/me', (request) => request.reply(200, {'ok': true}));

        final response = await dio.get<dynamic>(
          '/me',
          options: authed(RequestAuth.protected),
        );

        expect(response.statusCode, 200);
        expect(capturedAuthHeader, 'Bearer new.a');
        expect(capturedAttachedFlag, isTrue);
        expect(await tokens.accessToken, 'new.a');
      });

      test('optional: refreshes and attaches the new token too', () async {
        setupWith(refreshToken: 'r.tok');
        adapter
          ..onPost(
            testRefreshPath,
            (request) => request.reply(200, {'accessToken': 'new.a'}),
            data: Matchers.any,
          )
          ..onGet('/products', (request) => request.reply(200, {'ok': true}));

        await dio.get<dynamic>(
          '/products',
          options: authed(RequestAuth.optional),
        );

        expect(capturedAuthHeader, 'Bearer new.a');
        expect(capturedAttachedFlag, isTrue);
      });

      test('protected: rejects when the recovery refresh fails', () async {
        setupWith(refreshToken: 'r.tok');
        adapter
          ..onPost(
            testRefreshPath,
            (request) => request.reply(500, {'message': 'down'}),
            data: Matchers.any,
          )
          ..onGet('/me', (request) => request.reply(200, {'ok': true}));

        await expectLater(
          dio.get<dynamic>('/me', options: authed(RequestAuth.protected)),
          throwsMissingAccessToken,
        );
        // A 500 is transient — the refresh token survives for a later try.
        expect(await tokens.refreshToken, 'r.tok');
      });

      test(
        'optional: proceeds anonymously when the recovery refresh fails',
        () async {
          setupWith(refreshToken: 'r.tok');
          adapter
            ..onPost(
              testRefreshPath,
              (request) => request.reply(500, {'message': 'down'}),
              data: Matchers.any,
            )
            ..onGet('/products', (request) => request.reply(200, {'ok': true}));

          final response = await dio.get<dynamic>(
            '/products',
            options: authed(RequestAuth.optional),
          );

          expect(response.statusCode, 200);
          expect(capturedAuthHeader, isNull);
          expect(capturedAttachedFlag, isNull);
        },
      );
    });
  });
}
