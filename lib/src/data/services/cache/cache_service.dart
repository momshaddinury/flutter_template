import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference_service.dart';

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

abstract class CacheService {
  Future<void> save<T>(CacheKey key, T value);

  T? get<T>(CacheKey key);

  Future<void> remove(List<CacheKey> keys);

  Future<void> clear();
}
