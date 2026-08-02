import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Widget-building helper methods defeat the element tree's ability to
/// cache and rebuild granularly. UI fragments are extracted to widget
/// classes (`_PascalCase` part widgets), never to functions or methods
/// returning `Widget`.
class WidgetHelperRule extends AnalysisRule {
  WidgetHelperRule()
    : super(
        name: 'widget_returning_helper',
        description:
            'Extract UI to a widget class, not to a helper function or '
            'method returning Widget.',
      );

  static const LintCode code = LintCode(
    'widget_returning_helper',
    'Helper functions returning Widget defeat element-tree optimization.',
    correctionMessage: 'Extract the fragment to a widget class instead.',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry.addFunctionDeclaration(this, visitor);
    registry.addMethodDeclaration(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final WidgetHelperRule rule;
  final RuleContext context;

  bool _inPresentation() => (context.currentUnit ?? context.definingUnit)
      .file
      .path
      .contains('/lib/src/presentation/');

  bool _returnsWidget(TypeAnnotation? returnType) =>
      returnType is NamedType && returnType.name.lexeme == 'Widget';

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (!_inPresentation()) return;
    if (_returnsWidget(node.returnType)) rule.reportAtNode(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (!_inPresentation()) return;
    // `build` overrides are the framework contract, not helpers.
    if (node.name.lexeme == 'build') return;
    if (_returnsWidget(node.returnType)) rule.reportAtNode(node);
  }
}
