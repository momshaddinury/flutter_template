import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/auth/token_manager.dart';
import 'package:flutter_template/src/data/services/network/auth/token_store.dart';
import 'package:flutter_template/src/data/services/network/request_auth.dart';
import 'package:flutter_template/src/data/services/network/transport/interceptors/auth_header_interceptor.dart';
import 'package:flutter_template/src/data/services/network/transport/interceptors/refresh_retry_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../helpers.dart';

void main() {
  const protectedPath = '/me';

  late Dio transport;
  late DioAdapter adapter;
  late TokenManager tokens;
  late RecordingInterceptor spy;

  setUp(() {
    transport = Dio(BaseOptions(baseUrl: testBaseUrl));
    spy = RecordingInterceptor();
    transport.interceptors.add(spy);
    adapter = DioAdapter(dio: transport);
    tokens = TokenManager(
      store: FakeTokenStore(
        initial: {TokenKey.access: 'a.tok', TokenKey.refresh: 'r.tok'},
      ),
      transport: transport,
      refreshEndpoint: testRefreshPath,
    );
    transport.interceptors.addAll([
      AuthHeaderInterceptor(tokens),
      RefreshRetryInterceptor(tokens: tokens, transport: transport),
    ]);
  });

  group('RefreshRetryInterceptor', () {
    test('success passes through without refresh', () async {
      adapter.onGet(
        protectedPath,
        (request) => request.reply(200, {'ok': true}),
      );

      final response = await transport.get<dynamic>(
        protectedPath,
        options: authed(RequestAuth.protected),
      );

      expect(response.statusCode, 200);
      expect(spy.callsTo(testRefreshPath), 0);
    });

    test('401 on a token-carrying request: refreshes and replays', () async {
      // Two stubs distinguished by Authorization header — the first hit
      // carries `Bearer a.tok` (the seeded token) and gets 401; the replay
      // re-enters AuthHeaderInterceptor, picks up `Bearer new.a`, and
      // matches the 200 stub.
      adapter
        ..onGet(
          protectedPath,
          (request) => request.reply(401, {'message': 'expired'}),
          headers: {'Authorization': 'Bearer a.tok'},
        )
        ..onGet(
          protectedPath,
          (request) => request.reply(200, {'ok': true}),
          headers: {'Authorization': 'Bearer new.a'},
        )
        ..onPost(
          testRefreshPath,
          (request) => request.reply(200, {'accessToken': 'new.a'}),
          data: Matchers.any,
        );

      final response = await transport.get<dynamic>(
        protectedPath,
        options: authed(RequestAuth.protected),
      );

      expect(response.statusCode, 200);
      expect(response.data, {'ok': true});
      expect(spy.callsTo(testRefreshPath), 1);
      expect(await tokens.accessToken, 'new.a');
    });

    test('401 on an anonymous request: no refresh, error propagates', () async {
      adapter.onGet(
        protectedPath,
        (request) => request.reply(401, {'message': 'expired'}),
      );

      await expectLater(
        transport.get<dynamic>(protectedPath),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
      expect(spy.callsTo(testRefreshPath), 0);
    });

    test('late 401 after a completed refresh: replays without a second '
        'refresh', () async {
      // The request goes out with the seeded `a.tok` and is held at the
      // gate below; while it is in flight another caller's refresh
      // completes (simulated by `persist`). The late 401 must not trigger
      // a second rotation — no stub exists for the refresh endpoint, so
      // any refresh POST fails the test loudly. The replay picks up
      // `new.a` and succeeds.
      adapter
        ..onGet(
          protectedPath,
          (request) => request.reply(401, {'message': 'expired'}),
          headers: {'Authorization': 'Bearer a.tok'},
        )
        ..onGet(
          protectedPath,
          (request) => request.reply(200, {'ok': true}),
          headers: {'Authorization': 'Bearer new.a'},
        );

      // One-shot gate: holds the first protected request after its header
      // is attached, so the token rotation deterministically lands while
      // that request is in flight.
      final dispatched = Completer<void>();
      final released = Completer<void>();
      transport.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            if (options.path == protectedPath && !dispatched.isCompleted) {
              dispatched.complete();
              await released.future;
            }
            handler.next(options);
          },
        ),
      );

      final pending = transport.get<dynamic>(
        protectedPath,
        options: authed(RequestAuth.protected),
      );
      await dispatched.future;
      await tokens.persist(access: 'new.a');
      released.complete();

      final response = await pending;

      expect(response.statusCode, 200);
      expect(spy.callsTo(testRefreshPath), 0);
    });

    test(
      'transient refresh failure: tokens kept, original 401 propagates',
      () async {
        adapter
          ..onGet(
            protectedPath,
            (request) => request.reply(401, {'message': 'expired'}),
          )
          ..onPost(
            testRefreshPath,
            (request) => request.reply(500, {'message': 'down'}),
            data: Matchers.any,
          );

        await expectLater(
          transport.get<dynamic>(
            protectedPath,
            options: authed(RequestAuth.protected),
          ),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              'statusCode',
              401,
            ),
          ),
        );

        // A refresh-endpoint outage must not log the user out.
        expect(await tokens.refreshToken, 'r.tok');
        expect(spy.callsTo(testRefreshPath), 1);
      },
    );

    test(
      'rejected refresh token: tokens cleared, original 401 propagates',
      () async {
        adapter
          ..onGet(
            protectedPath,
            (request) => request.reply(401, {'message': 'expired'}),
          )
          ..onPost(
            testRefreshPath,
            (request) => request.reply(401, {'message': 'invalid refresh'}),
            data: Matchers.any,
          );

        await expectLater(
          transport.get<dynamic>(
            protectedPath,
            options: authed(RequestAuth.protected),
          ),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              'statusCode',
              401,
            ),
          ),
        );

        expect(await tokens.accessToken, isNull);
        expect(await tokens.refreshToken, isNull);
        expect(spy.callsTo(testRefreshPath), 1);
      },
    );

    test('a 401 on the replay is not refreshed again (loop guard)', () async {
      adapter
        ..onGet(
          protectedPath,
          (request) => request.reply(401, {'message': 'expired'}),
          headers: {'Authorization': 'Bearer a.tok'},
        )
        ..onGet(
          protectedPath,
          (request) => request.reply(401, {'message': 'still expired'}),
          headers: {'Authorization': 'Bearer new.a'},
        )
        ..onPost(
          testRefreshPath,
          (request) => request.reply(200, {'accessToken': 'new.a'}),
          data: Matchers.any,
        );

      await expectLater(
        transport.get<dynamic>(
          protectedPath,
          options: authed(RequestAuth.protected),
        ),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            401,
          ),
        ),
      );

      // Exactly one refresh — the replay's 401 propagates instead of
      // triggering a second refresh cycle.
      expect(spy.callsTo(testRefreshPath), 1);
    });

    test('401 with a FormData body: no refresh, error propagates', () async {
      adapter.onPost(
        '/upload',
        (request) => request.reply(401, {'message': 'expired'}),
        data: Matchers.any,
      );

      await expectLater(
        transport.post<dynamic>(
          '/upload',
          data: FormData.fromMap({'field': 'value'}),
          options: authed(RequestAuth.protected),
        ),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
      expect(spy.callsTo(testRefreshPath), 0);
    });

    test('non-401 errors propagate unchanged', () async {
      adapter.onGet(
        protectedPath,
        (request) => request.reply(500, {'message': 'down'}),
      );

      await expectLater(
        transport.get<dynamic>(
          protectedPath,
          options: authed(RequestAuth.protected),
        ),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            500,
          ),
        ),
      );
      expect(spy.callsTo(testRefreshPath), 0);
    });
  });
}
