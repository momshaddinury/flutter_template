import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/presentation/core/application_state/onboarding_status_provider/onboarding_status_provider.dart';
import 'package:flutter_template/src/presentation/core/application_state/session_status_provider/session_status_provider.dart';
import 'package:flutter_template/src/presentation/core/application_state/startup_provider/app_startup_provider.dart';
import 'package:flutter_template/src/presentation/core/router/router_state/router_state_provider.dart';
import 'package:flutter_template/src/presentation/core/router/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProviderContainer containerWith({
    required Future<void> Function(Ref ref) startup,
    bool onboarded = true,
    Future<SessionStatus> Function(Ref ref)? session,
  }) {
    final container = ProviderContainer(
      // WHY: matches the app's ProviderScope — auto-retry disabled so a
      // failed startup settles into its error state instead of silently
      // retrying past the assertion.
      retry: (retryCount, error) => null,
      overrides: [
        appStartupProvider.overrideWith(startup),
        onboardingStatusProvider.overrideWith((ref) => onboarded),
        if (session != null) sessionStatusProvider.overrideWith(session),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  Future<void> startupDone(Ref ref) async {}

  group('routerState', () {
    test('splash while startup is loading', () {
      final container = containerWith(
        startup: (ref) => Completer<void>().future,
      );

      expect(container.read(routerStateProvider), Routes.splash);
    });

    test('splash when startup failed', () async {
      final container = containerWith(
        startup: (ref) async => throw Exception('startup failed'),
      );
      await expectLater(
        container.read(appStartupProvider.future),
        throwsException,
      );

      expect(container.read(routerStateProvider), Routes.splash);
    });

    test('onboarding before it is completed', () async {
      final container = containerWith(startup: startupDone, onboarded: false);
      await container.read(appStartupProvider.future);

      expect(container.read(routerStateProvider), Routes.onboarding);
    });

    test('splash while the session status is loading', () async {
      final container = containerWith(
        startup: startupDone,
        session: (ref) => Completer<SessionStatus>().future,
      );
      await container.read(appStartupProvider.future);

      expect(container.read(routerStateProvider), Routes.splash);
    });

    test('login when unauthenticated', () async {
      final container = containerWith(
        startup: startupDone,
        session: (ref) async => SessionStatus.unauthenticated,
      );
      await container.read(appStartupProvider.future);
      await container.read(sessionStatusProvider.future);

      expect(container.read(routerStateProvider), Routes.login);
    });

    test('home when authenticated', () async {
      final container = containerWith(
        startup: startupDone,
        session: (ref) async => SessionStatus.authenticated,
      );
      await container.read(appStartupProvider.future);
      await container.read(sessionStatusProvider.future);

      expect(container.read(routerStateProvider), Routes.home);
    });
  });
}
