import 'package:flutter/material.dart';

class _LightColors {
  static const Color aliceBlue = Color(0xFFF2F8FF);
  static const Color crayolaBlue = Color(0xFF1877F2);
  static const Color davyGray = Color(0xFF52525B);
  static const Color frenchGray = Color(0xFFBABABD);
  static const Color gray = Color(0xFF75757C);
  static const Color jet = Color(0xFF313137);
  static const Color platinum = Color(0xFFD5DCE4);
  static const Color white = Color(0xFFFFFFFF);
}

class _DarkColors {
  static const Color black = Color(0xFF000000);
  static const Color eerieBlack = Color(0xFF1B1B1B);
  static const Color darkGray = Color(0xFF444750);
  static const Color white = Color(0xFFFFFFFF);
  static const Color crayolaBlue = Color(0xFF1877F2);
  static const Color platinum = Color(0xFFD5DCE4);
  static const Color frenchGray = Color(0xFFBABABD);
}

abstract class _AppBarColors {
  const _AppBarColors();

  Color get background;

  Color get icon;

  Color get surfaceTint;

  Color get title;
}

class _LightAppBarColors extends _AppBarColors {
  const _LightAppBarColors();

  @override
  Color get background => _LightColors.aliceBlue;

  @override
  Color get icon => _LightColors.jet;

  @override
  Color get surfaceTint => _LightColors.aliceBlue;

  @override
  Color get title => _LightColors.jet;
}

class _DarkAppBarColors extends _AppBarColors {
  const _DarkAppBarColors();

  @override
  Color get background => _DarkColors.eerieBlack;

  @override
  Color get icon => _DarkColors.white;

  @override
  Color get surfaceTint => _DarkColors.eerieBlack;

  @override
  Color get title => _DarkColors.white;
}

abstract class _BottomNavBarColors {
  const _BottomNavBarColors();

  Color get selectedItem;

  Color get unselectedItem;
}

class _LightBottomNavBarColors extends _BottomNavBarColors {
  const _LightBottomNavBarColors();

  @override
  Color get selectedItem => _LightColors.crayolaBlue;

  @override
  Color get unselectedItem => _LightColors.gray;
}

class _DarkBottomNavBarColors extends _BottomNavBarColors {
  const _DarkBottomNavBarColors();

  @override
  Color get selectedItem => _DarkColors.crayolaBlue;

  @override
  Color get unselectedItem => _DarkColors.frenchGray;
}

abstract class _PageViewColors {
  const _PageViewColors();

  Color get active;

  Color get inactive;
}

class _LightPageViewColors extends _PageViewColors {
  const _LightPageViewColors();

  @override
  Color get active => _LightColors.crayolaBlue;

  @override
  Color get inactive => _LightColors.platinum;
}

class _DarkPageViewColors extends _PageViewColors {
  const _DarkPageViewColors();

  @override
  Color get active => _DarkColors.crayolaBlue;

  @override
  Color get inactive => _DarkColors.darkGray;
}

abstract class _TextColors {
  const _TextColors();

  Color get primary;

  Color get secondary;

  Color get tertiary;
}

class _LightTextColors extends _TextColors {
  const _LightTextColors();

  @override
  Color get primary => _LightColors.crayolaBlue;

  @override
  Color get secondary => _LightColors.davyGray;

  @override
  Color get tertiary => _LightColors.jet;
}

class _DarkTextColors extends _TextColors {
  const _DarkTextColors();

  @override
  Color get primary => _DarkColors.crayolaBlue;

  @override
  Color get secondary => _DarkColors.platinum;

  @override
  Color get tertiary => _DarkColors.frenchGray;
}

class ColorExtension {
  final Color border;
  final Color icon;
  final Color onPrimary;
  final Color primary;
  final Color scaffoldBackground;

  final _AppBarColors appBar;
  final _BottomNavBarColors bottomNavBar;
  final _PageViewColors pageView;
  final _TextColors text;

  const ColorExtension({
    required this.border,
    required this.icon,
    required this.onPrimary,
    required this.primary,
    required this.scaffoldBackground,
    required this.appBar,
    required this.bottomNavBar,
    required this.pageView,
    required this.text,
  });
}

class LightColorExtension extends ThemeExtension<LightColorExtension>
    implements ColorExtension {
  const LightColorExtension({
    this.border = _LightColors.frenchGray,
    this.icon = _LightColors.jet,
    this.onPrimary = _LightColors.white,
    this.primary = _LightColors.crayolaBlue,
    this.scaffoldBackground = _LightColors.aliceBlue,
    this.appBar = const _LightAppBarColors(),
    this.bottomNavBar = const _LightBottomNavBarColors(),
    this.pageView = const _LightPageViewColors(),
    this.text = const _LightTextColors(),
  });

  @override
  final Color border;

  @override
  final Color icon;

  @override
  final Color onPrimary;

  @override
  final Color primary;

  @override
  final Color scaffoldBackground;

  @override
  final _AppBarColors appBar;

  @override
  final _BottomNavBarColors bottomNavBar;

  @override
  final _PageViewColors pageView;

  @override
  final _TextColors text;

  @override
  ThemeExtension<LightColorExtension> copyWith() {
    return const LightColorExtension();
  }

  @override
  ThemeExtension<LightColorExtension> lerp(
      covariant ThemeExtension<LightColorExtension>? other, double t) {
    return const LightColorExtension();
  }
}

class DarkColorExtension extends ThemeExtension<DarkColorExtension>
    implements ColorExtension {
  const DarkColorExtension({
    this.border = _DarkColors.platinum,
    this.icon = _DarkColors.white,
    this.onPrimary = _DarkColors.black,
    this.primary = _DarkColors.crayolaBlue,
    this.scaffoldBackground = _DarkColors.eerieBlack,
    this.appBar = const _DarkAppBarColors(),
    this.bottomNavBar = const _DarkBottomNavBarColors(),
    this.pageView = const _DarkPageViewColors(),
    this.text = const _DarkTextColors(),
  });

  @override
  final Color border;

  @override
  final Color icon;

  @override
  final Color onPrimary;

  @override
  final Color primary;

  @override
  final Color scaffoldBackground;

  @override
  final _AppBarColors appBar;

  @override
  final _BottomNavBarColors bottomNavBar;

  @override
  final _PageViewColors pageView;

  @override
  final _TextColors text;

  @override
  ThemeExtension<DarkColorExtension> copyWith() {
    return const DarkColorExtension();
  }

  @override
  ThemeExtension<DarkColorExtension> lerp(
      covariant ThemeExtension<DarkColorExtension>? other, double t) {
    return const DarkColorExtension();
  }
}
