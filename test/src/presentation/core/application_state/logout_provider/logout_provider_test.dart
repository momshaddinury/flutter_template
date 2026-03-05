import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/application_state/logout_provider/logout_provider.dart';
import 'package:flutter_template/src/domain/use_cases/authentication_use_case.dart';
import 'package:flutter_template/src/domain/use_cases/reset_repository_use_case.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_provider_test.mocks.dart';

@GenerateMocks([LogoutUseCase, ResetRepositoryUseCase])
void main() {
  late MockLogoutUseCase mockLogoutUseCase;
  late MockResetRepositoryUseCase mockResetRepositoryUseCase;
  late ProviderContainer container;

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    mockResetRepositoryUseCase = MockResetRepositoryUseCase();
    container = ProviderContainer(
      overrides: [
        logoutUseCaseProvider.overrideWithValue(mockLogoutUseCase),
        resetRepositoryUseCaseProvider.overrideWithValue(
          mockResetRepositoryUseCase,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('Logout Provider', () {
    test('initial state is AsyncValue.data(null)', () {
      // Arrange
      // (Initialization handled in setUp)

      // Act
      final state = container.read(logoutProvider);

      // Assert
      expect(state, const AsyncValue<bool?>.data(null));
    });

    test('successful logout sequence', () async {
      // Arrange
      when(mockLogoutUseCase.call()).thenAnswer((_) async => null);
      when(mockResetRepositoryUseCase.call(any)).thenReturn(null);

      final notifier = container.read(logoutProvider.notifier);
      final states = <AsyncValue<bool?>>[];

      container.listen(
        logoutProvider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      // Act
      final callFuture = notifier.call();

      // (Intermediate assertion to verify loading state)
      await Future.delayed(const Duration(milliseconds: 100));
      final isLoading = container.read(logoutProvider).isLoading;

      await callFuture;

      // Assert
      expect(isLoading, isTrue);
      expect(states.length, greaterThanOrEqualTo(3));
      expect(states.first, const AsyncValue<bool?>.data(null));
      expect(states.any((s) => s.isLoading), isTrue);
      expect(states.last, const AsyncValue<bool?>.data(true));

      verify(mockLogoutUseCase.call()).called(1);
      verify(mockResetRepositoryUseCase.call(any)).called(1);
    });

    test('logout failure sets error state', () async {
      // Arrange
      final exception = Exception('Logout failed');
      when(mockLogoutUseCase.call()).thenThrow(exception);

      final notifier = container.read(logoutProvider.notifier);

      // Act
      await notifier.call();

      // Assert
      final state = container.read(logoutProvider);
      expect(state.hasError, isTrue);
      expect(state.error, exception);
    });

    test('returns early if already loading', () async {
      // Arrange
      when(mockLogoutUseCase.call()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
      });

      final notifier = container.read(logoutProvider.notifier);

      // Act
      final firstCall = notifier.call();
      // Start second call immediately while first is still running
      await notifier.call();
      await firstCall;

      // Assert
      // Ensure mockLogoutUseCase was only called once despite two calls to notifier.call()
      verify(mockLogoutUseCase.call()).called(1);
    });
  });
}
