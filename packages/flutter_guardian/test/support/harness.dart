import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/error/error.dart';
// ignore: implementation_imports
import 'package:analyzer/src/diagnostic/diagnostic.dart' as diag;
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test/test.dart';

/// One rule resolved against an in-memory package laid out like the
/// template — `lib/src/<layer>/…`.
///
/// The layout carries meaning. Every rule scopes itself by matching
/// markers in the path of the file it visits, so a fixture only
/// exercises a rule when it sits where the real file would.
class _Harness extends AnalysisRuleTest {
  _Harness(AbstractAnalysisRule rule) {
    this.rule = rule;
  }

  /// A fixture that exists to carry one import has nothing to use it
  /// for, so the unused-import hint is noise here rather than a result.
  @override
  List<DiagnosticCode> get ignoredDiagnosticCodes => [
    ...super.ignoredDiagnosticCodes,
    diag.unusedImport,
  ];

  String at(String relative) => '$testPackageLibPath/src/$relative';
}

/// Runs [source] through [rule] as the file at `lib/src/[path]`, and
/// expects the rule to report exactly [flags] — each one a fragment of
/// the source, listed in the order it appears there. An empty [flags]
/// asserts the rule stays quiet.
///
/// [siblings] adds further files under `lib/src/`, for imports that have
/// to resolve. [packages] names packages whose `lib/<name>.dart` should
/// exist, for imports written in package form.
void ruleTest(
  String description, {
  required AbstractAnalysisRule Function() rule,
  required String path,
  required String source,
  List<String> flags = const [],
  Map<String, String> siblings = const {},
  List<String> packages = const [],
}) {
  test(description, () async {
    final harness = _Harness(rule());
    for (final name in packages) {
      harness.newPackage(name).addFile('lib/$name.dart', '');
    }
    harness.setUp();
    siblings.forEach(
      (sibling, content) => harness.newFile(harness.at(sibling), content),
    );

    final file = harness.at(path);
    harness.newFile(file, source);

    await harness.assertDiagnosticsInFile(file, [
      for (final (offset, length) in _spans(source, flags))
        harness.lint(offset, length),
    ]);
  });
}

/// Offset and length of every fragment in [flags], each searched for
/// after the previous match so a repeated fragment still lands on the
/// occurrence the test means.
Iterable<(int, int)> _spans(String source, List<String> flags) sync* {
  var from = 0;
  for (final flag in flags) {
    final offset = source.indexOf(flag, from);
    if (offset == -1) {
      throw ArgumentError('the fixture never contains "$flag"');
    }
    yield (offset, flag.length);
    from = offset + flag.length;
  }
}
