import 'dart:developer';

import 'package:rest_client_kit/rest_client_kit.dart';

import '../../../../core/service/network/src/endpoints.dart';

part 'authentication_data_source_impl.dart';

abstract interface class AuthenticationDataSource {
  Future<Response> register(Map<String, dynamic> data);

  Future<Response> login(Map<String, dynamic> data);

  Future saveCredentials(Map<String, dynamic> data);

  Future<Response> forgotPassword(Map<String, dynamic> data);

  Future<Response> resetPassword(Map<String, dynamic> data);

  Future<Response> verifyOTP(Map<String, dynamic> data);

  Future<Response> resendOTP(Map<String, dynamic> data);
}
