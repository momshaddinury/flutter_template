import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'rules/di_naming_rule.dart';

/// The entry point the Dart analysis server looks for: a top-level
/// variable named [plugin].
final plugin = FlutterGuardianPlugin();

/// Naming-convention rules for the template's dependency-injection
/// layers. Registered as warning rules so they are enabled by default —
/// `flutter analyze` treats warnings as fatal, which is what makes the
/// conventions gate builds without any consumer configuration.
class FlutterGuardianPlugin extends Plugin {
  @override
  String get name => 'flutter_guardian';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(RepositoryNamingRule());
    registry.registerWarningRule(UseCaseNamingRule());
    registry.registerWarningRule(ServiceNamingRule());
  }
}
