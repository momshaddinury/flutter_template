import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/extensions/riverpod_extensions.dart';
import '../../features/authentication/forgot_password/view/create_new_password_page.dart';
import '../../features/authentication/forgot_password/view/email_verification_page.dart';
import '../../features/authentication/forgot_password/view/reset_password_page.dart';
import '../../features/authentication/forgot_password/view/reset_password_success_page.dart';
import '../../features/authentication/login/view/login_page.dart';
import '../../features/authentication/registration/view/registration_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/onboarding/view/onboarding_page.dart';
import '../../features/profile/view/profile_page.dart';
import '../../features/splash/view/splash_page.dart';
import '../widgets/app_startup/startup_widget.dart';
import '../widgets/navigation_shell.dart';
import '../widgets/not_found_screen.dart';
import 'redirect_gate.dart';
import 'router_state/router_state_provider.dart';
import 'routes.dart';

part 'parts/authentication_routes.dart';
part 'parts/on_boarding_routes.dart';
part 'parts/shell_routes.dart';
part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  // WHY: created once — calling `asListenable` inside `redirect` would
  // allocate a fresh subscription per navigation that nothing disposes on
  // this keepAlive provider.
  final refresh = ref.asListenable(routerStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: refresh,
    initialLocation: Routes.splash.path,
    redirect: (context, state) =>
        RedirectGate.redirect(state.uri.path, ref.read(routerStateProvider)),
    errorBuilder: (context, state) => NotFoundScreen(uri: state.uri),
    routes: [
      ..._onboardingRoutes(ref),
      ..._authenticationRoutes(ref),
      _shellRoutes(ref),
    ],
  );
}
