import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../src/paths.dart';

/// Base for the DI naming conventions: every declaration in the given
/// DI parts file must carry the layer's suffix in its name. The rules
/// differ only in which file they scope to and which substring they
/// require, so the traversal lives here once.
abstract class DiNamingRule extends AnalysisRule {
  DiNamingRule({
    required super.name,
    required super.description,
    required this.pathSuffix,
    required this.requiredSubstring,
  });

  /// The DI parts file this rule scopes to, matched as a path suffix.
  final String pathSuffix;

  /// The substring every declared name in that file must contain.
  final String requiredSubstring;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _DeclarationNameVisitor(this, context);
    registry.addVariableDeclaration(this, visitor);
    registry.addMethodDeclaration(this, visitor);
    registry.addFunctionDeclaration(this, visitor);
  }

  bool _applies(RuleContext context) {
    final path = posixPath(context);

    return path.endsWith(pathSuffix);
  }
}

class _DeclarationNameVisitor extends SimpleAstVisitor<void> {
  _DeclarationNameVisitor(this.rule, this.context);

  final DiNamingRule rule;
  final RuleContext context;

  void _check(String name, AstNode node) {
    if (!rule._applies(context)) return;
    if (!name.contains(rule.requiredSubstring)) {
      rule.reportAtNode(node);
    }
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    // Only top-level `final xProvider = ...;` declarations — a local
    // variable inside a provider body is not a DI declaration.
    final list = node.parent;
    if (list is! VariableDeclarationList) return;
    if (list.parent is! TopLevelVariableDeclaration) return;
    _check(node.name.lexeme, node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    _check(node.name.lexeme, node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    // Only top-level functions — helpers nested inside another body are
    // not DI declarations.
    if (node.parent is! CompilationUnit) return;
    _check(node.name.lexeme, node);
  }
}

class RepositoryNamingRule extends DiNamingRule {
  RepositoryNamingRule()
    : super(
        name: 'invalid_repository_name',
        description:
            'Names in the repository DI file must include '
            '"Repository".',
        pathSuffix: 'di/parts/repository.dart',
        requiredSubstring: 'Repository',
      );

  static const LintCode code = LintCode(
    'invalid_repository_name',
    'Names in a repository file must include "Repository".',
    correctionMessage: 'Try renaming to include "Repository".',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;
}

class UseCaseNamingRule extends DiNamingRule {
  UseCaseNamingRule()
    : super(
        name: 'invalid_use_case_name',
        description: 'Names in the use-case DI file must include "UseCase".',
        pathSuffix: 'di/parts/use_cases.dart',
        requiredSubstring: 'UseCase',
      );

  static const LintCode code = LintCode(
    'invalid_use_case_name',
    'Names in a use case file must include "UseCase".',
    correctionMessage: 'Try renaming to include "UseCase".',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;
}

class ServiceNamingRule extends DiNamingRule {
  ServiceNamingRule()
    : super(
        name: 'invalid_service_name',
        description: 'Names in the services DI file must include "Service".',
        pathSuffix: 'di/parts/services.dart',
        requiredSubstring: 'Service',
      );

  static const LintCode code = LintCode(
    'invalid_service_name',
    'Names in a service file must include "Service".',
    correctionMessage: 'Try renaming to include "Service".',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;
}
