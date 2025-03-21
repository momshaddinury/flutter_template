import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../feature/authentication/presentation/forgot_password/view/create_new_password_page.dart';
import '../../../feature/authentication/presentation/forgot_password/view/email_verification_page.dart';
import '../../../feature/authentication/presentation/forgot_password/view/reset_password_page.dart';
import '../../../feature/authentication/presentation/forgot_password/view/reset_password_success_page.dart';
import '../../../feature/authentication/presentation/login/view/login_page.dart';
import '../../../feature/authentication/presentation/registration/view/registration_page.dart';
import '../../../feature/onboarding/presentation/view/onboarding_page.dart';
import '../../../feature/splash/presentation/view/splash_page.dart';
import '../../extensions/riverpod_extensions.dart';
import '../../logger/log.dart';
import '../../widgets/app_startup/startup_widget.dart';
import 'router_state/router_state_provider.dart';
import 'routes.dart';

part './parts/authentication_routes.dart';
part './parts/on_boarding_routes.dart';
part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: ref.asListenable(routerStateProvider),
    initialLocation: Routes.initial,
    redirect: (context, state) {
      Log.info('Redirecting to ${state.uri}');
      if ([
        Routes.initial,
        Routes.onboarding,
        Routes.splash,
      ].contains(state.uri.path)) {
        return ref.asListenable(routerStateProvider).value;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.initial,
        name: Routes.initial,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: AppStartupWidget(
              loading: SplashPage(),
              loaded: SplashPage(),
            ),
          );
        },
      ),
      ..._onboardingRoutes(ref),
      ..._authenticationRoutes(ref),
    ],
  );
}
