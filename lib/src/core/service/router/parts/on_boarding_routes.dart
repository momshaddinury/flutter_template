part of '../router.dart';

List<GoRoute> _onboardingRoutes(ref) {
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
        // Mark onboarding as completed
        ref
            .read(cacheServiceProvider)
            .save<bool>(CacheKey.isOnBoardingCompleted, true);
        // Return the onboarding page
        return const MaterialPage(child: OnboardingPage());
      },
    ),
  ];
}
