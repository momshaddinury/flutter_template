/// The app's named routes. [path] is the URL segment handed to
/// `GoRoute.path`; `name` (the enum member name) is what `GoRoute.name`
/// and named navigation (`context.pushNamed`) use. Keeping both on one
/// enum means path and name cannot drift, and switches over routes are
/// exhaustive.
///
/// Top-level routes carry absolute paths (leading `/`). Sub-routes carry
/// relative segments and nest under their parent in the route tree — their
/// full location is the joined path (e.g. `/login/registration`).
enum Routes {
  splash('/splash'),
  onboarding('/onboarding'),

  login('/login'),
  registration('registration'),
  resetPassword('reset-password'),
  emailVerification('email-verification'),
  createNewPassword('create-new-password'),
  resetPasswordSuccess('reset-password-success'),

  home('/home'),
  profile('/profile');

  const Routes(this.path);

  final String path;
}
