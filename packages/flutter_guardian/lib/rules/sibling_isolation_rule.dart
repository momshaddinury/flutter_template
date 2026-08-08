import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Base for isolation rules over sibling directories: a file inside
/// `<marker><x>/` must not import from `<marker><y>/`. Features and
/// services share this shape; the concrete rules supply the marker and
/// the diagnostic.
abstract class SiblingIsolationRule extends AnalysisRule {
  SiblingIsolationRule({
    required super.name,
    required super.description,
    required this.marker,
  });

  /// The path segment the isolated siblings live under, without a
  /// leading slash — matched in both file paths and package-form import
  /// URIs (for example `presentation/features/` or `data/services/`).
  final String marker;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addImportDirective(this, SiblingIsolationVisitor(this, context));
  }

  /// The sibling-directory name following [marker], or null when the
  /// path is outside the marked tree.
  String? siblingOf(String path) {
    final index = path.indexOf(marker);
    if (index == -1) return null;
    final segment = path.substring(index + marker.length).split('/').first;

    return segment.isEmpty ? null : segment;
  }
}

class SiblingIsolationVisitor extends SimpleAstVisitor<void> {
  SiblingIsolationVisitor(this.rule, this.context);

  final SiblingIsolationRule rule;
  final RuleContext context;

  @override
  void visitImportDirective(ImportDirective node) {
    // WHY: the analyzer hands back native separators on Windows, while
    // marker and _resolveRelative work in '/' — normalize once here so
    // every downstream match sees posix form.
    final path = (context.currentUnit ?? context.definingUnit).file.path
        .replaceAll(r'\', '/');
    final current = rule.siblingOf(path);
    if (current == null) return;

    final uri = node.uri.stringValue;
    if (uri == null) return;

    final imported = uri.startsWith('package:')
        ? rule.siblingOf(uri)
        : rule.siblingOf(_resolveRelative(path, uri));

    if (imported != null && imported != current) {
      rule.reportAtNode(node);
    }
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
