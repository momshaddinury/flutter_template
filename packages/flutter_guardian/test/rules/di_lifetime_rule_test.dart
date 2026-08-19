import 'package:flutter_guardian/rules/di_lifetime_rule.dart';

import '../support/harness.dart';

const _annotations = '''
class Riverpod {
  const Riverpod({this.keepAlive = false});

  final bool keepAlive;
}

const riverpod = Riverpod();
''';

void main() {
  ruleTest(
    'flags a keep-alive use-case provider',
    rule: DiLifetimeRule.new,
    path: 'di/parts/use_cases.dart',
    source: '$_annotations\n@Riverpod(keepAlive: true)\nint login() => 1;\n',
    flags: ['@Riverpod(keepAlive: true)'],
  );

  ruleTest(
    'accepts an auto-disposed use-case provider',
    rule: DiLifetimeRule.new,
    path: 'di/parts/use_cases.dart',
    source: '$_annotations\n@riverpod\nint login() => 1;\n',
  );

  ruleTest(
    'flags an auto-disposed repository provider',
    rule: DiLifetimeRule.new,
    path: 'di/parts/repository.dart',
    source: '$_annotations\n@riverpod\nint login() => 1;\n',
    flags: ['@riverpod'],
  );

  ruleTest(
    'accepts a keep-alive service provider',
    rule: DiLifetimeRule.new,
    path: 'di/parts/services.dart',
    source: '$_annotations\n@Riverpod(keepAlive: true)\nint cache() => 1;\n',
  );

  ruleTest(
    'ignores a file outside the DI parts',
    rule: DiLifetimeRule.new,
    path: 'domain/use_cases/login_use_case.dart',
    source: '$_annotations\n@riverpod\nint login() => 1;\n',
  );
}
