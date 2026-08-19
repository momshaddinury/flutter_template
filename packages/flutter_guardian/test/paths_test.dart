import 'dart:io';

import 'package:flutter_guardian/src/paths.dart';
import 'package:test/test.dart';

void main() {
  group('toPosix', () {
    test('rewrites Windows separators', () {
      expect(
        toPosix(r'C:\repo\lib\src\presentation\core\widgets\svg_icon.dart'),
        'C:/repo/lib/src/presentation/core/widgets/svg_icon.dart',
      );
    });

    test('leaves a posix path untouched', () {
      const path = '/repo/lib/src/presentation/core/widgets/svg_icon.dart';
      expect(toPosix(path), path);
    });

    test('rewrites the mixed form a Windows toolchain can produce', () {
      expect(toPosix(r'C:\repo/lib\src/data'), 'C:/repo/lib/src/data');
    });

    test('carries a Windows path into the markers rules match on', () {
      final path = toPosix(r'C:\repo\lib\src\presentation\features\login.dart');
      expect(path.contains('/lib/src/presentation/'), isTrue);
    });

    test('carries a Windows path into a sanctioned-file suffix', () {
      final path = toPosix(r'C:\repo\lib\src\di\parts\repository.dart');
      expect(path.endsWith('di/parts/repository.dart'), isTrue);
    });
  });

  // Every rule has to read its path through posixPath. Reading
  // `file.path` directly reintroduces the bug the helper exists to fix,
  // and it fails silently — on Windows the rule simply stops matching.
  test('no rule reads file.path directly', () {
    final offenders = Directory('lib/rules')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .where((file) => file.readAsStringSync().contains('.file.path'))
        .map((file) => file.uri.pathSegments.last)
        .toList();

    expect(offenders, isEmpty);
  });
}
