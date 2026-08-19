import 'package:flutter_guardian/rules/route_literal_rule.dart';

import '../support/harness.dart';

const _goRoute = '''
class GoRoute {
  const GoRoute({this.path, this.name});

  final String? path;
  final String? name;
}
''';

const _context = '''
class BuildContext {
  void pushNamed(String name) {}
}
''';

void main() {
  ruleTest(
    'flags a literal GoRoute path',
    rule: RouteLiteralRule.new,
    path: 'presentation/core/router/router.dart',
    source: "$_goRoute\nfinal route = GoRoute(path: '/login');\n",
    flags: ["path: '/login'"],
  );

  ruleTest(
    'flags a literal GoRoute name',
    rule: RouteLiteralRule.new,
    path: 'presentation/core/router/router.dart',
    source: "$_goRoute\nfinal route = GoRoute(name: 'login');\n",
    flags: ["name: 'login'"],
  );

  ruleTest(
    'accepts a GoRoute path taken from a constant',
    rule: RouteLiteralRule.new,
    path: 'presentation/core/router/router.dart',
    source:
        "$_goRoute\nconst login = '/login';\nfinal r = GoRoute(path: login);\n",
  );

  ruleTest(
    'flags a literal handed to pushNamed',
    rule: RouteLiteralRule.new,
    path: 'presentation/features/login/view/login_page.dart',
    source:
        "$_context\nvoid go(BuildContext context) {\n  context.pushNamed('home');\n}\n",
    flags: ["'home'"],
  );
}
