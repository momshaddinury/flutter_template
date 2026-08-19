import 'package:flutter_guardian/rules/layer_import_rule.dart';

import '../support/harness.dart';

void main() {
  ruleTest(
    'flags Flutter in the domain layer',
    rule: LayerImportRule.new,
    path: 'domain/entities/login_entity.dart',
    source: "import 'package:flutter/flutter.dart';\n",
    flags: ["import 'package:flutter/flutter.dart';"],
    packages: ['flutter'],
  );

  ruleTest(
    'flags domain reaching into data',
    rule: LayerImportRule.new,
    path: 'domain/entities/login_entity.dart',
    source: "import '../../data/models/login_model.dart';\n",
    flags: ["import '../../data/models/login_model.dart';"],
    siblings: {'data/models/login_model.dart': '// empty\n'},
  );

  ruleTest(
    'flags presentation reaching into data',
    rule: LayerImportRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "import '../../../../data/models/login_model.dart';\n",
    flags: ["import '../../../../data/models/login_model.dart';"],
    siblings: {'data/models/login_model.dart': '// empty\n'},
  );

  ruleTest(
    'flags data reaching into presentation',
    rule: LayerImportRule.new,
    path: 'data/repositories/login_repository_impl.dart',
    source: "import '../../presentation/core/theme/theme.dart';\n",
    flags: ["import '../../presentation/core/theme/theme.dart';"],
    siblings: {'presentation/core/theme/theme.dart': '// empty\n'},
  );

  ruleTest(
    'accepts data importing domain',
    rule: LayerImportRule.new,
    path: 'data/repositories/login_repository_impl.dart',
    source: "import '../../domain/entities/login_entity.dart';\n",
    siblings: {'domain/entities/login_entity.dart': '// empty\n'},
  );

  ruleTest(
    'accepts presentation importing Flutter',
    rule: LayerImportRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "import 'package:flutter/flutter.dart';\n",
    packages: ['flutter'],
  );
}
