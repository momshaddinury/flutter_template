import 'package:dart_mappable/dart_mappable.dart';

part 'sign_up_model.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.encode)
class SignUpRequestModel with SignUpRequestModelMappable {
  SignUpRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @MappableField(key: 'first_name')
  final String firstName;

  @MappableField(key: 'last_name')
  final String lastName;

  final String email;
  final String password;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class SignUpResponseModel with SignUpResponseModelMappable {
  SignUpResponseModel({required this.accessToken});

  @MappableField(key: 'access_token')
  final String accessToken;

  static const fromJson = SignUpResponseModelMapper.fromJson;
}
