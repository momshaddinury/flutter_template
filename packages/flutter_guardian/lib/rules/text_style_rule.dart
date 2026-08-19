import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// The type scale reads in one place. Screens never compose text styles —
/// no `context.textStyle...copyWith(...)` at a call site; they say what a
/// line of text *is* with a typography widget, and the widget carries the
/// style and its colour. Flags `context.textStyle` anywhere in
/// presentation outside `core/widgets/text/` — the typography family —
/// and `core/theme/`, where the scale is defined and the component themes
/// consume it.
class TextStyleRule extends AnalysisRule {
  TextStyleRule()
    : super(
        name: 'text_style_outside_typography',
        description:
            'Text styles compose inside the typography widgets, never at '
            'a call site.',
      );

  static const LintCode code = LintCode(
    'text_style_outside_typography',
    'Text styles compose inside the typography widgets, never at a call '
    'site.',
    correctionMessage:
        'Use a widget from core/widgets/text/ (HeadingLevel1Text, '
        'BodySmallText, LabelText, ...), or add the variant the screen '
        'needs to the typography family.',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addPrefixedIdentifier(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final TextStyleRule rule;
  final RuleContext context;

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    // WHY: lexical on purpose, like the sibling rules — the template
    // always names the receiver `context`, and matching the name keeps
    // `style.textStyle` reads on a ButtonStyle out of the blast radius.
    if (node.prefix.name != 'context') return;
    if (node.identifier.name != 'textStyle') return;

    final path = posixPath(context);
    if (!path.contains('/lib/src/presentation/')) return;
    if (path.contains('/presentation/core/theme/')) return;
    if (path.contains('/presentation/core/widgets/text/')) return;

    rule.reportAtNode(node);
  }
}
