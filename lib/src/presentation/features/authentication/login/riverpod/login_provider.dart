import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../domain/entities/login_entity.dart';
import '../../../../../domain/use_cases/authentication_use_cases.dart';
import 'login_state.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  late LoginUseCase _loginUseCase;
  late CheckRememberMeUseCase _checkRememberMeUseCase;
  late SaveRememberMeUseCase _saveRememberMeUseCase;

  @override
  LoginState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    _checkRememberMeUseCase = ref.read(checkRememberMeUseCaseProvider);
    _saveRememberMeUseCase = ref.read(saveRememberMeUseCaseProvider);

    return const LoginState();
  }

  Future<void> checkRememberMe() async {
    final rememberMe = await _checkRememberMeUseCase.call();
    state = state.copyWith(rememberMe: rememberMe);
  }

  void updateRememberMe(bool rememberMe) {
    state = state.copyWith(rememberMe: rememberMe);
  }

  Future<void> saveRememberMe(bool rememberMe) async {
    await _saveRememberMeUseCase.call(rememberMe);
  }

  void login({
    required String email,
    required String password,
    bool? shouldRemember,
  }) async {
    state = state.copyWith(type: Status.loading);

    try {
      LoginRequestEntity request = LoginRequestEntity(
        username: email,
        password: password,
        shouldRemeber: shouldRemember,
      );

      await _loginUseCase.call(request);
      state = state.copyWith(type: Status.success);
    } catch (e) {
      state = state.copyWith(type: Status.error, error: e.toString());
    }
  }
}
