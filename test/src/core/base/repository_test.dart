import 'package:flutter_template/src/core/base/failure.dart';
import 'package:flutter_template/src/core/base/repository.dart';
import 'package:flutter_template/src/core/base/result.dart';
import 'package:flutter_test/flutter_test.dart';

class TestRepository extends Repository<String> {}

class TestRepositoryWithNull extends Repository<String?> {}

void main() {
  late TestRepository repository;

  setUp(() {
    repository = TestRepository();
  });

  group('Repository', () {
    group('asyncGuard', () {
      test('should return Success when operation is successful', () async {
        // Arrange
        const expectedData = 'success_data';
        Future<String> operation() async => expectedData;

        // Act
        final result = await repository.asyncGuard(operation);

        // Assert
        expect(result, isA<Success<String, Failure>>());
        expect((result as Success).data, expectedData);
      });

      test('should return Error when operation throws an Exception', () async {
        // Arrange
        final exception = Exception('error_message');
        Future<String> operation() async => throw exception;

        // Act
        final result = await repository.asyncGuard(operation);

        // Assert
        expect(result, isA<Error<String, Failure>>());
        expect((result as Error).error.type, FailureType.unknown);
      });
    });

    group('guard', () {
      test('should return Success when sync operation is successful', () {
        // Arrange
        const expectedData = 'success_data';
        String operation() => expectedData;

        // Act
        final result = repository.guard(operation);

        // Assert
        expect(result, isA<Success<String, Failure>>());
        expect((result as Success).data, expectedData);
      });

      test('should return Error when sync operation throws an Exception', () {
        // Arrange
        final exception = Exception('error_message');
        String operation() => throw exception;

        // Act
        final result = repository.guard(operation);

        // Assert
        expect(result, isA<Error<String, Failure>>());
        expect((result as Error).error.type, FailureType.unknown);
      });
    });
    group('Edge Cases', () {
      test(
        'should handle null data returning from operation in asyncGuard',
        () async {
          // Arrange
          final repo = TestRepositoryWithNull();
          Future<String?> operation() async => null;

          // Act
          final result = await repo.asyncGuard(operation);

          // Assert
          expect(result, isA<Success<String?, Failure>>());
          expect((result as Success).data, isNull);
        },
      );

      test(
        'should capture stackTrace when exception occurs in asyncGuard',
        () async {
          Future<String> operation() async => throw Exception('error');

          final result = await repository.asyncGuard(operation);

          expect((result as Error).error.stackTrace, isNotNull);
        },
      );
    });
  });
}
