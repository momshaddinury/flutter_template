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
  Color get background => _Primitive.neutral0;

  @override
  Color get icon => _Primitive.neutral0;

  @override
  Color get surfaceTint => _Primitive.neutral0;

  @override
  Color get title => _Primitive.neutral50;
}

class _DarkAppBarColors extends AppBarColors {
  const _DarkAppBarColors();

  @override
  Color get background => _Primitive.neutral60;

  @override
  Color get icon => _Primitive.neutral0;

  @override
  Color get surfaceTint => _Primitive.neutral60;

  @override
  Color get title => _Primitive.neutral0;
}
