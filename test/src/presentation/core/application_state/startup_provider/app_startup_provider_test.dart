import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/application_state/startup_provider/app_startup_provider.dart';
import 'package:flutter_template/src/domain/use_cases/locale_use_case.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_startup_provider_test.mocks.dart';

@GenerateMocks([
  SharedPreferences,
  GetCurrentLocaleUseCase,
  SetCurrentLocaleUseCase,
])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MockGetCurrentLocaleUseCase mockGetLocaleUseCase;
  late MockSetCurrentLocaleUseCase mockSetLocaleUseCase;
  late ProviderContainer container;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockGetLocaleUseCase = MockGetCurrentLocaleUseCase();
    mockSetLocaleUseCase = MockSetCurrentLocaleUseCase();

    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => mockSharedPreferences),
        getCurrentLocaleUseCaseProvider.overrideWithValue(mockGetLocaleUseCase),
        setCurrentLocaleUseCaseProvider.overrideWithValue(mockSetLocaleUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('App Startup Provider', () {
    test('successful startup initialization', () async {
      // Arrange
      when(mockGetLocaleUseCase.call()).thenAnswer((_) async => 'en');

      // Act
      await container.read(appStartupProvider.future);

      // Assert
      verify(mockGetLocaleUseCase.call()).called(1);
    });

    test('startup handles error in localization', () async {
      // Arrange
      when(
        mockGetLocaleUseCase.call(),
      ).thenThrow(Exception('Localization error'));

      // Act & Assert
      expect(
        () => container.read(appStartupProvider.future),
        throwsA(isA<Exception>()),
      );
    });
  });
}
