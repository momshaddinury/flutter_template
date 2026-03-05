import 'package:flutter_template/src/data/services/cache/cache_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_service_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockPrefs;
  late SharedPreferencesService service;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    service = SharedPreferencesService(mockPrefs);
  });

  group('SharedPreferencesService', () {
    group('save', () {
      test('should call setString for String value', () async {
        // Arrange
        const key = CacheKey.accessToken;
        const value = 'token';
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);

        // Act
        await service.save<String>(key, value);

        // Assert
        verify(mockPrefs.setString(key.name, value)).called(1);
      });

      test('should call setInt for int value', () async {
        // Arrange
        const key = CacheKey
            .rememberMe; // Assuming we use it for int sometimes if needed, but let's just test the logic
        const value = 1;
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);

        // Act
        await service.save<int>(key, value);

        // Assert
        verify(mockPrefs.setInt(key.name, value)).called(1);
      });

      test('should call setBool for bool value', () async {
        // Arrange
        const key = CacheKey.isLoggedIn;
        const value = true;
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.save<bool>(key, value);

        // Assert
        verify(mockPrefs.setBool(key.name, value)).called(1);
      });

      test('should call setDouble for double value', () async {
        // Arrange
        const key = CacheKey.language; // Just for test
        const value = 1.0;
        when(mockPrefs.setDouble(any, any)).thenAnswer((_) async => true);

        // Act
        await service.save<double>(key, value);

        // Assert
        verify(mockPrefs.setDouble(key.name, value)).called(1);
      });

      test('should default to setString for unknown types', () async {
        // Arrange
        const key = CacheKey.accessToken;
        const value = 'unknown';
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);

        // Act (using dynamic to bypass type checking if possible or just testing the switch)
        await service.save(key, value);

        // Assert
        verify(mockPrefs.setString(key.name, value)).called(1);
      });
    });

    group('get', () {
      test('should return String value', () {
        // Arrange
        const key = CacheKey.accessToken;
        const value = 'token';
        when(mockPrefs.getString(any)).thenReturn(value);

        // Act
        final result = service.get<String>(key);

        // Assert
        expect(result, value);
        verify(mockPrefs.getString(key.name)).called(1);
      });

      test('should return int value', () {
        // Arrange
        const key = CacheKey.rememberMe;
        const value = 1;
        when(mockPrefs.getInt(any)).thenReturn(value);

        // Act
        final result = service.get<int>(key);

        // Assert
        expect(result, value);
        verify(mockPrefs.getInt(key.name)).called(1);
      });

      test('should return bool value', () {
        // Arrange
        const key = CacheKey.isLoggedIn;
        const value = true;
        when(mockPrefs.getBool(any)).thenReturn(value);

        // Act
        final result = service.get<bool>(key);

        // Assert
        expect(result, value);
        verify(mockPrefs.getBool(key.name)).called(1);
      });

      test('should return double value', () {
        // Arrange
        const key = CacheKey.language;
        const value = 1.0;
        when(mockPrefs.getDouble(any)).thenReturn(value);

        // Act
        final result = service.get<double>(key);

        // Assert
        expect(result, value);
        verify(mockPrefs.getDouble(key.name)).called(1);
      });

      test('should return null when value is not found', () {
        // Arrange
        const key = CacheKey.accessToken;
        when(mockPrefs.getString(any)).thenReturn(null);

        // Act
        final result = service.get<String>(key);

        // Assert
        expect(result, null);
      });

      test('should use generic get for unknown types', () {
        // Arrange
        const key = CacheKey.accessToken;
        const value = 'dynamic';
        when(mockPrefs.get(any)).thenReturn(value);

        // Act
        final result = service.get(key);

        // Assert
        expect(result, value);
        verify(mockPrefs.get(key.name)).called(1);
      });
    });

    group('remove', () {
      test('should call remove for each key', () async {
        // Arrange
        final keys = [CacheKey.accessToken, CacheKey.refreshToken];
        when(mockPrefs.remove(any)).thenAnswer((_) async => true);

        // Act
        await service.remove(keys);

        // Assert
        verify(mockPrefs.remove(CacheKey.accessToken.name)).called(1);
        verify(mockPrefs.remove(CacheKey.refreshToken.name)).called(1);
      });

      test('should do nothing if keys list is empty', () async {
        // Act
        await service.remove([]);

        // Assert
        verifyNever(mockPrefs.remove(any));
      });
    });

    group('clear', () {
      test('should call clear', () async {
        // Arrange
        when(mockPrefs.clear()).thenAnswer((_) async => true);

        // Act
        await service.clear();

        // Assert
        verify(mockPrefs.clear()).called(1);
      });
    });
  });
}
