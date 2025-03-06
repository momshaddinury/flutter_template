import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rest_client_kit/rest_client_kit.dart';

import 'exception_handlers.dart';
import 'token_manager.dart';

class RestClientKit {
  late Dio _dio;
  final String baseUrl;
  final TokenManager? tokenManager;
  final int connectionTimeout;
  final int receiveTimeout;
  final CacheOptions? cacheOptions;
  final RetryInterceptor? retryInterceptor;
  final VoidCallback? onUnAuthorizedError;

  RestClientKit({
    required this.baseUrl,
    this.cacheOptions,
    this.retryInterceptor,
    this.tokenManager,
    this.connectionTimeout = 30000,
    this.receiveTimeout = 30000,
    this.onUnAuthorizedError,
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectionTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    );

    _dio = Dio(options);
  }

  Future<Response<dynamic>> _request(
    String method,
    String path, {
    Object? data,
    Map<String, Object?>? headers,
    Map<String, Object?>? query,
  }) async {
    _setDioInterceptorList();

    Options options = Options()
      ..contentType = 'application/json'
      ..method = method;

    if (headers != null) {
      options.headers?.addAll(headers);
    }

    return _dio
        .request(path, data: data, options: options, queryParameters: query)
        .then((value) => value)
        .catchError(
          ExceptionHandlerInterceptor(
            onUnAuthorizedError: onUnAuthorizedError,
          ).handleError,
        );
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, Object?>? query,
    Map<String, Object?>? headers,
    bool shouldCache = false,
  }) {
    return _request('GET', path, query: query, headers: headers);
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    bool isFormData = false,
    Map<String, Object?>? headers,
    Map<String, Object?>? query,
  }) {
    return _request('POST', path, data: data, headers: headers, query: query);
  }

  Future<Response<dynamic>> patch(
    String path, {
    Object? data,
    Map<String, Object?>? headers,
    Map<String, Object?>? query,
  }) {
    return _request('PATCH', path, data: data, headers: headers, query: query);
  }

  Future<Response<dynamic>> put(
    String path, {
    Object? data,
    bool isFormData = false,
    Map<String, Object?>? headers,
    Map<String, Object?>? query,
  }) {
    return _request('PUT', path, data: data, headers: headers, query: query);
  }

  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, Object?>? headers,
    Map<String, Object?>? query,
  }) {
    return _request('DELETE', path, data: data, headers: headers, query: query);
  }

  void _setDioInterceptorList() async {
    /// List of interceptors to be added to the Dio instance
    List<Interceptor> interceptorList = [
      if (tokenManager != null) tokenManager!,
      if (cacheOptions != null) DioCacheInterceptor(options: cacheOptions!),
      if (retryInterceptor != null) retryInterceptor!,
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
    ];

    /// Clear all the existing interceptors
    _dio.interceptors.clear();

    /// Add the new interceptors
    _dio.interceptors.addAll(interceptorList);
  }
}
