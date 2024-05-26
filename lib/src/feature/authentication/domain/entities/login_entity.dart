interface class LoginEntity {}

class LoginRequestEntity extends LoginEntity {
  final String email;
  final String password;

  LoginRequestEntity({
    required this.email,
    required this.password,
  });
}

class LoginResponseEntity extends LoginEntity {
  final String accessToken;

  LoginResponseEntity({
    required this.accessToken,
  });
}
