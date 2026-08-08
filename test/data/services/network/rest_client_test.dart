import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_template/src/data/services/network/auth/token_manager.dart';
import 'package:flutter_template/src/data/services/network/endpoints.dart';
import 'package:flutter_template/src/data/services/network/request_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'helpers.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late ProviderContainer container;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: Endpoints.base));
    adapter = DioAdapter(dio: dio);

    final tokens = TokenManager(
      store: FakeTokenStore(),
      transport: dio,
      refreshEndpoint: Endpoints.refreshToken,
    );

    container = ProviderContainer(
      overrides: [
        networkStackProvider.overrideWithValue((
          transport: dio,
          tokens: tokens,
        )),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('RestClient through the DI wiring (networkStackProvider override)', () {
    test('login returns the mocked response body', () async {
      const path = Endpoints.login;
      const body = {'username': 'alice', 'password': 'pw'};
      final responseBody = {
        'id': 1,
        'username': 'alice',
        'email': 'a@x',
        'firstName': 'A',
        'lastName': 'B',
        'gender': 'female',
        'image': 'https://x/y.png',
        'accessToken': 'fake.access',
        'refreshToken': 'fake.refresh',
      };

      adapter.onPost(
        path,
        (request) => request.reply(200, responseBody),
        data: body,
      );

      final rest = container.read(restClientServiceProvider);
      final response = await rest.login(body);

      expect(response.response.statusCode, 200);
      expect(response.data, responseBody);
    });

    test('currentUser carries the RequestAuth.protected marker', () async {
      Object? seenMode;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            seenMode = options.extra[requestAuthKey];
            handler.next(options);
          },
        ),
      );
      adapter.onGet(
        Endpoints.currentUser,
        (request) => request.reply(200, {'id': 1, 'username': 'alice'}),
      );

      final rest = container.read(restClientServiceProvider);
      await rest.currentUser();

      expect(seenMode, RequestAuth.protected);
    });

    test('login surfaces server errors as DioException', () async {
      const path = Endpoints.login;
      const body = {'username': 'alice', 'password': 'wrong'};

      adapter.onPost(
        path,
        (request) => request.reply(401, {'message': 'Invalid credentials'}),
        data: body,
      );

      final rest = container.read(restClientServiceProvider);

      await expectLater(
        rest.login(body),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
    });
  });
}
