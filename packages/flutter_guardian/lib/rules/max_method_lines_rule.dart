part of 'rules.dart';

class MaxMethodLinesRule extends DartLintRule {
  // WHY: Factory constructor parses maxLines from configs before delegating to
  // the private constructor, which needs maxLines at init time for the LintCode message.
  factory MaxMethodLinesRule(CustomLintConfigs configs) {
    final options = configs.rules['max_method_lines']?.json;
    final maxLines = options?['max_lines'] as int? ?? 30;
    return MaxMethodLinesRule._(maxLines);
  }

  MaxMethodLinesRule._(this.maxLines)
    : super(
        code: LintCode(
          name: 'max_method_lines',
          problemMessage:
              'Method/function exceeds $maxLines lines. Break it into smaller functions.',
          correctionMessage:
              'Extract logic into private helper methods or separate use cases.',
          errorSeverity: ErrorSeverity.WARNING,
        ),
      );

  final int maxLines;

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry
      ..addMethodDeclaration((MethodDeclaration node) {
        _checkNodeLength(node, node.name, resolver, reporter);
      })
      ..addFunctionDeclaration((FunctionDeclaration node) {
        _checkNodeLength(node, node.name, resolver, reporter);
      });
  }

  void _checkNodeLength(
    AstNode node,
    // WHY: dynamic Token — method/function name used for precise error highlighting
    dynamic nameToken,
    CustomLintResolver resolver,
    ErrorReporter reporter,
  ) {
    final body = _extractBody(node);
    if (body == null || body is EmptyFunctionBody) return;

    final startLine = resolver.lineInfo.getLocation(body.offset).lineNumber;
    final endLine = resolver.lineInfo.getLocation(body.end).lineNumber;
    final lineCount = endLine - startLine + 1;

    if (lineCount > maxLines) {
      reporter.atToken(nameToken, code);
    }
  }

  FunctionBody? _extractBody(AstNode node) {
    if (node is MethodDeclaration) return node.body;
    if (node is FunctionDeclaration) return node.functionExpression.body;
    return null;
  }
}
