import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/domain/use_cases/locale_use_case.dart';
import 'package:flutter_template/src/domain/repositories/locale_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'locale_use_case_test.mocks.dart';

@GenerateMocks([LocaleRepository])
void main() {
  late MockLocaleRepository mockRepository;
  late GetCurrentLocaleUseCase getUseCase;
  late SetCurrentLocaleUseCase setUseCase;

  setUp(() {
    mockRepository = MockLocaleRepository();
    getUseCase = GetCurrentLocaleUseCase(mockRepository);
    setUseCase = SetCurrentLocaleUseCase(mockRepository);
  });

  group('GetCurrentLocaleUseCase', () {
    test('should return language from repository', () async {
      // Arrange
      const language = 'en';
      when(mockRepository.getLanguage()).thenAnswer((_) async => language);

      // Act
      final result = await getUseCase.call();

      // Assert
      expect(result, language);
      verify(mockRepository.getLanguage()).called(1);
    });

    test('should handle repository failure', () async {
      // Arrange
      when(
        mockRepository.getLanguage(),
      ).thenThrow(Exception('Failed to get language'));

      // Act & Assert
      expect(() => getUseCase.call(), throwsException);
    });
  });

  group('SetCurrentLocaleUseCase', () {
    test('should set language in repository', () async {
      // Arrange
      const language = 'en';
      when(mockRepository.setLanguage(any)).thenAnswer((_) async => null);

      // Act
      await setUseCase.call(language);

      // Assert
      verify(mockRepository.setLanguage(language)).called(1);
    });

    test('should handle repository failure', () async {
      // Arrange
      const language = 'en';
      when(
        mockRepository.setLanguage(any),
      ).thenThrow(Exception('Failed to set language'));

      // Act & Assert
      expect(() => setUseCase.call(language), throwsException);
    });
  });
}
