part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) =>
    SharedPreferences.getInstance();

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();

  dio.interceptors.addAll(
    [
      TokenManager(
        baseUrl: Endpoints.base,
        refreshTokenEndpoint: Endpoints.refreshToken,
        cacheService: ref.read(cacheServiceProvider),
        navigatorKey: ref.read(goRouterProvider).routerDelegate.navigatorKey,
        dio: Dio(
          BaseOptions(
            baseUrl: Endpoints.base,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 3),
          ),
        ),
      ),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
    ],
  );

  dio.options.headers['Content-Type'] = 'application/json';

  return dio;
}
