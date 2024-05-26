part of '../theme_data.dart';

class _InputDecorationTheme with ThemeExtensions {
  final BorderRadius _borderRadius = BorderRadius.circular(6);

  InputDecorationTheme call() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      border: OutlineInputBorder(borderRadius: _borderRadius),
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(
          color: color.border,
          width: 1,
        ),
      ),
      suffixIconColor: color.icon,
      disabledBorder: OutlineInputBorder(borderRadius: _borderRadius),
    );
  }
}
