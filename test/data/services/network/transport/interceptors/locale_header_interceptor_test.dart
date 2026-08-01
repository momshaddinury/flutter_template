import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/transport/interceptors/locale_header_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  const baseUrl = 'https://test.local';

  late Dio dio;
  late DioAdapter adapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    adapter = DioAdapter(dio: dio);
  });

  /// Installs [resolver] plus a downstream capture of the Accept-Language
  /// header, and stubs `/x`. Returns a getter for the captured value.
  String? Function() setupWith(LocaleResolver resolver) {
    String? captured;
    dio.interceptors.add(LocaleHeaderInterceptor(resolver));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          captured = options.headers['Accept-Language'] as String?;
          handler.next(options);
        },
      ),
    );
    adapter.onGet('/x', (request) => request.reply(200, const {}));
    return () => captured;
  }

  group('LocaleHeaderInterceptor', () {
    test('adds Accept-Language when the resolver returns a value', () async {
      final captured = setupWith(() async => 'bn');

      await dio.get<dynamic>('/x');

      expect(captured(), 'bn');
    });

    test('skips the header when the resolver returns null', () async {
      final captured = setupWith(() async => null);

      await dio.get<dynamic>('/x');

      expect(captured(), isNull);
    });

    test(
      'skips the header when the resolver returns an empty string',
      () async {
        final captured = setupWith(() async => '');

        await dio.get<dynamic>('/x');

        expect(captured(), isNull);
      },
    );

    test(
      'does not overwrite an Accept-Language header already on the request',
      () async {
        final captured = setupWith(() async => 'bn');

        await dio.get<dynamic>(
          '/x',
          options: Options(headers: {'Accept-Language': 'fr'}),
        );

        expect(captured(), 'fr');
      },
    );

    test('does not block the request when the resolver throws', () async {
      final captured = setupWith(() async {
        throw Exception('resolver failed');
      });

      final response = await dio.get<dynamic>('/x');

      expect(response.statusCode, 200);
      expect(captured(), isNull);
    });
  });
}
