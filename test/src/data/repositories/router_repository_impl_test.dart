import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/data/repositories/router_repository_impl.dart';
import 'package:flutter_template/src/data/services/cache/cache_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'router_repository_impl_test.mocks.dart';

@GenerateMocks([CacheService])
void main() {
  late MockCacheService mockLocal;
  late RouterRepositoryImpl repository;

  setUp(() {
    mockLocal = MockCacheService();
    repository = RouterRepositoryImpl(cacheService: mockLocal);
  });

  group('RouterRepositoryImpl', () {
    test('isOnboardingCompleted should return value from cache', () {
      // Arrange
      when(mockLocal.get(CacheKey.isOnBoardingCompleted)).thenReturn(true);

      // Act
      final result = repository.isOnboardingCompleted();

      // Assert
      expect(result, true);
      verify(mockLocal.get(CacheKey.isOnBoardingCompleted)).called(1);
    });

    test('isOnboardingCompleted should return false when cache is null', () {
      // Arrange
      when(mockLocal.get(CacheKey.isOnBoardingCompleted)).thenReturn(null);

      // Act
      final result = repository.isOnboardingCompleted();

      // Assert
      expect(result, false);
    });

    test('isUserLoggedIn should return value from cache', () {
      // Arrange
      when(mockLocal.get(CacheKey.isLoggedIn)).thenReturn(true);

      // Act
      final result = repository.isUserLoggedIn();

      // Assert
      expect(result, true);
      verify(mockLocal.get(CacheKey.isLoggedIn)).called(1);
    });

    test('isUserLoggedIn should return false when cache is null', () {
      // Arrange
      when(mockLocal.get(CacheKey.isLoggedIn)).thenReturn(null);

      // Act
      final result = repository.isUserLoggedIn();

      // Assert
      expect(result, false);
    });

    test('saveOnboardingAsCompleted should save true to cache', () {
      // Arrange
      when(
        mockLocal.save(CacheKey.isOnBoardingCompleted, true),
      ).thenAnswer((_) async {});

      // Act
      repository.saveOnboardingAsCompleted();

      // Assert
      verify(mockLocal.save(CacheKey.isOnBoardingCompleted, true)).called(1);
    });
  });
}
