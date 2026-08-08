import '../../core/base/result.dart';
import '../../core/base/unit.dart';
import '../entities/login_entity.dart';
import '../failures/business_failure.dart';

abstract interface class AuthenticationRepository {
  Future<Result<LoginResponseEntity, BusinessFailure>> login(
    LoginRequestEntity data,
  );

  Future<bool> rememberMe({bool? rememberMe});

  Future<Result<Unit, BusinessFailure>> logout();

  /// Called once at startup. Honors the remember-me choice recorded at
  /// login: when the remembered-session flag (`CacheKey.isLoggedIn`) is
  /// not set, any tokens left from a previous run are cleared so the
  /// session does not silently survive a restart the user opted out of.
  Future<Result<Unit, BusinessFailure>> restoreSession();
}
