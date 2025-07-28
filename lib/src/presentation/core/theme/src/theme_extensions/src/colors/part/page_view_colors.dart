part of '../colors.dart';

abstract class PageViewColors {
  const PageViewColors();

  Color get active;
  Color get inactive;
}

class _LightPageViewColors extends PageViewColors {
  const _LightPageViewColors();

  @override
  Color get active => _Primitive.brand;

  @override
  Color get inactive => _Primitive.neutral20;
}

class _DarkPageViewColors extends PageViewColors {
  const _DarkPageViewColors();

  @override
  Color get active => _Primitive.brand;

  @override
  Color get inactive => _Primitive.neutral20;
}
