import 'package:freezed_annotation/freezed_annotation.dart';

part 'infra_failure.freezed.dart';

/// Infrastructure-shaped failure vocabulary — what the data layer can
/// produce. Lives in the data layer; never surfaces to domain or
/// presentation. Repositories translate to `BusinessFailure` via
/// `InfraFailure.toBusinessFailure()` (see `infra_failure_mapper.dart`)
/// before returning — `BaseRepository`'s `asyncGuard` / `syncGuard` does
/// this automatically.
///
/// No user-facing copy lives here. [message] carries the server-provided
/// message when one exists; [code] carries the server error code or HTTP
/// status string; [cause] preserves the original exception for logging
/// and debugging. Translation to a human-readable string is the
/// presentation layer's job.
///
/// To produce an [InfraFailure] from a caught exception use the
/// `Object.toInfraFailure()` extension in `exception_classifier.dart`.
///
/// Variant classes carry the `Failure` suffix to avoid collisions with
/// `BusinessFailure` variants (e.g. `NotFound`, `Conflict`, `Cancelled`)
/// when both are imported in a mapper.
@freezed
sealed class InfraFailure with _$InfraFailure {
  const InfraFailure._();

  /// Connect, send, or receive timed out.
  const factory InfraFailure.timeout({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = TimeoutFailure;

  /// Connection refused, DNS failure, TLS/certificate error — anything
  /// that means the request never reached a server that could answer.
  const factory InfraFailure.network({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = NetworkFailure;

  /// 401.
  const factory InfraFailure.unauthorized({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = UnauthorizedFailure;

  /// 403.
  const factory InfraFailure.forbidden({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = ForbiddenFailure;

  /// 404. Extend the classifier to map your own "not found" exceptions
  /// here.
  const factory InfraFailure.notFound({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = NotFoundFailure;

  /// 409.
  const factory InfraFailure.conflict({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = ConflictFailure;

  /// 422 or a local validation error. [fieldErrors] is the form-friendly
  /// seam for per-field messages. The default classifier never populates
  /// it (the raw body stays available via `ServerError.details`); fill it
  /// from a custom classifier branch when your backend returns per-field
  /// errors.
  const factory InfraFailure.validation({
    String? message,
    String? code,
    Map<String, String>? fieldErrors,
    Object? cause,
    StackTrace? stackTrace,
  }) = ValidationFailure;

  /// 4xx without a more specific variant.
  const factory InfraFailure.badResponse({
    required int statusCode,
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = BadResponseFailure;

  /// 5xx.
  const factory InfraFailure.serverError({
    int? statusCode,
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = ServerErrorFailure;

  /// The caller cancelled the request.
  const factory InfraFailure.cancelled({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = CancelledFailure;

  /// JSON deserialization, type errors during decoding, malformed shape.
  const factory InfraFailure.parsing({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = ParsingFailure;

  /// A programmer bug reached the repository boundary — a Dart `Error`
  /// (null dereference, bad cast, failed assertion) rather than a
  /// recoverable `Exception`. `BaseRepository` reports it to the
  /// `CrashReporter` and rethrows in debug; this variant is what release
  /// builds fold it into.
  const factory InfraFailure.defect({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = DefectFailure;

  /// Catch-all: unexpected exception types the classifier could not place.
  const factory InfraFailure.unknown({
    String? message,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) = UnknownFailure;
}
