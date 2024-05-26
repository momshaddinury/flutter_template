part of '../dependency_injection.dart';

@riverpod
AuthenticationDataSourceImpl authenticationDataSource(
  AuthenticationDataSourceRef ref,
) {
  return AuthenticationDataSourceImpl(remote: ref.read(networkProvider));
}
