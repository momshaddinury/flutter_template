import 'package:core/base/response_model.dart';
import 'package:core/logger/log.dart';
import 'package:data/services/network/interceptor/failures.dart';

abstract base class Repository<T> {
  Future<T> request(
    Future<dynamic> Function() request, {
    Function(String?, {String? code}) onError = _defaultErrorHandler,
  }) async {
    try {
      return await request();
    } on Failure catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      ErrorModel? error = ResponseModel.fromJson(e.error).error;
      return onError.call(error?.message, code: error?.code);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      return onError.call('Something went wrong!');
    }
  }

  static Future _defaultErrorHandler(String? message, {String? code}) {
    return Future.error(message as Object);
  }
}
