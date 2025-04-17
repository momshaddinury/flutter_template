part of '../colors.dart';

abstract class _BottomNavBarColors {
  const _BottomNavBarColors();

  Color get selectedItem;
  Color get unselectedItem;
}

class _LightBottomNavBarColors extends _BottomNavBarColors {
  const _LightBottomNavBarColors();

  @override
  Color get selectedItem => _Colors.blue;

  @override
  Color get unselectedItem => _Colors.mediumGray;
}

class _DarkBottomNavBarColors extends _BottomNavBarColors {
  const _DarkBottomNavBarColors();

  @override
  Color get selectedItem => _Colors.blue;

  @override
  Color get unselectedItem => _Colors.lightGray;
}
