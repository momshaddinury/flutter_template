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
      await loginAndPersist(overrideAccess: 'garbage.token');

      final me = await rest.currentUser();

      expect(me.response.statusCode, 200);
      expect((me.data as Map<String, dynamic>)['username'], 'emilys');
    });
  });
}
