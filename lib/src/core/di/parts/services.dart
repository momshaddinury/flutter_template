part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
CacheService cacheService(Ref ref) {
  return SharedPreferencesService(
    ref.watch(sharedPreferencesProvider).requireValue,
  );
}

@Riverpod(keepAlive: true)
RestClient restClientService(Ref ref) {
  return RestClient(ref.watch(networkStackProvider).transport);
}
