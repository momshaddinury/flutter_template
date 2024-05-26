import '../../domain/entities/login_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../data_sources/authentication_data_source.dart';
import '../models/login_model.dart';
import '../models/sign_up_model.dart';

final class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource remote;

  AuthenticationRepositoryImpl({required this.remote});

  @override
  Future<SignUpResponseEntity> register(SignUpRequestEntity data) async {
    return await request(() async {
      final response = await remote.register(data.toJson());
      return SignUpResponseModel.fromJson(response.data);
    });
  }

  @override
  Future<LoginResponseEntity> login(LoginRequestEntity data) async {
    return await request(() async {
      final response = await remote.login(data.toJson());
      return LoginResponseModel.fromJson(response.data);
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
