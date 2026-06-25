# Known Gotchas

Things that will surprise you — don't "fix" them blindly.

- **Stubbed endpoints:** `register`, `forgotPassword`, `resetPassword`,
  `verifyOTP`, `resendOTP` in `AuthenticationRepositoryImpl` currently throw
  `UnimplementedError()`. Only login/logout/rememberMe are wired.
- **Stale test:** `test/widget_test.dart` is the default counter test and does
  not match `MyApp`. The `test/unit|widget|integration` folders in the README
  don't exist yet.
- **README drift:** the README's version table lists older versions
  (Riverpod `^2.5.1`, go_router `^14.2.8`) — trust `pubspec.yaml`, not the table.
- **Known typos (kept for compatibility):** the folder `core/utiliity/` and the
  field `shouldRemeber` on `LoginRequestEntity`. Match existing spelling when
  referencing them; fix only with an intentional rename across the codebase.
- **No FVM config committed** (`.fvmrc` / `.fvm/` are gitignored).
- **`docs/authentication_feature.md`** is referenced by the README but does not
  exist.
