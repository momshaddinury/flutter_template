import 'package:flutter_guardian/rules/collection_branch_rule.dart';
import 'package:flutter_guardian/rules/layout_named_widget_rule.dart';
import 'package:flutter_guardian/rules/top_level_presenter_rule.dart';

import '../support/harness.dart';

void main() {
  ruleTest(
    'flags a presentation class named by layout',
    rule: LayoutNamedWidgetRule.new,
    path: 'presentation/features/catalog/view/catalog_page.dart',
    source: 'class CatalogRow {}',
    flags: ['class CatalogRow {}'],
  );
  ruleTest(
    'accepts a presentation class named by role',
    rule: LayoutNamedWidgetRule.new,
    path: 'presentation/features/catalog/view/catalog_page.dart',
    source: 'class CatalogEntry {}',
  );
  ruleTest(
    'does not impose widget naming on data classes',
    rule: LayoutNamedWidgetRule.new,
    path: 'data/models/database_row.dart',
    source: 'class DatabaseRow {}',
  );
  ruleTest(
    'flags both unwrapped branches in a data list',
    rule: CollectionBranchRule.new,
    path: 'data/mappers/catalog_mapper.dart',
    source: 'List<int> values(bool include) => [if (include) 41 else 42];',
    flags: ['41', '42'],
  );
  ruleTest(
    'checks an inner branch when the outer loop is wrapped',
    rule: CollectionBranchRule.new,
    path: 'presentation/features/catalog/view/catalog_page.dart',
    source:
        'List<int> values(bool include) => '
        '[for (final _ in [0]) ...[if (include) 42]];',
    flags: ['42'],
  );
  ruleTest(
    'accepts wrapped collection branches at every level',
    rule: CollectionBranchRule.new,
    path: 'presentation/features/catalog/view/catalog_page.dart',
    source:
        'List<int> values(bool include) => '
        '[for (final _ in [0]) ...[if (include) ...[41] else ...[42]]];',
  );
  ruleTest(
    'leaves set collection branches unchanged',
    rule: CollectionBranchRule.new,
    path: 'domain/entities/catalog_entity.dart',
    source: 'Set<int> values(bool include) => {if (include) 42};',
  );
  ruleTest(
    'flags a top-level presenter',
    rule: TopLevelPresenterRule.new,
    path: 'presentation/core/widgets/confirm_dialog.dart',
    source: 'void showConfirmation() {}',
    flags: ['void showConfirmation() {}'],
  );
  ruleTest(
    'accepts a presenter owned by its widget class',
    rule: TopLevelPresenterRule.new,
    path: 'presentation/core/widgets/confirm_dialog.dart',
    source: 'class ConfirmDialog { static void show() {} }',
  );
  ruleTest(
    'does not flag calls to a presenter',
    rule: TopLevelPresenterRule.new,
    path: 'presentation/features/catalog/view/catalog_page.dart',
    source:
        'void open(void Function() showConfirmation) { showConfirmation(); }',
  );
  ruleTest(
    'ignores non-presentation functions starting with show',
    rule: TopLevelPresenterRule.new,
    path: 'data/services/debug_service.dart',
    source: 'void showDiagnostics() {}',
  );
}
