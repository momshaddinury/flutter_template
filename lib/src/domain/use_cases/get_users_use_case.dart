import '../../core/base/failure.dart';
import '../../core/base/result.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase({required this.repository});
  final UserRepository repository;

  Future<Result<UsersResponseEntity, Failure>> call({
    required int skip,
    required int limit,
  }) {
    return repository.getUsers(skip: skip, limit: limit);
  }
}
