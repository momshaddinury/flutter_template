import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/di/dependency_injection.dart';
import '../session_status_provider/session_status_provider.dart';

part 'logout_provider.g.dart';

@Riverpod(keepAlive: true)
class Logout extends _$Logout {
  @override
  AsyncValue<bool?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> call() async {
    if (state.isLoading) return;

    state = const AsyncValue.loading();

    // Intentional simulated delay to show loading indicator
    await Future.delayed(const Duration(seconds: 1));

    final result = await ref.read(logoutUseCaseProvider).call();

    switch (result) {
      case Success():
        ref.read(resetRepositoryUseCaseProvider).call(ref);
        // WHY: the session gate navigates, not the page. Refreshing the
        // session status flips routerState to login.
        ref.invalidate(sessionStatusProvider);
        state = const AsyncValue.data(true);
      case Error(:final error):
        state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
