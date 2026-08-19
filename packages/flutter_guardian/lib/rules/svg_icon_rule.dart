import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Icons have one door. Standard glyphs stay Material `Icons.*`; an icon
/// exported from the design file lands in `assets/icons/`, becomes a
/// generated `Assets.icons` entry, and renders through the `SvgIcon`
/// widget — the one file allowed to touch `flutter_svg`.
///
/// Flags an import of `flutter_svg` anywhere but `svg_icon.dart`, and a
/// `.svg` string literal anywhere in presentation but `svg_icon.dart` and
/// the generated assets file. The first keeps rendering in one place; the
/// second keeps asset paths out of widgets, where a typo becomes a
/// runtime error instead of a compile error.
class SvgIconRule extends AnalysisRule {
  SvgIconRule()
    : super(
        name: 'svg_outside_svg_icon',
        description:
            'SVG assets render through the SvgIcon widget, never directly.',
      );

  static const LintCode code = LintCode(
    'svg_outside_svg_icon',
    'SVG assets render through the SvgIcon widget, never directly.',
    correctionMessage:
        'Use Icons.* for standard glyphs. For a bespoke icon, add the file '
        'to assets/icons/, run build_runner, and pass Assets.icons.<name> '
        'to SvgIcon.',
    severity: DiagnosticSeverity.WARNING,
  );

  static const String _sanctionedFile =
      '/lib/src/presentation/core/widgets/svg_icon.dart';

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry.addImportDirective(this, visitor);
    registry.addSimpleStringLiteral(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final SvgIconRule rule;
  final RuleContext context;

  String get _path => (context.currentUnit ?? context.definingUnit).file.path;

  @override
  void visitImportDirective(ImportDirective node) {
    final uri = node.uri.stringValue;
    if (uri == null || !uri.startsWith('package:flutter_svg')) return;
    if (_path.endsWith(SvgIconRule._sanctionedFile)) return;
    // WHY: the generated assets file wraps flutter_svg on SvgIcon's
    // behalf; flagging it would flag every build_runner pass.
    if (_path.contains('/presentation/core/gen/')) return;

    rule.reportAtNode(node);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    if (!node.value.endsWith('.svg')) return;

    final path = _path;
    if (!path.contains('/lib/src/presentation/')) return;
    if (path.endsWith(SvgIconRule._sanctionedFile)) return;
    // WHY: the generated assets file is where the real paths live; the
    // rule exists to push widgets toward its typed accessors.
    if (path.contains('/presentation/core/gen/')) return;

    rule.reportAtNode(node);
  }
}
