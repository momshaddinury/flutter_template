import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// Enforces the DI lifetime table: providers in `di/parts/use_cases.dart`
/// are auto-disposed (`@riverpod`); providers in the repository, services,
/// and externals parts are `@Riverpod(keepAlive: true)`.
class DiLifetimeRule extends AnalysisRule {
  DiLifetimeRule()
    : super(
        name: 'invalid_di_lifetime',
        description:
            'Use-case providers are auto-disposed (@riverpod); repository, '
            'service, and external providers are @Riverpod(keepAlive: true).',
      );

  static const LintCode code = LintCode(
    'invalid_di_lifetime',
    'This provider does not follow the DI lifetime rule for its file.',
    correctionMessage:
        'Use @riverpod in use_cases.dart; @Riverpod(keepAlive: true) in '
        'repository.dart, services.dart, and externals.dart.',
    severity: DiagnosticSeverity.WARNING,
  );

  static const _keepAliveFiles = [
    'di/parts/repository.dart',
    'di/parts/services.dart',
    'di/parts/externals.dart',
  ];

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry.addFunctionDeclaration(this, visitor);
    registry.addClassDeclaration(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final DiLifetimeRule rule;
  final RuleContext context;

  void _checkMetadata(NodeList<Annotation> metadata) {
    final path = posixPath(context);
    final mustKeepAlive = DiLifetimeRule._keepAliveFiles.any(path.endsWith);
    final mustAutoDispose = path.endsWith('di/parts/use_cases.dart');
    if (!mustKeepAlive && !mustAutoDispose) return;

    for (final annotation in metadata) {
      final name = annotation.name.name;
      if (name == 'riverpod' && mustKeepAlive) {
        rule.reportAtNode(annotation);
      }
      if (name == 'Riverpod') {
        final source = annotation.toSource();
        final keepsAlive = source.contains('keepAlive: true');
        if (mustAutoDispose && keepsAlive) rule.reportAtNode(annotation);
        if (mustKeepAlive && !keepsAlive) rule.reportAtNode(annotation);
      }
    }
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    _checkMetadata(node.metadata);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _checkMetadata(node.metadata);
  }
}
