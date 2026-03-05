import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/domain/use_cases/router_use_case.dart';
import 'package:flutter_template/src/domain/repositories/router_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'router_use_case_test.mocks.dart';

@GenerateMocks([RouterRepository])
void main() {
  late MockRouterRepository mockRepository;
  late GetOnboardingStatusUseCase getOnboardingUseCase;
  late GetUserLoginStatusUseCase getLoginUseCase;
  late MarkOnboardingCompletedUseCase markCompletedUseCase;

  setUp(() {
    mockRepository = MockRouterRepository();
    getOnboardingUseCase = GetOnboardingStatusUseCase(mockRepository);
    getLoginUseCase = GetUserLoginStatusUseCase(mockRepository);
    markCompletedUseCase = MarkOnboardingCompletedUseCase(mockRepository);
  });

  group('GetOnboardingStatusUseCase', () {
    test('should return status from repository (true)', () {
      // Arrange
      when(mockRepository.isOnboardingCompleted()).thenReturn(true);

      // Act
      final result = getOnboardingUseCase.call();

      // Assert
      expect(result, true);
      verify(mockRepository.isOnboardingCompleted()).called(1);
    });

    test('should return status from repository (false)', () {
      // Arrange
      when(mockRepository.isOnboardingCompleted()).thenReturn(false);

      // Act
      final result = getOnboardingUseCase.call();

      // Assert
      expect(result, false);
      verify(mockRepository.isOnboardingCompleted()).called(1);
    });
  });

  group('GetUserLoginStatusUseCase', () {
    test('should return status from repository (true)', () {
      // Arrange
      when(mockRepository.isUserLoggedIn()).thenReturn(true);

      // Act
      final result = getLoginUseCase.call();

      // Assert
      expect(result, true);
      verify(mockRepository.isUserLoggedIn()).called(1);
    });

    test('should return status from repository (false)', () {
      // Arrange
      when(mockRepository.isUserLoggedIn()).thenReturn(false);

      // Act
      final result = getLoginUseCase.call();

      // Assert
      expect(result, false);
      verify(mockRepository.isUserLoggedIn()).called(1);
    });
  });

  group('MarkOnboardingCompletedUseCase', () {
    test('should call repository.saveOnboardingAsCompleted', () {
      // Arrange
      // No return value needed (void)

      // Act
      markCompletedUseCase.call();

      // Assert
      verify(mockRepository.saveOnboardingAsCompleted()).called(1);
    });

    test('should handle repository failure', () {
      // Arrange
      when(
        mockRepository.saveOnboardingAsCompleted(),
      ).thenThrow(Exception('Save failed'));

      // Act & Assert
      expect(() => markCompletedUseCase.call(), throwsException);
    });
  });
}
