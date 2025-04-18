import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'failures.dart';

class ExceptionHandlerInterceptor extends Interceptor {
  final VoidCallback? onUnAuthorizedError;

  ExceptionHandlerInterceptor({this.onUnAuthorizedError});

  dynamic handleError(dynamic err) {
    final response = err.response;
    if (response != null) {
      final errorData = response.data;
      switch (response.statusCode) {
        case 400:
          throw BadRequest(errorData);
        case 401:
          onUnAuthorizedError?.call();
          throw Unauthorized(errorData);
        case 403:
          throw Forbidden(errorData);
        case 404:
          throw NotFound(errorData);
        case 405:
          throw MethodNotAllowed(errorData);
        case 406:
          throw NotAcceptable(errorData);
        case 408:
          throw RequestTimeout(errorData);
        case 409:
          throw Conflict(errorData);
        case 410:
          throw Gone(errorData);
        case 411:
          throw LengthRequired(errorData);
        case 412:
          throw PreconditionFailed(errorData);
        case 413:
          throw PayloadTooLarge(errorData);
        case 414:
          throw URITooLong(errorData);
        case 415:
          throw UnsupportedMediaType(errorData);
        case 416:
          throw RangeNotSatisfiable(errorData);
        case 417:
          throw ExpectationFailed(errorData);
        case 422:
          throw UnprocessableEntity(errorData);
        case 429:
          throw TooManyRequests(errorData);
        case 500:
          throw InternalServerError(errorData);
        case 501:
          throw NotImplemented(errorData);
        case 502:
          throw BadGateway(errorData);
        case 503:
          throw ServiceUnavailable(errorData);
        case 504:
          throw GatewayTimeout(errorData);
        default:
          throw Unexpected(errorData);
      }
    }
  }
}
