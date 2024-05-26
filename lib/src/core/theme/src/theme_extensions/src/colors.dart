import 'package:flutter/material.dart';

class _Color {
  static const Color aliceBlue = Color(0xFFF2F8FF);
  static const Color black = Color(0xFF000000);
  static const Color columbiaBlue = Color(0xFFD6E8FF);
  static const Color crayolaBlue = Color(0xFF1877F2);
  static const Color davyGray = Color(0xFF52525B);
  static const Color frenchGray = Color(0xFFBABABD);
  static const Color gray = Color(0xFF75757C);
  static const Color jet = Color(0xFF313137);
  static const Color platinum = Color(0xFFD5DCE4);
  static const Color white = Color(0xFFFFFFFF);
}

class _AppBarColor {
  const _AppBarColor();

  /// Color Code #F2F8FF (Alice Blue)
  Color get background => _Color.aliceBlue;

  /// Color Code #313137 (Jet)
  Color get icon => _Color.jet;

  /// Color Code #F2F8FF (Alice Blue)
  Color get surfaceTint => _Color.aliceBlue;

  /// Color Code #313137 (Jet)
  Color get title => _Color.jet;
}

class _BottomNavigationBarColor {
  const _BottomNavigationBarColor();

  /// Color Code #1877F2 (Crayola Blue)
  Color get selectedItem => _Color.crayolaBlue;

  /// Color Code #75757C (Gray)
  Color get unselectedItem => _Color.gray;
}

class _PageViewColor {
  const _PageViewColor();

  /// Color Code #1877F2 (Crayola Blue)
  final active = _Color.crayolaBlue;

  /// Color Code #D5DCE4 (Platinum)
  final inactive = _Color.platinum;
}

class _TextColor {
  const _TextColor();

  /// Color Code #1877F2 (Crayola Blue)
  final primary = _Color.crayolaBlue;

  /// Color Code #52525B (Davy Gray)
  final secondary = _Color.davyGray;

  /// Color Code #313137 (Jet)
  final tertiary = _Color.jet;
}

class ColorExtension extends ThemeExtension<ColorExtension> {
  /// Color Code #BABABD (French Gray)
  final border = _Color.frenchGray;

  /// Color Code #BABABD (French Gray)
  final icon = _Color.frenchGray;

  /// Color Code #FFFFFF (White)
  final onPrimary = _Color.white;

  /// Color Code #1877F2 (Crayola Blue)
  final primary = _Color.crayolaBlue;

  /// Color Code #FFFFFF (White)
  final scaffoldBackground = _Color.white;

  final appBar = const _AppBarColor();
  final bottomNavbar = const _BottomNavigationBarColor();
  final pageView = const _PageViewColor();
  final text = const _TextColor();

  const ColorExtension();

  @override
  ThemeExtension<ColorExtension> copyWith() => const ColorExtension();

  @override
  ThemeExtension<ColorExtension> lerp(other, t) => const ColorExtension();
}
