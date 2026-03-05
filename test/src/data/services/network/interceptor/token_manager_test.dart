import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/data/services/cache/cache_service.dart';
import 'package:flutter_template/src/data/services/network/interceptor/token_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'token_manager_test.mocks.dart';

@GenerateMocks([
  CacheService,
  Dio,
  RequestInterceptorHandler,
  ErrorInterceptorHandler,
  NavigatorState,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TokenManager tokenManager;
  late MockCacheService mockCacheService;
  late MockDio mockDio;
  late MockRequestInterceptorHandler mockRequestHandler;
  late MockErrorInterceptorHandler mockErrorHandler;
  late GlobalKey<NavigatorState> navigatorKey;

  const baseUrl = 'https://api.example.com';
  const refreshTokenEndpoint = '/auth/refresh';

  setUp(() {
    mockCacheService = MockCacheService();
    mockDio = MockDio();
    mockRequestHandler = MockRequestInterceptorHandler();
    mockErrorHandler = MockErrorInterceptorHandler();
    navigatorKey = GlobalKey<NavigatorState>();

    tokenManager = TokenManager(
      baseUrl: baseUrl,
      refreshTokenEndpoint: refreshTokenEndpoint,
      cacheService: mockCacheService,
      navigatorKey: navigatorKey,
      dio: mockDio,
    );
  });

  group('TokenManager', () {
    group('onRequest', () {
      test('should add Authorization header when token exists', () async {
        // Arrange
        final options = RequestOptions(path: '/test');
        when(
          mockCacheService.get(CacheKey.accessToken),
        ).thenReturn('valid_token');

        // Act
        tokenManager.onRequest(options, mockRequestHandler);

        // Assert
        expect(options.headers['Authorization'], 'Bearer valid_token');
        verify(mockRequestHandler.next(options)).called(1);
      });

      test(
        'should NOT add Authorization header when token does not exist',
        () async {
          // Arrange
          final options = RequestOptions(path: '/test');
          when(mockCacheService.get(CacheKey.accessToken)).thenReturn(null);

          // Act
          tokenManager.onRequest(options, mockRequestHandler);

          // Assert
          expect(options.headers.containsKey('Authorization'), false);
          verify(mockRequestHandler.next(options)).called(1);
        },
      );
    });

    group('onError', () {
      test('should pass through non-401 errors', () async {
        // Arrange
        final err = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 500,
          ),
        );

        // Act
        tokenManager.onError(err, mockErrorHandler);

        // Assert
        verify(mockErrorHandler.next(err)).called(1);
      });

      test('should pass through 401 errors that are already retries', () async {
        // Arrange
        final err = DioException(
          requestOptions: RequestOptions(path: '/test', extra: {'retry': true}),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 401,
          ),
        );

        // Act
        tokenManager.onError(err, mockErrorHandler);

        // Assert
        verify(mockErrorHandler.next(err)).called(1);
      });

      test(
        'should handle 401 error, refresh token and retry request',
        () async {
          // Arrange
          final options = RequestOptions(path: '/test');
          final err = DioException(
            requestOptions: options,
            response: Response(requestOptions: options, statusCode: 401),
          );

          final refreshResponse = Response(
            requestOptions: RequestOptions(path: refreshTokenEndpoint),
            statusCode: 200,
            data: {
              'data': {'accessToken': 'new_token'},
            },
          );

          final retryResponse = Response(
            requestOptions: options,
            statusCode: 200,
            data: {'success': true},
          );

          when(
            mockCacheService.get(CacheKey.refreshToken),
          ).thenReturn('refresh_token');
          when(mockCacheService.get(CacheKey.accessToken)).thenReturn(null);

          when(mockDio.fetch(any)).thenAnswer((realInvocation) async {
            final RequestOptions retryOptions =
                realInvocation.positionalArguments[0];
            if (retryOptions.path == refreshTokenEndpoint) {
              return refreshResponse;
            } else {
              return retryResponse;
            }
          });

          // Act
          tokenManager.onError(err, mockErrorHandler);

          // Assert
          await Future.delayed(const Duration(milliseconds: 300));

          verify(mockCacheService.get(CacheKey.refreshToken));
          verify(
            mockCacheService.save(CacheKey.accessToken, 'new_token'),
          ).called(1);
          verify(mockErrorHandler.resolve(retryResponse)).called(1);
          expect(options.headers['Authorization'], 'Bearer new_token');
          expect(options.extra['retry'], true);
        },
      );

      test('should handle refresh failure, remove tokens and reject', () async {
        // Arrange
        final options = RequestOptions(path: '/test');
        final err = DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
        );

        when(
          mockCacheService.get(CacheKey.refreshToken),
        ).thenReturn('refresh_token');
        when(mockDio.fetch(any)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: refreshTokenEndpoint),
            response: Response(
              requestOptions: RequestOptions(path: refreshTokenEndpoint),
              statusCode: 401,
            ),
          ),
        );

        // Act
        tokenManager.onError(err, mockErrorHandler);

        // Assert
        await Future.delayed(const Duration(milliseconds: 300));

        verify(mockCacheService.get(CacheKey.refreshToken));
        verify(
          mockCacheService.remove([
            CacheKey.accessToken,
            CacheKey.refreshToken,
          ]),
        ).called(1);
        verify(mockErrorHandler.reject(err)).called(1);
      });

      test(
        'should queue requests during refresh and retry them after',
        () async {
          // Arrange
          final options1 = RequestOptions(path: '/test1');
          final err1 = DioException(
            requestOptions: options1,
            response: Response(requestOptions: options1, statusCode: 401),
          );
          final mockHandler1 = MockErrorInterceptorHandler();

          final options2 = RequestOptions(path: '/test2');
          final err2 = DioException(
            requestOptions: options2,
            response: Response(requestOptions: options2, statusCode: 401),
          );
          final mockHandler2 = MockErrorInterceptorHandler();

          final refreshResponse = Response(
            requestOptions: RequestOptions(path: refreshTokenEndpoint),
            statusCode: 200,
            data: {
              'data': {'accessToken': 'new_token'},
            },
          );

          when(
            mockCacheService.get(CacheKey.refreshToken),
          ).thenReturn('refresh_token');
          when(mockCacheService.get(CacheKey.accessToken)).thenReturn(null);

          when(mockDio.fetch(any)).thenAnswer((realInvocation) async {
            final RequestOptions opts = realInvocation.positionalArguments[0];
            if (opts.path == refreshTokenEndpoint) {
              await Future.delayed(const Duration(milliseconds: 100));
              return refreshResponse;
            } else {
              return Response(requestOptions: opts, statusCode: 200);
            }
          });

          // Act
          tokenManager.onError(err1, mockHandler1);

          await Future.delayed(const Duration(milliseconds: 20));
          tokenManager.onError(err2, mockHandler2);

          // Assert
          await Future.delayed(const Duration(milliseconds: 500));

          verify(mockDio.fetch(any));
          verify(mockHandler1.resolve(any)).called(1);
          verify(mockHandler2.resolve(any)).called(1);
          expect(options1.headers['Authorization'], 'Bearer new_token');
          expect(options2.headers['Authorization'], 'Bearer new_token');
        },
      );
    });
  });
}
