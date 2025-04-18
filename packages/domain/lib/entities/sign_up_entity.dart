interface class SignUpEntity {}

class SignUpRequestEntity extends SignUpEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignUpRequestEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

class SignUpResponseEntity extends SignUpEntity {
  final String accessToken;

  SignUpResponseEntity({
    required this.accessToken,
  });
}
