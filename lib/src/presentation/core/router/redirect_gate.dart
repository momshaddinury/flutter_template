import 'routes.dart';

/// The router's gating policy. Pure — no `Ref`, no `BuildContext` — so
/// the whole policy is unit-testable in isolation.
abstract final class RedirectGate {
  /// Enforces the [gate] destination for [path], or returns `null` to
  /// allow it.
  ///
  /// Splash and onboarding are hard gates (the user is pinned there). The
  /// login gate allows the whole auth flow. For any other gate — in
  /// practice [Routes.home], the authenticated state — only the
  /// gate-only routes redirect, so ordinary in-app navigation is
  /// unaffected. Idempotent — never returns the path already being
  /// visited, which is what prevents redirect loops.
  static String? redirect(String path, Routes gate) {
    return switch (gate) {
      .splash => path == Routes.splash.path ? null : Routes.splash.path,
      .onboarding =>
        path == Routes.onboarding.path ? null : Routes.onboarding.path,
      .login => _isAuthFlowPath(path) ? null : Routes.login.path,
      _ => _isGateOnlyPath(path) ? Routes.home.path : null,
    };
  }

  /// The unauthenticated auth flow: `/login` and everything nested under
  /// it (registration, the reset-password chain).
  static bool _isAuthFlowPath(String path) =>
      path == Routes.login.path || path.startsWith('${Routes.login.path}/');

  /// Routes that only exist to serve a gate. An authenticated user
  /// visiting one of these (or the bare `/`) is sent home.
  static bool _isGateOnlyPath(String path) =>
      _isAuthFlowPath(path) ||
      path == Routes.splash.path ||
      path == Routes.onboarding.path ||
      path == '/';
}
