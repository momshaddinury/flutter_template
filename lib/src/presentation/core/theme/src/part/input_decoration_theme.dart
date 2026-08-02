part of '../theme_data.dart';

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
      hintStyle: textStyle.body.regular.copyWith(color: color.text.muted),
      labelStyle: textStyle.label.regular.copyWith(color: color.text.muted),
      errorStyle: textStyle.label.caption.copyWith(color: color.status.danger),
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
