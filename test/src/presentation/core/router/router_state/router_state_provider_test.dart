import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/router/router_state/router_state_provider.dart';
import 'package:flutter_template/src/presentation/core/router/routes.dart';
import 'package:flutter_template/src/presentation/core/application_state/startup_provider/app_startup_provider.dart';
import 'package:flutter_template/src/domain/use_cases/router_use_case.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'router_state_provider_test.mocks.dart';

@GenerateMocks([
  GetOnboardingStatusUseCase,
  GetUserLoginStatusUseCase,
  MarkOnboardingCompletedUseCase,
])
void main() {
  late MockGetOnboardingStatusUseCase mockGetOnboardingUseCase;
  late MockGetUserLoginStatusUseCase mockGetLoginUseCase;
  late MockMarkOnboardingCompletedUseCase mockMarkOnboardingUseCase;
  late Completer<void> startupCompleter;
  late ProviderContainer container;

  setUp(() {
    mockGetOnboardingUseCase = MockGetOnboardingStatusUseCase();
    mockGetLoginUseCase = MockGetUserLoginStatusUseCase();
    mockMarkOnboardingUseCase = MockMarkOnboardingCompletedUseCase();
    startupCompleter = Completer<void>();

    container = ProviderContainer(
      overrides: [
        getOnboardingStatusUseCaseProvider.overrideWithValue(
          mockGetOnboardingUseCase,
        ),
        getUserLoginStatusUseCaseProvider.overrideWithValue(
          mockGetLoginUseCase,
        ),
        markOnboardingCompletedUseCaseProvider.overrideWithValue(
          mockMarkOnboardingUseCase,
        ),
        appStartupProvider.overrideWith((ref) => startupCompleter.future),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('RouterState Provider', () {
    test('initial state is Routes.initial', () {
      // Act
      final state = container.read(routerStateProvider);

      // Assert
      expect(state, Routes.initial);
    });

    test(
      'transitions to splash then onboarding when startup completes',
      () async {
        // Arrange
        when(mockGetOnboardingUseCase.call()).thenReturn(false);
        when(mockGetLoginUseCase.call()).thenReturn(false);

        // Trigger provider creation and listener registration
        container.read(routerStateProvider);

        // Act
        startupCompleter.complete();

        // Wait for build event loop
        await Future.delayed(Duration.zero);

        // At this point, ref.listen should have fired and called decideNextRoute
        // First call (initial -> splash)
        expect(container.read(routerStateProvider), Routes.splash);

        // Wait for the timer in decideNextRoute (500ms)
        await Future.delayed(const Duration(milliseconds: 600));

        // Assert - phase 2: onboarding
        expect(container.read(routerStateProvider), Routes.onboarding);
        verify(mockMarkOnboardingUseCase.call()).called(1);
      },
    );

    test('transitions to login if onboarded but not logged in', () async {
      // Arrange
      when(mockGetOnboardingUseCase.call()).thenReturn(true);
      when(mockGetLoginUseCase.call()).thenReturn(false);

      container.read(routerStateProvider);

      // Act
      startupCompleter.complete();
      await Future.delayed(Duration.zero);

      // Check intermediate
      expect(container.read(routerStateProvider), Routes.splash);

      await Future.delayed(const Duration(milliseconds: 600));

      // Assert
      expect(container.read(routerStateProvider), Routes.login);
    });

    test('transitions to home if onboarded and logged in', () async {
      // Arrange
      when(mockGetOnboardingUseCase.call()).thenReturn(true);
      when(mockGetLoginUseCase.call()).thenReturn(true);

      container.read(routerStateProvider);

      // Act
      startupCompleter.complete();
      await Future.delayed(Duration.zero);

      // Check intermediate
      expect(container.read(routerStateProvider), Routes.splash);

      await Future.delayed(const Duration(milliseconds: 600));

      // Assert
      expect(container.read(routerStateProvider), Routes.home);
    });
  });
}
