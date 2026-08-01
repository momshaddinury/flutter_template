import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_failure.freezed.dart';

/// Business-shaped failure vocabulary — the error type the domain layer
/// exposes to use cases and presentation. Each variant names a *business*
/// condition, not an HTTP status or Dio exception type.
///
/// Most repositories stop here: `BaseRepository`'s `asyncGuard` / `syncGuard`
/// produce `Result<T, BusinessFailure>` directly — they classify the thrown
/// object via `Object.toInfraFailure()` and translate the `InfraFailure` via
/// `InfraFailure.toBusinessFailure()` internally. Use cases return
/// `Result<_, BusinessFailure>`. Operations with richer business failures
/// (e.g. `ScanCameras` with `NoDevicesFound`) skip the guard and declare
/// their own sealed hierarchy that extends or wraps [BusinessFailure]; the
/// repository classifies the exception by hand and maps the `InfraFailure`
/// into that richer type.
///
/// [cause] and [stackTrace] are opaque pass-throughs from the underlying
/// `InfraFailure` — useful for crash reporters and `Log.error` callsites,
/// ignored by typical UI. Presentation should not branch on the cause's
/// runtime type; that would re-introduce the infrastructure coupling the
/// business failure exists to hide.
///
/// No user-facing copy lives here. [message] carries the server-provided
/// text when one exists; the localized copy a screen shows comes from
/// `BusinessFailureUIMapper` at the presentation boundary.
///
/// Pattern-match exhaustively at the presentation layer — the Dart compiler
/// will flag a missing case if you add a new variant.
@freezed
sealed class BusinessFailure with _$BusinessFailure {
  const BusinessFailure._();

  /// The caller has no valid session (expired or never signed in).
  const factory BusinessFailure.unauthenticated({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = Unauthenticated;

  /// The caller is authenticated but lacks permission.
  const factory BusinessFailure.permissionDenied({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = PermissionDenied;

  /// Server unreachable — network down, timeout, 5xx, certificate failure.
  /// The user-facing message is "connection problem"; the cause doesn't
  /// matter to business logic.
  const factory BusinessFailure.unreachable({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = Unreachable;

  /// Input failed validation. [fieldErrors] is the per-field seam for
  /// forms — null until a custom classifier populates it upstream.
  const factory BusinessFailure.invalidInput({
    String? message,
    Map<String, String>? fieldErrors,
    Object? cause,
    StackTrace? stackTrace,
  }) = InvalidInput;

  /// The requested resource doesn't exist.
  const factory BusinessFailure.notFound({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = NotFound;

  /// Request conflicts with current state (e.g. duplicate, stale version).
  const factory BusinessFailure.conflict({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = Conflict;

  /// The caller cancelled the operation.
  const factory BusinessFailure.cancelled({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = Cancelled;

  /// Catch-all: parsing errors, unexpected server shape.
  /// Presentation should log and show a generic message.
  const factory BusinessFailure.unexpected({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = Unexpected;

  /// A programmer bug, already reported to the crash reporter by
  /// `BaseRepository`. Reaches presentation only in release builds (debug
  /// rethrows); show generic copy — there is nothing the user can fix.
  const factory BusinessFailure.defect({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = Defect;
}
