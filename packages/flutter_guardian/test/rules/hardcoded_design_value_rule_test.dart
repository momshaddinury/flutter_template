import 'package:flutter_guardian/rules/hardcoded_design_value_rule.dart';

import '../support/harness.dart';

const _tokens = '''
class EdgeInsets {
  const EdgeInsets.all(this.value);

  final double value;
}

class Color {
  const Color(this.value);

  final int value;
}
''';

void main() {
  ruleTest(
    'flags a numeric literal in EdgeInsets',
    rule: HardcodedDesignValueRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: '$_tokens\nconst padding = EdgeInsets.all(8);\n',
    flags: ['8'],
  );

  ruleTest(
    'flags a numeric literal in Color',
    rule: HardcodedDesignValueRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: '$_tokens\nconst brand = Color(255);\n',
    flags: ['255'],
  );

  ruleTest(
    'accepts a token read from a constant',
    rule: HardcodedDesignValueRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source:
        '$_tokens\nconst space = 8.0;\nconst padding = EdgeInsets.all(space);\n',
  );

  ruleTest(
    'allows the theme to define literals',
    rule: HardcodedDesignValueRule.new,
    path: 'presentation/core/theme/dimensions.dart',
    source: '$_tokens\nconst padding = EdgeInsets.all(8);\n',
  );
}
