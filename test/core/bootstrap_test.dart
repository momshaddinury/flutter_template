import 'dart:ui' show ErrorCallback;

import 'package:flutter/foundation.dart';
import 'package:flutter_template/src/core/bootstrap.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('bootstrap', () {
    late FlutterExceptionHandler? previousOnError;
    late ErrorCallback? previousPlatformOnError;

    setUp(() {
      // bootstrap installs process-wide handlers; save and restore
      // flutter_test's own so failure reporting survives this file.
      previousOnError = FlutterError.onError;
      previousPlatformOnError = PlatformDispatcher.instance.onError;
    });

    tearDown(() {
      FlutterError.onError = previousOnError;
      PlatformDispatcher.instance.onError = previousPlatformOnError;
    });

    test('returns a working container and installs the handlers', () {
      final container = bootstrap();
      addTearDown(container.dispose);

      // The container resolves providers — the same instance main hands
      // to UncontrolledProviderScope.
      expect(container.read(crashReporterProvider), isNotNull);
      // Handlers were replaced with the bootstrap-installed ones.
      expect(FlutterError.onError, isNot(same(previousOnError)));
      expect(
        PlatformDispatcher.instance.onError,
        isNot(same(previousPlatformOnError)),
      );
    });
  });
}
