import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager extends Interceptor {
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  final String? refreshTokenEndpoint;
  final String accessTokenKey;
  final String? refreshTokenKey;

  TokenManager({
    required this.refreshTokenEndpoint,
    required this.accessTokenKey,
    this.refreshTokenKey,
  });

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
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Function to recursively search for keys in a nested JSON object
    void findTokens(Map<String, dynamic> json) {
      for (var key in json.keys) {
        var value = json[key];

        if ((accessTokenKey == key) && value is String) {
          log(
            'Found access token: $value',
            name: 'RestClientKit/TokenStorageHandler',
          );
          saveToken(_accessTokenKey, value);
        } else if ((refreshTokenKey == key) && value is String) {
          log(
            'Found refresh token: $value',
            name: 'RestClientKit/TokenStorageHandler',
          );
          saveToken(_refreshTokenKey, value);
        } else if (value is Map<String, dynamic>) {
          findTokens(value);
        } else if (value is List) {
          for (var item in value) {
            if (item is Map<String, dynamic>) {
              findTokens(item);
            }
          }
        }
      }
    }

    try {
      if (response.data is Map<String, dynamic>) {
        findTokens(response.data);
      }
    } catch (e, stackTrace) {
      log(
        'Failed to parse tokens: $e',
        name: 'RestClientKit/TokenStorageHandler',
        error: e,
        stackTrace: stackTrace,
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Clear the access token
      await SharedPreferences.getInstance().then((prefs) {
        prefs.remove(_accessTokenKey);
      });
    }

    //TODO: Implement refresh token logic
    super.onError(err, handler);
  }

  Future<void> saveToken(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }
}
