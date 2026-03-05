import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/base/status.dart';

void main() {
  group('StatusExtension', () {
    test('isInitial returns true only for Status.initial', () {
      // Arrange
      const status = Status.initial;

      // Act & Assert
      expect(status.isInitial, isTrue);
      expect(Status.loading.isInitial, isFalse);
      expect(Status.success.isInitial, isFalse);
      expect(Status.error.isInitial, isFalse);
    });

    test('isLoading returns true only for Status.loading', () {
      // Arrange
      const status = Status.loading;

      // Act & Assert
      expect(status.isLoading, isTrue);
      expect(Status.initial.isLoading, isFalse);
      expect(Status.success.isLoading, isFalse);
      expect(Status.error.isLoading, isFalse);
    });

    test('isSuccess returns true only for Status.success', () {
      // Arrange
      const status = Status.success;

      // Act & Assert
      expect(status.isSuccess, isTrue);
      expect(Status.initial.isSuccess, isFalse);
      expect(Status.loading.isSuccess, isFalse);
      expect(Status.error.isSuccess, isFalse);
    });

    test('isError returns true only for Status.error', () {
      // Arrange
      const status = Status.error;

      // Act & Assert
      expect(status.isError, isTrue);
      expect(Status.initial.isError, isFalse);
      expect(Status.loading.isError, isFalse);
      expect(Status.success.isError, isFalse);
    });
  });
}
