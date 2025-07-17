part of '../theme_data.dart';

class _InputDecorationLightTheme with ThemeExtensions {
  final BorderRadius _borderRadius = BorderRadius.circular(6);

  InputDecorationTheme call() {
    return InputDecorationTheme(
      hintStyle: textStyle.bodyLarge.copyWith(color: lightColor.text.secondary),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      border: OutlineInputBorder(borderRadius: _borderRadius),
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(
          color: lightColor.border,
          width: 1,
        ),
      ),
      suffixIconColor: lightColor.icon,
      disabledBorder: OutlineInputBorder(borderRadius: _borderRadius),
    );
  }
}

class _InputDecorationDarkTheme with ThemeExtensions {
  final BorderRadius _borderRadius = BorderRadius.circular(6);

  InputDecorationTheme call() {
    return InputDecorationTheme(
      hintStyle: textStyle.bodyLarge.copyWith(color: darkColor.text.secondary),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      border: OutlineInputBorder(borderRadius: _borderRadius),
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(
          color: darkColor.border,
          width: 1,
        ),
      ),
      suffixIconColor: darkColor.icon,
      disabledBorder: OutlineInputBorder(borderRadius: _borderRadius),
    );
  }
}
