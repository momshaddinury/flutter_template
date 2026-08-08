import '../../core/base/result.dart';
import '../../core/base/unit.dart';
import '../entities/login_entity.dart';
import '../failures/business_failure.dart';
import '../repositories/authentication_repository.dart';

final class LoginUseCase {
  LoginUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<Result<LoginResponseEntity, BusinessFailure>> call({
    required String email,
    required String password,
    bool? shouldRemember,
  }) async {
    final request = LoginRequestEntity(
      username: email,
      password: password,
      shouldRemember: shouldRemember,
    );

    return repository.login(request);
  }
}

final class LogoutUseCase {
  LogoutUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<Result<Unit, BusinessFailure>> call() async {
    return repository.logout();
  }
}

final class RestoreSessionUseCase {
  RestoreSessionUseCase(this.repository);

  final AuthenticationRepository repository;

  Future<Result<Unit, BusinessFailure>> call() async {
    return repository.restoreSession();
  }
}
