enum CacheKey {
  isOnBoardingCompleted,

  /// Set at login only when the user asked to be remembered. Read at
  /// startup by `restoreSession` to decide whether a previous run's
  /// tokens survive. Not the session source of truth — the stored
  /// refresh token is.
  isLoggedIn,

  /// The "Remember Me" checkbox preference, persisted for the UI.
  rememberMe,
  language,
}

/// Key-value persistence for small app state, keyed by [CacheKey] so
/// every stored name lives in one enum instead of scattered strings.
///
/// Values are primitives only ([String], [int], [bool], [double]);
/// implementations throw [ArgumentError] on anything else rather than
/// coercing. Anything richer belongs in a real store, not a preference
/// cache.
abstract class CacheService {
  Future<void> save<T>(CacheKey key, T value);

  T? get<T>(CacheKey key);

  Future<void> remove(List<CacheKey> keys);

  Future<void> clear();
}
