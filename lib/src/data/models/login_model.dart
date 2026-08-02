import 'package:dart_mappable/dart_mappable.dart';

part 'login_model.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.decode)
class LoginResponseModel with LoginResponseModelMappable {
  LoginResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  static const fromJson = LoginResponseModelMapper.fromJson;
}

@MappableClass(generateMethods: GenerateMethods.encode)
class LoginRequestModel with LoginRequestModelMappable {
  LoginRequestModel({required this.username, required this.password});

  final String username;
  final String password;
}
