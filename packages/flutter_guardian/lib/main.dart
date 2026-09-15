import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'rules/collection_branch_rule.dart';
import 'rules/cross_feature_import_rule.dart';
import 'rules/cross_service_import_rule.dart';
import 'rules/di_lifetime_rule.dart';
import 'rules/di_naming_rule.dart';
import 'rules/direct_dio_rule.dart';
import 'rules/hardcoded_design_value_rule.dart';
import 'rules/hardcoded_text_rule.dart';
import 'rules/layer_import_rule.dart';
import 'rules/layout_named_widget_rule.dart';
import 'rules/route_literal_rule.dart';
import 'rules/svg_icon_rule.dart';
import 'rules/text_style_rule.dart';
import 'rules/top_level_presenter_rule.dart';
import 'rules/widget_helper_rule.dart';

/// The entry point the Dart analysis server looks for: a top-level
/// variable named [plugin].
final plugin = FlutterGuardianPlugin();

/// The template's development rules, registered as warnings.
/// Run `fvm dart analyze` to load the native plugin and enforce them.
class FlutterGuardianPlugin extends Plugin {
  @override
  String get name => 'flutter_guardian';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(RepositoryNamingRule());
    registry.registerWarningRule(UseCaseNamingRule());
    registry.registerWarningRule(ServiceNamingRule());
    registry.registerWarningRule(LayerImportRule());
    registry.registerWarningRule(DiLifetimeRule());
    registry.registerWarningRule(RouteLiteralRule());
    registry.registerWarningRule(DirectDioRule());
    registry.registerWarningRule(WidgetHelperRule());
    registry.registerWarningRule(HardcodedTextRule());
    registry.registerWarningRule(HardcodedDesignValueRule());
    registry.registerWarningRule(CrossFeatureImportRule());
    registry.registerWarningRule(CrossServiceImportRule());
    registry.registerWarningRule(SvgIconRule());
    registry.registerWarningRule(TextStyleRule());
    registry.registerWarningRule(CollectionBranchRule());
    registry.registerWarningRule(LayoutNamedWidgetRule());
    registry.registerWarningRule(TopLevelPresenterRule());
  }
}
