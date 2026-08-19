import 'package:flutter_guardian/rules/widget_helper_rule.dart';

import '../support/harness.dart';

const _widget = 'class Widget {}\n';

void main() {
  ruleTest(
    'flags a top-level function returning Widget',
    rule: WidgetHelperRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: '${_widget}Widget buildHeader() => Widget();\n',
    flags: ['Widget buildHeader() => Widget();'],
  );

  ruleTest(
    'flags a method returning Widget',
    rule: WidgetHelperRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: '${_widget}class Page {\n  Widget header() => Widget();\n}\n',
    flags: ['Widget header() => Widget();'],
  );

  ruleTest(
    'accepts a build override',
    rule: WidgetHelperRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source: '${_widget}class Page {\n  Widget build() => Widget();\n}\n',
  );

  ruleTest(
    'ignores a helper outside presentation',
    rule: WidgetHelperRule.new,
    path: 'data/repositories/login_repository_impl.dart',
    source: '${_widget}Widget buildHeader() => Widget();\n',
  );
}
