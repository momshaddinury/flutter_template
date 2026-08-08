import 'package:flutter/foundation.dart';

import '../../core/base/crash_reporter.dart';
import '../../core/base/rethrow_with_stack.dart';
import '../../core/base/result.dart';
import '../../core/logger/log.dart';
import '../../domain/failures/business_failure.dart';
import '../failures/exception_classifier.dart';
import '../failures/infra_failure.dart';
import '../failures/infra_failure_mapper.dart';

/// Base for data-layer repositories — the one place `try`/`catch` lives.
///
/// [asyncGuard] / [syncGuard] wrap throwing work and return a typed
/// [Result]:
///
/// - an expected `Exception` is classified to an [InfraFailure] and
///   translated to a [BusinessFailure] (the recoverable path);
/// - a Dart `Error` (a programmer bug) is **reported** to [crashReporter],
///   **rethrown in debug** with its original stack, and folded to a
///   generic `defect` [BusinessFailure] in release — never silently
///   swallowed.
///
/// The recoverable/bug split is structural: [asyncGuard]'s `recover`
/// callback can only ever see the `Exception` path, never a bug.
///
/// The common case is a one-liner:
///
/// ```dart
/// return asyncGuard(() async { ... });
/// ```
///
/// `recover` handles endpoints where a specific infrastructure failure is
/// a valid business outcome — for example a 404 that means "nothing set"
/// rather than an error:
///
/// ```dart
/// return asyncGuard(
///   () async => ...,
///   recover: (failure) =>
///       failure is NotFoundFailure ? const Success(null) : null,
/// );
/// ```
///
/// For operations whose business failures exceed the generic
/// [BusinessFailure] vocabulary, skip the guard and write your own
/// `try`/`catch` that classifies with `e.toInfraFailure(stackTrace)` and
/// maps into your richer sealed hierarchy.
abstract base class Repository {
  const Repository({required this.crashReporter});

  @protected
  final CrashReporter crashReporter;

  /// Wraps async throwing work.
  ///
  /// [recover] runs **only** on the recoverable (`Exception`) path,
  /// receiving the classified [InfraFailure]; return a [Result] to
  /// short-circuit (recovered) or `null` to fall through to the normal
  /// translation. Because bugs take the bare-`catch` branch, [recover]
  /// can never fire for one.
  @protected
  Future<Result<T, BusinessFailure>> asyncGuard<T>(
    Future<T> Function() operation, {
    Result<T, BusinessFailure>? Function(InfraFailure failure)? recover,
  }) async {
    try {
      return Success(await operation());
    } on Exception catch (e, stackTrace) {
      return _recoverable<T>(e, stackTrace, recover);
    } catch (e, stackTrace) {
      return _bug<T>(e, stackTrace);
    }
  }

  /// The synchronous counterpart of [asyncGuard].
  @protected
  Result<T, BusinessFailure> syncGuard<T>(
    T Function() operation, {
    Result<T, BusinessFailure>? Function(InfraFailure failure)? recover,
  }) {
    try {
      return Success(operation());
    } on Exception catch (e, stackTrace) {
      return _recoverable<T>(e, stackTrace, recover);
    } catch (e, stackTrace) {
      return _bug<T>(e, stackTrace);
    }
  }

  Result<T, BusinessFailure> _recoverable<T>(
    Exception e,
    StackTrace stackTrace,
    Result<T, BusinessFailure>? Function(InfraFailure failure)? recover,
  ) {
    Log.error(e.toString());
    Log.error(stackTrace.toString());
    final infra = e.toInfraFailure(stackTrace);

    return recover?.call(infra) ?? Error(infra.toBusinessFailure());
  }

  /// A Dart `Error` reached the boundary — a programmer bug. Always
  /// reported; rethrown with its original stack in debug; folded to a
  /// generic `defect` in release (already reported, so the user sees
  /// generic copy instead of a crash).
  Result<T, BusinessFailure> _bug<T>(Object e, StackTrace stackTrace) {
    crashReporter.report(e, stackTrace, fatal: false);
    if (kDebugMode) rethrowWithStack(e, stackTrace);

    return Error(e.toInfraFailure(stackTrace).toBusinessFailure());
  }
}
