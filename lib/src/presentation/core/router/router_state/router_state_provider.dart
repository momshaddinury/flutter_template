import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/repositories/router_repository.dart';
import '../../application_state/startup_provider/app_startup_provider.dart';
import '../routes.dart';

part 'router_state_provider.g.dart';

@Riverpod(keepAlive: true)
class RouterState extends _$RouterState {
  RouterRepository? _routerRepository;

  @override
  String? build() {
    ref.listen(appStartupProvider, (_, state) {
      if (!(state.isLoading || state.hasError)) {
        _routerRepository = ref.read(routerRepositoryProvider);
        decideNextRoute();
      }
    });
    return Routes.initial;
  }

  void decideNextRoute() {
    final isOnboarded = _routerRepository?.isOnboardingCompleted() ?? false;
    final isLoggedIn = _routerRepository?.isUserLoggedIn() ?? false;

    if (state == Routes.initial) {
      state = Routes.splash;
      Timer(const Duration(milliseconds: 500), () => decideNextRoute());
      return;
    }

    if (!isOnboarded) {
      state = Routes.onboarding;
      // Mark onboarding as completed
      _routerRepository?.saveOnboardingAsCompleted();
      return;
    }

    state = isLoggedIn ? Routes.home : Routes.login;
  }
}
