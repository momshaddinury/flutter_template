part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
AuthenticationRepository authenticationRepository(Ref ref) {
  return AuthenticationRepositoryImpl(
    remote: ref.watch(restClientServiceProvider),
    local: ref.watch(cacheServiceProvider),
    tokens: ref.watch(tokenManagerProvider),
    crashReporter: ref.watch(crashReporterProvider),
  );
}

@Riverpod(keepAlive: true)
RouterRepository routerRepository(Ref ref) {
  return RouterRepositoryImpl(cacheService: ref.watch(cacheServiceProvider));
}

@Riverpod(keepAlive: true)
LocaleRepository localeRepository(Ref ref) {
  return LocaleRepositoryImpl(ref.watch(cacheServiceProvider));
}
