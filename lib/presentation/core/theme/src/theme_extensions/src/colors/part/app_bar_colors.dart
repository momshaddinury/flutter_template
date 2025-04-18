part of '../colors.dart';

abstract class AppBarColors {
  const AppBarColors();

  Color get background;
  Color get icon;
  Color get surfaceTint;
  Color get title;
}

class _LightAppBarColors extends AppBarColors {
  const _LightAppBarColors();

  @override
  Color get background => _LightThemeColors.background;

  @override
  Color get icon => _LightThemeColors.icon;

  @override
  Color get surfaceTint => _LightThemeColors.background;

  @override
  Color get title => _LightThemeColors.textPrimary;
}

class _DarkAppBarColors extends AppBarColors {
  const _DarkAppBarColors();

  @override
  Color get background => _DarkThemeColors.background;

  @override
  Color get icon => _DarkThemeColors.icon;

  @override
  Color get surfaceTint => _DarkThemeColors.background;

  @override
  Color get title => _DarkThemeColors.textPrimary;
}
