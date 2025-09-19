import '../../core/base/base.dart';
import '../entities/user_entity.dart';

abstract base class UserRepository extends Repository {
  Future<Result<List<UserEntity>, Failure>> getUsers();
}
