import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/src/core/di/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  group('networkStackProvider', () {
    test('wires PrettyDioLogger as the debug logger', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final stack = container.read(networkStackProvider);

      expect(
        stack.transport.interceptors.whereType<PrettyDioLogger>(),
        hasLength(1),
      );
    });
  });
}
