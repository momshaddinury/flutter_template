import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_template/src/feature/authentication/domain/entities/login_entity.dart';
import 'package:flutter_template/src/feature/authentication/domain/use_cases/authentication_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  late LoginUseCase useCase;

  @override
  AsyncValue<LoginResponseEntity>? build() {
    useCase = LoginUseCase(ref.read(authenticationRepositoryProvider));
    return null;
  }

  void login() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      LoginRequestEntity request = LoginRequestEntity(
        email: 'example@email.com',
        password: '123456',
      );

      return await useCase.call(request);
    });
  }
}
