part of '../colors.dart';

abstract class TextColors {
  const TextColors();

  Color get primary;
  Color get secondary;
  Color get tertiary;
}

class _LightTextColors extends TextColors {
  const _LightTextColors();

  @override
  Color get primary => _Primitive.neutral50;

  @override
  Color get secondary => _Primitive.neutral20;

  @override
  Color get tertiary => _Primitive.neutral20;
}

class _DarkTextColors extends TextColors {
  const _DarkTextColors();

  @override
  Color get primary => _Primitive.neutral0;

  @override
  Color get secondary => _Primitive.neutral20;

  @override
  Color get tertiary => _Primitive.neutral20;
}
