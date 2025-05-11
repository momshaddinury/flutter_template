import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';
import 'logout_state.dart';

part 'logout_provider.g.dart';

@Riverpod(keepAlive: true)
class Logout extends _$Logout {
  @override
  LogoutState build() {
    return const LogoutState();
  }

  Future<void> call() async {
    state = const LogoutState(type: Status.loading);

    // Intentional simulated delay to show loading indicator
    await Future.delayed(const Duration(seconds: 1));

    try {
      await ref.read(logoutUseCaseProvider).call();
      state = const LogoutState(type: Status.success);
    } catch (e) {
      state = LogoutState(type: Status.error, error: e.toString());
    }
  }
}
