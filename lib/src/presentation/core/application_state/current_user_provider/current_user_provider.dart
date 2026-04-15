import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/entities/login_entity.dart';

part 'current_user_provider.g.dart';

@riverpod
CachedUserEntity? currentUser(Ref ref) {
  return ref.read(getCachedUserUseCaseProvider).call();
}
