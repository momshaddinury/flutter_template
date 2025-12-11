part of '../theme_data.dart';

class _InputDecorationLightTheme with ThemeExtensions {
  InputDecorationTheme call() {
    final BorderRadius borderRadius = BorderRadius.circular(
      dimensions.radius.r6,
    );

    return InputDecorationTheme(
      hintStyle: textStyle.bodyLarge.copyWith(color: lightColor.text.secondary),
      contentPadding: EdgeInsets.symmetric(
        vertical: dimensions.spacing.s12,
        horizontal: dimensions.spacing.s16,
      ),
      border: OutlineInputBorder(borderRadius: borderRadius),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: lightColor.border,
          width: dimensions.spacing.s1,
        ),
      ),
      suffixIconColor: lightColor.icon,
      disabledBorder: OutlineInputBorder(borderRadius: borderRadius),
    );
  }
}

class _InputDecorationDarkTheme with ThemeExtensions {
  InputDecorationTheme call() {
    final BorderRadius borderRadius = BorderRadius.circular(
      dimensions.radius.r6,
    );

    return InputDecorationTheme(
      hintStyle: textStyle.bodyLarge.copyWith(color: darkColor.text.secondary),
      contentPadding: EdgeInsets.symmetric(
        vertical: dimensions.spacing.s12,
        horizontal: dimensions.spacing.s16,
      ),
      border: OutlineInputBorder(borderRadius: borderRadius),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: darkColor.border,
          width: dimensions.spacing.s1,
        ),
      ),
      suffixIconColor: darkColor.icon,
      disabledBorder: OutlineInputBorder(borderRadius: borderRadius),
    );
  }
}
