part of 'rules.dart';

class MaxFileLinesRule extends DartLintRule {
  // WHY: Factory constructor parses maxLines from configs before delegating to
  // the private constructor, which needs maxLines at init time for the LintCode message.
  factory MaxFileLinesRule(CustomLintConfigs configs) {
    final options = configs.rules['max_file_lines']?.json;
    final maxLines = options?['max_lines'] as int? ?? 150;
    return MaxFileLinesRule._(maxLines);
  }

  MaxFileLinesRule._(this.maxLines)
    : super(
        code: LintCode(
          name: 'max_file_lines',
          problemMessage:
              'File exceeds $maxLines lines. Split into smaller files.',
          correctionMessage:
              'Extract widgets, utilities, or classes into separate files.',
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
    context.registry.addCompilationUnit((CompilationUnit node) {
      final lineCount = resolver.lineInfo.lineCount;

      if (lineCount > maxLines) {
        reporter.atNode(node, code);
      }
    });
  }
}
