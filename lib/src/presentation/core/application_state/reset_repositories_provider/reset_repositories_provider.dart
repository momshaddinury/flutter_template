// ignore: implementation_imports, depend_on_referenced_packages
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_repositories_provider.g.dart';

@Riverpod(keepAlive: true)
class ResetRepositories extends _$ResetRepositories {
  @override
  void build() {}

  /// Invalidates all repository dependencies in the dependency injection
  /// container.
  ///
  /// This method will invalidate all repository providers, forcing them to be
  /// recreated on next access. This is useful for clearing cached data and
  /// ensuring fresh repository instances.
  ///
  /// This is particularly important in scenarios where cached data needs to be
  /// cleared and fresh repository instances are required. For example, when
  /// switching between different businesses, or when a user logs out and then
  /// logs back in, we need to ensure that repositories do not retain data from
  /// the previous context. Without invalidation, repositories would retain
  /// data from the previous state since they are kept alive by the dependency
  /// injection container.
  void call() {
    ref.container.getAllProviderElements().forEach((element) {
      if (element.provider.name!.contains('Repository')) {
        ref.invalidate(element.provider);
      }
    });
  }
}
