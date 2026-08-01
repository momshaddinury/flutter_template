import '../../core/base/result.dart';
import '../../core/logger/log.dart';
import '../../domain/failures/business_failure.dart';
import '../failures/exception_classifier.dart';
import '../failures/infra_failure_mapper.dart';

/// Base class for data-layer repository implementations. Provides the two
/// guard helpers every `*RepositoryImpl` needs:
///
/// - [asyncGuard] / [syncGuard] — wrap a throwing operation and produce a
///   `Result<T, BusinessFailure>`. The thrown object is classified into an
///   `InfraFailure` via `Object.toInfraFailure()` and then translated to
///   the corresponding [BusinessFailure] variant before the Result returns.
///
/// Use directly in the common case:
///
/// ```dart
/// return asyncGuard(() async { ... });
/// ```
///
/// For operations whose business failures exceed the generic
/// [BusinessFailure] vocabulary (e.g. `ScanCameras` with a `NoDevicesFound`
/// case), skip the guard and write your own `try`/`catch` that classifies
/// the exception with `e.toInfraFailure(stackTrace)` and maps the
/// `InfraFailure` into your richer sealed hierarchy.
abstract base class BaseRepository {
  Future<Result<T, BusinessFailure>> asyncGuard<T>(
    Future<T> Function() operation,
  ) async {
    try {
      return Success(await operation());
    } catch (e, stackTrace) {
      return _failure<T>(e, stackTrace);
    }
  }

  Result<T, BusinessFailure> syncGuard<T>(T Function() operation) {
    try {
      return Success(operation());
    } catch (e, stackTrace) {
      return _failure<T>(e, stackTrace);
    }
  }

  Error<T, BusinessFailure> _failure<T>(Object e, StackTrace stackTrace) {
    Log.error(e.toString());
    Log.error(stackTrace.toString());
    return Error(e.toInfraFailure(stackTrace).toBusinessFailure());
  }
}
