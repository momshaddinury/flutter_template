import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// Design values come from the theme tokens (`context.color`,
/// `context.textStyle`, `context.dimensions`), never from numeric
/// literals. Flags `Color`, `EdgeInsets`, and `TextStyle` constructors
/// carrying a numeric literal argument, everywhere in presentation
/// except the theme itself — the one place literals are defined.
class HardcodedDesignValueRule extends AnalysisRule {
  HardcodedDesignValueRule()
    : super(
        name: 'hardcoded_design_value',
        description:
            'Colors, spacing, and text styles come from the theme tokens, '
            'not numeric literals.',
      );

  static const LintCode code = LintCode(
    'hardcoded_design_value',
    'Design values come from the theme tokens, not numeric literals.',
    correctionMessage:
        'Use context.color / context.textStyle / context.dimensions, or '
        'add a token to the theme.',
    severity: DiagnosticSeverity.WARNING,
  );

  static const _designTypes = {'Color', 'EdgeInsets', 'TextStyle'};

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addInstanceCreationExpression(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final HardcodedDesignValueRule rule;
  final RuleContext context;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final path = posixPath(context);
    if (!path.contains('/lib/src/presentation/')) return;
    if (path.contains('/presentation/core/theme/')) return;

    final typeName = node.constructorName.type.name.lexeme;
    if (!HardcodedDesignValueRule._designTypes.contains(typeName)) return;

    for (final argument in node.argumentList.arguments) {
      final expression = argument.argumentExpression;
      if (expression is IntegerLiteral || expression is DoubleLiteral) {
        rule.reportAtNode(argument);
      }
    }
  }
}
