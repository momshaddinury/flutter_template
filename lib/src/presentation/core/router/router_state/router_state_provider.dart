import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../application_state/startup_provider/app_startup_provider.dart';
import '../routes.dart';

part 'router_state_provider.g.dart';

@Riverpod(keepAlive: true)
class RouterState extends _$RouterState {
  @override
  String? build() {
    ref.listen(appStartupProvider, (_, state) {
      if (!(state.isLoading || state.hasError)) {
        decideNextRoute();
      }
    });
    return Routes.initial;
  }

  void decideNextRoute() {
    final isOnboarded = ref.read(getOnboardingStatusUseCaseProvider).call();
    final isLoggedIn = ref.read(getUserLoginStatusUseCaseProvider).call();

    if (state == Routes.initial) {
      state = Routes.splash;
      Timer(const Duration(milliseconds: 500), () => decideNextRoute());
      return;
    }

    if (!isOnboarded) {
      state = Routes.onboarding;
      // Mark onboarding as completed
      ref.read(markOnboardingCompletedUseCaseProvider).call();
      return;
    }

    state = isLoggedIn ? Routes.home : Routes.login;
  }
}
