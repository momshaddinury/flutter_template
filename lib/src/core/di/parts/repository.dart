part of '../dependency_injection.dart';

@riverpod
AuthenticationRepositoryImpl authenticationRepository(
  Ref ref,
) {
  return AuthenticationRepositoryImpl(
    remote: ref.read(restClientServiceProvider),
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

@riverpod
LocaleRepository localeRepository(Ref ref) {
  return LocaleRepositoryImpl(ref.read(cacheServiceProvider));
}
