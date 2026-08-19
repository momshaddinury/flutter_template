import 'package:flutter_guardian/rules/text_style_rule.dart';

import '../support/harness.dart';

const _context = '''
class BuildContext {
  String get textStyle => '';
}

String read(BuildContext context) => context.textStyle;
''';

void main() {
  ruleTest(
    'flags context.textStyle in a screen',
    rule: TextStyleRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: _context,
    flags: ['context.textStyle'],
  );

  ruleTest(
    'allows the typography widgets to compose styles',
    rule: TextStyleRule.new,
    path: 'presentation/core/widgets/text/typography.dart',
    source: _context,
  );

  ruleTest(
    'allows the theme to compose styles',
    rule: TextStyleRule.new,
    path: 'presentation/core/theme/text_theme.dart',
    source: _context,
  );

  ruleTest(
    'ignores a same-named getter on another receiver',
    rule: TextStyleRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: '''
class ButtonStyle {
  String get textStyle => '';
}

String read(ButtonStyle style) => style.textStyle;
''',
  );
}
