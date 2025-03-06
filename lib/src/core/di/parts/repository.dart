part of '../dependency_injection.dart';

@riverpod
AuthenticationRepositoryImpl authenticationRepository(
  AuthenticationRepositoryRef ref,
) {
  return AuthenticationRepositoryImpl(
    restClient: ref.read(restClientProvider),
  );
}
