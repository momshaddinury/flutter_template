import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'rules/rules.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _FlutterGuardian();

/// A plugin class is used to list all the assists/lints defined by a plugin.
class _FlutterGuardian extends PluginBase {
  /// We list all the custom warnings/infos/errors
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    RepositoryNamingConvention(configs),
    UseCaseNamingConvention(configs),
    ServiceNamingConvention(configs),
  ];
}
