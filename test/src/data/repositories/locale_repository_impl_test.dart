import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/data/repositories/locale_repository_impl.dart';
import 'package:flutter_template/src/data/services/cache/cache_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'locale_repository_impl_test.mocks.dart';

@GenerateMocks([CacheService])
void main() {
  late MockCacheService mockLocal;
  late LocaleRepositoryImpl repository;

  setUp(() {
    mockLocal = MockCacheService();
    repository = LocaleRepositoryImpl(mockLocal);
  });

  group('LocaleRepositoryImpl', () {
    test('setLanguage should save language to cache', () async {
      // Arrange
      const language = 'bn';
      when(
        mockLocal.save(CacheKey.language, language),
      ).thenAnswer((_) async => {});

      // Act
      await repository.setLanguage(language);

      // Assert
      verify(mockLocal.save(CacheKey.language, language)).called(1);
    });

    group('getLanguage', () {
      test('should return cached language', () async {
        // Arrange
        const language = 'bn';
        when(mockLocal.get<String>(CacheKey.language)).thenReturn(language);

        // Act
        final result = await repository.getLanguage();

        // Assert
        expect(result, language);
        verify(mockLocal.get<String>(CacheKey.language)).called(1);
      });

      test('should return default "en" when cache is null', () async {
        // Arrange
        when(mockLocal.get<String>(CacheKey.language)).thenReturn(null);

        // Act
        final result = await repository.getLanguage();

        // Assert
        expect(result, 'en');
      });
    });
  });
}
