import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/entities/user_entity.dart';

part 'user_provider.g.dart';

@riverpod
Future<List<UserEntity>> users(Ref ref) async {
  final getUsersUseCase = ref.read(getUsersUseCaseProvider);

  await Future.delayed(const Duration(seconds: 1));
  final result = await getUsersUseCase();

  return result.when(
    success: (data) => data,
    error: (error) => throw Exception(error.message),
  );
}
