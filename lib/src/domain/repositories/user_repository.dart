import '../../core/base/failure.dart';
import '../../core/base/repository.dart';
import '../../core/base/result.dart';
import '../entities/user_entity.dart';

abstract base class UserRepository extends Repository {
  Future<Result<UsersResponseEntity, Failure>> getUsers({
    required int skip,
    required int limit,
  });
}
