# Localization

Multi-language support via `flutter gen-l10n` + ARB files
(English / Bangla / Arabic).

- ARB sources: `lib/src/core/localization/intl_en.arb` (template),
  `intl_bn.arb`, `intl_ar.arb`. Config in `l10n.yaml`.
- Output is generated to `lib/src/core/gen/l10n/app_localizations.dart`
  (gitignored).

## Workflow

1. Add the key to **all** ARB files.
2. Run `flutter gen-l10n`.
3. Access in UI via the extension:

```dart
Text(context.locale.login); // lib/src/core/extensions/app_localization.dart
```

Validation / error strings are localized — keep them in ARB, not hardcoded.

See also: [codegen](./codegen.md).
