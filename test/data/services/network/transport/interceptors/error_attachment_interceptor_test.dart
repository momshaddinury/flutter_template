import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/config/server_error_parser.dart';
import 'package:flutter_template/src/data/services/network/transport/interceptors/error_attachment_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class _StaticParser implements ServerErrorParser {
  _StaticParser(this._result);
  final ServerError? _result;

  @override
  ServerError? parse(Response<dynamic>? response) => _result;
}

void main() {
  const baseUrl = 'https://test.local';

  late Dio dio;
  late DioAdapter adapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    adapter = DioAdapter(dio: dio);
  });

  group('ErrorAttachmentInterceptor', () {
    test('attaches the parsed ServerError to DioException.error', () async {
      const parsed = ServerError(message: 'nope', code: '422');
      dio.interceptors.add(ErrorAttachmentInterceptor(_StaticParser(parsed)));
      adapter.onGet(
        '/x',
        (request) => request.reply(422, {'message': 'ignored'}),
      );

      await expectLater(
        dio.get<dynamic>('/x'),
        throwsA(
          isA<DioException>().having(
            (e) => e.error,
            'error',
            isA<ServerError>()
                .having((s) => s.message, 'message', 'nope')
                .having((s) => s.code, 'code', '422'),
          ),
        ),
      );
    });

    test('passes through unchanged when the parser returns null', () async {
      dio.interceptors.add(ErrorAttachmentInterceptor(_StaticParser(null)));
      adapter.onGet(
        '/x',
        (request) => request.reply(500, {'message': 'server'}),
      );

      // Passthrough intact: no parsed error attached, response untouched.
      await expectLater(
        dio.get<dynamic>('/x'),
        throwsA(
          isA<DioException>()
              .having((e) => e.error, 'error', isNull)
              .having((e) => e.response?.statusCode, 'statusCode', 500),
        ),
      );
    });
  });
}
