import 'package:flutter_guardian/rules/hardcoded_text_rule.dart';

import '../support/harness.dart';

const _text = '''
class Text {
  const Text(this.data);

  final String data;
}

class BodySmallText extends Text {
  const BodySmallText(super.data);
}
''';

void main() {
  ruleTest(
    'flags a literal handed to Text',
    rule: HardcodedTextRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "$_text\nfinal title = Text('Sign in');\n",
    flags: ["'Sign in'"],
  );

  ruleTest(
    'flags a literal handed to a typography widget',
    rule: HardcodedTextRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "$_text\nfinal title = BodySmallText('Sign in');\n",
    flags: ["'Sign in'"],
  );

  ruleTest(
    'accepts copy taken from a variable',
    rule: HardcodedTextRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: "$_text\nconst copy = 'Sign in';\nfinal title = Text(copy);\n",
  );

  ruleTest(
    'ignores a literal outside presentation',
    rule: HardcodedTextRule.new,
    path: 'data/repositories/login_repository_impl.dart',
    source: "$_text\nfinal title = Text('Sign in');\n",
  );
}
