import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/auth/token_store.dart';
import 'package:flutter_template/src/data/services/network/config/network_config.dart';
import 'package:flutter_template/src/data/services/network/config/server_error_parser.dart';
import 'package:flutter_template/src/data/services/network/request_auth.dart';
import 'package:flutter_template/src/data/services/network/transport/dio_builder.dart';
import 'package:flutter_template/src/data/services/network/transport/interceptors/locale_header_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../helpers.dart';

void main() {
  NetworkStack buildStack({
    Map<TokenKey, String>? tokens,
    LocaleResolver? localeResolver,
    List<Interceptor> extraInterceptors = const [],
  }) {
    return DioBuilder(
      config: const NetworkConfig(baseUrl: testBaseUrl),
      store: FakeTokenStore(initial: tokens),
      errorParser: const DefaultServerErrorParser(),
      refreshEndpoint: testRefreshPath,
      localeResolver: localeResolver,
      extraInterceptors: extraInterceptors,
      logger: null,
    ).build();
  }

  group('DioBuilder end-to-end', () {
    test('401 on a protected endpoint refreshes and replays through the '
        'full chain', () async {
      final stack = buildStack(
        tokens: {TokenKey.access: 'a.tok', TokenKey.refresh: 'r.tok'},
      );
      final adapter = DioAdapter(dio: stack.transport);
      adapter
        ..onGet(
          '/me',
          (request) => request.reply(401, {'message': 'expired'}),
          headers: {'Authorization': 'Bearer a.tok'},
        )
        ..onGet(
          '/me',
          (request) => request.reply(200, {'ok': true}),
          headers: {'Authorization': 'Bearer new.a'},
        )
        ..onPost(
          testRefreshPath,
          (request) => request.reply(200, {'accessToken': 'new.a'}),
          data: Matchers.any,
        );

      final response = await stack.transport.get<dynamic>(
        '/me',
        options: authed(RequestAuth.protected),
      );

      expect(response.statusCode, 200);
      expect(await stack.tokens.accessToken, 'new.a');
    });

    test('failing responses carry the parsed ServerError', () async {
      final stack = buildStack();
      final adapter = DioAdapter(dio: stack.transport);
      adapter.onGet(
        '/fail',
        (request) => request.reply(422, {
          'message': 'Name is required',
          'code': 'validation',
        }),
      );

      await expectLater(
        stack.transport.get<dynamic>('/fail'),
        throwsA(
          isA<DioException>().having(
            (e) => e.error,
            'error',
            isA<ServerError>().having(
              (s) => s.message,
              'message',
              'Name is required',
            ),
          ),
        ),
      );
    });

    test('locale resolver stamps Accept-Language on every request', () async {
      final stack = buildStack(localeResolver: () async => 'bn');
      final adapter = DioAdapter(dio: stack.transport);
      adapter.onGet(
        '/public',
        (request) => request.reply(200, {'ok': true}),
        headers: {'Accept-Language': 'bn'},
      );

      final response = await stack.transport.get<dynamic>('/public');

      expect(response.statusCode, 200);
    });

    test(
      'extra interceptors see the enriched request and the parsed error',
      () async {
        final capturing = RecordingInterceptor();
        final stack = buildStack(
          tokens: {TokenKey.access: 'a.tok', TokenKey.refresh: 'r.tok'},
          extraInterceptors: [capturing],
        );
        final adapter = DioAdapter(dio: stack.transport);
        adapter.onGet(
          '/me',
          (request) => request.reply(403, {'message': 'forbidden'}),
        );

        await expectLater(
          stack.transport.get<dynamic>(
            '/me',
            options: authed(RequestAuth.protected),
          ),
          throwsA(isA<DioException>()),
        );

        expect(capturing.authHeaders, ['Bearer a.tok']);
        expect(capturing.errors, hasLength(1));
        expect(capturing.errors.single, isA<ServerError>());
      },
    );
  });
}
