import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// A sheet or dialog presenter belongs to its widget as a static method,
/// such as `DatePicker.showRange`. A top-level `showX` is a
/// global that nothing owns, and its result is usually untyped.
class TopLevelPresenterRule extends AnalysisRule {
  TopLevelPresenterRule()
    : super(
        name: 'top_level_presenter',
        description:
            'A presenter is a static method on its widget, not a '
            'top-level function.',
      );

  static const LintCode code = LintCode(
    'top_level_presenter',
    'A presenter is a static method on its widget, not a top-level '
        'function.',
    correctionMessage:
        'Move it onto the widget as `static Future<T> show(...)` and '
        'type the result.',
    severity: DiagnosticSeverity.WARNING,
  );

  static final _presenterName = RegExp(r'^show[A-Z]');

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addFunctionDeclaration(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final TopLevelPresenterRule rule;
  final RuleContext context;

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.parent is! CompilationUnit) return;
    final path = posixPath(context);
    if (!path.contains('/lib/src/presentation/')) return;
    if (!TopLevelPresenterRule._presenterName.hasMatch(node.name.lexeme)) {
      return;
    }
    rule.reportAtNode(node);
  }
}
