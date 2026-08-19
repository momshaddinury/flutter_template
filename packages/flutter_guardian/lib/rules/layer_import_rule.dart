import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// Enforces the Clean Architecture import directions: `domain/` imports
/// neither `data/` nor `presentation/` nor Flutter; `presentation/` and
/// `data/` never import each other. The domain layer is the center;
/// everything depends on it, never the reverse.
class LayerImportRule extends AnalysisRule {
  LayerImportRule()
    : super(
        name: 'invalid_layer_import',
        description:
            'Imports must follow the layer rules: domain imports neither '
            'data nor presentation nor Flutter; presentation and data '
            'never import each other.',
      );

  static const LintCode code = LintCode(
    'invalid_layer_import',
    'This import crosses a layer boundary the architecture forbids.',
    correctionMessage:
        'Route the dependency through the domain layer or a provider.',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addImportDirective(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final LayerImportRule rule;
  final RuleContext context;

  @override
  void visitImportDirective(ImportDirective node) {
    final path = posixPath(context);
    final uri = node.uri.stringValue;
    if (uri == null) return;

    final bool forbidden;
    if (path.contains('/lib/src/domain/')) {
      forbidden =
          _crossesInto(uri, 'data') ||
          _crossesInto(uri, 'presentation') ||
          uri.startsWith('package:flutter/');
    } else if (path.contains('/lib/src/presentation/')) {
      forbidden = _crossesInto(uri, 'data');
    } else if (path.contains('/lib/src/data/')) {
      forbidden = _crossesInto(uri, 'presentation');
    } else {
      forbidden = false;
    }

    if (forbidden) rule.reportAtNode(node);
  }

  /// Matches both relative crossings (`../../data/...`) and package-form
  /// imports of the layer.
  bool _crossesInto(String uri, String layer) =>
      uri.contains('/$layer/') || uri.contains('src/$layer/');
}
