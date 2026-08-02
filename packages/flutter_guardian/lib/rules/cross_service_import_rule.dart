import 'package:analyzer/error/error.dart';

import 'sibling_isolation_rule.dart';

/// Services are isolated: a file under `data/services/<x>/` never
/// imports from another service's directory. Composition happens one
/// level up — repositories may depend on several services; the services
/// themselves stay independent so each can be understood, tested, and
/// replaced alone.
class CrossServiceImportRule extends SiblingIsolationRule {
  CrossServiceImportRule()
    : super(
        name: 'cross_service_import',
        description:
            'Services never import from another service. Repositories '
            'compose services; services stay independent.',
        marker: 'data/services/',
      );

  static const LintCode code = LintCode(
    'cross_service_import',
    'Services are isolated — this import reaches into another service.',
    correctionMessage:
        'Compose the services in a repository instead of coupling them, '
        'or move the shared piece to core.',
    severity: DiagnosticSeverity.WARNING,
  );

  @override
  LintCode get diagnosticCode => code;
}
