import 'package:dio/dio.dart';
import 'package:flutter_template/src/data/failures/exception_classifier.dart';
import 'package:flutter_template/src/data/failures/infra_failure.dart';
import 'package:flutter_template/src/data/services/network/config/server_error_parser.dart';
import 'package:flutter_template/src/data/services/network/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _dio(
  int? status, {
  DioExceptionType type = DioExceptionType.badResponse,
  Object? attachedError,
}) {
  final options = RequestOptions(path: '/x');
  return DioException(
    requestOptions: options,
    type: type,
    response: status == null
        ? null
        : Response<dynamic>(requestOptions: options, statusCode: status),
    error: attachedError,
  );
}

/// Produces a real [TypeError] via a deliberate bad cast.
TypeError _captureTypeError() {
  try {
    (42 as dynamic) as String;
  } on TypeError catch (e) {
    return e;
  }
  throw StateError('the bad cast did not throw a TypeError');
}

void main() {
  group('Object.toInfraFailure', () {
    test('DioException 401 → unauthorized', () {
      expect(_dio(401).toInfraFailure(), isA<UnauthorizedFailure>());
    });

    test('DioException 403 → forbidden', () {
      expect(_dio(403).toInfraFailure(), isA<ForbiddenFailure>());
    });

    test('DioException 404 → notFound', () {
      expect(_dio(404).toInfraFailure(), isA<NotFoundFailure>());
    });

    test('DioException 409 → conflict', () {
      expect(_dio(409).toInfraFailure(), isA<ConflictFailure>());
    });

    test('DioException 422 → validation', () {
      expect(_dio(422).toInfraFailure(), isA<ValidationFailure>());
    });

    test('DioException 500 → serverError', () {
      expect(
        _dio(500).toInfraFailure(),
        isA<ServerErrorFailure>().having(
          (f) => f.statusCode,
          'statusCode',
          500,
        ),
      );
    });

    test('DioException 503 → serverError', () {
      expect(_dio(503).toInfraFailure(), isA<ServerErrorFailure>());
    });

    test('DioException 418 → badResponse (no specific variant)', () {
      expect(
        _dio(418).toInfraFailure(),
        isA<BadResponseFailure>().having(
          (f) => f.statusCode,
          'statusCode',
          418,
        ),
      );
    });

    test('DioException connectionTimeout → timeout', () {
      expect(
        _dio(null, type: DioExceptionType.connectionTimeout).toInfraFailure(),
        isA<TimeoutFailure>(),
      );
    });

    test('DioException sendTimeout → timeout', () {
      expect(
        _dio(null, type: DioExceptionType.sendTimeout).toInfraFailure(),
        isA<TimeoutFailure>(),
      );
    });

    test('DioException receiveTimeout → timeout', () {
      expect(
        _dio(null, type: DioExceptionType.receiveTimeout).toInfraFailure(),
        isA<TimeoutFailure>(),
      );
    });

    test('DioException connectionError → network', () {
      expect(
        _dio(null, type: DioExceptionType.connectionError).toInfraFailure(),
        isA<NetworkFailure>(),
      );
    });

    test('DioException badCertificate → network', () {
      expect(
        _dio(null, type: DioExceptionType.badCertificate).toInfraFailure(),
        isA<NetworkFailure>(),
      );
    });

    test('DioException cancel → cancelled', () {
      expect(
        _dio(null, type: DioExceptionType.cancel).toInfraFailure(),
        isA<CancelledFailure>(),
      );
    });

    test('DioException unknown → unknown', () {
      expect(
        _dio(null, type: DioExceptionType.unknown).toInfraFailure(),
        isA<UnknownFailure>(),
      );
    });

    test('DioException with MissingAccessTokenException → unauthorized', () {
      final ex = DioException(
        requestOptions: RequestOptions(path: '/x'),
        error: const MissingAccessTokenException(),
      );

      expect(ex.toInfraFailure(), isA<UnauthorizedFailure>());
    });

    test('DioException with ServerError uses code + message', () {
      const server = ServerError(message: 'denied', code: 'AUTH_001');
      final ex = _dio(403, attachedError: server);

      expect(
        ex.toInfraFailure(),
        isA<ForbiddenFailure>()
            .having((f) => f.message, 'message', 'denied')
            .having((f) => f.code, 'code', 'AUTH_001'),
      );
    });

    test('TypeError → parsing', () {
      expect(_captureTypeError().toInfraFailure(), isA<ParsingFailure>());
    });

    test('Generic Exception → unknown', () {
      final ex = Exception('something');
      expect(ex.toInfraFailure(), isA<UnknownFailure>());
    });
  });
}
