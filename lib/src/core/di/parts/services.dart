part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
CacheService cacheService(Ref ref) {
  return SharedPreferencesService(
    ref.read(sharedPreferencesProvider).requireValue,
  );
}

@riverpod
RestClient restClient(Ref ref) {
  return RestClient(ref.read(dioProvider));
}
