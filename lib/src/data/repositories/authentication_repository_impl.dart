import '../services/network/rest_client.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/interfaces/authentication_repository.dart';
import '../models/login_model.dart';

final class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.remote,
  });

  final RestClient remote;

  @override
  Future<SignUpResponseEntity> register(SignUpRequestEntity data) async {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<LoginResponseEntity> login(LoginRequestEntity data) async {
    return await request(() async {
      final model = LoginRequestModel.fromEntity(data);
      final response = await remote.login(model);
      return LoginResponseModelMapper.fromJson(response.data);
    });
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
}
