import '../../domain/entities/login_entity.dart';

extension LoginRequestModel on LoginRequestEntity {
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({
    required super.accessToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json["access_token"],
    );
  }
}
