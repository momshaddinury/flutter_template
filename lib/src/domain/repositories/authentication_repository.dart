import '../../core/base/result.dart';
import '../../core/base/unit.dart';
import '../entities/login_entity.dart';
import '../entities/sign_up_entity.dart';
import '../failures/business_failure.dart';

abstract interface class AuthenticationRepository {
  Future<SignUpResponseEntity> register(SignUpRequestEntity data);

  Future<Result<LoginResponseEntity, BusinessFailure>> login(
    LoginRequestEntity data,
  );

  Future<bool> rememberMe({bool? rememberMe});

  Future<String> forgotPassword(Map<String, dynamic> data);

  Future<String> resetPassword(Map<String, dynamic> data);

  Future<String> verifyOTP(Map<String, dynamic> data);

  Future<String> resendOTP(Map<String, dynamic> data);

  Future<Result<Unit, BusinessFailure>> logout();
}
