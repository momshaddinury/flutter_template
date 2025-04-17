part of '../colors.dart';

abstract class _TextColors {
  const _TextColors();

  Color get primary;
  Color get secondary;
  Color get tertiary;
}

class _LightTextColors extends _TextColors {
  const _LightTextColors();

  @override
  Color get primary => _LightThemeColors.textPrimary;

  @override
  Color get secondary => _LightThemeColors.textSecondary;

  @override
  Color get tertiary => _LightThemeColors.textTertiary;
}

class _DarkTextColors extends _TextColors {
  const _DarkTextColors();

  @override
  Color get primary => _DarkThemeColors.textPrimary;

  @override
  Color get secondary => _DarkThemeColors.textSecondary;

  @override
  Color get tertiary => _DarkThemeColors.textTertiary;
}
