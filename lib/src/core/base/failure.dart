import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../logger/log.dart';
import 'exceptions.dart';

part 'failure.freezed.dart';

enum FailureType {
  timeout,
  badResponse,
  badCertificate,
  network,
  parsing,
  validation,
  illegalOperation,
  notFound,
  unauthorized,
  typeError,
  unknown,
}

@freezed
abstract class Failure with _$Failure {
  const factory Failure({
    required FailureType type,
    required String message,
    String? code,
    StackTrace? stackTrace,
  }) = _Failure;

  const Failure._();

  factory Failure.mapExceptionToFailure(Object e) {
    if (e is DioException) {
      ({String message, String? code})? error = _parseError(e.response);

      return switch (e.type) {
        DioExceptionType.connectionTimeout => Failure(
          type: FailureType.timeout,
          message:
              error?.message ??
              'Unable to connect.'
                  'Please check your internet connection and try again.',
          code: error?.code,
          stackTrace: e.stackTrace,
        ),
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout => Failure(
          type: FailureType.timeout,
          message:
              error?.message ??
              'The request took too long to complete.'
                  'Please try again or check your network connection.',
          code: error?.code,
          stackTrace: e.stackTrace,
        ),
        DioExceptionType.badResponse => Failure(
          type: FailureType.badResponse,
          message: error?.message ?? e.toString(),
          code: error?.code,
          stackTrace: e.stackTrace,
        ),
        DioExceptionType.badCertificate => Failure(
          type: FailureType.badCertificate,
          message: error?.message ?? e.toString(),
          code: error?.code,
          stackTrace: e.stackTrace,
        ),
        DioExceptionType.connectionError => Failure(
          type: FailureType.network,
          message:
              error?.message ??
              'Unable to connect to the server.'
                  'Please check your internet connection or try again later.',
          code: error?.code,
          stackTrace: e.stackTrace,
        ),
        _ => Failure(
          type: FailureType.unknown,
          message: error?.message ?? 'Something went wrong.',
          code: error?.code,
          stackTrace: e.stackTrace,
        ),
      };
    }

    if (e is CustomException) {
      return switch (e) {
        ParsingException() => Failure(
          type: FailureType.parsing,
          message: e.message,
          stackTrace: e.stackTrace,
        ),
        ValidationException() => Failure(
          type: FailureType.validation,
          message: e.message,
          stackTrace: e.stackTrace,
        ),
        IllegalOperationException() => Failure(
          type: FailureType.illegalOperation,
          message: e.message,
          stackTrace: e.stackTrace,
        ),
        NotFoundException() => Failure(
          type: FailureType.notFound,
          message: e.message,
          stackTrace: e.stackTrace,
        ),
        UnauthorizedException() => Failure(
          type: FailureType.unauthorized,
          message: e.message,
          stackTrace: e.stackTrace,
        ),
        _ => Failure(
          type: FailureType.unknown,
          message: e.toString(),
          stackTrace: e.stackTrace,
        ),
      };
    }

    if (e is Error) {
      return switch (e) {
        TypeError() => Failure(
          type: FailureType.typeError,
          message: 'Type mismatch: ${e.toString()}',
          stackTrace: e.stackTrace,
        ),
        _ => Failure(
          type: FailureType.unknown,
          message: e.toString(),
          stackTrace: e.stackTrace,
        ),
      };
    }

    return Failure(type: FailureType.unknown, message: e.toString());
  }

  static ({String message, String? code})? _parseError(Response? response) {
    if (response == null) return null;

    try {
      if (response.data is Map<String, dynamic>) {
        String message;
        final errorMap = response.data;

        if (errorMap['message'] is Map<String, dynamic>) {
          final messageMap = errorMap['message'] as Map<String, dynamic>;
          message = messageMap.values.join(' ');
        } else {
          message = errorMap['message']?.toString() ?? 'Something went wrong';
        }

        return (message: message, code: errorMap['statusCode']?.toString());
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      return null;
    }

    return null;
  }
}
