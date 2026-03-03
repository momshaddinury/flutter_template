import '../../core/base/failure.dart';
import '../../core/base/repository.dart';
import '../../core/base/result.dart';
import '../entities/login_entity.dart';
import '../entities/sign_up_entity.dart';

abstract class AuthenticationRepository extends Repository {
  Future<SignUpResponseEntity> register(SignUpRequestEntity data);

  Future<Result<LoginResponseEntity, Failure>> login(LoginRequestEntity data);

  Future<bool> rememberMe({bool? rememberMe});

  Future<String> forgotPassword(Map<String, dynamic> data);

  Future<String> resetPassword(Map<String, dynamic> data);

  Future<String> verifyOTP(Map<String, dynamic> data);

  Future<String> resendOTP(Map<String, dynamic> data);

  Future<void> logout();
}
