part of '../router.dart';

List<GoRoute> _onboardingRoutes(Ref ref) {
  return [
    GoRoute(
      path: Routes.splash.path,
      name: Routes.splash.name,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: StartupWidget(loading: SplashPage(), loaded: SplashPage()),
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
