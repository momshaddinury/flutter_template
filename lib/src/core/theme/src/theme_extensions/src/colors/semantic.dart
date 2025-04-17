part of 'colors.dart';

/// Semantic color palette that defines colors by their purpose
class _Colors {
  static const Color blue = Color(0xFF1877F2); // crayolaBlue
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF2F8FF); // aliceBlue
  static const Color darkBackground = Color(0xFF1B1B1B); // eerieBlack
  static const Color lightText = Color(0xFF313137); // jet
  static const Color darkText = Color(0xFFFFFFFF); // white
  static const Color mediumGray = Color(0xFF75757C); // gray
  static const Color lightGray = Color(0xFFBABABD); // frenchGray
  static const Color darkGray = Color(0xFF444750);
  static const Color platinum = Color(0xFFD5DCE4);
  static const Color green = Color(0xFF008000);
  static const Color red = Color(0xFFFF0000);
  static const Color yellow = Color(0xFFFFFF00);
}

class _LightThemeColors {
  const _LightThemeColors();

  // Primary colors
  static const Color primary = _Colors.blue;
  static const Color onPrimary = _Colors.white;

  // Background colors
  static const Color background = _Colors.lightBackground;
  static const Color surface = _Colors.white;
  static const Color border = _Colors.lightGray;

  // Text colors
  static const Color textPrimary = _Colors.lightText;
  static const Color textSecondary = _Colors.mediumGray;
  static const Color textTertiary = _Colors.lightText;

  /// Semantic colors
  static const Color success = _Colors.green;
  static const Color error = _Colors.red;
  static const Color warning = _Colors.yellow;
  static const Color info = _Colors.blue;
  static const Color disabled = _Colors.lightGray;
  static const Color active = _Colors.blue;
  static const Color inactive = _Colors.platinum;

  // Component colors
  static const Color icon = _Colors.lightText;

  // AppBar specific
  final appBar = const _LightAppBarColors();

  // Bottom navigation
  final bottomNavBar = const _LightBottomNavBarColors();

  // Page indicators
  final pageView = const _LightPageViewColors();
}

class _DarkThemeColors {
  const _DarkThemeColors();

  // Primary colors
  static const Color primary = _Colors.blue;
  static const Color onPrimary = _Colors.black;

  // Background colors
  static const Color background = _Colors.darkBackground;
  static const Color surface = _Colors.darkGray;
  static const Color border = _Colors.platinum;

  // Text colors
  static const Color textPrimary = _Colors.darkText;
  static const Color textSecondary = _Colors.platinum;
  static const Color textTertiary = _Colors.lightGray;

  /// Semantic colors
  static const Color success = _Colors.green;
  static const Color error = _Colors.red;
  static const Color warning = _Colors.yellow;
  static const Color info = _Colors.blue;
  static const Color disabled = _Colors.lightGray;
  static const Color active = _Colors.blue;
  static const Color inactive = _Colors.platinum;

  // Component colors
  static const Color icon = _Colors.white;

  // AppBar specific
  final appBar = const _DarkAppBarColors();

  // Bottom navigation
  final bottomNavBar = const _DarkBottomNavBarColors();

  // Page indicators
  final pageView = const _DarkPageViewColors();
}
