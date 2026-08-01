import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/dependency_injection.dart';

part 'onboarding_status_provider.g.dart';

/// Whether the user has completed onboarding. `routerState` watches this;
/// the onboarding page invalidates it after marking completion, which is
/// what moves the gate forward. Reading the cache is cheap, so the
/// provider stays a thin reactive wrapper over the use case.
@Riverpod(keepAlive: true)
bool onboardingStatus(Ref ref) {
  return ref.read(getOnboardingStatusUseCaseProvider).call();
}
