import 'package:flutter_guardian/rules/di_naming_rule.dart';

import '../support/harness.dart';

void main() {
  ruleTest(
    'flags a repository provider without "Repository" in its name',
    rule: RepositoryNamingRule.new,
    path: 'di/parts/repository.dart',
    source: 'final loginProvider = 1;\n',
    flags: ['loginProvider = 1'],
  );

  ruleTest(
    'accepts a repository provider that carries the suffix',
    rule: RepositoryNamingRule.new,
    path: 'di/parts/repository.dart',
    source: 'final loginRepositoryProvider = 1;\n',
  );

  ruleTest(
    'ignores a file outside the repository DI part',
    rule: RepositoryNamingRule.new,
    path: 'di/parts/services.dart',
    source: 'final loginProvider = 1;\n',
  );

  ruleTest(
    'flags a use-case provider without "UseCase" in its name',
    rule: UseCaseNamingRule.new,
    path: 'di/parts/use_cases.dart',
    source: 'final loginProvider = 1;\n',
    flags: ['loginProvider = 1'],
  );

  ruleTest(
    'accepts a use-case provider that carries the suffix',
    rule: UseCaseNamingRule.new,
    path: 'di/parts/use_cases.dart',
    source: 'final loginUseCaseProvider = 1;\n',
  );

  ruleTest(
    'flags a service provider without "Service" in its name',
    rule: ServiceNamingRule.new,
    path: 'di/parts/services.dart',
    source: 'final cacheProvider = 1;\n',
    flags: ['cacheProvider = 1'],
  );

  ruleTest(
    'accepts a service provider that carries the suffix',
    rule: ServiceNamingRule.new,
    path: 'di/parts/services.dart',
    source: 'final cacheServiceProvider = 1;\n',
  );

  ruleTest(
    'ignores a local variable inside a provider body',
    rule: ServiceNamingRule.new,
    path: 'di/parts/services.dart',
    source: '''
int cacheService() {
  final helper = 1;

  return helper;
}
''',
  );
}
