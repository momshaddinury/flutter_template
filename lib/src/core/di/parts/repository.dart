part of '../dependency_injection.dart';

@riverpod
AuthenticationRepositoryImpl authenticationRepository(
  AuthenticationRepositoryRef ref,
) {
  return AuthenticationRepositoryImpl(
    remote: ref.read(authenticationDataSourceProvider),
  );
}
