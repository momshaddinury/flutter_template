import '../../../../core/base/repository.dart';
import '../entities/login_entity.dart';
import '../entities/sign_up_entity.dart';

abstract base class AuthenticationRepository extends Repository {
  Future<SignUpResponseEntity> register(SignUpRequestEntity data);

  Future<LoginResponseEntity> login(LoginRequestEntity data);

  Future<String> forgotPassword(Map<String, dynamic> data);

  Future<String> resetPassword(Map<String, dynamic> data);

  Future<String> verifyOTP(Map<String, dynamic> data);

  Future<String> resendOTP(Map<String, dynamic> data);
}
