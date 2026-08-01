import 'package:dio/dio.dart';

import '../services/network/config/server_error_parser.dart';
import '../services/network/exceptions.dart';
import 'infra_failure.dart';

/// Classifies any thrown object into an [InfraFailure]. Pass the stack
/// trace from the surrounding `catch (e, stackTrace)` so the failure
/// preserves it for logging. `DioException`s carry their own `stackTrace`,
/// which takes precedence; the parameter covers every other thrown object.
///
/// The default branches cover `DioException` (HTTP/network),
/// `FormatException` (malformed data — the common `jsonDecode`,
/// `int.parse`, `DateTime.parse` failures), and Dart `Error` (a programmer
/// bug — null dereference, bad cast — classified as `defect`, never as a
/// data problem). Anything else is folded into `InfraFailure.unknown` with
/// the original exception attached as `cause`. Extend this extension in
/// consumer apps that throw their own structured exception types and want
/// finer-grained classification.
extension ExceptionClassifier on Object {
  InfraFailure toInfraFailure([StackTrace? stackTrace]) {
    final self = this;
    final trace = stackTrace ?? (self is Error ? self.stackTrace : null);

    return switch (self) {
      DioException() => _fromDioException(self),
      FormatException() => .parsing(
        message: self.message,
        cause: self,
        stackTrace: trace,
      ),
      Error() => .defect(
        message: self.toString(),
        cause: self,
        stackTrace: trace,
      ),
      _ => .unknown(message: self.toString(), cause: self, stackTrace: trace),
    };
  }
}

InfraFailure _fromDioException(DioException e) {
  if (e.error is MissingAccessTokenException) {
    return InfraFailure.unauthorized(
      message: e.error.toString(),
      cause: e,
      stackTrace: e.stackTrace,
    );
  }

  final server = e.error is ServerError ? e.error as ServerError : null;
  final fallbackCode = e.response?.statusCode?.toString();
  final code = server?.code ?? fallbackCode;
  final message = server?.message;

  return switch (e.type) {
    .connectionTimeout || .sendTimeout || .receiveTimeout => .timeout(
      message: message,
      code: code,
      cause: e,
      stackTrace: e.stackTrace,
    ),
    .badCertificate || .connectionError => .network(
      message: message,
      code: code,
      cause: e,
      stackTrace: e.stackTrace,
    ),
    .cancel => .cancelled(
      message: message,
      code: code,
      cause: e,
      stackTrace: e.stackTrace,
    ),
    .badResponse => _fromStatusCode(e, server),
    .unknown => .unknown(
      message: message,
      code: code,
      cause: e,
      stackTrace: e.stackTrace,
    ),
  };
}

InfraFailure _fromStatusCode(DioException e, ServerError? server) {
  final status = e.response?.statusCode ?? 0;
  final code = server?.code ?? status.toString();
  final message = server?.message;
  final stack = e.stackTrace;

  return switch (status) {
    401 => .unauthorized(
      message: message,
      code: code,
      cause: e,
      stackTrace: stack,
    ),
    403 => .forbidden(
      message: message,
      code: code,
      cause: e,
      stackTrace: stack,
    ),
    404 => .notFound(message: message, code: code, cause: e, stackTrace: stack),
    409 => .conflict(message: message, code: code, cause: e, stackTrace: stack),
    422 => .validation(
      message: message,
      code: code,
      cause: e,
      stackTrace: stack,
    ),
    >= 500 => .serverError(
      statusCode: status,
      message: message,
      code: code,
      cause: e,
      stackTrace: stack,
    ),
    _ => .badResponse(
      statusCode: status,
      message: message,
      code: code,
      cause: e,
      stackTrace: stack,
    ),
  };
}
