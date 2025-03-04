part of 'authentication_data_source.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  AuthenticationDataSourceImpl({required this.remote});

  final RestClientKit remote;

  @override
  Future<Response> login(Map<String, dynamic> data) async {
    return remote.post(Endpoints.login, data: data);
  }

  @override
  Future<Response> register(Map<String, dynamic> data) async {
    return remote.post(Endpoints.register, data: data);
  }

  @override
  Future<Response> forgotPassword(Map<String, dynamic> data) async {
    return remote.post(Endpoints.forgotPassword, data: data);
  }

  @override
  Future<Response> resetPassword(Map<String, dynamic> data) async {
    return remote.post(Endpoints.resetPassword, data: data);
  }

  @override
  Future<Response> verifyOTP(Map<String, dynamic> data) async {
    return remote.post(Endpoints.verifyOtp, data: data);
  }

  @override
  Future<Response> resendOTP(Map<String, dynamic> data) async {
    return remote.post(Endpoints.resendOtp, data: data);
  }

  @override
  Future saveCredentials(Map<String, dynamic> data) {
    log(data.toString(), name: 'AuthenticationDataSourceImpl');
    // TODO: implement saveCredentials
    throw UnimplementedError();
  }
}
