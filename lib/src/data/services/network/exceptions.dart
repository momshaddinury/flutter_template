/// Sentinel raised by `AuthHeaderInterceptor` when a `RequestAuth.protected`
/// request has no access token to send. The exception classifier maps it to
/// `InfraFailure.unauthorized` → `BusinessFailure.unauthenticated`, so the
/// user sees the session-expired flow instead of a generic failure
/// message.
class MissingAccessTokenException implements Exception {
  const MissingAccessTokenException();

  @override
  String toString() => 'Access token is missing';
}
