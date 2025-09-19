import 'dart:math';

import '../../core/base/base.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase({required this.repository});

  final UserRepository repository;

  Future<Result<List<UserEntity>, Failure>> call() async {
    // Randomly throw an error 30% of the time
    final random = Random();
    if (random.nextDouble() < 0.3) {
      throw Exception('Random error occurred in GetUsersUseCase');
    }

    return repository.getUsers();
  }
}
