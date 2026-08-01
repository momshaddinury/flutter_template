import 'package:flutter_template/src/core/base/rethrow_with_stack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('rethrowWithStack', () {
    test('rethrows the same object with the given stack trace', () {
      final original = StateError('boom');
      final trace = StackTrace.current;

      // rethrowWithStack returns Never, so no fail() guard is needed —
      // falling through the try is impossible by type.
      try {
        rethrowWithStack(original, trace);
      } on StateError catch (e, st) {
        expect(e, same(original));
        expect(st, same(trace));
      }
    });
  });
}
