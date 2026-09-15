# flutter_guardian

The template's native Dart analyzer plugin enforces the machine-checkable rules in [agent/](../../agent/README.md).

## Enable and run

The root `analysis_options.yaml` already loads the plugin:

```yaml
plugins:
  flutter_guardian:
    path: packages/flutter_guardian
```

Run `fvm dart analyze` or `agent/gate` from the repository root.
The plugin stays pure Dart and is resolved by the analysis server; it is not an app dependency.

## Rules

| Rule | Checks |
|---|---|
| `invalid_layer_import` | Layer boundaries |
| `cross_feature_import` | Feature isolation |
| `cross_service_import` | Service isolation |
| `invalid_di_lifetime` | DI provider lifetime |
| `invalid_repository_name`, `invalid_service_name`, `invalid_use_case_name` | DI provider names |
| `hardcoded_route` | Route enum use |
| `direct_dio_call` | Direct Dio calls outside network services |
| `widget_returning_helper` | Widget-producing helper functions |
| `hardcoded_text` | Literal user-facing text |
| `hardcoded_design_value` | Inline colors and geometry |
| `svg_outside_app_icon` | SVG access outside the icon wrapper |
| `text_style_outside_typography` | Text styles outside `core/widgets/text/` and theme |
| `layout_named_widget` | Layout suffixes in presentation class names |
| `unwrapped_collection_branch` | List branches without a spread list |
| `top_level_presenter` | Top-level sheet or dialog presenters |

## Tests

```bash
cd packages/flutter_guardian
fvm dart pub get
fvm dart test
```

Tests resolve source fixtures with the existing analyzer harness. Each test checks expected diagnostics and accepted code.
When adding a rule, register it in `lib/main.dart`, add tests under `test/rules/`, and update this table.
