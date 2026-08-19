import 'package:flutter_guardian/rules/direct_dio_rule.dart';

import '../support/harness.dart';

const _source = '''
class Dio {
  void get(String path) {}
}

void load(Dio dio) {
  dio.get('/profile');
}
''';

void main() {
  ruleTest(
    'flags a Dio call from a repository',
    rule: DirectDioRule.new,
    path: 'data/repositories/login_repository_impl.dart',
    source: _source,
    flags: ["dio.get('/profile')"],
  );

  ruleTest(
    'allows the network layer to call Dio',
    rule: DirectDioRule.new,
    path: 'data/services/network/transport/dio_builder.dart',
    source: _source,
  );

  ruleTest(
    'ignores a same-named method on another type',
    rule: DirectDioRule.new,
    path: 'data/repositories/login_repository_impl.dart',
    source: '''
class Cache {
  void get(String key) {}
}

void load(Cache cache) {
  cache.get('profile');
}
''',
  );
}
