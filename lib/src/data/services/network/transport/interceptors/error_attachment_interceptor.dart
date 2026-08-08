import 'package:dio/dio.dart';

import '../../config/server_error_parser.dart';

/// Parses failing responses via [ServerErrorParser] and attaches the
/// resulting [ServerError] to [DioException.error]. Downstream code reads
/// the structured error without reparsing the body — the classifier
/// invoked from `Repository.asyncGuard` is the main consumer.
class ErrorAttachmentInterceptor extends Interceptor {
  const ErrorAttachmentInterceptor(this._parser);

  final ServerErrorParser _parser;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final serverError = _parser.parse(err.response);
    if (serverError == null) return handler.next(err);

    handler.next(err.copyWith(error: serverError));
  }
}
