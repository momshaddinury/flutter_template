/// The signed-in user, as the domain sees it. Tokens never appear here:
/// the data layer persists them through `TokenManager`, and the app
/// reasons about the session through the session gate — never through
/// token values.
class LoginResponseEntity {
  LoginResponseEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
}
