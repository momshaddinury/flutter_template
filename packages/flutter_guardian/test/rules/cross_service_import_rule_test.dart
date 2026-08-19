import 'package:flutter_guardian/rules/cross_service_import_rule.dart';

import '../support/harness.dart';

void main() {
  ruleTest(
    'flags a service importing another service',
    rule: CrossServiceImportRule.new,
    path: 'data/services/cache/cache_service.dart',
    source: "import '../network/rest_client.dart';\n",
    flags: ["import '../network/rest_client.dart';"],
    siblings: {'data/services/network/rest_client.dart': '// empty\n'},
  );

  ruleTest(
    'accepts an import within the same service',
    rule: CrossServiceImportRule.new,
    path: 'data/services/network/transport/dio_builder.dart',
    source: "import '../rest_client.dart';\n",
    siblings: {'data/services/network/rest_client.dart': '// empty\n'},
  );

  ruleTest(
    'ignores a repository composing services',
    rule: CrossServiceImportRule.new,
    path: 'data/repositories/login_repository_impl.dart',
    source: "import '../services/network/rest_client.dart';\n",
    siblings: {'data/services/network/rest_client.dart': '// empty\n'},
  );
}
