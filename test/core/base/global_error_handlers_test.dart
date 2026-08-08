import 'dart:ui' show ErrorCallback;

import 'package:flutter/foundation.dart';
import 'package:flutter_template/src/core/base/global_error_handlers.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_crash_reporter.dart';

void main() {
  group('installGlobalErrorHandlers', () {
    late FakeCrashReporter reporter;
    late FlutterExceptionHandler? previousOnError;
    late ErrorCallback? previousPlatformOnError;

    setUp(() {
      reporter = FakeCrashReporter();
      previousOnError = FlutterError.onError;
      previousPlatformOnError = PlatformDispatcher.instance.onError;
      installGlobalErrorHandlers(reporter);
    });

    tearDown(() {
      FlutterError.onError = previousOnError;
      PlatformDispatcher.instance.onError = previousPlatformOnError;
    });

    test('framework errors report non-fatal', () {
      final details = FlutterErrorDetails(
        exception: StateError('build failed'),
        stack: StackTrace.current,
      );

      FlutterError.onError!(details);

      expect(reporter.reports, hasLength(1));
      expect(reporter.reports.single.error, details.exception);
      expect(reporter.reports.single.fatal, isFalse);
    });

    test('platform-dispatcher errors report fatal and are marked handled', () {
      final error = StateError('escaped the framework');
      final trace = StackTrace.current;

      final handled = PlatformDispatcher.instance.onError!(error, trace);

      expect(handled, isTrue);
      expect(reporter.reports, hasLength(1));
      expect(reporter.reports.single.error, same(error));
      expect(reporter.reports.single.fatal, isTrue);
    });
  });
}
