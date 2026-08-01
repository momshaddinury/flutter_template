/// Request-extra key carrying a [RequestAuth] value. Declared once, on the
/// Retrofit endpoint — the single source of truth read by both
/// `AuthHeaderInterceptor` (attach the header?) and
/// `RefreshRetryInterceptor` (refresh on 401?):
///
/// ```dart
/// @Extra({requestAuthKey: RequestAuth.protected})
/// @GET('/me')
/// Future<HttpResponse> me();
/// ```
const requestAuthKey = 'auth.mode';

/// Request-extra key stamped by `AuthHeaderInterceptor` when it actually
/// attached an Authorization header. `RefreshRetryInterceptor` reads it on
/// a 401 to decide whether a refresh + retry can help: a request that went
/// out *with* a token can succeed after a refresh; one that went out
/// anonymously cannot.
const authAttachedKey = 'auth.attached';

/// How a request participates in authentication.
///
/// Unmarked endpoints default to [public]. This default is deliberate:
/// `TokenManager` performs the refresh call on the bare transport with no
/// extras, so "unmarked never carries a token" keeps the refresh path safe
/// by construction. The cost is remembering to mark protected endpoints —
/// a missing annotation fails visibly (a 401 on first use) rather than
/// leaking a token.
enum RequestAuth {
  /// The interceptor never attaches an Authorization header, even when a
  /// token exists. Login, signup, password reset, public catalogs, and
  /// the refresh call itself. A header set manually on the request passes
  /// through untouched — do not set one on public endpoints.
  public,

  /// Attach the token when one exists; proceed anonymously otherwise.
  /// For endpoints that serve guests but personalize for signed-in users.
  optional,

  /// Attach the token; reject with `MissingAccessTokenException` when no
  /// token is available.
  protected,
}
