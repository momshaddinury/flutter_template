part of '../colors.dart';

abstract class _PageViewColors {
  const _PageViewColors();

  Color get active;
  Color get inactive;
}

class _LightPageViewColors extends _PageViewColors {
  const _LightPageViewColors();

  @override
  Color get active => _LightThemeColors.active;

  @override
  Color get inactive => _LightThemeColors.inactive;
}

class _DarkPageViewColors extends _PageViewColors {
  const _DarkPageViewColors();

  @override
  Color get active => _DarkThemeColors.active;

  @override
  Color get inactive => _DarkThemeColors.inactive;
}
