import 'package:data/services/cache/cache_service.dart';
import 'package:domain/repositories/router_repository.dart';

class RouterRepositoryImpl extends RouterRepository {
  RouterRepositoryImpl({required this.cacheService});

  final CacheService cacheService;

  @override
  bool isOnboardingCompleted() {
    return cacheService.get(CacheKey.isOnBoardingCompleted) ?? false;
  }

  @override
  bool isUserLoggedIn() {
    return cacheService.get(CacheKey.isLoggedIn) ?? false;
  }

  @override
  void saveOnboardingAsCompleted() {
    cacheService.save(CacheKey.isOnBoardingCompleted, true);
  }
}
