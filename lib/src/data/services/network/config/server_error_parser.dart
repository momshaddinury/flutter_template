import 'package:dio/dio.dart';

/// Parsed server-side error payload. Interceptors attach a [ServerError] to
/// [DioException.error] so downstream mappers do not reparse the body.
class ServerError {
  const ServerError({required this.message, this.code, this.details});

  final String message;
  final String? code;
  final Map<String, dynamic>? details;

  @override
  String toString() => 'ServerError(code: $code, message: $message)';
}

/// Strategy for extracting a [ServerError] from a failed HTTP response.
///
/// Template consumers swap the `errorParser` argument of `DioBuilder` in
/// `core/di/parts/externals.dart` when their backend
/// uses a response shape that differs from the default
/// `{message, statusCode | code}` envelope. The full response body is
/// preserved in [ServerError.details].
abstract class ServerErrorParser {
  ServerError? parse(Response<dynamic>? response);
}

class DefaultServerErrorParser implements ServerErrorParser {
  const DefaultServerErrorParser();

  @override
  ServerError? parse(Response<dynamic>? response) {
    final data = response?.data;
    if (data is! Map<String, dynamic>) return null;

    final rawMessage = data['message'];
    final String message;
    if (rawMessage is Map<String, dynamic>) {
      message = rawMessage.values.join(' ');
    } else if (rawMessage is List) {
      message = rawMessage.join(' ');
    } else {
      message = rawMessage?.toString() ?? 'Something went wrong';
    }

    return ServerError(
      message: message,
      code: data['statusCode']?.toString() ?? data['code']?.toString(),
      details: data,
    );
  }
}
