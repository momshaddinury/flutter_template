import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/domain/use_cases/reset_repository_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_repository_use_case_test.mocks.dart';

@GenerateMocks([Ref])
void main() {
  late MockRef mockRef;
  late ProviderContainer container;
  late ResetRepositoryUseCase resetUseCase;

  setUp(() {
    mockRef = MockRef();
    container = ProviderContainer();
    resetUseCase = const ResetRepositoryUseCase();

    when(mockRef.container).thenReturn(container);
  });

  tearDown(() {
    container.dispose();
  });

  group('ResetRepositoryUseCase', () {
    test(
      'should invalidate only providers containing "Repository" in their name',
      () {
        // Arrange
        // We create real providers with names
        final repoProvider = Provider<int>((ref) => 0, name: 'AuthRepository');
        final otherProvider = Provider<int>((ref) => 0, name: 'other');

        // We need to "read" them so they have elements in the container
        container.read(repoProvider);
        container.read(otherProvider);

        // Act
        resetUseCase.call(mockRef);

        // Assert
        // We can check if invalidate was called with the repoProvider
        verify(mockRef.invalidate(repoProvider)).called(1);
        verifyNever(mockRef.invalidate(otherProvider));
      },
    );

    test('should do nothing if no providers match the name "Repository"', () {
      // Arrange
      final otherProvider = Provider<int>((ref) => 0, name: 'someProvider');
      container.read(otherProvider);

      // Act
      resetUseCase.call(mockRef);

      // Assert
      verifyNever(mockRef.invalidate(any));
    });

    test('should handle providers with null names', () {
      // Arrange
      final nullNameProvider = Provider<int>(
        (ref) => 0,
      ); // Default name is null usually if not set or generated
      final repoProvider = Provider<int>((ref) => 0, name: 'RouterRepository');

      container.read(nullNameProvider);
      container.read(repoProvider);

      // Act
      resetUseCase.call(mockRef);

      // Assert
      verify(mockRef.invalidate(repoProvider)).called(1);
      verifyNever(mockRef.invalidate(nullNameProvider));
    });
  });
}
