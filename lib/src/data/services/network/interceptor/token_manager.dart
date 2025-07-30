import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../presentation/core/router/routes.dart';
import '../../cache/cache_service.dart';

class TokenManager extends Interceptor {
  TokenManager({
    required this.baseUrl,
    required this.refreshTokenEndpoint,
    required this.cacheService,
    required this.navigatorKey,
    required this.dio,
  });

  final String baseUrl;
  final String refreshTokenEndpoint;
  final CacheService cacheService;
  final GlobalKey<NavigatorState> navigatorKey;
  final Dio dio;

  bool _isRefreshing = false;
  final List<_QueuedRequest> _queue = [];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final options = err.requestOptions;

    if (_shouldHandleError(statusCode, options)) {
      await _handleUnauthorizedError(err, handler);
      return;
    }

    handler.next(err);
  }

  bool _shouldHandleError(int? statusCode, RequestOptions options) {
    return statusCode == 401 && options.extra['retry'] != true;
  }

  Future<void> _handleUnauthorizedError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_isRefreshing) {
      _queue.add(_QueuedRequest(options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    try {
      final newToken = await _refreshAccessToken();
      await _retryFailedRequest(err.requestOptions, handler, newToken);
      await _retryQueuedRequests(newToken);
    } catch (e) {
      await _handleRefreshFailure(err, handler);
    } finally {
      _isRefreshing = false;
      _queue.clear();
    }
  }

  Future<String> _refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      throw DioException(
        requestOptions: RequestOptions(),
        error: 'No refresh token available',
      );
    }

    final refreshResp = await dio.fetch(
      RequestOptions(
        baseUrl: baseUrl,
        path: refreshTokenEndpoint,
        method: 'GET',
        headers: {'Authorization': 'Bearer $refreshToken'},
      ),
    );

    if (refreshResp.statusCode != 200) {
      throw DioException(
        requestOptions: RequestOptions(),
        error: 'Refresh token request failed with status: '
            '${refreshResp.statusCode}',
      );
    }

    final newToken = refreshResp.data['data']['accessToken'] as String;
    await saveToken(CacheKey.accessToken, newToken);

    return newToken;
  }

  Future<void> _retryFailedRequest(
    RequestOptions options,
    ErrorInterceptorHandler handler,
    String newToken,
  ) async {
    options.headers['Authorization'] = 'Bearer $newToken';
    options.extra['retry'] = true;

    final retryResponse = await dio.fetch(options);
    handler.resolve(retryResponse);
  }

  Future<void> _retryQueuedRequests(String newToken) async {
    for (final queuedRequest in _queue) {
      try {
        await _retryFailedRequest(
          queuedRequest.options,
          queuedRequest.handler,
          newToken,
        );
      } on DioException catch (e) {
        queuedRequest.handler.reject(e);
      }
    }
  }

  Future<void> _handleRefreshFailure(
    DioException originalError,
    ErrorInterceptorHandler handler,
  ) async {
    await _removeTokens();
    _navigateToLoginScreen();
    handler.reject(originalError);
  }

  Future<void> _removeTokens() async {
    await cacheService.remove([CacheKey.accessToken, CacheKey.refreshToken]);
  }

  void _navigateToLoginScreen() {
    if (navigatorKey.currentState?.mounted == true) {
      navigatorKey.currentState?.context.goNamed(Routes.login, extra: true);
    }
  }

  Future<void> saveToken(CacheKey key, String value) async {
    await cacheService.save(key, value);
  }

  Future<String?> getAccessToken() async {
    return cacheService.get(CacheKey.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return cacheService.get(CacheKey.refreshToken);
  }
}

class _QueuedRequest {
  const _QueuedRequest({required this.options, required this.handler});

  final RequestOptions options;
  final ErrorInterceptorHandler handler;
}
