part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
CacheService cacheService(CacheServiceRef ref) {
  return SharedPreferencesService(
    ref.read(sharedPreferencesProvider).requireValue,
  );
}
