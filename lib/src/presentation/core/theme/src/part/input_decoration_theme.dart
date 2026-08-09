part of '../theme_data.dart';

/// The hint, label, and error styles carry fonts only — no colors.
/// InputDecorator merges the provided style over Material 3's stateful
/// defaults, whose colors come from the ColorScheme: hint and label read
/// `onSurfaceVariant` (wired to `text.muted`), error states read
/// `colorScheme.error` (wired to `status.danger`), and a focused label
/// reads primary. A color set here would freeze those states; colorless
/// styles keep the token fonts and the framework's state handling both.
class _InputDecorationThemeData with ThemeExtensions {
  _InputDecorationThemeData(this.color);

  final ColorExtension color;

  InputDecorationTheme call() {
    final BorderRadius borderRadius = BorderRadius.circular(
      dimensions.radius.medium,
    );

    OutlineInputBorder border(Color borderColor, double width) {
      return OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: borderColor, width: width),
      );
    }

    return InputDecorationTheme(
      filled: true,
      fillColor: color.background.surface,
      contentPadding: EdgeInsets.symmetric(
        vertical: dimensions.space.s12,
        horizontal: dimensions.space.s16,
      ),
      hintStyle: textStyle.body.regular,
      labelStyle: textStyle.label.regular,
      errorStyle: textStyle.label.caption,
      suffixIconColor: color.text.muted,
      prefixIconColor: color.text.muted,
      border: border(color.border.defaultValue, dimensions.border.xs),
      enabledBorder: border(color.border.defaultValue, dimensions.border.xs),
      focusedBorder: border(color.primary.strong, dimensions.border.md),
      disabledBorder: border(color.border.defaultValue, dimensions.border.xs),
      errorBorder: border(color.status.danger, dimensions.border.xs),
      focusedErrorBorder: border(color.status.danger, dimensions.border.md),
    );
  }
}
