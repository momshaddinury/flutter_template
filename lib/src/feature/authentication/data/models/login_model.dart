import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/login_entity.dart';

part 'login_model.mapper.dart';

@MappableClass()
class LoginResponse extends LoginResponseEntity with LoginResponseMappable {
  LoginResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.accessToken,
    required this.gender,
    required this.refreshToken,
  }) : super(accessToken: accessToken);

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;
}

@MappableClass()
class LoginRequest with LoginRequestMappable {
  LoginRequest({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
