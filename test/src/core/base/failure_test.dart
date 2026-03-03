import 'package:dio/dio.dart';
import 'package:flutter_template/src/core/base/exceptions.dart';
import 'package:flutter_template/src/core/base/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure', () {
    group('mapExceptionToFailure', () {
      test(
        'should map DioException connectionTimeout to FailureType.timeout',
        () {
          // Arrange
          final errorMessage = 'Connection Timeout';
          final exception = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {'message': errorMessage},
            ),
          );

          // Act
          final failure = Failure.mapExceptionToFailure(exception);

          // Assert
          expect(failure.type, FailureType.timeout);
          expect(failure.message, contains(errorMessage));
        },
      );

      test('should map DioException receiveTimeout to FailureType.timeout', () {
        // Arrange
        final errorMessage = 'Recieve Timeout';
        final exception = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.receiveTimeout,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': errorMessage},
          ),
        );

        // Act
        final failure = Failure.mapExceptionToFailure(exception);

        // Assert
        expect(failure.type, FailureType.timeout);
        expect(failure.message, contains(errorMessage));
      });

      test('should map DioException sendTimeout to FailureType.timeout', () {
        // Arrangek
        final errorMessage = 'Send Timeout';
        final exception = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.sendTimeout,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': errorMessage},
          ),
        );

        // Act
        final failure = Failure.mapExceptionToFailure(exception);

        // Assert
        expect(failure.type, FailureType.timeout);
        expect(failure.message, contains(errorMessage));
      });

      test(
        'should map DioException badResponse with custom message and code',
        () {
          // Arrange
          final errorMessage = 'custom_error_message';
          final exception = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 400,
              data: {'message': errorMessage, 'statusCode': 400},
            ),
          );

          // Act
          final failure = Failure.mapExceptionToFailure(exception);

          // Assert
          expect(failure.type, FailureType.badResponse);
          expect(failure.message, contains(errorMessage));
          expect(failure.code, '400');
        },
      );

      test(
        'maps DioException.badCertificate to FailureType.badCertificate',
        () {
          final errorMessage = 'Cert error';
          final exception = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badCertificate,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {'message': errorMessage},
            ),
          );

          final failure = Failure.mapExceptionToFailure(exception);

          expect(failure.type, FailureType.badCertificate);
          expect(failure.message, contains(errorMessage));
        },
      );

      test('maps DioException.connectionError to FailureType.network', () {
        final errorMessage = 'Network down';
        final exception = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': errorMessage},
          ),
        );

        final failure = Failure.mapExceptionToFailure(exception);

        expect(failure.type, FailureType.network);
        expect(failure.message, contains(errorMessage));
      });

      test('maps unknown DioException type to FailureType.unknown', () {
        final errorMessage = 'Cancelled';
        final exception = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.cancel, // a type not explicitly handled
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': errorMessage},
          ),
        );

        final failure = Failure.mapExceptionToFailure(exception);

        expect(failure.type, FailureType.unknown);
        expect(failure.message, contains(errorMessage));
      });

      test(
        'should handle nested Map in message during DioException parsing',
        () {
          // Arrange
          final exception = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {
                'message': {'error': 'first_error', 'detail': 'second_error'},
              },
            ),
          );

          // Act
          final failure = Failure.mapExceptionToFailure(exception);

          // Assert
          expect(failure.message, 'first_error second_error');
        },
      );

      test('should map ParsingException to FailureType.parsing', () {
        // Arrange
        const exception = CustomException.parsing(message: 'parse_error');

        // Act
        final failure = Failure.mapExceptionToFailure(exception);

        // Assert
        expect(failure.type, FailureType.parsing);
        expect(failure.message, 'parse_error');
      });

      test('should map ValidationException to FailureType.validation', () {
        // Arrange
        const exception = CustomException.validation(
          message: 'validation_error',
          field: 'field_name',
        );

        // Act
        final failure = Failure.mapExceptionToFailure(exception);

        // Assert
        expect(failure.type, FailureType.validation);
        expect(failure.message, 'validation_error');
      });

      test(
        'should map IllegalOperationException to FailureType.illegalOperation',
        () {
          // Arrange
          const exception = CustomException.illegalOperation(
            message: 'illegal_operation',
          );

          // Act
          final failure = Failure.mapExceptionToFailure(exception);

          // Assert
          expect(failure.type, FailureType.illegalOperation);
          expect(failure.message, 'illegal_operation');
        },
      );

      test('should map NotFoundException to FailureType.notFound', () {
        // Arrange
        const exception = CustomException.notFound(message: 'not_found');

        // Act
        final failure = Failure.mapExceptionToFailure(exception);

        // Assert
        expect(failure.type, FailureType.notFound);
        expect(failure.message, 'not_found');
      });

      test('should map UnauthorizedException to FailureType.unauthorized', () {
        // Arrange
        const exception = CustomException.unauthorized(message: 'unauthorized');

        // Act
        final failure = Failure.mapExceptionToFailure(exception);

        // Assert
        expect(failure.type, FailureType.unauthorized);
        expect(failure.message, 'unauthorized');
      });

      test('should map unknown object to FailureType.unknown', () {
        // Arrange
        const unknown = 'some_string';

        // Act
        final failure = Failure.mapExceptionToFailure(unknown);

        // Assert
        expect(failure.type, FailureType.unknown);
        expect(failure.message, 'some_string');
      });

      test('should map TypeError to FailureType.typeError', () {
        // Arrange
        final error = TypeError();

        // Act
        final failure = Failure.mapExceptionToFailure(error);

        // Assert
        expect(failure.type, FailureType.typeError);
        expect(failure.message, contains('Type mismatch'));
      });

      test('should map unknown Error to FailureType.unknown', () {
        // Arrange
        final error =
            ArgumentError(); // an Error type not explicitly handled in the mapping

        // Act
        final failure = Failure.mapExceptionToFailure(error);

        // Assert
        expect(failure.type, FailureType.unknown);
        expect(failure.message, error.toString());
      });

      group('Edge Cases', () {
        test('should handle null response in DioException', () {
          // Arrange
          final exception = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: null,
          );

          // Act
          final failure = Failure.mapExceptionToFailure(exception);

          // Assert
          expect(failure.message, exception.toString());
        });

        test('should handle non-map data in Response', () {
          // Arrange
          final exception = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: 'string_data',
            ),
          );

          // Act
          final failure = Failure.mapExceptionToFailure(exception);

          // Assert
          expect(failure.message, exception.toString());
        });
      });
    });
  });
}
