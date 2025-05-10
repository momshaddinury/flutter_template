import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../domain/entities/login_entity.dart';
import '../../../../../domain/use_cases/authentication_use_cases.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  late LoginUseCase _useCase;

  @override
  AsyncValue<LoginResponseEntity>? build() {
    _useCase = ref.read(loginUseCaseProvider);
    return null;
  }

  void login({
    required String email,
    required String password,
    bool? shouldRemember,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      LoginRequestEntity request = LoginRequestEntity(
        username: email,
        password: password,
        shouldRemeber: shouldRemember,
      );

      return await _useCase.call(request);
    });
  }
}
