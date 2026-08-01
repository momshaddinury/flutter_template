import '../../domain/repositories/router_repository.dart';
import '../services/cache/cache_service.dart';
import '../services/network/auth/token_manager.dart';

class RouterRepositoryImpl extends RouterRepository {
  RouterRepositoryImpl({required this.cacheService, required this.tokens});

  final CacheService cacheService;
  final TokenManager tokens;

  @override
  bool isOnboardingCompleted() {
    return cacheService.get(CacheKey.isOnBoardingCompleted) ?? false;
  }

  @override
  Future<bool> hasSession() async {
    final refreshToken = await tokens.refreshToken;

    return refreshToken != null && refreshToken.isNotEmpty;
  }

  @override
  void saveOnboardingAsCompleted() {
    cacheService.save(CacheKey.isOnBoardingCompleted, true);
  }
}
