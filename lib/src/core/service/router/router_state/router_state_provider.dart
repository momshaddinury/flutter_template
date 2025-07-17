import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../di/dependency_injection.dart';
import '../../../riverpod/startup/app_startup_provider.dart';
import '../../cache/cache_service.dart';
import '../routes.dart';

part 'router_state_provider.g.dart';

@Riverpod(keepAlive: true)
class RouterState extends _$RouterState {
  CacheService? local;

  @override
  String? build() {
    ref.listen(appStartupProvider, (_, state) {
      if (!(state.isLoading || state.hasError)) {
        local = ref.read(cacheServiceProvider);
        decideNextRoute();
      }
    });
    return Routes.initial;
  }

  void decideNextRoute() {
    final isOnboarded = local?.get(CacheKey.isOnBoardingCompleted) ?? false;
    final isLoggedIn = local?.get(CacheKey.isLoggedIn) ?? false;

    if (state == Routes.initial) {
      state = Routes.splash;
      Timer(const Duration(milliseconds: 500), () => decideNextRoute());
      return;
    }

    if (!isOnboarded) {
      state = Routes.onboarding;
      // Mark onboarding as completed
      local?.save(CacheKey.isOnBoardingCompleted, true);
      return;
    }

    state = isLoggedIn ? Routes.homeTab : Routes.login;
  }
}
