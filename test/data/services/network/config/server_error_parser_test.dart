import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/services/network/config/server_error_parser.dart';
import 'package:flutter_test/flutter_test.dart';

Response<dynamic> _response(Object? data) => Response<dynamic>(
  requestOptions: RequestOptions(path: '/x'),
  data: data,
);

void main() {
  const parser = DefaultServerErrorParser();

  group('DefaultServerErrorParser', () {
    test('plain string message is used as-is', () {
      final error = parser.parse(_response({'message': 'nope'}));

      expect(error?.message, 'nope');
    });

    test('Map message joins the values with a space', () {
      final error = parser.parse(
        _response({
          'message': {'name': 'Name is required', 'email': 'Email is bad'},
        }),
      );

      expect(error?.message, 'Name is required Email is bad');
    });

    test('List message joins the entries with a space', () {
      final error = parser.parse(
        _response({
          'message': ['Name is required', 'Email is bad'],
        }),
      );

      expect(error?.message, 'Name is required Email is bad');
    });

    test('missing message falls back to a generic one', () {
      final error = parser.parse(_response({'code': 'oops'}));

      expect(error?.message, 'Something went wrong');
    });

    test('null message falls back to a generic one', () {
      final error = parser.parse(_response({'message': null}));

      expect(error?.message, 'Something went wrong');
    });

    test('statusCode key wins over code key', () {
      final error = parser.parse(
        _response({'message': 'x', 'statusCode': 422, 'code': 'validation'}),
      );

      expect(error?.code, '422');
    });

    test('code falls back to the code key', () {
      final error = parser.parse(
        _response({'message': 'x', 'code': 'validation'}),
      );

      expect(error?.code, 'validation');
    });

    test('non-Map body yields null', () {
      expect(parser.parse(_response('plain text')), isNull);
      expect(parser.parse(_response(null)), isNull);
    });

    test('null response yields null', () {
      expect(parser.parse(null), isNull);
    });

    test('the whole body is preserved in details', () {
      final body = {'message': 'x', 'code': 'y', 'hint': 'extra'};

      final error = parser.parse(_response(body));

      expect(error?.details, body);
    });
  });
}
