import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/core/base/crash_reporter.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('crashReporterProvider', () {
    test('defaults to the logging reporter', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(crashReporterProvider),
        isA<LoggingCrashReporter>(),
      );
    });
  });
}
