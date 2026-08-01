import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  group('networkLoggerProvider', () {
    // Test binaries run with asserts enabled, so kDebugMode is true here.
    // The release branch (null — logging disabled) cannot be exercised
    // from a test; this pins the debug-build default.
    test('defaults to PrettyDioLogger in debug builds', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(networkLoggerProvider), isA<PrettyDioLogger>());
    });
  });
}
