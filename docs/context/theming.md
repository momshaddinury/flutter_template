# Theming — `BuildContext` extensions only

There is **no** `AppTheme` / `AppSize` / `AppCustomTextStyles`. Everything goes
through `context` (see `lib/src/presentation/core/theme/theme.dart`).

| Need | Use |
|---|---|
| Colors | `context.color.primary`, `context.color.text.primary`, `context.color.text.secondary` |
| Text styles | `context.textStyle.bodyMedium`, `context.textStyle.headingLarge` |
| Spacing (Gap/SizedBox) | `context.spacing.s16`, `context.spacing.s80` |
| Padding | `context.padding.p16` |
| Margin / radius | `context.margin.*`, `context.radius.*` |

```dart
Padding(
  padding: EdgeInsets.symmetric(horizontal: context.padding.p16),
  child: Column(children: [
    Gap(context.spacing.s16),
    Text('Hi', style: context.textStyle.bodyMedium
        .copyWith(color: context.color.text.primary)),
  ]),
)
```

## Rules

- ❌ Never hardcode colors, text styles, or sizes (`Colors.blue`, `fontSize: 16`,
  `EdgeInsets.all(16)`, `SizedBox(height: 24)`).
- ✅ Prefer the ready-made typography widgets in
  `presentation/core/widgets/text/typography.dart` (`HeadingLargeText`,
  `BodyMediumText`, `BodyMediumText.secondary`, …).
- ✅ If a token is missing, **add it to the theme extension** — never inline a
  literal value.

See also: [dos-and-donts](./dos-and-donts.md).
