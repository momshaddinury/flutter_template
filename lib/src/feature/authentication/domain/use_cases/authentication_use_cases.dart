import '../../../../core/base/use_case.dart';
import '../entities/login_entity.dart';
import '../entities/sign_up_entity.dart';
import '../repositories/authentication_repository.dart';

final class RegisterUseCase
    extends UseCase<SignUpResponseEntity, SignUpRequestEntity> {
  final AuthenticationRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<SignUpResponseEntity> call(SignUpRequestEntity request) async {
    return repository.register(request);
  }
}

final class LoginUseCase
    extends UseCase<LoginResponseEntity, LoginRequestEntity> {
  final AuthenticationRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<LoginResponseEntity> call(LoginRequestEntity request) async {
    return repository.login(request);
  }
}
