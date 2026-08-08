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

      expect(container.read(crashReporterProvider), isNotNull);
      expect(FlutterError.onError, isNot(same(previousOnError)));
      expect(
        PlatformDispatcher.instance.onError,
        isNot(same(previousPlatformOnError)),
      );
    });
  });
}
