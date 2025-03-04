import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_template/src/feature/authentication/domain/entities/login_entity.dart';
import 'package:flutter_template/src/feature/authentication/domain/use_cases/authentication_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  late LoginUseCase _useCase;

  @override
  AsyncValue<LoginResponseEntity>? build() {
    _useCase = LoginUseCase(ref.read(authenticationRepositoryProvider));
    return null;
  }

  bool _shouldRemember = false;

  void shouldRemember(bool value) {
    _shouldRemember = value;
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
        shouldRemeber: _shouldRemember,
      );

      return await _useCase.call(request);
    });
  }
}
