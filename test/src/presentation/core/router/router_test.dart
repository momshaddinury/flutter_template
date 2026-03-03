import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/router/router.dart';
import 'package:flutter_template/src/presentation/core/router/router_state/router_state_provider.dart';
import 'package:flutter_template/src/presentation/core/router/routes.dart';
import 'package:go_router/go_router.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [routerStateProvider.overrideWith(() => FakeRouterState())],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('GoRouter Provider', () {
    test('returns a GoRouter instance', () {
      // Act
      final router = container.read(goRouterProvider);

      // Assert
      expect(router, isA<GoRouter>());
    });

    test('initial location is correctly set', () {
      // Act
      final router = container.read(goRouterProvider);

      // Assert
      expect(router.routeInformationProvider.value.uri.path, Routes.initial);
    });
  });
}

// Manual Fake for RouterState to avoid Mockito issues with generated Riverpod classes
class FakeRouterState extends RouterState {
  @override
  String? build() => Routes.initial;
}
