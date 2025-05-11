import '../entities/login_entity.dart';
import '../entities/sign_up_entity.dart';
import '../repositories/authentication_repository.dart';

final class RegisterUseCase {
  RegisterUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<SignUpResponseEntity> call(SignUpRequestEntity request) async {
    return repository.register(request);
  }
}

final class LoginUseCase {
  LoginUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<void> call(LoginRequestEntity request) async {
    await repository.login(request);
  }
}

final class CheckRememberMeUseCase {
  CheckRememberMeUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<bool> call() async {
    return repository.rememberMe();
  }
}

final class SaveRememberMeUseCase {
  SaveRememberMeUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<bool> call(bool rememberMe) async {
    return repository.rememberMe(rememberMe: rememberMe);
  }
}
