import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// An `if` or `for` inside a list literal wraps its branch in `...[ ]`.
/// The wrap makes the branch a block: adding a second child is a new
/// line, not a restructure, and nested branches read the same at every
/// level.
class CollectionBranchRule extends AnalysisRule {
  CollectionBranchRule()
    : super(
        name: 'unwrapped_collection_branch',
        description:
            'Wrap the branch of an if or for inside a list literal in a '
            '...[ ] spread.',
      );

  static const LintCode code = LintCode(
    'unwrapped_collection_branch',
    'An if or for inside a list literal wraps its branch in `...[ ]`.',
    correctionMessage: 'Write `if (x) ...[child]` or `for (...) ...[child]`.',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this);
    registry.addIfElement(this, visitor);
    registry.addForElement(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule);

  final CollectionBranchRule rule;

  static bool _wrapped(CollectionElement element) =>
      element is SpreadElement && element.expression is ListLiteral;

  @override
  void visitIfElement(IfElement node) {
    if (node.parent is! ListLiteral) return;
    if (!_wrapped(node.thenElement)) rule.reportAtNode(node.thenElement);
    final elseElement = node.elseElement;
    if (elseElement == null || elseElement is IfElement) return;
    if (!_wrapped(elseElement)) rule.reportAtNode(elseElement);
  }

  @override
  void visitForElement(ForElement node) {
    if (node.parent is! ListLiteral) return;
    if (!_wrapped(node.body)) rule.reportAtNode(node.body);
  }
}
