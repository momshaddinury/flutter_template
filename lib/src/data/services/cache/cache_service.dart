import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference_service.dart';

enum CacheKey {
  isOnBoardingCompleted,
  isLoggedIn,
  rememberMe,
}

abstract class CacheService {
  Future<void> save<T>(CacheKey key, T value);

  T? get<T>(CacheKey key);

  Future<void> remove(List<CacheKey> keys);

  Future<void> clear();
}
