import '../../domain/failures/business_failure.dart';
import 'infra_failure.dart';

/// Default translation from infrastructure errors to business errors.
/// `BaseRepository`'s guards apply this for you; call it directly only
/// from repository methods whose business failures exceed the generic
/// [BusinessFailure] vocabulary and need to wrap it inside a richer
/// per-operation sealed type.
///
/// [cause] and [stackTrace] are forwarded so crash reporters and log
/// callsites at higher layers can still see the original exception.
///
/// Shared fields ([message], [cause], [stackTrace]) are read via the
/// freezed-generated getters on the sealed base — only variant-specific
/// fields are destructured in the switch arms.
extension InfraFailureToBusiness on InfraFailure {
  BusinessFailure toBusinessFailure() => switch (this) {
    UnauthorizedFailure() => .unauthenticated(
      message: message,
      cause: cause,
      stackTrace: stackTrace,
    ),
    ForbiddenFailure() => .permissionDenied(
      message: message,
      cause: cause,
      stackTrace: stackTrace,
    ),
    NotFoundFailure() => .notFound(
      message: message,
      cause: cause,
      stackTrace: stackTrace,
    ),
    ConflictFailure() => .conflict(
      message: message,
      cause: cause,
      stackTrace: stackTrace,
    ),
    ValidationFailure(:final fieldErrors) => .invalidInput(
      message: message,
      fieldErrors: fieldErrors,
      cause: cause,
      stackTrace: stackTrace,
    ),
    CancelledFailure() => .cancelled(
      message: message,
      cause: cause,
      stackTrace: stackTrace,
    ),
    TimeoutFailure() || NetworkFailure() || ServerErrorFailure() =>
      .unreachable(message: message, cause: cause, stackTrace: stackTrace),
    BadResponseFailure() || ParsingFailure() || UnknownFailure() => .unexpected(
      message: message,
      cause: cause,
      stackTrace: stackTrace,
    ),
  };
}
