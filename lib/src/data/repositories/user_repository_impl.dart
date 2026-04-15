import '../../core/base/failure.dart';
import '../../core/base/result.dart';
import '../services/network/rest_client.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../mappers/user_mapper.dart';

final class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required this.restClient});
  final RestClient restClient;

  @override
  Future<Result<UsersResponseEntity, Failure>> getUsers({
    required int skip,
    required int limit,
  }) async {
    return asyncGuard(() async {
      final response = await restClient.getUsers(skip, limit);
      return UserMapper.toResponseEntity(response);
    });
  }
}
