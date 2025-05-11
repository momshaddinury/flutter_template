part of '../dependency_injection.dart';

@riverpod
AuthenticationRepositoryImpl authenticationRepository(
  Ref ref,
) {
  return AuthenticationRepositoryImpl(
    remote: ref.read(restClientProvider),
    local: ref.read(cacheServiceProvider),
  );
}

@riverpod
RouterRepository routerRepository(
  Ref ref,
) {
  return RouterRepositoryImpl(
    cacheService: ref.read(cacheServiceProvider),
  );
}
