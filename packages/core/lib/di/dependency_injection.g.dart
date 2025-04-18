// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependency_injection.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'48e60558ea6530114ea20ea03e69b9fb339ab129';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = FutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = FutureProviderRef<SharedPreferences>;
String _$dioHash() => r'eec3c05057965d03b05f1c911d23290608dce9e5';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$authenticationRepositoryHash() =>
    r'4cb0cd4bae311e2eb1dd0990a0cb0b371d972799';

/// See also [authenticationRepository].
@ProviderFor(authenticationRepository)
final authenticationRepositoryProvider =
    AutoDisposeProvider<AuthenticationRepositoryImpl>.internal(
  authenticationRepository,
  name: r'authenticationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthenticationRepositoryRef
    = AutoDisposeProviderRef<AuthenticationRepositoryImpl>;
String _$routerRepositoryHash() => r'a075d8eb90942d244bd09127ed90aaa02d549193';

/// See also [routerRepository].
@ProviderFor(routerRepository)
final routerRepositoryProvider =
    AutoDisposeProvider<RouterRepositoryImpl>.internal(
  routerRepository,
  name: r'routerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRepositoryRef = AutoDisposeProviderRef<RouterRepositoryImpl>;
String _$cacheServiceHash() => r'21a7ce6ef1eab778d1b25d2ff1b8fcc3ca26aac5';

/// See also [cacheService].
@ProviderFor(cacheService)
final cacheServiceProvider = Provider<CacheService>.internal(
  cacheService,
  name: r'cacheServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cacheServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheServiceRef = ProviderRef<CacheService>;
String _$restClientHash() => r'53a98cb9524e30c0a6bd05594c57185613bfc720';

/// See also [restClient].
@ProviderFor(restClient)
final restClientProvider = AutoDisposeProvider<RestClient>.internal(
  restClient,
  name: r'restClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$restClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RestClientRef = AutoDisposeProviderRef<RestClient>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
