import '../entities/login_entity.dart';
import '../entities/sign_up_entity.dart';
import '../repositories/authentication_repository.dart';

final class RegisterUseCase {
  final AuthenticationRepository repository;

  RegisterUseCase(this.repository);

  Future<SignUpResponseEntity> call(SignUpRequestEntity request) async {
    return repository.register(request);
  }
}

final class LoginUseCase {
  final AuthenticationRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponseEntity> call(LoginRequestEntity request) async {
    return repository.login(request);
  }
}
