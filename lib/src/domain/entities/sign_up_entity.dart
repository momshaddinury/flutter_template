class SignUpRequestEntity {
  SignUpRequestEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
}

class SignUpResponseEntity {
  SignUpResponseEntity({required this.accessToken});

  final String accessToken;
}
