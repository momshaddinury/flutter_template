import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_template/src/core/base/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/core/base/failure.dart';
import 'package:flutter_template/src/core/base/result.dart';
import 'package:flutter_template/src/data/models/login_model.dart';
import 'package:flutter_template/src/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_template/src/data/services/cache/cache_service.dart';
import 'package:flutter_template/src/data/services/network/rest_client.dart';
import 'package:flutter_template/src/domain/entities/login_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'authentication_repository_impl_test.mocks.dart';

@GenerateMocks([RestClient, CacheService])
void main() {
  late MockRestClient mockRemote;
  late MockCacheService mockLocal;
  late AuthenticationRepositoryImpl repository;

  setUp(() {
    mockRemote = MockRestClient();
    mockLocal = MockCacheService();
    repository = AuthenticationRepositoryImpl(
      remote: mockRemote,
      local: mockLocal,
    );
  });

  group('AuthenticationRepositoryImpl', () {
    group('login', () {
      final loginRequest = LoginRequestEntity(
        username: 'test',
        password: 'password',
        shouldRemeber: true,
      );

      final loginResponseData = {
        'id': 1,
        'username': 'test',
        'email': 'test@example.com',
        'firstName': 'First',
        'lastName': 'Last',
        'gender': 'male',
        'image': 'url',
        'accessToken': 'access',
        'refreshToken': 'refresh',
      };

      test(
        'should return Success when login is successful and save session if shouldRemember is true',
        () async {
          // Arrange
          final httpResponse = HttpResponse(
            loginResponseData,
            Response(requestOptions: RequestOptions(path: '')),
          );

          when(mockRemote.login(any)).thenAnswer((_) async => httpResponse);
          when(
            mockLocal.save(CacheKey.isLoggedIn, true),
          ).thenAnswer((_) async {});

          // Act
          final result = await repository.login(loginRequest);

          // Assert
          expect(result, isA<Success>());
          final data = (result as Success).data;
          expect(data, isA<LoginResponseModel>());
          expect(data.accessToken, 'access');

          verify(mockRemote.login(any)).called(1);
          verify(mockLocal.save(CacheKey.isLoggedIn, true)).called(1);
        },
      );

      test(
        'should return Success but NOT save session if shouldRemember is false',
        () async {
          // Arrange
          final request = LoginRequestEntity(
            username: 'test',
            password: 'password',
            shouldRemeber: false,
          );
          final response = Response(
            data: loginResponseData,
            requestOptions: RequestOptions(path: ''),
          );
          final httpResponse = HttpResponse(loginResponseData, response);

          when(mockRemote.login(any)).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.login(request);

          // Assert
          expect(result, isA<Success>());
          verify(mockRemote.login(any)).called(1);
          verifyNever(mockLocal.save(CacheKey.isLoggedIn, any));
        },
      );

      test(
        'should return Error when remote.login throws an Exception',
        () async {
          // Arrange
          final exception = Exception('Network error');
          when(mockRemote.login(any)).thenThrow(exception);

          // Act
          final result = await repository.login(loginRequest);

          // Assert
          expect(result, isA<Error>());
          final failure = (result as Error).error as Failure;
          expect(failure.message, contains('Network error'));
          verify(mockRemote.login(any)).called(1);
        },
      );

      test('should return Error when response data is malformed', () async {
        // Arrange
        final malformedData = {'invalid': 'data'};
        final response = Response(
          data: malformedData,
          requestOptions: RequestOptions(path: ''),
        );
        final httpResponse = HttpResponse(malformedData, response);

        when(mockRemote.login(any)).thenAnswer((_) async => httpResponse);

        // Act
        final result = await repository.login(loginRequest);

        // Assert
        expect(result, isA<Error>());
        final failure = (result as Error).error as Failure;
        expect(failure.type, FailureType.unknown);
        verify(mockRemote.login(any)).called(1);
      });
    });

    group('rememberMe', () {
      test('should return cached value when rememberMe is null', () async {
        // Arrange
        when(mockLocal.get<bool>(CacheKey.rememberMe)).thenReturn(true);

        // Act
        final result = await repository.rememberMe(rememberMe: null);

        // Assert
        expect(result, true);
        verify(mockLocal.get<bool>(CacheKey.rememberMe)).called(1);
      });

      test('should return false when cached value is null', () async {
        // Arrange
        when(mockLocal.get<bool>(CacheKey.rememberMe)).thenReturn(null);

        // Act
        final result = await repository.rememberMe(rememberMe: null);

        // Assert
        expect(result, false);
      });

      test(
        'should save and return new value when rememberMe is NOT null',
        () async {
          // Arrange
          when(
            mockLocal.save(CacheKey.rememberMe, true),
          ).thenAnswer((_) async {});

          // Act
          final result = await repository.rememberMe(rememberMe: true);

          // Assert
          expect(result, true);
          verify(mockLocal.save(CacheKey.rememberMe, true)).called(1);
        },
      );

      test('should return false when an error occurs', () async {
        // Arrange
        when(
          mockLocal.get<bool>(CacheKey.rememberMe),
        ).thenThrow(Exception('Cache error'));

        // Act
        final result = await repository.rememberMe(rememberMe: null);

        // Assert
        expect(result, false);
      });
    });

    group('logout', () {
      test('should remove login and remember me status from cache', () async {
        // Arrange
        when(mockLocal.remove(any)).thenAnswer((_) async {});

        // Act
        await repository.logout();

        // Assert
        verify(
          mockLocal.remove([CacheKey.isLoggedIn, CacheKey.rememberMe]),
        ).called(1);
      });
    });
  });
}
