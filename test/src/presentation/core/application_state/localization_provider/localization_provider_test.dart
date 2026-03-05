import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/application_state/localization_provider/localization_provider.dart';
import 'package:flutter_template/src/domain/use_cases/locale_use_case.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'localization_provider_test.mocks.dart';

@GenerateMocks([GetCurrentLocaleUseCase, SetCurrentLocaleUseCase])
void main() {
  late MockGetCurrentLocaleUseCase mockGetUseCase;
  late MockSetCurrentLocaleUseCase mockSetUseCase;
  late ProviderContainer container;

  setUp(() {
    mockGetUseCase = MockGetCurrentLocaleUseCase();
    mockSetUseCase = MockSetCurrentLocaleUseCase();

    container = ProviderContainer(
      overrides: [
        getCurrentLocaleUseCaseProvider.overrideWithValue(mockGetUseCase),
        setCurrentLocaleUseCaseProvider.overrideWithValue(mockSetUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('Localization Provider', () {
    test('initial state is Locale("en")', () {
      // Arrange
      // (Initialization handled in build method)

      // Act
      final state = container.read(localizationProvider);

      // Assert
      expect(state, const Locale('en'));
    });

    test('changeLocale updates state and calls use case', () async {
      // Arrange
      const newLocale = Locale('bn');
      when(mockSetUseCase.call('bn')).thenAnswer((_) async => null);

      // Act
      await container
          .read(localizationProvider.notifier)
          .changeLocale(newLocale);

      // Assert
      expect(container.read(localizationProvider), newLocale);
      verify(mockSetUseCase.call('bn')).called(1);
    });

    test('setCurrentLocal sets state from use case', () async {
      // Arrange
      when(mockGetUseCase.call()).thenAnswer((_) async => 'es');

      // Act
      await container.read(localizationProvider.notifier).setCurrentLocal();

      // Assert
      expect(container.read(localizationProvider), const Locale('es'));
      verify(mockGetUseCase.call()).called(1);
    });
  });
}
