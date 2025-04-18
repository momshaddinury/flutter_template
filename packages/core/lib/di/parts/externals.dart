part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();

  dio.interceptors.addAll(
    [
      TokenManager(
        refreshTokenEndpoint: 'refreshToken',
        accessTokenKey: 'accessToken',
      ),
      ExceptionHandlerInterceptor(
        onUnAuthorizedError: () {},
      ),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
    ],
  );

  return dio;
}
