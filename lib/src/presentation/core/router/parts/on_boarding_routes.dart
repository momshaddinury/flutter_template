part of '../router.dart';

List<GoRoute> _onboardingRoutes(Ref ref) {
  return [
    GoRoute(
      path: Routes.splash,
      name: Routes.splash,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: SplashPage());
      },
    ),
    GoRoute(
      path: Routes.onboarding,
      name: Routes.onboarding,
      pageBuilder: (context, state) {
        return const MaterialPage(child: OnboardingPage());
      },
    ),
  ];
}
