part of 'rules.dart';

class UseCaseNamingConvention extends DartLintRule {
  const UseCaseNamingConvention(this.configs) : super(code: _code);

  final CustomLintConfigs configs;

  static const _code = LintCode(
    name: 'invalid_use_case_name',
    problemMessage: 'Names in a use case file must include "UseCase".',
    correctionMessage: 'Try renaming to include "UseCase"',
    errorSeverity: ErrorSeverity.ERROR,
  );

  bool _isInUseCaseFile(CustomLintResolver resolver) {
    return resolver.source.fullName.contains('di/parts/use_cases.dart');
  }

  void _checkNameAndReport({
    required String name,
    required AstNode node,
    required ErrorReporter reporter,
  }) {
    if (!name.contains('UseCase')) {
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
      if (!_isInUseCaseFile(resolver)) return;
      _checkNameAndReport(
        name: node.name.lexeme,
        node: node,
        reporter: reporter,
      );
    });

    context.registry.addMethodDeclaration((node) {
      if (!_isInUseCaseFile(resolver)) return;
      _checkNameAndReport(
        name: node.name.lexeme,
        node: node,
        reporter: reporter,
      );
    });

    context.registry.addFunctionDeclaration((node) {
      if (!_isInUseCaseFile(resolver)) return;
      _checkNameAndReport(
        name: node.name.lexeme,
        node: node,
        reporter: reporter,
      );
    });
  }
}
