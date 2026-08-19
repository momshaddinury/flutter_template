import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// User-facing copy comes from the localization files, never from string
/// literals in widgets. Flags a string literal as the first positional
/// argument of `Text` or any `*Text` wrapper (the typography widgets).
class HardcodedTextRule extends AnalysisRule {
  HardcodedTextRule()
    : super(
        name: 'hardcoded_text',
        description:
            'User-facing strings come from context.locale, not literals.',
      );

  static const LintCode code = LintCode(
    'hardcoded_text',
    'User-facing text must come from the localization files.',
    correctionMessage:
        'Add the string to every ARB file and use context.locale.<key>.',
    severity: DiagnosticSeverity.WARNING,
  );

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

  final HardcodedTextRule rule;
  final RuleContext context;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final path = posixPath(context);
    if (!path.contains('/lib/src/presentation/')) return;

    final typeName = node.constructorName.type.name.lexeme;
    if (typeName != 'Text' && !typeName.endsWith('Text')) return;

    final arguments = node.argumentList.arguments;
    if (arguments.isEmpty) return;
    final first = arguments.first;
    if (first is! NamedArgument && first.argumentExpression is StringLiteral) {
      rule.reportAtNode(first);
    }
  }
}
