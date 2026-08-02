part of '../router.dart';

List<GoRoute> _onboardingRoutes(Ref ref) {
  return [
    GoRoute(
      path: Routes.splash.path,
      name: Routes.splash.name,
      pageBuilder: (context, state) {
        // WHY: the splash route hosts the startup widget so a failed
        // startup shows its retry UI — the gate pins the user here while
        // startup is loading or failed.
        return const NoTransitionPage(
          child: AppStartupWidget(loading: SplashPage(), loaded: SplashPage()),
        );
      },
    ),
    GoRoute(
      path: Routes.onboarding.path,
      name: Routes.onboarding.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: OnboardingPage());
      },
    ),
  ];
}
