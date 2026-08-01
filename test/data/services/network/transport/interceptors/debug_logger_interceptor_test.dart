// DebugLoggerInterceptor is observably correct only via what it writes to
// the logger, which is global state. The tests below verify the
// non-blocking behavior (every callback forwards) and that no request body
// or Authorization value is exposed by the interceptor's API — anything
// stronger would require tapping into the logger singleton.

import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/transport/interceptors/debug_logger_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  const baseUrl = 'https://test.local';

  late Dio dio;
  late DioAdapter adapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    adapter = DioAdapter(dio: dio);
    dio.interceptors.add(const DebugLoggerInterceptor());
  });

  group('DebugLoggerInterceptor', () {
    test('forwards a successful response unchanged', () async {
      adapter.onGet('/x', (request) => request.reply(200, {'ok': true}));

      final response = await dio.get<dynamic>('/x');

      expect(response.statusCode, 200);
      expect(response.data, {'ok': true});
    });

    test('forwards an error unchanged', () async {
      adapter.onGet('/x', (request) => request.reply(500, {'message': 'down'}));

      await expectLater(
        dio.get<dynamic>('/x'),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            500,
          ),
        ),
      );
    });

    test(
      'does not mutate request options (no body capture, no header strip)',
      () async {
        RequestOptions? observed;
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              observed = options;
              handler.next(options);
            },
          ),
        );
        adapter.onPost(
          '/x',
          (request) => request.reply(200, const {}),
          data: {'secret': 'value'},
        );

        await dio.post<dynamic>(
          '/x',
          data: {'secret': 'value'},
          options: Options(headers: {'Authorization': 'Bearer abc'}),
        );

        expect(observed?.data, {'secret': 'value'});
        expect(observed?.headers['Authorization'], 'Bearer abc');
      },
    );
  });
}
