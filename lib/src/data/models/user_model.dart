import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.decode)
class UserResponseModel with UserResponseModelMappable {
  UserResponseModel({required this.users});

  final List<UserModel> users;

  static const fromJson = UserResponseModelMapper.fromJson;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class UserModel extends UserEntity with UserModelMappable {
  UserModel({required super.id, required super.username, required super.email});

  static const fromJson = UserModelMapper.fromJson;
}
