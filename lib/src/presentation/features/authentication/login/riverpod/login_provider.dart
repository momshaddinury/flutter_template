import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/base/result.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../core/application_state/session_status_provider/session_status_provider.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  AsyncValue build() {
    return const AsyncValue.data(null);
  }

  void login({
    required String email,
    required String password,
    bool? shouldRemember,
  }) async {
    if (state.isLoading) return;

    state = const AsyncValue.loading();

    final result = await ref
        .read(loginUseCaseProvider)
        .call(email: email, password: password, shouldRemember: shouldRemember);

    if (!ref.mounted) return;

    state = switch (result) {
      Success() => AsyncValue.data(result),
      Error(:final error) => AsyncValue.error(error, StackTrace.current),
    };

    if (state.hasValue && state.value != null) {
      ref.invalidate(sessionStatusProvider);
    }
  }
}
