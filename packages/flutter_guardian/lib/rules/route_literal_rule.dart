import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Route paths and names exist only on the `Routes` enum. This rule flags
/// string literals handed to `GoRoute(path:/name:)` or to the named
/// navigation methods — the drift the enum exists to prevent.
class RouteLiteralRule extends AnalysisRule {
  RouteLiteralRule()
    : super(
        name: 'hardcoded_route',
        description:
            'Route paths and names come from the Routes enum, never from '
            'string literals.',
      );

  static const LintCode code = LintCode(
    'hardcoded_route',
    'Route paths and names come from the Routes enum, not string literals.',
    correctionMessage:
        'Use Routes.<member>.path for GoRoute.path and '
        'Routes.<member>.name for named navigation.',
    severity: DiagnosticSeverity.WARNING,
  );

  static const _navigationMethods = {
    'pushNamed',
    'pushReplacementNamed',
    'goNamed',
    'pushNamedAndRemoveUntil',
  };

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this);
    registry.addInstanceCreationExpression(this, visitor);
    registry.addMethodInvocation(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final RouteLiteralRule rule;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.type.name.lexeme != 'GoRoute') return;
    for (final argument in node.argumentList.arguments) {
      if (argument is NamedArgument &&
          (argument.name.lexeme == 'path' || argument.name.lexeme == 'name') &&
          argument.argumentExpression is StringLiteral) {
        rule.reportAtNode(argument);
      }
    }
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (!RouteLiteralRule._navigationMethods.contains(node.methodName.name)) {
      return;
    }
    final arguments = node.argumentList.arguments;
    if (arguments.isEmpty) return;
    final first = arguments.first;
    if (first is! NamedArgument && first.argumentExpression is StringLiteral) {
      rule.reportAtNode(first);
    }
  }
}
