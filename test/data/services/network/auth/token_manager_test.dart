import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/auth/token_manager.dart';
import 'package:flutter_template/src/data/services/network/auth/token_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../helpers.dart';

void main() {
  late Dio transport;
  late DioAdapter adapter;
  late FakeTokenStore store;
  late RecordingInterceptor spy;

  TokenManager build({Map<TokenKey, String>? initial}) {
    store = FakeTokenStore(initial: initial);
    return TokenManager(
      store: store,
      transport: transport,
      refreshEndpoint: testRefreshPath,
    );
  }

  setUp(() {
    transport = Dio(BaseOptions(baseUrl: testBaseUrl));
    spy = RecordingInterceptor();
    transport.interceptors.add(spy);
    adapter = DioAdapter(dio: transport);
  });

  group('TokenManager', () {
    group('load + cache', () {
      test('returns null when the store is empty', () async {
        final manager = build();

        expect(await manager.accessToken, isNull);
        expect(await manager.refreshToken, isNull);
      });

      test('loads stored values on first access', () async {
        final manager = build(
          initial: {TokenKey.access: 'a.tok', TokenKey.refresh: 'r.tok'},
        );

        expect(await manager.accessToken, 'a.tok');
        expect(await manager.refreshToken, 'r.tok');
      });

      test('continues working when the initial load throws', () async {
        final manager = build();
        store.readThrows = Exception('keystore locked');

        expect(await manager.accessToken, isNull);
        expect(await manager.refreshToken, isNull);
      });
    });

    group('persist', () {
      test(
        'writes access (and refresh if given) to memory and store',
        () async {
          final manager = build();

          await manager.persist(access: 'new.a', refresh: 'new.r');

          expect(await manager.accessToken, 'new.a');
          expect(await manager.refreshToken, 'new.r');
          expect(await store.read(TokenKey.access), 'new.a');
          expect(await store.read(TokenKey.refresh), 'new.r');
        },
      );

      test(
        'leaves the existing refresh token in place when none is supplied',
        () async {
          final manager = build(initial: {TokenKey.refresh: 'old.r'});

          await manager.persist(access: 'new.a');

          expect(await manager.accessToken, 'new.a');
          expect(await manager.refreshToken, 'old.r');
        },
      );
    });

    group('refresh', () {
      test('sends the stored refresh token in the request body', () async {
        final manager = build(initial: {TokenKey.refresh: 'r.tok'});

        adapter.onPost(
          testRefreshPath,
          (request) => request.reply(200, {
            'accessToken': 'new.a',
            'refreshToken': 'new.r',
          }),
          data: Matchers.any,
        );

        await manager.refresh();

        expect(spy.bodies.last, {'refreshToken': 'r.tok'});
        // Unmarked → public: the refresh call never carries a bearer.
        expect(spy.authHeaders.last, isNull);
      });

      test('persists the rotated access and refresh tokens', () async {
        final manager = build(initial: {TokenKey.refresh: 'r.tok'});

        adapter.onPost(
          testRefreshPath,
          (request) => request.reply(200, {
            'accessToken': 'new.a',
            'refreshToken': 'new.r',
          }),
          data: Matchers.any,
        );

        final newAccess = await manager.refresh();

        expect(newAccess, 'new.a');
        expect(await manager.accessToken, 'new.a');
        expect(await manager.refreshToken, 'new.r');
        expect(await store.read(TokenKey.access), 'new.a');
        expect(await store.read(TokenKey.refresh), 'new.r');
      });

      test(
        'preserves the existing refresh token when the response omits it',
        () async {
          final manager = build(initial: {TokenKey.refresh: 'r.tok'});

          adapter.onPost(
            testRefreshPath,
            (request) => request.reply(200, {'accessToken': 'new.a'}),
            data: Matchers.any,
          );

          await manager.refresh();

          expect(await manager.refreshToken, 'r.tok');
        },
      );

      test('throws and clears when no refresh token is stored', () async {
        final manager = build(initial: {TokenKey.access: 'a.tok'});

        await expectLater(manager.refresh(), throwsA(isA<StateError>()));

        expect(await manager.accessToken, isNull);
        expect(await manager.refreshToken, isNull);
        expect(spy.calls, isEmpty);
      });

      test(
        'keeps tokens when the refresh endpoint returns 5xx (transient)',
        () async {
          final manager = build(
            initial: {TokenKey.access: 'a.tok', TokenKey.refresh: 'r.tok'},
          );

          adapter.onPost(
            testRefreshPath,
            (request) => request.reply(500, {'message': 'down'}),
            data: Matchers.any,
          );

          await expectLater(manager.refresh(), throwsA(isA<DioException>()));

          expect(await manager.accessToken, 'a.tok');
          expect(await manager.refreshToken, 'r.tok');
          expect(await store.read(TokenKey.refresh), 'r.tok');
        },
      );

      test(
        'keeps tokens when the refresh call fails at the network layer',
        () async {
          final manager = build(initial: {TokenKey.refresh: 'r.tok'});

          adapter.onPost(
            testRefreshPath,
            (request) => request.throws(
              0,
              DioException.connectionError(
                requestOptions: RequestOptions(path: testRefreshPath),
                reason: 'network unreachable',
              ),
            ),
            data: Matchers.any,
          );

          await expectLater(manager.refresh(), throwsA(isA<DioException>()));

          expect(await manager.refreshToken, 'r.tok');
          expect(await store.read(TokenKey.refresh), 'r.tok');
        },
      );

      test(
        'clears tokens when the server rejects the refresh token (401)',
        () async {
          final manager = build(
            initial: {TokenKey.access: 'a.tok', TokenKey.refresh: 'r.tok'},
          );

          adapter.onPost(
            testRefreshPath,
            (request) =>
                request.reply(401, {'message': 'invalid refresh token'}),
            data: Matchers.any,
          );

          await expectLater(manager.refresh(), throwsA(isA<DioException>()));

          expect(await manager.accessToken, isNull);
          expect(await manager.refreshToken, isNull);
          expect(await store.read(TokenKey.refresh), isNull);
        },
      );

      test(
        'completes with the original error even when store.clear() throws',
        () async {
          final manager = build(initial: {TokenKey.refresh: 'r.tok'});
          store.clearThrows = Exception('keystore locked');

          adapter.onPost(
            testRefreshPath,
            (request) =>
                request.reply(401, {'message': 'invalid refresh token'}),
            data: Matchers.any,
          );

          // Must not hang; must surface the refresh error, not the clear
          // error.
          await expectLater(manager.refresh(), throwsA(isA<DioException>()));
        },
      );

      test(
        'releases the inflight slot after a refresh that failed during clear',
        () async {
          final manager = build(initial: {TokenKey.refresh: 'r.tok'});
          store.clearThrows = Exception('keystore locked');

          adapter.onPost(
            testRefreshPath,
            (request) =>
                request.reply(401, {'message': 'invalid refresh token'}),
            data: Matchers.any,
          );
          await expectLater(manager.refresh(), throwsA(isA<DioException>()));

          // The inflight slot is free again — after a re-login, refresh
          // works.
          store.clearThrows = null;
          await manager.persist(access: 'a2', refresh: 'r2');
          adapter.onPost(
            testRefreshPath,
            (request) => request.reply(200, {'accessToken': 'new.a'}),
            data: Matchers.any,
          );
          expect(await manager.refresh(), 'new.a');
        },
      );

      test('throws and clears the session when the refresh response has no '
          'accessToken', () async {
        final manager = build(initial: {TokenKey.refresh: 'r.tok'});

        adapter.onPost(
          testRefreshPath,
          (request) => request.reply(200, {'note': 'no token here'}),
          data: Matchers.any,
        );

        await expectLater(manager.refresh(), throwsA(isA<StateError>()));

        expect(await manager.refreshToken, isNull);
      });

      test(
        'is single-flight — concurrent callers share one HTTP roundtrip',
        () async {
          final manager = build(initial: {TokenKey.refresh: 'r.tok'});

          adapter.onPost(
            testRefreshPath,
            (request) => request.reply(200, {
              'accessToken': 'new.a',
            }, delay: const Duration(milliseconds: 30)),
            data: Matchers.any,
          );

          final results = await Future.wait([
            manager.refresh(),
            manager.refresh(),
            manager.refresh(),
          ]);

          expect(spy.callsTo(testRefreshPath), 1);
          expect(results, ['new.a', 'new.a', 'new.a']);
        },
      );

      test(
        'clears the inflight slot after completion so the next call works',
        () async {
          final manager = build(initial: {TokenKey.refresh: 'r.tok'});

          adapter.onPost(
            testRefreshPath,
            (request) => request.reply(200, {'accessToken': 'new.a'}),
            data: Matchers.any,
          );

          await manager.refresh();
          await manager.refresh();

          expect(spy.callsTo(testRefreshPath), 2);
        },
      );
    });

    group('clear', () {
      test('empties both memory and the store', () async {
        final manager = build(
          initial: {TokenKey.access: 'a', TokenKey.refresh: 'r'},
        );

        await manager.clear();

        expect(await manager.accessToken, isNull);
        expect(await manager.refreshToken, isNull);
        expect(await store.read(TokenKey.access), isNull);
        expect(await store.read(TokenKey.refresh), isNull);
      });
    });
  });
}
