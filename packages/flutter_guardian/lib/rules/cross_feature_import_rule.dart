import 'package:analyzer/error/error.dart';

import 'sibling_isolation_rule.dart';

/// Features are isolated: a file under `presentation/features/<x>/` never
/// imports from another feature's directory — most importantly not its
/// Riverpod providers. Shared state lives in
/// `presentation/core/application_state/` (readable by every feature),
/// and cross-feature reactivity goes through a domain use case.
class CrossFeatureImportRule extends SiblingIsolationRule {
  CrossFeatureImportRule()
    : super(
        name: 'cross_feature_import',
        description:
            'Features never import from another feature. Shared state '
            'belongs in presentation/core/application_state; shared '
            'widgets in presentation/core/widgets.',
        marker: 'presentation/features/',
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
}
