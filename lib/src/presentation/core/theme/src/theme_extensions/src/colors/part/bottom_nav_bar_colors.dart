part of '../colors.dart';

abstract class BottomNavBarColors {
  const BottomNavBarColors();

  Color get selectedItem;
  Color get unselectedItem;
}

class _LightBottomNavBarColors extends BottomNavBarColors {
  const _LightBottomNavBarColors();

  @override
  Color get selectedItem => _Colors.blue;

  @override
  Color get unselectedItem => _Colors.mediumGray;
}

class _DarkBottomNavBarColors extends BottomNavBarColors {
  const _DarkBottomNavBarColors();

  @override
  Color get selectedItem => _Colors.blue;

  @override
  Color get unselectedItem => _Colors.lightGray;
}
