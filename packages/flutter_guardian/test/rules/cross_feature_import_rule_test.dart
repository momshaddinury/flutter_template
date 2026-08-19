import 'package:flutter_guardian/rules/cross_feature_import_rule.dart';

import '../support/harness.dart';

void main() {
  ruleTest(
    'flags a feature importing another feature',
    rule: CrossFeatureImportRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "import '../../profile/view/profile_page.dart';\n",
    flags: ["import '../../profile/view/profile_page.dart';"],
    siblings: {
      'presentation/features/profile/view/profile_page.dart': '// empty\n',
    },
  );

  ruleTest(
    'accepts an import within the same feature',
    rule: CrossFeatureImportRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "import '../widgets/login_form.dart';\n",
    siblings: {
      'presentation/features/login/widgets/login_form.dart': '// empty\n',
    },
  );

  ruleTest(
    'accepts a feature importing shared core',
    rule: CrossFeatureImportRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "import '../../../core/widgets/svg_icon.dart';\n",
    siblings: {'presentation/core/widgets/svg_icon.dart': '// empty\n'},
  );
}
