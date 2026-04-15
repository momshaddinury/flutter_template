interface class LoginEntity {}

class LoginRequestEntity extends LoginEntity {
  LoginRequestEntity({
    required this.username,
    required this.password,
    this.shouldRemeber = false,
  });

  final String username;
  final String password;
  final bool? shouldRemeber;
}

class LoginResponseEntity extends LoginEntity {
  LoginResponseEntity({required this.accessToken});

  final String accessToken;
}

class CachedUserEntity {
  const CachedUserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String image;

  String get fullName => '$firstName $lastName'.trim();
}
