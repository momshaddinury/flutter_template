// Manual smoke run against the live dummyjson.com API. Named without the
// `_test` suffix so `flutter test` skips it by default — network calls do
// not belong in the normal suite. Run explicitly:
//
//   flutter test test/integration/dummyjson_smoke.dart
//
// Exercises the real DioBuilder stack end to end: login via RestClient,
// bearer attach on the protected currentUser(), and the refresh path.

import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/config/network_config.dart';
import 'package:flutter_template/src/data/services/network/config/server_error_parser.dart';
import 'package:flutter_template/src/data/services/network/endpoints.dart';
import 'package:flutter_template/src/data/services/network/rest_client.dart';
import 'package:flutter_template/src/data/services/network/transport/dio_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/services/network/helpers.dart';

void main() {
  const credentials = {'username': 'emilys', 'password': 'emilyspass'};

  late NetworkStack stack;
  late RestClient rest;

  setUp(() {
    stack = DioBuilder(
      config: const NetworkConfig(),
      store: FakeTokenStore(),
      errorParser: const DefaultServerErrorParser(),
      refreshEndpoint: Endpoints.refreshToken,
      logger: null,
    ).build();
    rest = RestClient(stack.transport);
  });

  tearDown(() => stack.transport.close(force: true));

  /// Logs in and persists the returned tokens, optionally replacing the
  /// access token with [overrideAccess]. Returns the login response body.
  Future<Map<String, dynamic>> loginAndPersist({String? overrideAccess}) async {
    final login = await rest.login(credentials);
    final data = login.data as Map<String, dynamic>;
    await stack.tokens.persist(
      access: overrideAccess ?? data['accessToken'] as String,
      refresh: data['refreshToken'] as String,
    );
    return data;
  }

  group('dummyjson live', () {
    test('login returns tokens', () async {
      final response = await rest.login(credentials);

      expect(response.response.statusCode, 200);
      final data = response.data as Map<String, dynamic>;
      expect(data['accessToken'], isA<String>());
      expect(data['refreshToken'], isA<String>());
    });

    test('currentUser carries the bearer and succeeds', () async {
      await loginAndPersist();

      final me = await rest.currentUser();

      expect(me.response.statusCode, 200);
      expect((me.data as Map<String, dynamic>)['username'], 'emilys');
    });

    test('refresh returns a new access token', () async {
      await loginAndPersist();

      try {
        final newAccess = await stack.tokens.refresh();
        expect(newAccess, isNotEmpty);
      } on DioException catch (e) {
        printOnFailure(
          'REFRESH FAILED — status: ${e.response?.statusCode}, '
          'type: ${e.type}, body: ${e.response?.data}',
        );
        rethrow;
      }
    });

    test('expired access token heals via refresh + replay', () async {
      // Corrupt the access token but keep the real refresh token: the
      // first currentUser() 401s, RefreshRetryInterceptor refreshes and
      // replays, and the call succeeds without the caller noticing.
      await loginAndPersist(overrideAccess: 'garbage.token');

      final me = await rest.currentUser();

      expect(me.response.statusCode, 200);
      expect((me.data as Map<String, dynamic>)['username'], 'emilys');
    });
  });
}
