import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// A widget is named by its role, never by its layout. `_ReportDay`
/// says what the widget shows; `_DateRow` says how it is drawn today,
/// and that changes. Figma layer names such as `LogRow` yield too.
class LayoutNamedWidgetRule extends AnalysisRule {
  LayoutNamedWidgetRule()
    : super(
        name: 'layout_named_widget',
        description: 'Name a widget by its role, not by its layout.',
      );

  static const LintCode code = LintCode(
    'layout_named_widget',
    'A widget is named by its role, not by its layout.',
    correctionMessage:
        'Drop the Row, Column, or Stack suffix and name what it shows.',
    severity: DiagnosticSeverity.WARNING,
  );

  static final _layoutSuffix = RegExp(r'(Row|Column|Stack)$');

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addClassDeclaration(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final LayoutNamedWidgetRule rule;
  final RuleContext context;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final path = posixPath(context);
    if (!path.contains('/lib/src/presentation/')) return;
    if (!LayoutNamedWidgetRule._layoutSuffix.hasMatch(
      node.namePart.typeName.lexeme,
    )) {
      return;
    }
    rule.reportAtNode(node);
  }
}
