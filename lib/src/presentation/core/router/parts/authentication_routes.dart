part of '../router.dart';

// WHY: route definitions are split per feature as parts of router.dart so
// the route tree stays one navigable unit while each file stays small.
List<GoRoute> _authenticationRoutes(Ref ref) {
  return [
    GoRoute(
      path: Routes.login.path,
      name: Routes.login.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginPage());
      },
      routes: [
        GoRoute(
          path: Routes.registration.path,
          name: Routes.registration.name,
          pageBuilder: (context, state) =>
              const MaterialPage(child: RegistrationPage()),
        ),
        GoRoute(
          path: Routes.resetPassword.path,
          name: Routes.resetPassword.name,
          pageBuilder: (context, state) =>
              const MaterialPage(child: ResetPasswordPage()),
          routes: [
            GoRoute(
              path: Routes.emailVerification.path,
              name: Routes.emailVerification.name,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: EmailVerificationPage()),
            ),
            GoRoute(
              path: Routes.createNewPassword.path,
              name: Routes.createNewPassword.name,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: CreateNewPasswordPage()),
              routes: [
                GoRoute(
                  path: Routes.resetPasswordSuccess.path,
                  name: Routes.resetPasswordSuccess.name,
                  pageBuilder: (context, state) =>
                      const MaterialPage(child: ResetPasswordSuccessPage()),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
