import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'rules/rules.dart';

/// The entrypoint of the flutter_guardian custom linter plugin.
PluginBase createPlugin() => _FlutterGuardian();

/// A plugin class used to list all the assists/lints defined by this plugin.
class _FlutterGuardian extends PluginBase {
  /// Returns all custom lint rules registered with this plugin.
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    RepositoryNamingConvention(configs),
    UseCaseNamingConvention(configs),
    ServiceNamingConvention(configs),
    MaxFileLinesRule(configs),
    MaxMethodLinesRule(configs),
  ];
}
