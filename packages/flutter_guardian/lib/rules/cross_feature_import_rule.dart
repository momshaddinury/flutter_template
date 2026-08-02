import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Features are isolated: a file under `presentation/features/<x>/` never
/// imports from another feature's directory — most importantly not its
/// Riverpod providers. Shared state lives in
/// `presentation/core/application_state/` (readable by every feature),
/// and cross-feature reactivity goes through a domain use case.
class CrossFeatureImportRule extends AnalysisRule {
  CrossFeatureImportRule()
    : super(
        name: 'cross_feature_import',
        description:
            'Features never import from another feature. Shared state '
            'belongs in presentation/core/application_state; shared '
            'widgets in presentation/core/widgets.',
      );

  static const LintCode code = LintCode(
    'cross_feature_import',
    'Features are isolated — this import reaches into another feature.',
    correctionMessage:
        'Move shared state to presentation/core/application_state, shared '
        'widgets to presentation/core/widgets, or route the dependency '
        'through a domain use case.',
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

  final CrossFeatureImportRule rule;
  final RuleContext context;

  static const _marker = '/presentation/features/';

  @override
  void visitImportDirective(ImportDirective node) {
    final path = (context.currentUnit ?? context.definingUnit).file.path;
    final currentFeature = _featureOf(path);
    if (currentFeature == null) return;

    final uri = node.uri.stringValue;
    if (uri == null) return;

    final importedFeature = uri.startsWith('package:')
        ? _featureOf(uri.replaceFirst('package:', '/'))
        : _featureOf(_resolveRelative(path, uri));

    if (importedFeature != null && importedFeature != currentFeature) {
      rule.reportAtNode(node);
    }
  }

  /// The feature-directory segment following `presentation/features/`,
  /// or null when the path is outside the features tree.
  String? _featureOf(String path) {
    final index = path.indexOf(_marker);
    if (index == -1) {
      // Package-form URIs carry no leading slash before 'presentation'.
      final alt = path.indexOf('presentation/features/');
      if (alt == -1) return null;
      final rest = path.substring(alt + 'presentation/features/'.length);

      return rest.split('/').first;
    }
    final rest = path.substring(index + _marker.length);

    return rest.split('/').first;
  }

  /// Resolves a relative import against the importing file's directory
  /// without touching the file system.
  String _resolveRelative(String filePath, String uri) {
    final segments = filePath.split('/')..removeLast();
    for (final part in uri.split('/')) {
      if (part == '..') {
        if (segments.isNotEmpty) segments.removeLast();
      } else if (part != '.' && part.isNotEmpty) {
        segments.add(part);
      }
    }

    return segments.join('/');
  }
}
