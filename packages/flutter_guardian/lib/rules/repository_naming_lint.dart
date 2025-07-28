part of 'rules.dart';

class RepositoryNamingConvention extends DartLintRule {
  const RepositoryNamingConvention(this.configs) : super(code: _code);

  final CustomLintConfigs configs;

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'invalid_repository_name',
    problemMessage: 'Names in a repository file must include "Repository".',
    correctionMessage: 'Try renaming to include "Repository"',
    errorSeverity: ErrorSeverity.ERROR,
  );

  bool _isInRepositoryFile(CustomLintResolver resolver) {
    return resolver.source.fullName.contains('di/parts/repository.dart');
  }

  void _checkNameAndReport({
    required String name,
    required AstNode node,
    required ErrorReporter reporter,
  }) {
    if (!name.contains('Repository')) {
      reporter.atNode(node, _code);
    }
  }

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclaration((node) {
      if (!_isInRepositoryFile(resolver)) return;
      _checkNameAndReport(
        name: node.name.lexeme,
        node: node,
        reporter: reporter,
      );
    });

    context.registry.addMethodDeclaration((node) {
      if (!_isInRepositoryFile(resolver)) return;
      _checkNameAndReport(
        name: node.name.lexeme,
        node: node,
        reporter: reporter,
      );
    });

    context.registry.addFunctionDeclaration((node) {
      if (!_isInRepositoryFile(resolver)) return;
      _checkNameAndReport(
        name: node.name.lexeme,
        node: node,
        reporter: reporter,
      );
    });
  }
}
