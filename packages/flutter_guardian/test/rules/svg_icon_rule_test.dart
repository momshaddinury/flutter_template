import 'package:flutter_guardian/rules/svg_icon_rule.dart';

import '../support/harness.dart';

const _widget = 'presentation/core/widgets/svg_icon.dart';
const _screen = 'presentation/features/login/view/login_page.dart';
const _generated = 'presentation/core/gen/assets.gen.dart';

void main() {
  ruleTest(
    'flags a .svg literal in a presentation file',
    rule: SvgIconRule.new,
    path: _screen,
    source: "const icon = 'assets/icons/placeholder.svg';\n",
    flags: ["'assets/icons/placeholder.svg'"],
  );

  ruleTest(
    'leaves the SVG door widget alone',
    rule: SvgIconRule.new,
    path: _widget,
    source: "const icon = 'assets/icons/placeholder.svg';\n",
  );

  ruleTest(
    'leaves the generated assets file alone',
    rule: SvgIconRule.new,
    path: _generated,
    source: "const icon = 'assets/icons/placeholder.svg';\n",
  );

  ruleTest(
    'ignores a literal outside presentation',
    rule: SvgIconRule.new,
    path: 'data/services/cache/cache_service.dart',
    source: "const icon = 'assets/icons/placeholder.svg';\n",
  );

  ruleTest(
    'flags a flutter_svg import outside the door widget',
    rule: SvgIconRule.new,
    path: _screen,
    source: "import 'package:flutter_svg/flutter_svg.dart';\n",
    flags: ["import 'package:flutter_svg/flutter_svg.dart';"],
    packages: ['flutter_svg'],
  );

  ruleTest(
    'allows a flutter_svg import in the door widget',
    rule: SvgIconRule.new,
    path: _widget,
    source: "import 'package:flutter_svg/flutter_svg.dart';\n",
    packages: ['flutter_svg'],
  );

  ruleTest(
    'ignores a package whose name merely starts with flutter_svg',
    rule: SvgIconRule.new,
    path: _screen,
    source:
        "import 'package:flutter_svg_provider/flutter_svg_provider.dart';\n",
    packages: ['flutter_svg_provider'],
  );
}
