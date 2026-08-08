import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application_state/onboarding_status_provider/onboarding_status_provider.dart';
import '../../application_state/session_status_provider/session_status_provider.dart';
import '../../application_state/startup_provider/startup_provider.dart';
import '../routes.dart';

part 'router_state_provider.g.dart';

/// The gate destination the router enforces, derived from app startup,
/// onboarding, and session status.
///
/// The router reacts to this alone — it never reads startup or session
/// directly, and never sees a token. Splash while startup (or the session
/// read) is pending or failed; onboarding until completed; then home or
/// login by session. New inputs (a force-update flag, a maintenance mode)
/// compose here without touching the router.
///
/// A pure derivation on purpose: no timers, no side effects, no
/// imperative transitions. The pages that change the underlying state
/// (login, logout, onboarding completion) invalidate the providers this
/// one watches, and the gate follows.
@Riverpod(keepAlive: true)
Routes routerState(Ref ref) {
  final startup = ref.watch(startupProvider);
  if (startup.isLoading || startup.hasError) return .splash;

  if (!ref.watch(onboardingStatusProvider)) return .onboarding;

  return switch (ref.watch(sessionStatusProvider)) {
    AsyncData(value: .authenticated) => .home,
    AsyncData() => .login,
    _ => .splash,
  };
}
