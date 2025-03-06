import 'dart:developer';

import 'package:flutter_template/src/core/service/network/rest_client.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../models/login_model.dart';

final class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;

  @override
  Future<SignUpResponseEntity> register(SignUpRequestEntity data) async {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<LoginResponseEntity> login(LoginRequestEntity data) async {
    try {
      final response = await restClient.login(
        LoginRequest(
          username: data.username,
          password: data.password,
        ),
      );

      return LoginResponseMapper.fromJson(response.data);
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      rethrow;
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
}
