import '../../core/base/base.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../services/network/rest_client.dart';

final class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required this.remote});

  final RestClient remote;

  @override
  Future<Result<List<UserEntity>, Failure>> getUsers() {
    return asyncGuard(() async {
      final response = await remote.getUsers();

      final data = UserResponseModel.fromJson(response.data);

      return data.users;
    });
  }
}
