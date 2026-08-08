import 'package:flutter_template/src/presentation/core/router/redirect_gate.dart';
import 'package:flutter_template/src/presentation/core/router/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RedirectGate', () {
    group('splash gate (startup pending or failed)', () {
      test('pins every path to splash', () {
        expect(RedirectGate.redirect('/', Routes.splash), '/splash');
        expect(RedirectGate.redirect('/home', Routes.splash), '/splash');
        expect(RedirectGate.redirect('/login', Routes.splash), '/splash');
        expect(RedirectGate.redirect('/unknown', Routes.splash), '/splash');
      });

      test('is idempotent at splash', () {
        expect(RedirectGate.redirect('/splash', Routes.splash), isNull);
      });
    });

    group('onboarding gate', () {
      test('pins every path to onboarding', () {
        expect(
          RedirectGate.redirect('/home', Routes.onboarding),
          '/onboarding',
        );
        expect(
          RedirectGate.redirect('/login', Routes.onboarding),
          '/onboarding',
        );
      });

      test('is idempotent at onboarding', () {
        expect(RedirectGate.redirect('/onboarding', Routes.onboarding), isNull);
      });
    });

    group('login gate (unauthenticated)', () {
      test('allows the whole auth flow', () {
        expect(RedirectGate.redirect('/login', Routes.login), isNull);
        expect(
          RedirectGate.redirect('/login/registration', Routes.login),
          isNull,
        );
        expect(
          RedirectGate.redirect(
            '/login/reset-password/create-new-password',
            Routes.login,
          ),
          isNull,
        );
      });

      test('sends everything else to login', () {
        expect(RedirectGate.redirect('/home', Routes.login), '/login');
        expect(RedirectGate.redirect('/profile', Routes.login), '/login');
        expect(RedirectGate.redirect('/splash', Routes.login), '/login');
        expect(RedirectGate.redirect('/', Routes.login), '/login');
      });
    });

    group('home gate (authenticated)', () {
      test('keeps in-app navigation free', () {
        expect(RedirectGate.redirect('/home', Routes.home), isNull);
        expect(RedirectGate.redirect('/profile', Routes.home), isNull);
        expect(RedirectGate.redirect('/unknown', Routes.home), isNull);
      });

      test('bounces gate-only routes home', () {
        expect(RedirectGate.redirect('/login', Routes.home), '/home');
        expect(
          RedirectGate.redirect('/login/registration', Routes.home),
          '/home',
        );
        expect(RedirectGate.redirect('/splash', Routes.home), '/home');
        expect(RedirectGate.redirect('/onboarding', Routes.home), '/home');
        expect(RedirectGate.redirect('/', Routes.home), '/home');
      });
    });
  });
}
