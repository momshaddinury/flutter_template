import '../../core/base/result.dart';
import '../../core/base/unit.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/failures/business_failure.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../base/base_repository.dart';
import '../models/login_model.dart';
import '../services/cache/cache_service.dart';
import '../services/network/auth/token_manager.dart';
import '../services/network/rest_client.dart';

final class AuthenticationRepositoryImpl extends BaseRepository
    implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.remote,
    required this.local,
    required this.tokens,
    required super.crashReporter,
  });

  final RestClient remote;
  final CacheService local;
  final TokenManager tokens;

  @override
  Future<SignUpResponseEntity> register(SignUpRequestEntity data) async {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Result<LoginResponseEntity, BusinessFailure>> login(
    LoginRequestEntity data,
  ) async {
    return asyncGuard(() async {
      final request = LoginRequestModel.fromEntity(data);
      final response = await remote.login(request.toJson());

      final model = LoginResponseModel.fromJson(response.data);

      await tokens.persist(
        access: model.accessToken,
        refresh: model.refreshToken,
      );

      if (data.shouldRemeber ?? false) {
        try {
          await _saveSession();
        } catch (_) {
          // WHY: a failed session write must not leave orphaned tokens in
          // the keystore — clear them so the failed login is atomic.
          await tokens.clear();
          rethrow;
        }
      }

      return model;
    });
  }

  Future<void> _saveSession() async {
    await local.save(CacheKey.isLoggedIn, true);
  }

  /// Reads or writes the persisted "Remember Me" checkbox preference.
  ///
  /// When [rememberMe] is null, retrieves the current setting from cache;
  /// otherwise updates it. Returns the current or newly saved value,
  /// defaulting to false on errors. This is the UI preference only —
  /// whether a session survives a restart is decided by [restoreSession].
  @override
  Future<bool> rememberMe({bool? rememberMe}) async {
    try {
      if (rememberMe == null) {
        return local.get<bool>(CacheKey.rememberMe) ?? false;
      }

      await local.save(CacheKey.rememberMe, rememberMe);

      return rememberMe;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> forgotPassword(Map<String, dynamic> data) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<String> resetPassword(Map<String, dynamic> data) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<String> verifyOTP(Map<String, dynamic> data) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }

  @override
  Future<String> resendOTP(Map<String, dynamic> data) {
    // TODO: implement resendOTP
    throw UnimplementedError();
  }

  @override
  Future<Result<Unit, BusinessFailure>> restoreSession() async {
    return asyncGuard(() async {
      final remembered = local.get<bool>(CacheKey.isLoggedIn) ?? false;
      if (!remembered) await tokens.clear();

      return Unit.value;
    });
  }

  @override
  Future<Result<Unit, BusinessFailure>> logout() async {
    return asyncGuard(() async {
      // WHY: flag first, tokens second — the session derives from the
      // stored tokens, so the token clear is the step that actually ends
      // it. In this order a failed token clear leaves the user signed in
      // with a surfaced error prompting a retry, instead of a cleared
      // flag masking tokens that still authenticate.
      await local.remove([CacheKey.isLoggedIn, CacheKey.rememberMe]);
      await tokens.clear();
      return Unit.value;
    });
  }
}
